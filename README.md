dotfiles
========

## Setup
This repo use [GNU Stow](https://gnu.org/software/stow/) to manage dotfiles.

```bash
# 1. install stow
sudo apt install stow

# 2. clone this repo
git clone git@github.com:dungdm93/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. restore/apply dotfiles
stow <dir>
```

## References
* [dotfiles.github.io](https://dotfiles.github.io/)
* [Managing dotfiles with GNU stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
* [Managing dotfiles with Git bare repository](https://www.atlassian.com/git/tutorials/dotfiles) | [YouTube](https://youtu.be/tBoLDpTWVOM)

See also:
* [Command Line history](https://devblogs.microsoft.com/commandline/windows-command-line-backgrounder/)
