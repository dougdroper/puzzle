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

  def solve
    @pieces.each do |piece|
    if piece_fits?(piece)
      @fitted_pieces << piece
    end
  end

  # def solve
  #   @location = 0
  #   @tries = @pieces.length
  #   while @pieces.length != 0
  #     piece = @pieces.shift

  #     (0..4).each do |i|
  #       if piece_fits?(piece, @location)
  #         @fitted_pieces << piece
  #         @location += 1
  #         break
  #       else
  #         piece.rotate
  #         if i == 4
  #           (0..4).each do |j|
  #             if piece_fits?(piece, @location)
  #             @fitted_pieces.last.rotate
  #             if j == 4
  #               @pieces << @fitted_pieces
  #               @pieces << piece
  #               @location -= 1
  #               break
  #             end
  #           end
  #         end
  #       end
  #     end
  #   end
  #   @fitted_pieces.to_s
  # end

  # def piece_fits?(piece, location)
  #   case location
  #   when 0
  #     true
  #   when 1, 2
  #     left_right_match?(piece, location)
  #   when 3
  #     piece.top + @fitted_pieces[0].bottom == 0
  #   when 4
  #     piece.top + @fitted_pieces[1].bottom == 0 && left_right_match?(piece, location)
  #   when 5
  #     piece.top + @fitted_pieces[2].bottom == 0 && left_right_match?(piece, location)
  #   when 6
  #     piece.top + @fitted_pieces[3].bottom == 0
  #   when 7
  #     piece.top + @fitted_pieces[4].bottom == 0 && left_right_match?(piece, location)
  #   when 8
  #     piece.top + @fitted_pieces[5].bottom == 0 && left_right_match?(piece, location)
  #   end
  # end

  # def left_right_match?(piece, location)
  #   piece.left + @fitted_pieces[location - 1].right == 0
  # end

  # def top_bottom_macth(piece)
  # end
end




# grid = Grid.new([piece_1, piece_2,piece_3,piece_4,piece_5,piece_6,piece_7,piece_8,piece_9])

# grid.solve



#while pieces is not empty

    #piece = pop pieces

#    while piece does not fit
#        rotate;
#        num_rotations++
#        if num rotations == 4
#            push piece onto pieces
#            pop next piece from pieces
#    else
#        put piece into grid
#circular shift pieces