require "timeout"
require "io/console"
require "colorize"
require "wavefile"
include WaveFile


$scroll = -4
$note_array = [" B", "#A", " A", "#G", " G", "#F", " F", " E", "#D", " D", "#C", " C"]
$two_pi = 2* Math::PI
$sample_rate = 44100
$jump = 0


system("clear && printf '\e[3J'")
print "\033[2J"

def save(sheet, file)
    str=sheet.inspect()
    File.open("#{file}.txt", "w"){ |f| f.write str }
    return
end


# method for assigning value to each position of the window
def page(sheet,x,y, pos, state)
    
    f = x + $scroll

    if y==0
        top_border = " ".colorize(:color => :light_black, :background => :light_black)
        return ((x==0)? "      " : "") + ((x==pos[0])? " " : "") + (((x!=pos[0]) && (x!=0))? top_border : "")
        puts pos[0]

    else

        if x > 0 && x < 101
            grid = "_".colorize(:color => :light_white, :background => :white)
            off_note = " ".colorize(:color => :light_cyan, :background => :light_magenta)
            on_note = " "
            value = grid
            if f>= -3 && f<=0
                value =  " ".colorize(:color => :light_black, :background => :light_blue)
    
            elsif sheet["T"+f.to_s] != nil

    
                if (sheet["T"+f.to_s][$note_array[y%12] + (y/12).to_s] != nil)

                    value =  (pos[0]==x)?on_note:off_note
                
                end

            elsif sheet["N"+f.to_s] != nil
    
    
                if (sheet["N"+f.to_s][$note_array[y%12] + (y/12).to_s] != nil)

                    value =  (pos[0]==x)?on_note:off_note

                end
   
    
            end

            return value

        else
        ## This part deals with the non-scrolling part of the console.
            
            if x==0
            ## Creates the left hand side index.
                str= $note_array[y%12] + (y/12).to_s + "   "
                return str.colorize(:color => :light_black, :background => :light_yellow)
            else 
            ## Creates right hand side 'button' layout.
                a = ' '
                ## Creates red move 'buttons' for keys 'a'(left), 'd'(right), 'w'(up) and 's'(down).
                if y>=2 && y<=4 && x>=112 && x<=114
                    if y==3 && x==113
                        a = "W"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
                
                elsif y>=5 && y<=7 && x>=109 && x<=111
                    if y==6 && x==110
                        a = "A"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
                    
                elsif y>=5 && y<=7 && x>=115 && x<=117
                    if y==6 && x==116
                        a = "D"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
                   
                elsif y>=8 && y<=10 && x>=112 && x<=114
                    if y==9 && x==113
                        a = "S"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
                    
                end



                ## Creates red jump 'buttons' for keys 'a'(left), 'd'(right).

                if y>=18 && y<=22 && x>=103 && x<=109
                    a = ' '
                    if y==20 && x==106
                        a =  "A"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
                    
                elsif y>=18 && y<=22 && x>=117 && x<=123
                    a = ' '
                    if y==20 && x==120
                        a = "D"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
                  
                elsif y>=13 && y<=17 && x>=110 && x<=116
                    a = ' '
                    if y==15 && x==113
                        a = "W"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
        
                elsif y>=23 && y<=27 && x>=110 && x<=116
                    a = ' '
                    if y==25 && x==113
                        a = "S"
                    end
                    return a.colorize(:color => :light_white, :background => :light_red)
                end




                ## Creates side scrolling between sub-panels.
                if x>=125 && x<=129 && y>=1 && y<=12
                    a = ' '
                    if x==127 && y==6
                        a='r'
                    end
                    return ($jump==0)? a.colorize(:color => :black, :background => :light_cyan) : a.colorize(:color => :black, :background => :cyan)
                    
                elsif x>=125 && x<=129 && y>=13 && y<=27
                    a = ' '
                    if x==127 && y==18
                        a='f'
                    end
                    return ($jump==1)? a.colorize(:color => :black, :background => :light_cyan) : a.colorize(:color => :black, :background => :cyan)
                    
                end

                ##Creates yellow background of panel.
                return " ".colorize(:color => :light_black, :background => :light_yellow)
            end
        end

    end
            
end



def cursor(pos, key)



    a = pos[0]
    b = pos[1]

    next_pos = [0,0]
    next_pos[0] = a
    next_pos[1] = b

    key_array = ['w', 's', 'd', 'a']


    if key=='w'

        next_pos[1]=pos[1]-1 - $jump*4

    elsif key=='s'
        
        next_pos[1]=pos[1]+1 + $jump*4

    elsif key=='d'

        next_pos[0]=pos[0]+1 + $jump*25

    elsif key=='a'

        next_pos[0]=pos[0]-1 - $jump*25

    end

 
  
    if next_pos[0] > 0 && next_pos[0] < 99 && next_pos[1] > 0 && next_pos[1] < 48
        pos = next_pos
        return pos
    else
        if pos[0]<=98 && pos[0]>=99-1-25*$jump && key=='d'
            $scroll=$scroll+(next_pos[0]-pos[0])
        elsif pos[0]>=1 && next_pos[0]<=0 && $scroll+next_pos[0]>0&& key=='a'
            if $scroll>100
                $scroll=$scroll-100
                pos[0]=100+ next_pos[0]
            else 
                $scroll=-4
                pos[0]= 99+ next_pos[0]
            end
        end
     
        return pos
    end  

