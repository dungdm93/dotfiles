# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################
export AQUA_GLOBAL_CONFIG=$HOME/aqua.yaml
export PATH="$(aqua root-dir)/bin:$PATH"
source <(aqua completion bash)

eval "$(starship init bash)"

has() {
    command -v "$1" 1>/dev/null 2>&1
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export CONDA_DIR="$HOME/.conda"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($CONDA_DIR/bin/conda 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_DIR/etc/profile.d/conda.sh" ]; then
        . "$CONDA_DIR/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_DIR/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/go/bin:/usr/local/go/bin:$PATH"

# bun & deno
export BUN_INSTALL="$HOME/.bun"
export DENO_INSTALL="$HOME/.deno"
export PATH=$BUN_INSTALL/bin:$DENO_INSTALL/bin:$PATH

if has kubectl; then
    source <(kubectl completion bash)

    alias k=kubectl
    complete -o default -F __start_kubectl k

    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

if has helm; then
    source <(helm completion bash)
fi

if has helmfile; then
    source <(helmfile completion bash)
fi

if has crictl; then
    source <(crictl completion)
fi

if has nerdctl; then
    source <(nerdctl completion bash)
fi

if has ig; then
    source <(ig completion bash)
fi

if has flux; then
    source <(flux completion bash)
fi

if has opa; then
    source <(opa completion bash)
fi

if has trivy; then
    source <(trivy completion bash)
fi

if has grype; then
    source <(grype completion bash)
fi

if has syft; then
    source <(syft completion bash)
fi

if has oras; then
    source <(oras completion bash)
fi

if has crane; then
    source <(crane completion bash)
fi

if has cosign; then
    source <(cosign completion bash)
fi

if has gitsign; then
    source <(gitsign completion bash)
fi

if has buf; then
    source <(buf completion bash)
fi

if has yq; then
    source <(yq shell-completion bash)
fi

if has vault; then
    complete -C "$(which vault)" vault
    export VAULT_ADDR=http://localhost:8200
fi

if has terraform; then
    complete -C "$(which terraform)" terraform
fi

if has mc; then
    complete -C "$(which mc)" mc
fi

# ref: https://github.com/apache/avro/tree/master/lang/java/tools
alias avro-tools="java -jar $HOME/.local/bin/avro-tools-1.11.0.jar"

# ref: https://orc.apache.org/docs/java-tools.html
alias orc-tools="java -jar $HOME/.local/bin/orc-tools-1.7.2-uber.jar"

# NOTE: newer parquet-tools version renamed to parquet-cli
# ref: https://github.com/apache/parquet-mr/tree/master/parquet-cli
alias parquet-tools="java -jar $HOME/.local/bin/parquet-tools-1.8.3.jar"
