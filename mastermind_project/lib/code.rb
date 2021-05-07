class Code

  attr_reader :pegs 

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)

    chars.all?{|chars| Code::POSSIBLE_PEGS.has_key?(chars.upcase)}
  end

  def initialize(pegs)

    raise if !Code::valid_pegs?(pegs)

    @pegs = pegs.map(&:upcase)


  end

  def self.random(length)

  r_pegs = Array.new(length) {POSSIBLE_PEGS.keys.sample}
  Code.new(r_pegs)

  end

  def self.from_string(string)
    Code.new(string.split(""))
  end

  def [](index)

    @pegs[index]

  end

  def length
    @pegs.length 
  end

  def num_exact_matches(guess_code)
    (0...guess_code.length).count { |i| guess_code[i] == @pegs[i] }
  end


  def num_near_matches(guess_code)

    count = 0 
    (0...guess_code.length).each do |i|
      if guess_code[i] != @pegs[i] && self.pegs.include?(guess_code[i])
        count += 1
      end
    end
    
    count
  end

  def ==(another_code)

    another_code == self.pegs

  end








end
