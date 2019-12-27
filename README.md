# Hörbert Helper for Linux
Helper script for converting audio files for the music player for children

[Hörbert](https://www.hoerbert.com/) is a mp3 player for children which requires Mono-WAV files for energy saving playback. 
For Windows and Mac graphical tools are provided, for Linux so far only the `sox` command is advised to used (manually).

## mp3toHoerbert.sh 
Looks for subdirectories in the active directory and convert all mp3 and ogg files to WAV for Hoerbert
```
 _ Folder
   |_ mp3toHoerbert.sh
   |_ Folder1
   |  |_ Song1.mp3
   |  |_ Song2.ogg
   |_ SDCARD <- created by script
      |_ Folder1
         |_ 0.WAV
         |_ 1.WAV
```

Usage `# .\mp3toHoerbert.sh`

Rename all folders in the "SDCARD" folder from 0 to (maximum) 8 in the desired order (assigns folders/music to Hoerberts buttons).

Copy all folders to the SD-card an put it into Hoerbert! 
