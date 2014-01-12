#!/bin/bash
# Script to render icons in various sizes

USAGE="usage: $0 <listfile> <size> <input-directory> <output-directory>"

if [[ $# -ne 4 ]]; then
    echo $USAGE >& 2
    exit 1
fi

LISTFILE="$1"
SIZE="$2"
IN_DIR="$3"
OUT_DIR="$4"

NAMES=()
while read -a NAMES; do
    IN_NAME="$IN_DIR/${NAMES[0]}.svg"
    OUT_NAME="$OUT_DIR/${NAMES[0]}.png"
    ADDITIONAL_NAMES=${NAMES[@]:1}

    # Convert the file
    convert -quiet "$IN_NAME" -resize ${SIZE}x${SIZE} "$OUT_NAME" 
    
    # Render additional names
    for NAME in ${ADDITIONAL_NAMES[@]}; do
        ln -s "${NAMES[0]}.png" "$OUT_DIR/${NAME}.png"
    done

done < "$LISTFILE"
