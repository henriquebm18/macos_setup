#!/bin/bash

echo "hello there..."

check_sudo() {
  if sudo -n true 2>/dev/null; then
    echo "you are in the sudo group"
    return 0
  else
    echo "!!! YOU HAVE NO RIGHTS !!!"
    return 1
  fi
}

echo "user-level settings"

# trackpad
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# defaults write -g com.apple.swipescrolldirection -bool true

# keyboard
defaults write -g ApplePressAndHoldEnabled -bool false

# dock
defaults write com.apple.dock orientation left
defaults write com.apple.dock autohide -bool true
# defaults write com.apple.dock autohide-delay -float 0
# defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock show-recents -bool false
killall Dock

# finder
defaults write com.apple.finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder

# shuffle 
defaults write com.apple.screencapture type JPG
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 7
defaults write -g PMPrintingExpandedStateForPrint -bool TRUE


# well...
install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already in the system"
  else
    echo "installing homebrew locally"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null
    # change path to the user to avoid needing sudo
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_homebrew

if check_sudo; then
  sudo nvram StartupMute=%00
  sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "TEXT TO REPLACE"
fi

echo
echo "Some still need manual intervention:"
echo "- Touch ID"
echo "- Accessibility (zoom, trackpad and others)"
echo "- Hot Corners"
echo "- Network priority"
echo "- True Tone + Night Shift"
echo "- Siri & Spotlight"
echo "- Privacy and Lock Screen"

echo
echo "eos"

