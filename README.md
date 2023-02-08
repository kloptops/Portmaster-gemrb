# Portmaster-GemRB


This is the configuration files and the required steps to build the GemRB engine for handheld emulator devices (Anbernic RG353V, etc.) using the Portmaster scripts for launching.


# Installation

Use portmaster to install gemrb, copy the desired game or games into `{PORTFOLDER}/gemrb/games/{GAME_ID}`. On launch it will ask you to choose the game if it detects multiple games.

# Controls

- R1/A: Left Click
- L1/B: Right Click
- L2: Priest spells
- R2: Wizard spells
- X: Inventory
- Y: Character Record
- Select+L1: Quick Save
- Start: pause
- Select: options
- Up: Map
- Down: Journal
- Left: Toggle AI
- Right: Character Arbitration
- Left Stick: Move cursor
- Right Stick: Move screen

To enter text: press Start + Right, up and down selects the letter, left and right moves forwards and backwards. Start or A to get out.

## Required libs

- the following libraries from Debian 11 Bullseye Aarch64
  - libpython3.9 & library files

 
## Building

    git clone https://github.com/kloptops/gemrb.git

    cd gemrb

    mkdir build

    cd build

    cmake .. -DOPENGL_BACKEND=GLES -DCMAKE_BUILD_TYPE=Release -DLAYOUT=home  -DUSE_ICONV=OFF -DDISABLE_VIDEOCORE=ON -DUSE_LIBVLC=OFF -DCMAKE_INSTALL_PREFIX:FILE="engine"

    cd engine

    zip -9r ../engine.zip engine/

    cd ..

At the end, you want the `engine.zip` file is what you want.

# Game folder structure

- gemrb/games/GAME_ID
 - **bg1** for Baldur's Gate 1
 - **bg2** for Baldur's Gate 2
 - **iwd** for Icewind Dale
 - **iwd2** for Icewind Dale 2
 - **pst** for Planescape Torment

# TODO:

- [x] Get a game to work!
- [ ] Add custom configs where needed
- [ ] Add custom gptokeyb mappings if needed
- [ ] Fix flickering cursor

# Thanks

A special thanks to the excellent folks on the [AmberELEC discord](https://discord.com/invite/R9Er7hkRMe).
