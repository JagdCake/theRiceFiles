source /usr/share/defaults/etc/profile
alias start='xdg-open'
alias monitor='gio monitor'
alias takeoutthetrash='gio trash --empty'

### My Places ###
web_dev_dir=~/Documents/web_dev/
alias mywebdev="cd ${web_dev_dir}"
alias myclientprojects="cd ${web_dev_dir}2_client_projects/"
alias mysites="cd ${web_dev_dir}3_my_sites/"
alias myscripts="cd /home/jagdcake/Documents/my_github/shell_scripts"
### ###

### My Scripts ###
scripts_dir=~/Documents/my_github/shell_scripts/scripts/
alias shutdownorwhat="${scripts_dir}./shut_down.sh"
alias nightl="watch -n 3 ${scripts_dir}./night_light.sh &> /dev/null &"
alias dsearch="${scripts_dir}./docsSearch.sh"
alias recipes="${scripts_dir}./recipes.sh"
alias weighttracker="${scripts_dir}./weight_tracker.sh"
alias workspace="${scripts_dir}./workspace.sh"
alias pomodoro="${scripts_dir}./pomodoro.sh"
alias checkwebsites="${scripts_dir}./check_websites.sh"
alias generatewebproject="${scripts_dir}./generate_web_project.sh"
alias notes="${scripts_dir}./take_notes.sh"
alias backup="~/Documents/backup/./backup.sh"
alias buildwebproject="${scripts_dir}./build_web_project.sh"
alias learn="$scripts_dir/./track_time.sh learn"
alias work="$scripts_dir/./track_time.sh work"
### ###

### My Apps ###
alias movieadd='cd /home/jagdcake/Documents/my_github/node_scripts/site.movies.generate_html/ && node app.js'
checklogsfor() {
    server_name=''
    server_ip=''
    logs_location=~/Documents/web_dev/9_logs/
    
    #'[app name]-app'
    app_name="$1"
    ssh "$server_name"@"$server_ip" docker logs "$app_name" > "$logs_location"${app_name}_logs && less "$logs_location"${app_name}_logs
}
### ###

### Neovim ###
alias codenvim='terminator -l neovim'
readnvim() {
    terminator -l light_reading -e "neovim -u /home/jagdcake/.config/nvim/reader.vim $1"
}
# the vim commands don't work because terminator thinks they are a part of the parameters 
# webnvim() {
    # terminator -l light_reading -e "nvim -u ~/.config/nvim/reader.vim +'r !w3m -dump $1' +'call FixLinebreaks()'"
# }
rednvim() {
    terminator -l movie -e "neovim -u ~/.config/nvim/red.vim $1"
}
### ###

### Edit Files ###
# create local 'did' files
alias did="neovim +'normal G o' +'r!date' +'normal o- ' ./did"
### ###

### Misc. ###
# show a human readable summary of the size(s) of files / folders and sort them from biggest to smallest 
# use double quotes around the path to expand wildcards
showfilesize() {
   du -sh $1 | sort -hr 
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
    log_file=~/Documents/text_files/my_logs/weather_log

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

    echo | tee -a "$log_file"
    echo "It's "$what"" | tee -a "$log_file"
    echo "Today is: "$date"" | tee -a "$log_file"
    echo "The time is: "$time_now"" | tee -a "$log_file"
    echo "Current topside temperature is: "$current_temp"°C" | tee -a "$log_file"
    echo "With an estimated high of: "$max_temp"°C" | tee -a "$log_file"
    echo "The humidity is at: "$humidity"%" | tee -a "$log_file"
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
workout() {
    day=$(date +%u)

    if [[ $day -eq 1 || $day -eq 3 || $day -eq 5 ]]; then
        choices=('Start off day workout' 'End workout' 'Show summary')
        timew_tag='workout_off_day'
    elif [[ $day -eq 2 || $day -eq 4 || $day -eq 7 ]]; then
        choices=('Start workout' 'End workout' 'Show summary')
        timew_tag='workout'
    else
        choices=('Show summary')
    fi

    choices+=('Quit')

    select option in "${choices[@]}"; do
       case "$option" in
            'Start workout' )
                timew start $timew_tag
                break;;
            'Start off day workout' )
                timew start $timew_tag
                break;;
            'Show summary' )
                timew summary year $timew_tag
                break;;
            'End workout' )
                timew stop
                break;;
            "Quit" )
                return;;
        esac
    done

    workout
}
### ###

### Environment Variables ###
export PS1="\[\e[01;34m\]JC\[\e[0m\]\[\e[2;16m\]\w$\[\e[0m\] "

export PATH="$PATH:/home/jagdcake/.yarn/bin:/home/jagdcake/.local/bin"
export GOPATH=$HOME/Documents/go
# default 'cat' behaviour for 'bat', i.e. don't use a pager for 'bat'
export BAT_PAGER='never'
### ###

