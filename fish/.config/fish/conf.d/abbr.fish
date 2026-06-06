# Special
function last_history_item
    echo $history[1]
end
abbr -ag !! --position anywhere --function last_history_item

# Git
abbr -ag gc 'git clone'
abbr -ag ga 'git add'
abbr -ag gb --set-cursor 'git branch%'
abbr -ag gcm --set-cursor 'git commit -m "%"'
abbr -ag gco 'git checkout'
abbr -ag gd --set-cursor 'git diff%'
abbr -ag gl --set-cursor 'git log%'
abbr -ag gm 'git merge'
abbr -ag gr --set-cursor 'git remote%'
abbr -ag gss --set-cursor 'git status%'

# Alternative
abbr -ag py 'python'
# abbr -ag monkey --set-cursor 'smassh%'
abbr -ag au --set-cursor 'as-cmd -b%'
abbr -ag rename --position anywhere 'mmv'
abbr -ag clock --set-cursor 'tty-clock -c%'
abbr -ag pick --set-cursor 'hyprpicker%'
abbr -ag sv 'sudo -Es nvim'
abbr -ag svd 'sudo -Es nvim -d'
abbr -ag hh --position anywhere --set-cursor '~/%'
abbr -ag hhd --position anywhere --set-cursor '~/.%'
abbr -ag sf --set-cursor 'exec fish%'
abbr -ag fd 'fd -gH'
abbr -ag tree 'tree -C'
abbr -ag t1 'tree -C -L 1'
abbr -ag t2 'tree -C -L 2'
abbr -ag ta 'tree -C -a'
abbr -ag tng 'tree -C -a -I .git/'
abbr -ag pcache --set-cursor 'paru -Scad%'
# abbr -ag paru 'yay'
# abbr -ag yy 'yay'
abbr -ag ss 'paru -Ss'
abbr -ag pa 'sudo pacman'
abbr -ag sy --set-cursor 'sudo pacman -Syu%'
abbr -ag pu --set-cursor 'paru -Sua%'
abbr -ag mt 'neo-matrix -aFs'
abbr -ag testvram 'memtest_vulkan'
abbr -ag wt 'curl wttr.in/Hochiminh+City?0dFqp'
abbr -ag rebuild 'kbuildsycoca6 --noincremental'
abbr -ag disk 'ncdu'

# Config shortcuts
abbr -ag cf --set-cursor 'cd ~/.config%'
# abbr -ag cfv --set-cursor 'nvim -c "cd ~/.config/nvim" ~/.config/nvim%'
abbr -ag cfv --set-cursor 'nvim ~/.config/nvim%'
abbr -ag cff --set-cursor 'nvim ~/.config/fish%'
abbr -ag cfff --set-cursor 'sudo -Es nvim /etc/fish%'
abbr -ag cft --set-cursor 'nvim ~/.config/tmux/tmux.conf%'
abbr -ag cfn --set-cursor 'nvim ~/.config/niri/config.kdl%'
abbr -ag nr --set-cursor 'niri-session%'
# abbr -ag wcp --set-cursor 'wl-copy %'
# abbr -ag wp --set-cursor 'wl-paste > %'

# Get the best rated mirrors
# abbr -ag mirror --set-cursor 'sudo reflector --country Vietnam,Singapore,Japan --latest 6 --sort rate --save /etc/pacman.d/mirrorlist%'
abbr -ag mr --set-cursor 'sudo rate-mirrors --allow-root --max-mirrors-to-output 10 --save /etc/pacman.d/mirrorlist arch%'

# Download yt as audio
abbr -ag dlm 'yt-dlp --extract-audio --audio-format best --audio-quality 0 --ignore-errors -o "%(title)s.%(ext)s"'

# Vpn/Proxy services
abbr -ag won --set-cursor 'warp-cli connect%'
abbr -ag woff --set-cursor 'warp-cli disconnect%'
abbr -ag warp --set-cursor 'warp-cli status%'
# abbr -ag warpc --set-cursor 'curl https://www.cloudflare.com/cdn-cgi/trace/ 2>/dev/null | grep warp%'
abbr -ag von --set-cursor 'mullvad connect%'
abbr -ag voff --set-cursor 'mullvad disconnect%'
# abbr -ag vpn --set-cursor 'sudo systemctl start wg-quick@protonvpn.service%'
abbr -ag vpn --set-cursor 'mullvad status%'

# Run fish in private mode
abbr -ag fip 'fish -P'

# Open custom tmux
abbr -ag tm --set-cursor 'tmux a -t %'

# Open Dolphin in current dir
abbr -ag dol --set-cursor 'dolphin --select . &%'

# Reboot to different boot
abbr -ag rebootc --set-cursor 'systemctl reboot --boot-loader-entry=%.conf'
# Reboot to firmware
abbr -ag rebootf 'systemctl reboot --firmware-setup'

# Timeshift
abbr -ag tsc --set-cursor 'sudo timeshift --create --comments "%"'
abbr -ag tsl --set-cursor 'sudo timeshift --list%'
abbr -ag tsd --set-cursor 'ts-delete%'

# Run plasma desktop on tty
abbr -ag run-plasma 'dbus-run-session startplasma-wayland'
