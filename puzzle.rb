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
  attr_accessor :fitted_pieces, :location
  def initialize(pieces)
    @pieces = pieces
    @pieces_dub = pieces.dup
    @fitted_pieces = []
  end

  def solve(loc)
    return true if @pieces.empty?
    @pieces.each_with_index do |e, i|
      if @fitted_pieces[loc] == nil
        @fitted_pieces[loc] = @pieces.shift
      else
        next
      end

      (0..4).each do |k|
        if piece_fits?(@fitted_pieces[loc], loc) && solve(loc + 1)
          return true;
        else
          @fitted_pieces[loc].rotate
        end
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
    when 3
      piece.top + @fitted_pieces[0].bottom == 0
    when 4
      piece.top + @fitted_pieces[1].bottom == 0 && left_right_match?(piece, location)
    when 5
      piece.top + @fitted_pieces[2].bottom == 0 && left_right_match?(piece, location)
    when 6
      piece.top + @fitted_pieces[3].bottom == 0
    when 7
      piece.top + @fitted_pieces[4].bottom == 0 && left_right_match?(piece, location)
    when 8
      piece.top + @fitted_pieces[5].bottom == 0 && left_right_match?(piece, location)
    end
  end

  def left_right_match?(piece, location)
    piece.left + @fitted_pieces[location - 1].right == 0
  end
end


# piece_1 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
# piece_2 = Piece.new([SPADE, INNER_SPADE, INNER_CLUBS, HEART], 1)
# piece_3 = Piece.new([DIAMOND, INNER_SPADE, INNER_HEART, SPADE], 2)
# piece_4 = Piece.new([DIAMOND, INNER_DIAMOND, INNER_HEART, HEART], 3)
# piece_5 = Piece.new([CLUBS, INNER_CLUBS, INNER_DIAMOND, DIAMOND], 4)
# piece_6 = Piece.new([HEART, INNER_SPADE, INNER_HEART, CLUBS], 5)
# piece_7 = Piece.new([SPADE, INNER_HEART, INNER_CLUBS, SPADE], 6)
# piece_8 = Piece.new([DIAMOND, INNER_CLUBS, INNER_CLUBS, HEART], 7)
# piece_9 = Piece.new([HEART, INNER_DIAMOND, INNER_CLUBS, CLUBS], 8)

# grid = Grid.new([piece_1, piece_2,piece_3,piece_4,piece_5,piece_6,piece_7,piece_8,piece_9])

# grid.solve(0)
