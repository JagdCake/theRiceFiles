source /usr/share/defaults/etc/profile
alias start='xdg-open'

### My Places ###
alias mywebdev='cd /home/jagdcake/Documents/web_dev'
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
### ###

### My Apps ###
alias movie_add='cd /home/jagdcake/Documents/web_dev/5_node_apps/generate_movie_html/write_to_json && node app.js'
check_logs_for() {
    server_name=''
    server_ip=''
    logs_location=~/Documents/web_dev/9_logs/
    
    #'[app name]-app'
    app_name="$1"
    ssh "$server_name"@"$server_ip" docker logs "$app_name" > "$logs_location"${app_name}_logs
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
# show a human readable summary of the size(s) of files / folders and sort them from biggest to smallest 
# use double quotes around the path to expand wildcards
showfilesize() {
   du -sh $1 | sort -hr 
}
toggle_icons() {
    status=$(gsettings get org.gnome.desktop.background show-desktop-icons)
    if [ $status == 'true' ]; then
        gsettings set org.gnome.desktop.background show-desktop-icons false
    else
        gsettings set org.gnome.desktop.background show-desktop-icons true
    fi
}
weather() {
    echo "The time is: $(date +%T)"
    echo "Current topside temperature is: $(curl -s 'https://www.sinoptik.bg/vidin-bulgaria-100725905' | rg wfCurrentTemp | rg -o -e '\d{2}')°C" 
    echo "With an estimated high of: $(curl -s 'https://www.sinoptik.bg/vidin-bulgaria-100725905?location' | rg 'Максимална температура' | head -n 1 | rg -o -e '\d{2}')°C"
    echo "The humidity is at: $(curl -s 'https://www.sinoptik.bg/vidin-bulgaria-100725905' | rg wfCurrentValue | rg -o -e '\d{2}%')"
}
alias radio1='mpv http://stream.metacast.eu/radio1.opus'
download() {
    megadl --path=/mnt/hdd/ "$1" &&
    spd-say -t female2 'Download complete!'
}
synonyms_of() {
    trans "$1" | rg Synonyms:
}
### ###

### Environment Variables ###
export PS1="\[\e[01;34m\]JC\[\e[0m\]\[\e[2;16m\]\w$\[\e[0m\] "

export PATH="$PATH:/home/jagdcake/.yarn/bin"
export GOPATH=$HOME/Documents/go
### ###

