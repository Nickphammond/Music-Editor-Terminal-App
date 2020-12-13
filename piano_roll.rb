require "timeout"
require 'io/console'
require 'colorize'

# ['']

$note_array = [" B", "#A", " A", "#G", " G", "#F", " F", " E", "#D", " D", "#C", " C"]

sheetA = {"T0" => {" C1" => 2}, "T9" => {" C1" => 2}, "T19" => {" C1" => 2}, "T29" => {" C1" => 2}}

def page(sheet,x,y)
    if x==0
        
        return $note_array[y%12] + (y/12).to_s + "   "

    elsif sheet["T"+x.to_s] != null

        sheet["T"+x.to_s][$note_array[y%12] + (y/12).to_s ]

    else
        return '.'
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