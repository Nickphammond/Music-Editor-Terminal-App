require "timeout"
require 'io/console'
require 'colorize'




# position = [98,25]
$scroll = 0
$note_array = [" B", "#A", " A", "#G", " G", "#F", " F", " E", "#D", " D", "#C", " C"]


# sheetA = {"T1" => {" C1" => 2}, "T10" => {" B1" => 2}, "T20" => {"#A1" => 2}, "T30" => {" A1" => 2}, "T40" => {" C1" => 2}, "T50" => {" B1" => 2}, "T60" => {"#A1" => 2}, "T70" => {" A1" => 2},"T80" => {" C1" => 2}, "T90" => {" B1" => 2}, "T100" => {"#A1" => 2}, "T110" => {" A1" => 2},"T120" => {" C1" => 2}, "T130" => {" B1" => 2}, "T140" => {"#A1" => 2}, "T150" => {" A1" => 2}}


def save2(sheet)
    return save(sheet)
end

def save(sheet)
    str=sheet.inspect()
    File.open("test.txt", "w"){ |f| f.write str }
    return
end



def page(sheet,x,y)

    f = x + $scroll
    if x==0
        

        return $note_array[y%12] + (y/12).to_s + "   "

    elsif sheet["T"+f.to_s] != nil



        if sheet["T"+f.to_s][$note_array[y%12] + (y/12).to_s] != nil

            return " ".colorize(:color => :light_cyan, :background => :light_magenta)
        else
            return '_'.colorize(:color => :light_white, :background => :white)
        end

    else
        return '_'.colorize(:color => :light_white, :background => :white)
    end
            
end



def cursor(pos, key)
    
    if key=='w' && pos[1]!=0
        pos[1]=pos[1]-1
        return pos
    elsif key=='s' && pos[1]!=47
        pos[1]=pos[1]+1
        return pos
    elsif key=='d' && pos[0]!=99
        pos[0]=pos[0]+1
        return pos
    elsif key=='a' && pos[0]!=1 
        pos[0]=pos[0]-1
        return pos
    else
        return pos
    end
    
end



def print_roll(sheet, pos)
    str = "\n\n"

    for j in 0..48
        for i in 0..100
            if i==pos[0] && j==pos[1]
                str= str +  '_'.colorize(:color => :light_white, :background => :light_cyan)
            else
                z =page(sheet,i,j)
                str= str + z
            end
        end
        str= str+"\n"
    end
    return str
end




def print_cycle(sheet, pos)

    
    output=(print_roll(sheet, pos))
    system("clear && printf '\e[3J'")
    print "\033[2J"

    print output
    sleep(0.1) 
     
    str = (STDIN.getch).to_s

    if str!='q'
        if pos[0]==99 && str=='d'
            $scroll=$scroll+1

        elsif pos[0]==1 && str=='a' && $scroll>0
            $scroll=$scroll-1
        elsif str=='p'
            return play_back(sheet, pos)
        elsif str=='1'
            f=pos[0]+$scroll
            note_hash = {($note_array[pos[1]%12] + (pos[1]/12).to_s) => 2}
            begin
            sheet["T"+f.to_s]=sheet["T"+f.to_s].merge(note_hash)
            rescue
                sheet["T"+f.to_s]=note_hash
            end

        elsif str=='l' 
            f=pos[0]+$scroll
            begin
                note_hash=($note_array[pos[1]%12] + (pos[1]/12).to_s).to_s
                sheet["T"+f.to_s].delete(note_hash)
            rescue

            end
        end
        return print_cycle(sheet, cursor(pos, str))
    else
        puts "Do you want to save (y/n)?"
        ans = gets.chomp
        if ans!='y' && ans!='n'
            "Invalid input, please press y or n"
        else
            puts "blah"

            if ans=='y'
                save(sheet)

            end
            puts "Thankyou"
            return
        end
    end
    
    
    
    
end


def play_back(sheet, pos)
    output=(print_roll(sheet, pos))
    system("clear && printf '\e[3J'")
    print "\033[2J"

    print output
    a=0
    
    begin
        status = Timeout::timeout(0.001){
            str = STDIN.getch
            if str=='x'
                a=1
            end
            return nick.to_i
        }
    rescue
    
        if a==0
            $scroll=$scroll+1
            play_back(sheet, pos)
        else
            return print_cycle(sheet, pos)
        end
    end
end


system("clear && printf '\e[3J'")
print "\033[2J"

# print_cycle(sheetA, position)
# play_back(sheetA, position)

