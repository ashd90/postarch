# Hyprland Setup Guide for Vanilla Arch Linux

## System Specifications
- **CPU:** Intel Core i5-10400 (12 threads) @ 4.30 GHz
- **GPU:** Intel UHD Graphics 630 @ 1.10 GHz (Integrated)

## Prerequisites

Before starting, ensure your system is up to date:

```bash
sudo pacman -Syu
```

## 1. Install Hyprland and Core Dependencies

### Base Hyprland Installation

```bash
sudo pacman -S hyprland xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland
```

### Graphics Drivers (Intel)

```bash
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver
```

## 2. Essential Hyprland Ecosystem Tools

### Window Management & Utilities

```bash
sudo pacman -S \
    hyprpaper \
    hypridle \
    hyprlock \
    hyprpicker \
    waybar \
    rofi-wayland \
    dunst \
    swayosd
```

### Notifications

```bash
sudo pacman -S dunst libnotify
```

### Authentication Agent

```bash
sudo pacman -S polkit-kde-agent
```

## 3. Additional Essential Tools

### Terminal & File Management

```bash
sudo pacman -S \
    kitty \
    thunar \
    gvfs \
    thunar-volman \
    tumbler \
    ffmpegthumbnailer
```

### Screenshot & Screen Recording

```bash
sudo pacman -S \
    grim \
    slurp \
    wl-clipboard \
    swappy
```

### Audio

```bash
sudo pacman -S \
    pipewire \
    wireplumber \
    pipewire-audio \
    pipewire-pulse \
    pipewire-alsa \
    pavucontrol
```

### Brightness Control

```bash
sudo pacman -S brightnessctl
```

### Bluetooth (Optional)

```bash
sudo pacman -S bluez bluez-utils blueman
sudo systemctl enable bluetooth.service
```

### Network Management

```bash
sudo pacman -S networkmanager nm-connection-editor
sudo systemctl enable NetworkManager.service
```

## 4. AUR Packages (Optional but Recommended)

Install an AUR helper first if you don't have one:

```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

### Useful AUR Packages

```bash
yay -S \
    hyprshade \
    wlogout \
    swaync \
    cliphist
```

## 5. Configuration Files

### Create Hyprland Config Directory

```bash
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/dunst
mkdir -p ~/.config/hypr/scripts
```

### Basic Hyprland Configuration

Create `~/.config/hypr/hyprland.conf`:

```bash
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# Monitor configuration
monitor=,preferred,auto,1

# Execute at launch
exec-once = waybar
exec-once = hyprpaper
exec-once = dunst
exec-once = /usr/lib/polkit-kde-authentication-agent-1
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store

# Environment variables
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct
env = QT_QPA_PLATFORM,wayland
env = GDK_BACKEND,wayland,x11
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland

# Intel GPU specific
env = WLR_DRM_DEVICES,/dev/dri/card0

# Input configuration
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = false
    }

    sensitivity = 0
}

# General settings
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle

    allow_tearing = false
}

