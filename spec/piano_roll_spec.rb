require "../piano_roll.rb"

describe "cursor" do
    it "" do
        new_pos = cursor([20,25], 'd')
        expect(new_pos[0]).to eq(21)
    end
end

describe "cursor" do
    it "" do
        new_pos = cursor([99,25], 'd')
        expect(new_pos[0]).to eq(99)
    end
end


