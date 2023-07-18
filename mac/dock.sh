#!/bin/sh

dockutil --no-restart --remove all

dockutil --no-restart --add "/System/Applications/Music.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/System/Applications/Reminders.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/Applications/zoom.us.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Postman.app"
dockutil --no-restart --add "/Applications/Docker.app"
dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"
dockutil --no-restart --add "$HOME/Downloads"

killall Dock
