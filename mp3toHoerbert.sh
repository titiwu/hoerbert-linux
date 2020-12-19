#!/bin/bash
DATE=$(date '+%m-%d-%Y')
TIME=$(date '+%H:%M:%S')

# Start a new file
start_time=`date +%s`
echo "INFO: Start converting at $DATE $TIME with PID $$"

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
dirnum=0
mkdir -p $output_dir

# Function for converting files
convert_file () {
      local file_name=$i
      local output_file="../${output_dir}/${dirnum}/${new}.WAV"
      sox --buffer 131072 --multi-threaded --no-glob "$file_name" --clobber -r 32000 -b 16 -e signed-integer --no-glob "${output_file}" remix - gain -n -1.5 bass +1 loudness -1 pad 0 0 dither
      # If returncode == 0
      if [ $? -eq 0 ];then
        echo "INFO: \"${my_dir}/${file_name}\" converted to \"${output_file}\""
      else
        echo "WARNING: failed decoding \"${my_dir}/${file_name}\""
      fi
}

# Loop over all files
for my_dir in *; do 
  if [[ -d ${my_dir} && ! ${my_dir} == $output_dir ]]; then 
    echo "INFO: Found folder \"${my_dir}\""
    cd "${my_dir}"
    a=0
    # Encode to WAV
    mkdir -p "../$output_dir/${dirnum}"
    while read i; do
        new=$(printf "%d" "$a")
        convert_file &
        let a=a+1
    done < <(find -iname "*.mp3" -o -iname "*.ogg" -o -iname "*.wav" | sort -n)
    let dirnum=dirnum+1
    cd ..
  fi
done
wait
echo "INFO: Finished! Converting took $(expr `date +%s` - $start_time) s"