# Decoration
decoration {
    rounding = 10

    blur {
        enabled = true
        size = 3
        passes = 1
        vibrancy = 0.1696
    }

    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animations
animations {
    enabled = true

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layouts
dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_status = master
}

# Gestures
gestures {
    workspace_swipe = false
}

# Misc settings
misc {
    force_default_wallpaper = 0
    disable_hyprland_logo = true
}

# Window rules
windowrulev2 = suppressevent maximize, class:.*

# Keybindings
$mainMod = SUPER

# Applications
bind = $mainMod, RETURN, exec, kitty
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, D, exec, rofi -show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,

# Screenshots
bind = , PRINT, exec, grim -g "$(slurp)" - | swappy -f -
bind = SHIFT, PRINT, exec, grim - | swappy -f -

# Move focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move window to workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through workspaces
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Media keys
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# Brightness keys
bind = , XF86MonBrightnessUp, exec, brightnessctl set 10%+
bind = , XF86MonBrightnessDown, exec, brightnessctl set 10%-
EOF
```

### Hyprpaper Configuration

Create `~/.config/hypr/hyprpaper.conf`:

```bash
cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/.config/hypr/wallpaper.jpg

wallpaper = ,~/.config/hypr/wallpaper.jpg

splash = false
EOF
```

Download a wallpaper or use your own:

```bash
# Example: Download a sample wallpaper
curl -o ~/.config/hypr/wallpaper.jpg https://w.wallhaven.cc/full/pk/wallhaven-pkz95g.jpg
```

### Dunst Configuration

Create `~/.config/dunst/dunstrc`:

```bash
cat > ~/.config/dunst/dunstrc << 'EOF'
[global]
    monitor = 0
    follow = mouse
    width = 300
    height = 300
    origin = top-right
    offset = 10x50
    scale = 0
    notification_limit = 0
    
    progress_bar = true
    progress_bar_height = 10
    progress_bar_frame_width = 1
    progress_bar_min_width = 150
    progress_bar_max_width = 300
    
    indicate_hidden = yes
    transparency = 0
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    text_icon_padding = 0
    frame_width = 3
    frame_color = "#8EC07C"
    separator_color = frame
    sort = yes
    
    font = Monospace 10
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    vertical_alignment = center
    show_age_threshold = 60
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes
    
    icon_position = left
    min_icon_size = 0
    max_icon_size = 32
    
    sticky_history = yes
    history_length = 20
    
    browser = /usr/bin/xdg-open
    always_run_script = true
    title = Dunst
    class = Dunst
    corner_radius = 10
    ignore_dbusclose = false
    
    mouse_left_click = close_current
    mouse_middle_click = do_action, close_current
    mouse_right_click = close_all

[urgency_low]
    background = "#282828"
    foreground = "#928374"
    timeout = 10

[urgency_normal]
    background = "#458588"
    foreground = "#EBDBB2"
    timeout = 10

[urgency_critical]
    background = "#CC241D"
    foreground = "#EBDBB2"
    frame_color = "#FABD2F"
    timeout = 0
EOF
```

## 6. Display Manager Setup (Optional)

If you want to use a display manager instead of starting Hyprland manually:

```bash
sudo pacman -S sddm
sudo systemctl enable sddm.service
```

## 7. Starting Hyprland

### Option 1: From TTY (Recommended for testing)

Add to `~/.bash_profile` or `~/.zprofile`:

```bash
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi
```

### Option 2: Manual Start

Just type in TTY:

```bash
Hyprland
```

## 8. Post-Installation Tips

### Enable Services

```bash
# Enable NetworkManager if not already enabled
sudo systemctl enable --now NetworkManager

# Enable Bluetooth if installed
sudo systemctl enable --now bluetooth
```

### Performance Tuning for Intel iGPU

Add to `~/.config/hypr/hyprland.conf`:

```
# Intel specific optimizations
env = LIBVA_DRIVER_NAME,iHD
env = VDPAU_DRIVER,va_gl
```

### Clipboard History

Since we installed cliphist, you can view clipboard history:

```bash
# Add this keybind to hyprland.conf
bind = $mainMod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
```

## 9. Troubleshooting

### If Hyprland crashes on start:

1. Check logs:
```bash
cat /tmp/hypr/$(ls -t /tmp/hypr | head -n 1)/hyprland.log
```

2. Start with minimal config:
```bash
Hyprland --config /dev/null
```

### If screen tearing occurs:

Add to hyprland.conf:
```
misc {
    vrr = 1
}
```

### If performance is poor:

Disable blur temporarily:
```
decoration {
    blur {
        enabled = false
    }
}
```

## 10. Package Maintenance

To avoid breaking updates like with omarchy:

1. **Always read Arch news before updating:**
   - Visit https://archlinux.org/news/

2. **Check Hyprland changelog:**
   - Visit https://github.com/hyprwm/Hyprland/releases

3. **Update safely:**
```bash
# Check for news first
sudo pacman -Syu
```

4. **If something breaks, rollback:**
```bash
# Downgrade specific package
sudo pacman -U /var/cache/pacman/pkg/hyprland-*.pkg.tar.zst
```

5. **Consider using snapshots:**
```bash
sudo pacman -S snapper
```

## 11. Your Waybar Config

Since you mentioned you have your own waybar config, place it in:
```
~/.config/waybar/config
~/.config/waybar/style.css
```

Waybar will automatically pick it up when launched by Hyprland.

## Complete Package List Summary

```bash
# Core Hyprland
sudo pacman -S hyprland xdg-desktop-portal-hyprland

# Intel Graphics
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver

# Hyprland Ecosystem
sudo pacman -S hyprpaper hypridle hyprlock hyprpicker waybar rofi-wayland dunst swayosd

# Essential Tools
sudo pacman -S kitty thunar gvfs thunar-volman tumbler ffmpegthumbnailer

# Media & Screenshots
sudo pacman -S grim slurp wl-clipboard swappy

# Audio
sudo pacman -S pipewire wireplumber pipewire-audio pipewire-pulse pipewire-alsa pavucontrol

# System
sudo pacman -S brightnessctl networkmanager polkit-kde-agent qt5-wayland qt6-wayland

# Optional AUR
yay -S hyprshade wlogout swaync cliphist
```

---

This setup should give you a stable, feature-complete Hyprland environment without the update issues you experienced with omarchy. All packages come from official Arch repositories (except the optional AUR packages), ensuring better stability and compatibility.
