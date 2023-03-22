fonts
=====

* [Nerd Fonts](https://www.nerdfonts.com/)
* [Powerline](https://github.com/powerline/fonts)

## Installation

[ref](https://itsfoss.com/install-fonts-ubuntu/)

## Terminal
> [Change the font of various **Terminal emulators**](https://askubuntu.com/a/283831)

* Gnome Terminal

    ```bash
    $ gsettings get org.gnome.desktop.interface monospace-font-name
    'Ubuntu Mono 13'
    $ gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font 13'
    ```

* Tilix

    ```bash
    dconf dump /com/gexperts/Tilix/ > tilix.dconf
    dconf load /com/gexperts/Tilix/ < tilix.dconf
    ```
    [ref](https://github.com/gnunn1/tilix/issues/571#issuecomment-293097876)
