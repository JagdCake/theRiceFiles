source /usr/share/defaults/etc/profile
# enable z (https://github.com/rupa/z) to track directories
source /home/jagdcake/Documents/code.github/z/z.sh
# use vi keybindings in bash
set -o vi
alias start='xdg-open'
alias monitor='gio monitor'
alias takeoutthetrash='gio trash --empty'
# copy piped command's output
alias copy="xclip -selection clipboard"
alias nvim="$HOME/Downloads/./nvim.appimage"
alias work="tmuxp load work"

editor() {
    "$HOME/Downloads/./nvim.appimage" "$@"
}

### My Places ###
web_dev_dir=~/Documents/web_dev/
alias mywebdev="cd ${web_dev_dir}"
alias myclientprojects="cd ${web_dev_dir}2_client_projects/"
alias mysites="cd ${web_dev_dir}3_my_sites/"
alias myscripts="cd /home/jagdcake/Documents/my_github/shell_scripts"
### ###

### My Scripts ###
scripts_dir=~/Documents/my_github/shell_scripts/scripts/
alias sow=$HOME/Documents/go/bin/./script.shutdown-or-reboot
alias nightl="watch -n 3 ${scripts_dir}./night_light.sh &> /dev/null &"
alias dsearch="${scripts_dir}./docsSearch.sh"
alias recipes="${scripts_dir}./recipes.sh"
alias weighttracker="${scripts_dir}./weight_tracker.sh"
alias workspace="${scripts_dir}./workspace.sh"
alias pomodoro="${scripts_dir}./pomodoro.sh"
alias checkwebsites="${scripts_dir}./check_websites.sh"
alias generatewebproject="${scripts_dir}./generate_web_project.sh"
alias notes="${scripts_dir}./take_notes.sh"
alias budget="${scripts_dir}./budget.sh"
alias backup="~/Documents/backup/./backup.sh"
alias buildwebproject="${scripts_dir}./build_web_project.sh"
### ###

### Git ###
alias numofcommits="~/Downloads/./git-num.sh"
### ###

### My Apps ###
alias movieadd="~/Documents/web_dev/3_my_sites/site.movies/bin/console server:run"
### ###

### Edit Files ###
did() {
    flag="$1"
    # create / append to local did files by default
    did_file='./did'

    # append to the global did file
    if [ "$flag" == '-g' ]; then
        did_file=~/Documents/text_files/did
    fi

    editor +'normal G o' +'r!date' +'normal o- ' "$did_file"
}
learned() {
    fact_file=~/Documents/text_files/general-knowledge

    editor +'normal G o' +'r!date' +'normal o- ' "$fact_file"
}
### ###

