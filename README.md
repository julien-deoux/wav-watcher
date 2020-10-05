# wav-watcher

Simple Shell script to automatically encode WAV files into MP3, OGG and FLAC.

## Dependencies

* lame
* oggenc (part of vorbis-tools)
* flac
* inotifywait (part of inotify-tools)

## Usage

Run the `watch.sh` script. It should create a `wav` folder at the root of this repo.

In your DAW, export your project in that `wav` folder, using filename `<album-name>--<song-name>.wav`.

As soon as the export is finished, the script should pick it up, create the necessary directories, and encode that WAV file into the desired format.

## Possible improvements

* Handle tags. Right now, the generated files don't have any tag.
* Allow more flexibility regarding directories, using a config file or command line parameters or something.
* Maybe allow for a custom separator in the WAV filename.
* Maybe add a system tray icon.

