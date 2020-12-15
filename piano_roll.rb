require "timeout"
require "io/console"
require "colorize"
require "wavefile"
include WaveFile


$scroll = -4
$note_array = [" B", "#A", " A", "#G", " G", "#F", " F", " E", "#D", " D", "#C", " C"]
$two_pi = 2* Math::PI
$sample_rate = 44100


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

        

        if x==0
            
            str= $note_array[y%12] + (y/12).to_s + "   "
            return str.colorize(:color => :light_black, :background => :light_yellow)

        elsif f==-3
            return " ".colorize(:color => :light_black, :background => :light_blue)
        elsif f==-2
            return " ".colorize(:color => :light_black, :background => :light_blue)
        elsif f==-1
            return " ".colorize(:color => :light_black, :background => :light_blue)
        elsif f==0
            return " ".colorize(:color => :light_black, :background => :light_blue)

        elsif sheet["T"+f.to_s] != nil

            off_note = " ".colorize(:color => :light_cyan, :background => :light_magenta)
            on_note = " "

            if sheet["T"+f.to_s][$note_array[y%12] + (y/12).to_s] != nil
                return (pos[0]==x)?on_note:off_note
            else

                return '_'.colorize(:color => :light_white, :background => :white)
            
            end

        else
            return '_'.colorize(:color => :light_white, :background => :white)
        end

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



def print_roll(sheet, pos, state)
    str = "\n\n"

    for j in 0..48
        for i in 0..100
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
        if pos[0]==99 && str=='d'
            $scroll=$scroll+1

        elsif pos[0]==1 && str=='a' && $scroll>0
            $scroll=$scroll-1
        elsif str=='p'
            state = 1
            return play_back(sheet, pos, file, state)
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
        return print_cycle(sheet, cursor(pos, str), file, state)
    else
        puts "Do you want to save (y/n)?"
        ans = $stdin.gets.chomp
        if ans!='y' && ans!='n'
            "Invalid input, please press y or n"
        else

            if ans=='y'
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
        puts "blah"
        play_notes(41000, sheet["T"+f.to_s])
        # if sheet["T"+f.to_s][$note_array[y%12] + (y/12).to_s] != nil
            
        #     play_note(41000,262.0)
        # end
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
        for k in 0..arr.length()-1

            freq = arr[k]
            period_diff = 1.0/$sample_rate
            sum = sum + (Math::sin($two_pi*period_pos*freq)/arr.length().to_f)
            period_pos = period_pos + period_diff

        
        end
        sample_array[i] = sum
        if period_pos>= 1.0
            period_pos = 0
        end
    end

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
    
    system("open #{$chord}.wav")
    # system("rm #{$chord}.wav")
end

$chord="test"


