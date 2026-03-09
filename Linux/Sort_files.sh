#!/bin/bash

SOURCE_DIR="/home/muhammad-abdullah/Downloads"
IMAGES=("jpg" "png" "jpeg")
VIDEOS=("mp4" "mkv" "avi")
DOCUMENTS=("pdf" "docx" "xlsx" "pptx" "txt")

ABS_DEST=$(readlink -f "$SOURCE_DIR")

mkdir -p "$ABS_DEST/Images" "$ABS_DEST/Videos" "$ABS_DEST/Documents" "$ABS_DEST/Others"

for file in "$ABS_DEST"/*; do
    [ -d "$file" ] && continue  
    ext="${file##*.}"
    ext="${ext,,}"  # convert to lowercase

    if [[ " ${IMAGES[@]} " =~ " $ext " ]]; then
        mv "$file" "$ABS_DEST/Images/"
    elif [[ " ${VIDEOS[@]} " =~ " $ext " ]]; then
        mv "$file" "$ABS_DEST/Videos/"
    elif [[ " ${DOCUMENTS[@]} " =~ " $ext " ]]; then
        mv "$file" "$ABS_DEST/Documents/"
    else
        mv "$file" "$ABS_DEST/Others/"
    fi
done


echo "Successful🫡"