require_relative "piano_roll.rb"


# sheetA = {"T1" => {" C1" => 2}, "T10" => {" B1" => 2}, "T20" => {"#A1" => 2}, "T30" => {" A1" => 2}, "T40" => {" C1" => 2}, "T50" => {" B1" => 2}, "T60" => {"#A1" => 2}, "T70" => {" A1" => 2},"T80" => {" C1" => 2}, "T90" => {" B1" => 2}, "T100" => {"#A1" => 2}, "T110" => {" A1" => 2},"T120" => {" C1" => 2}, "T130" => {" B1" => 2}, "T140" => {"#A1" => 2}, "T150" => {" A1" => 2}}
position = [98,25]


qfile =  'test'

# system("touch #{qfile}.txt")
file = File.open("#{qfile}.txt")
# file = File.open("./test.txt")
data =file.read
sheetA = eval(data)
print_cycle(sheetA, position)