end






def print_roll(sheet, pos, state)
    system("printf '\e[8;60;150t'")

    str = "\n\n"

    for j in 0..48
        for i in 0..130
            z =page(sheet,i,j, pos, state)
            if i==pos[0] && j==pos[1] && z!='_'.colorize(:color => :light_white, :background => :cyan) && z!=" "
                str= str +  '_'.colorize(:color => :light_white, :background => :light_cyan)
            elsif i==pos[0] && z!=" "
                str= str + '_'.colorize(:color => :light_white, :background => :cyan)
            else   
                str= str + z
            end
        end
        str= str+"\n"
    end
    return str
end



def print_cycle(sheet, pos, file, state)

    
    output=(print_roll(sheet, pos, state))
    system("clear && printf '\e[3J'")
    print "\033[2J"

    print output
    sleep(0.1) 
     
    str = (STDIN.getch).to_s

    if str!='q'
        
        note=($note_array[pos[1]%12] + (pos[1]/12).to_s)
        f=pos[0]+$scroll

        if str=='p'
            state = 1
            return play_back(sheet, pos, file, state)

        elsif str=='1'
            note_hash = {note => 1}
            begin
                sheet["T"+f.to_s]=sheet["T"+f.to_s].merge(note_hash)
            rescue
                sheet["T"+f.to_s]=note_hash
            end

        elsif str=='2'
            note_hash = {note => 2}
            begin
                sheet["T"+f.to_s]=sheet["T"+f.to_s].merge(note_hash)

                begin
                    sheet["N"+(f+1).to_s]=sheet["N"+(f+1).to_s].merge(note_hash)
                rescue
                    sheet["N"+(f+1).to_s]=note_hash
                end
            rescue
                sheet["T"+f.to_s]=note_hash
                sheet["N"+(f+1).to_s]=note_hash
            end

        elsif str=='3'
            note_hash = {note => 3}
            begin
                sheet["T"+f.to_s]=sheet["T"+f.to_s].merge(note_hash)
            rescue
                sheet["T"+f.to_s]=note_hash
            end

        elsif str=='l' 

            begin
                note_type = sheet["T"+f.to_s][note]
                sheet["T"+f.to_s].delete(note)
                
                for j in  1..2**(note_type-1) - 1
                    sheet["N"+(f+1).to_s].delete(note) 
                end

            rescue
                puts "Make sure the cursor is positioned over the note you wish to delete"
            end

        elsif str=='r'||str=='f'
            
            $jump = (str=='r')?0:1
            
        end
        
        return print_cycle(sheet, cursor(pos, str), file, state)
    else
        puts "Do you want to save (y/n)?"
        ans = $stdin.gets.chomp
        if ans!='y' && ans!='n'
            puts "Invalid input, please press y or n"
            sleep(1)
            print_cycle(sheet, pos, file, state)
        else

            if ans=='y'
                if file==nil
                    puts "Enter the name you wish to use for your file"
                    file=gets.chomp   
                end
                save(sheet, file)
            end
            puts "Thankyou"
            return
        end
    end
    
    
end





def play_back(sheet, pos, file, state)
    output=(print_roll(sheet, pos, state))
    system("clear && printf '\e[3J'")
    print "\033[2J"

    print output

    x = pos[0]
    y = pos[1]
    f = x + $scroll
    if sheet["T"+f.to_s] != nil
        play_notes(41000, sheet["T"+f.to_s])
    end
    
    
    begin
        status = Timeout::timeout(0.001){
            str = STDIN.getch
            if str=='x'
                state=0
            end
            return nick.to_i
        }
    rescue
    
        if state==1
            $scroll=$scroll+1
            play_back(sheet, pos, file, state)
        else
            return print_cycle(sheet, pos, file, state)
        end
    end
end












# SOUND GENERATION




time = 1
sample_total = $sample_rate*time
# frequency = 262.0



def basic_note(num, chord)
    arr = []
    for i in 0..3
        for j in 0..11
            if chord[$note_array[j] + i.to_s] != nil
                arr = arr.append(262.0*(2**((23 - i*12 - j).to_f/12)))
            end   
        end
    end


    period_pos = 0.0


    sample_array = [].fill(0.0, 0, num)
    for i in 0..(num)
        sum = 0.0
        period_diff = 1.0/$sample_rate
        for k in 0..arr.length()-1

            freq = arr[k]
            
            sum = sum + (Math::sin($two_pi*period_pos*freq).to_f)/arr.length()
            

        
        end
        period_pos = period_pos + period_diff
        sample_array[i] = sum
        if period_pos>= 1.0
            period_pos = 0
        end
    end

    # puts sample_array
    # sleep(10)
    return sample_array
end


def make_file(num, chord)
    note_array=basic_note(num, chord)
 
    note_data = WaveFile::Buffer.new(note_array, WaveFile::Format.new(:mono, :float, $sample_rate))
    WaveFile::Writer.new("#{$chord}.wav", WaveFile::Format.new(:mono, :pcm_16, 44100)) do |writer|
        writer.write(note_data)
      end
end


def play_notes(num, chord)
    make_file(num, chord)

    begin
        status = Timeout::timeout(0.25){
    
            system("afplay #{$chord}.wav")
    
        }
    rescue
        
    end

end

$chord="testt"





