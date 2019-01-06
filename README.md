# Hörbert Helper for Linux
Helper script for converting audio files for the music player for children

Hörbert is a mp3 player for children which requires Mono-WAV files for energy saving playback. 
For Windows and Mac graphical tools are provided, for Linux so far only the `sox` command.

## mp3toHoerbert 
Look for subdirectories in the active directory and convert all mp3 and ogg files to WAV for Hoerbert
```
 - Folder
   |_ mp3toHoerbert.sh
   |_ Folder1
   |  |_ Song1.mp3
   |  |_ Song2.ogg
   |_ SDCARD <- created by script
      |_Folder1
         |_0.WAV
         |_1.WAV
```