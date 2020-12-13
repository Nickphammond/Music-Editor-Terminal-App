require "timeout"
require 'io/console'
require 'colorize'

# ['']

$note_array = [" B", "#A", " A", "#G", " G", "#F", " F", " E", "#D", " D", "#C", " C"]

sheetA = {"T1" => {" C1" => 2}, "T10" => {" B1" => 2}, "T20" => {"#A1" => 2}, "T30" => {" A1" => 2}, "T40" => {" C1" => 2}, "T50" => {" B1" => 2}, "T60" => {"#A1" => 2}, "T70" => {" A1" => 2}}

def page(sheet,x,y)
    if x==0
        

        return $note_array[y%12] + (y/12).to_s + "   "

    elsif sheet["T"+x.to_s] != nil

        if sheet["T"+x.to_s][$note_array[y%12] + (y/12).to_s] != nil

            return " ".colorize(:color => :light_cyan, :background => :light_magenta)
        else
            return '.'.colorize(:color => :light_white, :background => :white)
        end

    else
        return '.'.colorize(:color => :light_white, :background => :white)
    end
            
end



def print_roll(sheet)
    str= ''
    for j in 0..48
        for i in 0..100

            str= str + page(sheet,i,j)
        end
        str= str+"\n"
    end
    return str
end

puts print_roll(sheetA)

# puts note_array[1]

