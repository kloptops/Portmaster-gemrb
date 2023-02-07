# Portmaster-GemRB


This is the configuration files and the required steps to build the GemRB engine for handheld emulator devices (Anbernic RG353V, etc.) using the Portmaster scripts for launching.


# Installation

Use portmaster to install gemrb, copy the desired game or games into `{PORTFOLDER}/gemrb/games/{GAMENAME}`. On launch it will ask you to choose the game if it detects multiple games.

# Controls

## Required libs

- the following libraries from Debian 11 Bullseye Aarch64
  - libpython3.9 & library files

 
## Building

    git clone https://github.com/kloptops/gemrb.git

    cd gemrb

    mkdir build

    cd build

    cmake .. -DOPENGL_BACKEND=GLES -DCMAKE_BUILD_TYPE=Debug -DLAYOUT=home  -DUSE_ICONV=OFF -DDISABLE_VIDEOCORE=ON -DUSE_LIBVLC=OFF -DCMAKE_INSTALL_PREFIX:FILE="engine"

    cd engine

    zip -vr ../engine.zip engine/

    cd ..

At the end, you want the `engine.zip` file is what you want.

# Game folder structure

- gemrb/games/GAME_NAME
  - INSTALLED GAME FILES
  - CD1/
    - CD 1 FILES
  - CD2/
    - CD 2 FILES
  - CD3/
    - CD 3 FILES
  - CD4/
    - CD 4 FILES

# TODO:

- [ ] Get a game to work!


# Thanks

A special thanks to the excellent folks on the [AmberELEC discord](https://discord.com/invite/R9Er7hkRMe).
