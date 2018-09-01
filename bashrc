source /usr/share/defaults/etc/profile
source ~/Documents/my_github/pureline/pureline ~/.pureline.conf
alias start='xdg-open'

### My Places ###
web_dev_dir=~/Documents/web_dev/
alias mywebdev="cd ${web_dev_dir}"
alias myclientprojects="cd ${web_dev_dir}2_client_projects/"
alias mysites="cd ${web_dev_dir}3_my_sites/"
alias myscripts="cd /home/jagdcake/Documents/my_github/shell_scripts"
### ###

### My Scripts ###
scripts_dir=~/Documents/my_github/shell_scripts/scripts/
alias shutdown_or_what="${scripts_dir}./shut_down.sh"
alias nightl="watch -n 3 ${scripts_dir}./night_light.sh &> /dev/null &"
alias dsearch="${scripts_dir}./docsSearch.sh"
alias recipes="${scripts_dir}./recipes.sh"
alias weight_tracker="${scripts_dir}./weight_tracker.sh"
alias workspace="${scripts_dir}./workspace.sh"
alias pomodoro="${scripts_dir}./pomodoro.sh"
alias check_websites="${scripts_dir}./check_websites.sh"
alias generate_web_project="${scripts_dir}./generate_web_project.sh"
alias notes="${scripts_dir}./take_notes.sh"
alias backup="~/Documents/backup/./backup.sh"
### ###

### My Apps ###
alias movie_add='cd /home/jagdcake/Documents/web_dev/5_node_apps/generate_movie_html/write_to_json && node app.js'
check_logs_for() {
    server_name=''
    server_ip=''
    logs_location=~/Documents/web_dev/9_logs/
    
    #'[app name]-app'
    app_name="$1"
    ssh "$server_name"@"$server_ip" docker logs "$app_name" > "$logs_location"${app_name}_logs && less "$logs_location"${app_name}_logs
}
### ###

### Front-end automation ###
build_for_firebase() {
    firebase init &&

    html-minifier --input-dir ./ --output-dir public/ --file-ext html --case-sensitive --collapse-whitespace --remove-comments --minify-css &&

    cp -r js/ images/ public/ &&

    terser public/js/all.js -o /public/js/all.min.js --compress --mangle &&

    svgo -f public/images/ &&

    optipng -o5 public/images/*.png &&

    # copy over 404 page and favicon

    echo 'Use the all.min.js file instead of all.js'
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
alias did="neovim +'normal G o' +'r!date' +'normal o- ' /home/jagdcake/Documents/text_files/did"
### ###

### Misc. ###
toggle_icons() {
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
    current_temp="$(curl -s "$url" | rg wfCurrentTemp | rg -o -e '\d{2}')"
    max_temp="$(curl -s "$url" | rg 'Максимална температура' | head -n 1 | rg -o -e '\d{2}')"
    humidity="$(curl -s "$url" | rg wfCurrentValue | rg -o -e '\d{2}%' | rg -o -e '\d{2}')"

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
    megadl --path=/mnt/hdd/ "$1" &&
    spd-say -t female2 'Download complete!'
}
synonyms_of() {
    trans "$1" | rg Synonyms:
}
show_percent_of() {
    if [ $# -ne 2 ]; then
        echo "Usage: show_percent_of [PERCENT] of [NUMBER (integer or float)]"
    else
        percent=$1
        number=$2

        result=$(echo "scale=2; $number * $percent / 100" | bc -l)
        echo ""$percent"% of "$number" is "$result""
    fi
}
### ###

### Environment Variables ###
# Overwritten by 'pureline'
# export PS1="\[\e[01;34m\]JC\[\e[0m\]\[\e[2;16m\]\w$\[\e[0m\] "

export PATH="$PATH:/home/jagdcake/.yarn/bin:/home/jagdcake/.local/bin"
export GOPATH=$HOME/Documents/go
### ###

