#!/usr/bin/env bash
# Future Tone Proton Helper

## Config: ##
##
STEAMAPPID="2643947249" # Insert your non-Steam Shortcut for Future Tone here.
PROTONVERSIONNAME="Proton - Experimental" # Insert the directory for the version of Proton you are using for the game. Should be in the Steamapps/Common folder.
PROTONSUBDIRECTORYNAME="files" # In the case of Proton Experimental, they use the "files" folder before going into bin/wine.
# This is where you should put the Steam library that you are running the game from, as the compatdata directory with the required Proton prefix will be there.
# For the local Steam install folder, this would be "/home/$USER/.steam/steam".
PREFIXINSTALL="/home/$USER/.steam/steam"
STEAMINSTALL="/home/$USER/.steam"

## Script Functionality begins here: ##
function SetupRedistributables()
{
    curl -O https://download.visualstudio.microsoft.com/download/pr/144a5711-f076-44fa-bf55-f7e0121eb30c/B7AE307237F869E09F7413691A2CD1944357B5CEE28049C0A0D3430B47BB3EDC/VC_redist.x86.exe
    curl -O https://download.visualstudio.microsoft.com/download/pr/d22ecb93-6eab-4ce1-89f3-97a816c55f04/37ED59A66699C0E5A7EBEEF7352D7C1C2ED5EDE7212950A1B0A8EE289AF4A95B/VC_redist.x64.exe
    curl -O https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0fd66638cde16859462a6243a4629a50/ndp48-x86-x64-allos-enu.exe

    export WINEPREFIX="$PREFIXINSTALL/steamapps/compatdata/$STEAMAPPID/pfx"

    "$STEAMINSTALL/steam/steamapps/common/$PROTONVERSIONNAME/$PROTONSUBDIRECTORYNAME/bin/wine" ndp48-x86-x64-allos-enu.exe /q
    "$STEAMINSTALL/steam/steamapps/common/$PROTONVERSIONNAME/$PROTONSUBDIRECTORYNAME/bin/wine" VC_redist.x64.exe /quiet /norestart
    "$STEAMINSTALL/steam/steamapps/common/$PROTONVERSIONNAME/$PROTONSUBDIRECTORYNAME/bin/wine" VC_redist.x86.exe /quiet /norestart

    echo "Make sure to use "WINEDLLOVERRIDES="dinput8=n,b","dnsapi=n,b" %command%" in the launch parameters for the game's non-Steam shortcut."
}

SetupRedistributables