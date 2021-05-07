require_relative "board"

class SudokuGame

    def self.from_file(filename)
        board = Board.from_file(filename)
        self.new(board)
    end

    attr_reader :board 
    def initialize(board)
        @board = board 
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "please enter a position (e,g. '3,4)"
            print "> "
            pos = parse_pos(gets.chomp)
        end
        pos 
    end

    def get_val
        val = nil

        until val && valid_val?(val)
            puts "please enter a number between 1 and 9"
            print "> "
            val = parse_val(gets.chomp)
        end

        val
    end

    def parse_pos(string)
        string.split(",").map {|char| Integer(char)}
    end

    def parse_val(string)
        Integer(string)
    end

    def play_turn
        board.render
        pos = get_pos
        val = get_val
        board[pos] = val 
    end

    def run
      board.render 
      play_turn until solved?
      puts "Congratulations, you won the game"
    end

    def solved?
        board.solved?
    end

    def valid_pos?(pos)
        pos.is_a?(Array) &&
        pos.count == 2 &&
        pos.all? {|x| x.between?(1, board.size - 1)}
    
    end

    def valid_val?(val)
        val.is_a?(Integer) &&
        val.between?(1, 9)
    end

end

p SudokuGame.from_file('puzzles/sudoku1.txt').run





  







