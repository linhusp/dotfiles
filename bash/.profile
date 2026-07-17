# Make local programs callable
export PATH="$HOME/.local/bin:$PATH"

# XDG base directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

# Import Environment Variables from systemd/environment.d
# This ensures TTYs and SSH sessions match the graphical session.
# --------------------------------------------------------------------
# Loop through user environment configs
if [ -d "$HOME/.config/environment.d" ]; then
    # Automatically exports any variables defined in the sourced files
    set -a

    # Source every .conf file
    for file in "$HOME/.config/environment.d"/*.conf; do
        if [ -f "$file" ]; then
            . "$file"
        fi
    done

    # Stop exporting
    set +a
fi
# --------------------------------------------------------------------

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    # Wayland backends
    export QT_QPA_PLATFORM=wayland
    export EGL_PLATFORM=wayland
    export CLUTTER_BACKEND=wayland
    export ELECTRON_OZONE_PLATFORM_HINT=auto

    # QT scaling
    # export QT_AUTO_SCREEN_SCALE_FACTOR=1
    # export QT_ENABLE_HIGHDPI_SCALING=1
    export QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor

    # Input method
    # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
    export XMODIFIERS=@im=fcitx
fi

# Stop them from solving garbages into the home directory
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export PATH="$CARGO_HOME/bin:$GOPATH/bin:$PATH"

# Use nvim as man viewer
export MANPAGER="nvim +Man!"

# Use nvim as the default editor
export EDITOR="nvim"
export VISUAL="nvim"
