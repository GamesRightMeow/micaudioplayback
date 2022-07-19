# Mic Audio Playback
A simple audio playback app for quickly testing audio on a Playdate. The app is intended for recording audio over [a supported audio cable](#supported-audio-cable) but you can also record input from the Playdate's built-in mic.

## Quickstart
1. [Install the app](#install).
1. Plug the [audio cable](#supported-audio-cable) into your computer's headphone/audio out jack.
1. Plug the other end into your Playdate.
1. Play audio on your computer i.e. open your game in the Simulator or Pulp.
1. Press A to start recording audio on your Playdate.
1. After a few moments, press B to playback the audio over the Playdate's speakers.
1. Use the crank to adjust the gain/volume.

## Install
Download the [latest release](https://github.com/GamesRightMeow/micaudioplayback/releases) or [build](#build) the project locally. Then refer to [the official Panic documentation about sideloading games](https://help.play.date/games/sideloading/).

## Build
If using VS Code, there are 3 tasks configured in [tasks.json](/.vscode/tasks.json):
- `buildPdx`: builds the PDX from the `src` folder.
- `runSimulator`: runs the built PDX in the Playdate Simulator.
- `buildRunSimulator`: runs `buildPdx` then `runSimulator`.

Otherwise, see [the official Panic documentation on compiling and running a Playdate project](https://sdk.play.date/Inside%20Playdate.html#_compiling_a_project).

## Supported audio cable
In order to correctly send audio to your Playdate, you need to use a cable with TRRS (Tip, Ring, Ring, Sleeve) 3.5mm audio connectors on both ends. This type of cable supports sending stereo audio as well as mic input. You can usually identify these cables by checking if there are 3 rings around the tip of the connector.