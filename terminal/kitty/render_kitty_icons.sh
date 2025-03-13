#!/bin/bash
set -eu
if ! command -v magick &>/dev/null; then
    >&2 echo "ERROR: imagemagick 'magick' command not in PATH."
    exit 1
fi
# small images with thin borders can benefit from darker edge blending
[[ ${1:-} == --fluxbox ]] && alpha_multiplier=5 && shift
[[ ${1:-} == --alpha-multiplier=* ]] && alpha_multiplier=${1#*=} && shift
if [[ ${#} -ne 1 ]]; then
    >&2 echo "USAGE: ${0} [--fluxbox | --alpha-multiplier=*] <svg_path>"
    exit 1
fi
svg_path=${1}
metadata=$(magick identify -format "%w %h" "${svg_path}")
source_width=${metadata%% *}
source_height=${metadata##* }

render_image() {
    if [[ ${#} -ne 3 ]]; then
        >&2 printf '%s' \
            "USAGE: render_image <width> <height> <output_file>"
        return 1
    fi
    local dest_width=${1}
    local dest_height=${2}
    local dest_file=${3}
    local render_args=(-background none)
    local convert_args=()
    if [[ ${source_width} != "${dest_width}" \
            || ${source_height} != "${dest_height}" ]]; then
        local density_x=$(( dest_width * 100 / source_width ))
        local density_y=$(( dest_height * 100 / source_height ))
        local density=$(( density_x < density_y ? density_x : density_y ))
        render_args+=(-density "${density}")
        convert_args+=(-resize "${dest_width}x${dest_height}")
    fi
    if [[ ${alpha_multiplier:-1} -ne 1 ]]; then
        convert_args+=(-channel A -evaluate multiply "${alpha_multiplier}")
    fi
    echo "Generating \"${dest_file}\":"
    echo "- render arguments: ${render_args[*]}"
    echo "- conversion arguments: ${convert_args[*]}"
    magick "${render_args[@]}" "${svg_path}" "${convert_args[@]}" "${dest_file}"
}

render_image 128 128 kitty.app-128.png
render_image 512 512 kitty.app.png