### Misc. ###
# show a human readable summary of the size of a file / folder
showfilesize() {
   du -sh "$1" | sort -hr | awk '{ print $1 }'
}
toggleicons() {
    status=$(gsettings get org.gnome.desktop.background show-desktop-icons)
    if [ $status == 'true' ]; then
        gsettings set org.gnome.desktop.background show-desktop-icons false
    else
        gsettings set org.gnome.desktop.background show-desktop-icons true
    fi
}
weather() {
    time_now="$(date +%T)"
    date="$(date "+%d %b %Y")"
    url='https://www.sinoptik.bg/vidin-bulgaria-100725905'
    current_temp="$(curl -s "$url" | rg wfCurrentTemp | rg -o -e '-?\d{1,2}')"
    max_temp="$(curl -s "$url" | rg 'Максимална температура' | head -n 1 | rg -o -e '-?\d{1,2}')"
    humidity="$(curl -s "$url" | rg wfCurrentValue | rg -o -e '\d{1,3}%' | rg -o -e '\d{1,3}')"

    if [[ "$current_temp" -gt 30 && "$humidity" -ge 80 ]]; then
        what='hell'
    elif [[ "$current_temp" -ge 30 ]]; then
        what='hot'
    elif [[ "$current_temp" -ge 25 ]]; then
        what='hot-ish'
    elif [[ "$current_temp" -ge 20 ]]; then
        what='warm'
    elif [[ "$current_temp" -ge 13 ]]; then
        what='nice'
    elif [[ "$current_temp" -ge 7 ]]; then
        what='cold-ish'
    elif [[ "$current_temp" -ge 0 ]]; then
        what='cold'
    else
        what='very cold'
    fi

    echo "It's $what"
    echo "Today is: $date"
    echo "The time is: $time_now"
    echo "Current topside temperature is: $current_temp°C"
    echo "With an estimated high of: $max_temp°C"
    echo "The humidity is at: $humidity%"

    psql -d weather -c "INSERT INTO readings VALUES (DEFAULT, '$what', '$date', '$time_now', $current_temp, $max_temp, $humidity)" > /dev/null
}
alias radio1='mpv http://stream.metacast.eu/radio1.opus'
download() {
    sound_effect='/usr/share/sounds/gnome/default/alerts/glass.ogg'

    if [ $# -eq 1 ]; then
        megadl --choose-files --path=/mnt/hdd/ "$1" &&
        paplay "$sound_effect"
    else
        echo "Usage: download [link]"
    fi
}
synonymsof() {
    trans "$1" | rg Synonyms:
}
showpercentof() {
    if [ $# -ne 2 ]; then
        echo "Usage: show_percent_of [PERCENT] of [NUMBER (integer or float)]"
    else
        percent=$1
        number=$2

        result=$(echo "scale=2; $number * $percent / 100" | bc -l)
        echo ""$percent"% of "$number" is "$result""
    fi
}
checknetwork() {
    ip_address=$(ifconfig | rg -C 1 enp3s0 | rg -o -e 'addr:\d+.\d+.\d+.' | awk -F':' '{ print $2 }')

    sudo nmap -sn "$ip_address"0/24
}
todo() {
    input="$1"

    if [ "$input" == 'show' ]; then
       task project:dailies ls
    elif [ $# -eq 1 ]; then
       task add "$input" project:dailies due:tomorrow
    else
        printf "Usage:\n"
        printf "  todo [TASK/OPTION]\n\n"
        printf "Note:\n"
        printf "  tasks need to be quoted\n\n"
        printf "Options:\n"
        printf "  show — displays all daily tasks\n\n"
    fi
}
remindme() {
    # show all tasks added this week
    task entry.after:today-7days description

    tabs 4
    printf "\nCommands to run at a certain time:\n"
    printf "\tnightl — before watching a movie\n"
    printf "\tmovieadd — after a movie\n"
    printf "\tweighttracker — every Monday morning\n"
    printf "\tpomodoro — while working\n"
    printf "\tnotes — while learning\n"
    printf "\tbackup — before going to bed\n"

    printf "\nCommands I often forget about:\n"
    printf "\tdid — to write down what I've done\n"
    printf "\tudunits2 — for measurement conversion\n"
    printf "\tlearned — write down random facts\n"

    printf "\nLast backup:\n"
    printf "$(tail -n 3 ~/Documents/backup/log)\n"

    # reset tabs to standard interval (do I have to?)
    tabs -8
}
ftoc() {
    udunits2 -H "${1} fahrenheit" -W celsius
}
ptokg() {
    udunits2 -H "${1} pounds" -W kilograms
}
fttom() {
    udunits2 -H "${1} feet" -W meters
}
suomitoeng() {
    trans -no-auto -from suomi "$1"
}
engtosuomi() {
    trans -no-auto -to suomi "$1"
}
checklist() {
    flag="$1"
    new_list_name="$2"

    list_dir=~/Documents/checklists/
    # stop execution if above dir doesn't exist
    cd "$list_dir" || { return 1; }

    if [[ "$flag" == '-c' || "$flag" == '--create' ]]; then
        # open neovim buffer containing the contents of the template file
        editor '+r template.sh' '+set filetype=sh'
    else
        # canceling checklist selection reverses the cd and returns the same exit code that fzf returns when interrupted
        checklist="$(exa *.sh | fzf)" || { cd ~- && return 130; }
        ./"$checklist"
    fi

    cd ~- || return 1
}
hoursandminutestominutes() {
    hours_and_minutes=$1

    if [ $# -ne 1 ]; then
        echo "Usage"
        echo "hoursandminutestominutes [HOURS]:[MINUTES]"
        return 0
    fi

    echo "$hours_and_minutes" | awk -F: '{ print ($1 * 60) + $2 }'
}
search() {
    term="$1"
    # the category parameter is optional
    # if not provided, search all files in the cards dir
    category="$2"

    anki_cards="$HOME/Documents/text_files/anki-cards/$category"

    if [ $# -lt 1 ]; then
        echo "Usage:"
        echo "search [SEARCH TERM] [CATEGORY (DEFAULT=ALL)]"
        echo
        echo "Categories:"
        # hide file extensions
        # should export Anki cards as plain text files
        exa "$HOME/Documents/text_files/anki-cards/" | awk -F'.txt' '{ print $1 }'
        return 0
    fi

    # search only the questions for the provided term
    # all questions should end with "?"
    rg -i "$term.*\?" "$anki_cards"*
}
### ###

### Environment Variables ###
export PS1="\[\e[01;34m\]JC\[\e[0m\]\[\e[2;16m\]\w$\[\e[0m\] "

export PATH="$PATH:/home/jagdcake/.yarn/bin:/home/jagdcake/.local/bin:/home/jagdcake/.cargo/bin"
export GOPATH=$HOME/Documents/go
### ###

