eval "$(starship init bash)"
eval "$(gh completion -s bash)"
source /etc/profile.d/bash_completion.sh
# enable z (https://github.com/rupa/z) to track directories
source /home/jagdcake/Documents/code.github/z/z.sh
# ===
# use vi keybindings in bash
set -o vi
alias start='xdg-open'
alias monitor='gio monitor'
alias takeoutthetrash='gio trash --empty'
# copy piped command's output
alias copy="xclip -selection clipboard"
alias work="tmuxp load work"
alias budget="hledger-iadd"
alias rm="rm -I"
alias exa="exa --sort modified"
# the date in ISO 8601 format, plus the timezone abbreviation and the
# full weekday name
alias isodate="date +'%Y-%m-%d %T %Z %A'"

### My Scripts ###
scripts_dir=~/Documents/projects/bash/shell_scripts/scripts/
alias sow=$HOME/Documents/go/bin/./script.shutdown-or-reboot
alias recipes="${scripts_dir}./recipes.sh"
alias weighttracker="${scripts_dir}./weight_tracker.sh"
alias notes="${scripts_dir}./take_notes.sh"
alias backup="~/Documents/backup/./backup.sh"
alias numofcommits="~/Misc/./git-num.sh"
### ###

### Misc. ###
alias radio1='mpv http://stream.metacast.eu/radio1.opus'
alias movieadd="npm run --prefix ~/Documents/projects/web-dev/movie-form add-movie"
### ###

### Environment Variables ###
export PS1="\[\e[01;34m\]JC\[\e[0m\]\[\e[2;16m\]\w$\[\e[0m\] "

export PATH="$PATH:/home/jagdcake/.yarn/bin:/home/jagdcake/.local/bin:/home/jagdcake/.cargo/bin:/home/jagdcake/bin/:/home/jagdcake/.npm-global/bin/"
export GOPATH=$HOME/Documents/go
export EDITOR=nvim
export MPV_HOME=$HOME/.config/mpv
### ###

