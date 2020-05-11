#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="bstone"
rp_module_desc="Blake Stone - BStone A source port of Blake Stone: Aliens of Gold and Blake Stone: Planet Strike"
rp_module_licence="GPL2 https://raw.githubusercontent.com/bibendovsky/bstone/develop/LICENSE"
rp_module_help="For Aliens of Gold registered version, replace the shareware files in $romdir/ports/bstone/aog/ to play. These files for the registered version are required: AUDIOHED.BS6, AUDIOT.BS6, EANIM.BS6, GANIM.BS6, IANIM.BS6, MAPHEAD.BS6, MAPTEMP.BS6, SANIM.BS6, VGADICT.BS6, VGAGRAPH.BS6, VGAHEAD.BS6, VSWAP.BS6."
rp_module_section="exp"
rp_module_flags=""

function depends_bstone() {
    getDepends cmake libsdl2-dev libsdl2-net-dev libsdl2-mixer-dev libsdl2-image-dev timidity freepats
}

function sources_bstone() {
    gitPullOrClone "$md_build" https://github.com/bibendovsky/bstone.git dbf812f 033d35df0d5b6ea2b29450f9c335c86eb49a5c51
}

function build_bstone() {
    cd "$md_build/src"
    cmake "$md_build/src" -DCMAKE_BUILD_TYPE=Release
    make
    md_ret_require="$md_build/src"
}

function install_bstone() {
    md_ret_files=(
       'src/bstone'
    )
}

function game_data_bstone() {
    if [[ ! -f "$romdir/ports/bstone/aog/BS_AOG.EXE" ]]; then
        wget "https://ia800303.us.archive.org/30/items/BlakeStoneAliensOfGold/BSTONE.ZIP"
        unzip BSTONE.ZIP -d "$romdir/ports/bstone/aog/"
        rm -r BSTONE.ZIP
        chown -R $user:$user "$romdir/ports/bstone"
    fi
}

function configure_bstone() {
    addPort "$md_id" "bstone" "Blake Stone - Aliens of Gold" "$md_inst/bstone --data_dir $romdir/ports/bstone/aog"

    mkRomDir "ports/bstone"
    mkRomDir "ports/bstone/aog"

    moveConfigDir "$home/.local/share/bibendovsky/bstone" "$md_conf_root/bstone"

    [[ "$md_mode" == "install" ]] && game_data_bstone
}
