HEART = 1
SPADE = 2
DIAMOND = 3
CLUBS = 4

INNER_HEART = -1
INNER_SPADE = -2
INNER_DIAMOND = -3
INNER_CLUBS = -4

class Piece
  attr_reader :top, :right, :left, :bottom, :config, :id
  def initialize(config, id)
    @id = id
    @top, @right, @bottom, @left = config
    @config = [@top, @right, @bottom, @left]
  end

  def rotate
    @config.rotate!
    @top, @right, @bottom, @left = @config
  end

  def to_s
    mapping = {"1" => "heart", "2" => "spade", "3" => "diamond", "4" => "clubs", "-1" => "i_heart", "-2" => "i_spade", "-3" => "i_diamond", "-4" => "i_clubs"}
    @config.map{|a| mapping[a.to_s]}.to_s
  end
end

class Grid
  attr_accessor :fitted_pieces
  def initialize(pieces)
    @pieces = pieces
    @fitted_pieces = []
  end

  def solve(loc)
    puts @fitted_pieces.map(&:id).inspect
    return true if @pieces.empty?
    @pieces.each do
      next unless @fitted_pieces[loc] == nil
      @fitted_pieces[loc] = @pieces.shift

      (0..3).each do
        return true if piece_fits?(@fitted_pieces[loc], loc) && solve(loc + 1)
        @fitted_pieces[loc].rotate
      end
      @pieces << @fitted_pieces.pop
    end
    false
  end

  def piece_fits?(piece, location)
    case location
    when 0
      true
    when 1, 2
      left_right_match?(piece, location)
    when 3, 6
      top_bottom_match?(piece, location)
    when 4, 5, 7, 8
      top_bottom_match?(piece, location) && left_right_match?(piece, location)
    end
  end

  def left_right_match?(piece, location)
    piece.left + @fitted_pieces[location - 1].right == 0
  end

  def top_bottom_match?(piece, location)
    piece.top + @fitted_pieces[location - 3].bottom == 0
  end
end
