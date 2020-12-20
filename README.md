




## Description

This is a terminal app for writing music.

Github : https://github.com/Nickphammond/Terminal-App-Asignment



## How to install and run

Dependencies
- Ruby
- rspec
- colorize
- timeout
- io-console
- wavefile
- suitable default media player capable of playing .wav files


To install and run
- '$ gem install bundler'
- '$ bundle install'
- '$ ruby index.rb'


## Instructions

### Command line arguments

To create a new file pass the desired name of the file as the first command line argument. If opening an existing file enter the path as the first argument.

### Main console

The sheet can be navigated with the cursor using: 'w'(up), 's'(down), 'a'(left) and 'd'(right)
The cursor can be switched with 'r'(step) and 'f'(jump)
To place a note at the location of the cursor press: '1'
To delete a note at the location of the cursor press: 'l'
To start playback of composition press: 'p'
To stop playback of compositopn press: 'x'
To quit first make sure you are in edit and not playback mode and then press: 'q'
You will be the prompted with an option to save: 'y'(yes) or 'n'(no) and the enter