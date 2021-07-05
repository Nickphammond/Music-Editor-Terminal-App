




## Description

This is a terminal app for writing music.

Github : https://github.com/Nickphammond/Terminal-App-Asignment

<br>
<br>
<br>

## How to install

Dependencies
- Ruby
- rspec
- colorize
- timeout
- io-console
- wavefile
- suitable default media player capable of playing .wav files


To install
- '$ gem install bundler'
- '$ bundle install'

<br>
<br>
<br>
<br>

## Instructions

<br>
<br>

### Command line arguments

<br>

To run the program there are two ways:

<br>

1. To create a new file pass the desired name of the file as the first command line argument. If opening an existing file enter the path as the first argument.

    In more detail, enter the command:

    ``$ ruby start.rb {composition_name}``

    For example, if the name of the composition is 'my_composition', the command will be:

    ``$ ruby start.rb my_composition``

    If a file my_composition.txt exists within the working directory, this will open this file in the application.
    Otherwise, it will generate a NEW text file, my_composition.txt, which will then be opened in th application.

    (Please note that 
    ``$ ruby start.rb my_composition`` 
    corresponds to creating or opening the file my_composition.txt, do not use the .txt extention in the name of composition when passing it through the command, otherwise this will create a new composition my_composition.txt.txt)

<br>
OR
<br>

2. Simply use the command:

    ``$ ruby start.rb``

    This will then give you prompts which you can follow


<br>
<br>
<br>
<br>


### Main console

<br>

#### Navigating the piano scroll

<br>

The sheet can be navigated with the cursor. One can use the 'w', 's', 'a', 'd' keys to move the cursor: 

- 'w' for moving up, 
- 's' for moving down, 
- 'a' for moving left and 
- 'd' for moving right

The default step type for the cursor is to move one place for each keystroke. However this can be quite slow if one needs to move a large distance through the pianoscroll.
For this reason there is an option to change this default cursor movement from single steps, to a much larger jump. 
This cursor setting can be switched using the 'r' and 'f' keys with:

- 'r' putting the cursor into single step mode and 
- 'f' putting the cursor into single jump mode

The console also provides a visual way of knowing which state the cursor is in by highlighting the 'r' or 'f' blocks to the right of the piano scroll accordingly.

<br>
<br>
<br>

#### Editing the piano scroll

<br>

To place a note at the location of the cursor press: '1'
To delete a note at the location of the cursor press: 'l'

Note that when deleting a note, that the cursor is ACTUALLY over note, not simply cursor line. 

<br>
<br>
<br>

#### Playback of the piano scroll

<br>

To start playback of composition press: 'p'
To stop playback of compositopn press: 'x'

<br>
<br>
<br>

#### Quiting and saving

<br>
To quit first make sure you are in edit and not playback mode and then press: 'q'
You will be the prompted with an option to save: 'y'(yes) or 'n'(no) and the enter