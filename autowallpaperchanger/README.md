## autowallpaperchanger
Auto Wallpaper Changer with gnome based desktops.


## Dependencies
- xdg-user-dirs
- gsettings

https://user-images.githubusercontent.com/62564400/145715804-ca2444ed-e09a-4e38-a241-b8186935c227.mp4


## Install
```
git clone (this repo)

cd autowallpaperchanger

mkdir -p $HOME/.local/bin $HOME/.config/autostart

install -Dm755 ./autowallpaperchanger $HOME/.local/bin/autowallpaperchanger
```

## Usage
#### Initial setup: "Generates autostart( \~/.config/autostart/autowallpaperchanger.desktop ) file and config ( \~/.config/autowallpaperchanger.conf ) file"
```autowallpaperchanger first```

## Pin wallpaper
```autowallpaperchanger pin```

## Unpin wallpaper
```autowallpaperchanger unpin```

## Show current wallpaper name
```autowallpaperchanger show```

## Reload script
```autowallpaper reload```

## Stop script current session
```autowallpaper stop```

## Remove this installation
```autowallpaper remove```

#### Configuring:
```nano ~/.config/autowallpaperchanger.conf
##############################
#
## WALLPAPER DIRECTORY PATH
#
##############################
WALLPATH="/home/USER/Pictures/Wallpapers"   <- Wallpapers directory
EXTENSIONS="jpg,png,jpeg"                   <- File extensions

##############################
#
## CHANGER DURATION
#
##############################
DURATION="1m"                               <- Changer duration
```

## Changelog
```
v2.0 : Added pin and unpin mode
v1.1 : Script cleaned
v1.0 : Initial setup
```
