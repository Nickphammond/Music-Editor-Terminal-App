require_relative "piano_roll.rb"
require "colorize"
require "io/console"



position = [20,25]

qfile =  ''


if ARGV[0] == nil

    puts "Please enter the name of the composition you wish to open or create:"
    qfile = gets.chomp

else
    qfile =  ARGV[0]
    if ARGV[1] != nil 
        if ARGV[1] == 'i'
            b = " ".colorize(:color => :light_black, :background => :light_green)


            puts '                          '+b+b+' '+b+b+'    '  +b+b+   '   ' +b+b+b+b+       '  ' + b+b+b+b+b+b+b+b+' '   +b+b+b+b+b+b+b+  '  '+b+b+'    '+b+b+' '+'   '+b+b+b+   '   '    +b+b+b+b+b+b+b+b+' '  +b+b+'    '+b+b+b+    '    '   +b+b+'    '  +b+b+    '   ' +b+b+b+b+                    "\n"+\
                '                          '+b+b+' '+b+b+b+'   ' +b+b+   ' ' +b+b+'    '+b+b+  '  ' + ' '+b+b+'    '        +b+b+'    '+b+b+  ' '+b+b+'    '+b+b+' '+' '+b+b+'   '+b+b+'    '   +b+b+        '    '+b+b+'  '+b+b+'   '+b+b+ '  '  +b+b+b+'   ' +b+b+    ' ' +b+b+'    '+b+b+               "\n"+\
                '                          '+b+b+' '+b+b+b+b+'  '+b+b+   ' ' +b+b+'     '+     '  ' + '  '+b+b+'    '       +b+b+'    '+b+b+  ' '+b+b+'    '+b+b+' '+b+b+         '          '  +b+b+        '    '+b+b+' '+b+b+'     '+b+b+ ' '  +b+b+b+b+'  '+b+b+    ' ' +b+b+'     '+                  "\n"+\
                '                          '+b+b+' '+b+b+' '+b+b+' '+b+b+  '   ' +b+b+      '  ' + '     '+b+b+'    '       +b+b+b+b+b+b+   '   '+b+b+'    '+b+b+' '+b+b+         '          '  +b+b+        '    '+b+b+' '+b+b+'     '+b+b+ ' '  +b+b+' '+b+b+' '+b+b+ '   ' +b+b+                        "\n"+\
                '                          '+b+b+' '+b+b+'  ' +b+b+b+b+   '     ' +b+b+         '  ' + '   '+b+b+'    '     +b+b+b+b+     '     '+b+b+'    '+b+b+' '+b+b+         '          '  +b+b+        '    '+b+b+' '+b+b+'     '+b+b+ ' '  +b+b+'  '+b+b+b+b+    '     ' +b+b+                      "\n"+\
                '                          '+b+b+' '+b+b+'   '+b+b+b+    '       ' +b+b+       '  ' + ' '+b+b+'    '        +b+b+'  '+b+b+  '   '+b+b+'    '+b+b+' '+b+b+         '          '  +b+b+        '    '+b+b+' '+b+b+'     '+b+b+ ' '  +b+b+'   '+b+b+b+     '       ' +b+b+                    "\n"+\
                '                          '+b+b+' '+b+b+'    ' +b+b+    ' '+b+b+'    '+b+b+   '  ' + ' '+b+b+'    '        +b+b+'   '+b+b+  '  '+b+b+'    '+b+b+' '+' '+b+b+'   ' +b+b+'    '  +b+b+        '    '+b+b+'  '+b+b+'   '+b+b+ '  '  +b+b+'    ' +b+b+     ' '+b+b+'    '+b+b+                "\n"+\
                '                          '+b+b+' '+b+b+'    ' +b+b+    '   ' +b+b+b+b+       '  ' + '   '+b+b+'    '      +b+b+'    '+b+b+  '   '+b+b+b+b+   '   '+'   '+b+b+b+     '      '  +b+b+        '    '+b+b+'    '+b+b+b+     '    '  +b+b+'    ' +b+b+     '   ' +b+b+b+b+                    "\n"


                puts "\n\n\n\
                    The sheet can be navigated with the cursor using: 'w'(up), 's'(down), 'a'(left) and 'd'(right)\n\
                    The cursor can be switched with 'r'(step) and 'f'(jump)\n\
                    To place a note at the location of the cursor press: '1'\n\
                    To delete a note at the location of the cursor press: 'l'\n\
                    To start playback of composition press: 'p'\n\
                    To stop playback of compositopn press: 'x'\n\
                    To quit first make sure you are in edit and not playback mode and then press: 'q'\n\
                    You will be the prompted with an option to save: 'y'(yes) or 'n'(no). After pressing the key, press the enter"

                puts "\n\n\n Press enter to continue"    
                
            con = STDIN.gets
        end
    end
end





system("touch #{qfile}.txt")
file = File.open("#{qfile}.txt")

data =file.read

if eval(data) == nil
    File.open("#{qfile}.txt", "w"){ |f| f.write '{}' }
    sheetA = {}
else
    sheetA = eval(data)
end







print_cycle(sheetA, position, qfile, 0)


