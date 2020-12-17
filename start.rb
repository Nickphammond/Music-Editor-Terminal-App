require_relative "piano_roll.rb"


position = [20,25]

qfile =  ARGV[0]

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


