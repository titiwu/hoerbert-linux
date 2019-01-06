#!/bin/bash
DATE=$(date '+%m-%d-%Y')
TIME=$(date '+%H:%M:%S')

# Start a new file
echo "Start converting at $DATE $TIME with PID $$"

# Look for subdirectories and convert all mp3 and ogg files to WAV for Hoerbert
# - Folder
#   |_ mp3toHoerbert.sh
#   |_ Folder1
#   |  |_ Song1.mp3
#   |  |_ Song2.ogg
#   |_ SDCARD <- created by script
#      |_Folder1
#         |_0.WAV
#         |_1.WAV

output_dir=SDCARD
mkdir -p $output_dir
for my_dir in *; do 
  if [[ -d ${my_dir} && ! ${my_dir} == $output_dir ]]; then 
    echo Found folder ${my_dir}
    cd "${my_dir}"
    a=0
    # Encode to WAV
    mkdir -p "../$output_dir/${my_dir}"
    find -iname "*.mp3" -o -iname "*.ogg" | sort -n | while read i; do
      new=$(printf "%d" "$a")
      output_file="../${output_dir}/${my_dir}/${new}.WAV"
      sox --buffer 131072 --multi-threaded --no-glob "$i" --clobber -r 32000 -b 16 -e signed-integer --no-glob "${output_file}" remix - gain -n -1.5 bass +1 loudness -1 pad 0 0 dither
      # If returncode == 0
      if [ $? -eq 0 ];then
        echo "\"${my_dir}/${i}\" converted to \"${output_file}\""
      else
        echo "failed decoding \"${my_dir}/${i}\""
      fi
      let a=a+1
    done
    cd ..
  fi 
done

echo "Finished converting at $DATE $TIME with PID $$"
