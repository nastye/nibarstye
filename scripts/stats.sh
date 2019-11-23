#!/bin/bash

PATH=/usr/local/bin/:$PATH

# Check if date exists
if ! [ -x "$(command -v date)" ]; then
  echo "{\"error\":\"date binary not found\"}"
  exit 1
fi

# Check if pmset exists
if ! [ -x "$(command -v pmset)" ]; then
  echo "{\"error\":\"pmset binary not found\"}"
  exit 1
fi

# Check if egrep exists
if ! [ -x "$(command -v egrep)" ]; then
  echo "{\"error\":\"egrep binary not found\"}"
  exit 1
fi

# Check if cut exists
if ! [ -x "$(command -v cut)" ]; then
  echo "{\"error\":\"cut binary not found\"}"
  exit 1
fi

# Check if memory_pressure exists
if ! [ -x "$(command -v memory_pressure)" ]; then
  echo "{\"error\":\"memory_pressure binary not found\"}"
  exit 1
fi

# Check if sysctl exists
if ! [ -x "$(command -v sysctl)" ]; then
  echo "{\"error\":\"sysctl binary not found\"}"
  exit 1
fi

# Check if osascript exists
if ! [ -x "$(command -v osascript)" ]; then
  echo "{\"error\":\"osascript binary not found\"}"
  exit 1
fi

# Check if df exists
if ! [ -x "$(command -v df)" ]; then
  echo "{\"error\":\"df binary not found\"}"
  exit 1
fi

# Check if grep exists
if ! [ -x "$(command -v grep)" ]; then
  echo "{\"error\":\"grep binary not found\"}"
  exit 1
fi

# Check if sed exists
if ! [ -x "$(command -v sed)" ]; then
  echo "{\"error\":\"sed binary not found\"}"
  exit 1
fi

# Check if awk exists
if ! [ -x "$(command -v awk)" ]; then
  echo "{\"error\":\"awk binary not found\"}"
  exit 1
fi

# Check if networksetup exists
if ! [ -x "$(command -v networksetup)" ]; then
  echo "{\"error\":\"networksetup binary not found\"}"
  exit 1
fi

# Check if shpotify exists
if ! [ -x "$(command -v spotify)" ]; then
  echo "{\"error\":\"shpotify binary not found\"}"
  exit 1
fi

# Check if tr exists
if ! [ -x "$(command -v tr)" ]; then
  echo "{\"error\":\"tr binary not found\"}"
  exit 1
fi

export LC_TIME="en_US.UTF-8"
TIME=$(date +"%H:%M")
DATE=$(date +"%a %d/%m")

BATTERY_PERCENTAGE=$(pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d'%')
BATTERY_STATUS=$(pmset -g batt | grep "'.*'" | sed "s/'//g" | cut -c 18-19)
BATTERY_REMAINING=$(pmset -g batt | egrep -o '([0-9]+%).*' | cut -d\  -f3)

BATTERY_CHARGING=""
if [ "$BATTERY_STATUS" == "BA" ]; then
  BATTERY_CHARGING="false"
elif [ "$BATTERY_STATUS" == "AC" ]; then
  BATTERY_CHARGING="true"
fi

LOAD_AVERAGE=$(sysctl -n vm.loadavg | awk '{print $2}')

WIFI_STATUS=$(ifconfig en0 | grep status | cut -c 10-)
WIFI_SSID=$(networksetup -getairportnetwork en0 | cut -c 24-)

ETHERIP=`ifconfig en0 | grep -E "(inet |status:)" | head -n 1 | awk '{ print $2}'`
AIRIP=`ifconfig en1 | grep -E "(inet |status:)" | head -n 1 | awk '{ print $2}'`

VOLUME=$(osascript -e 'output volume of (get volume settings)')
if [ "$VOLUME" == "missing value" ]; then
  VOLUME="external"
  IS_MUTED="false"
else
  IS_MUTED=$(osascript -e 'output muted of (get volume settings)')
fi

SPOTIFY_ARTIST=""
SPOTIFY_TRACK=""
SPOTIFY_PLAYING=""
if [ "$(osascript -e 'application "Spotify" is running')" == "true" ]; then
  SPOTIFY_ARTIST=$(osascript -e 'tell application "Spotify" to artist of the current track')
  SPOTIFY_TRACK=$(osascript -e 'tell application "Spotify" to name of the current track')
  SPOTIFY_PLAYING=$(osascript -e 'tell application "Spotify" to player state')
fi

echo $(cat <<-EOF
{
  "datetime": {
    "time": "$TIME",
    "date": "$DATE"
  },
  "battery": {
    "percentage": "$BATTERY_PERCENTAGE",
    "charging": "$BATTERY_CHARGING",
    "remaining": "$BATTERY_REMAINING"
  },
  "cpu": {
    "loadAverage": "$LOAD_AVERAGE"
  },
  "wifi": {
    "status": "$WIFI_STATUS",
    "ssid": "$WIFI_SSID"
  },
  "volume": {
    "value": "$VOLUME",
    "mute": "$IS_MUTED"
  },
  "spotify": {
    "artist": "$SPOTIFY_ARTIST",
    "track": "$SPOTIFY_TRACK",
    "playing": "$SPOTIFY_PLAYING"
  }
}
EOF
)
