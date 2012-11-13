
require_relative "spec_helper"

describe Piece do
  subject {Piece.new([1,2,3,4], 1)}
  it "has top, right, left and right" do
    subject.top.should == 1
    subject.right.should == 2
    subject.bottom.should == 3
    subject.left.should == 4
  end

  it "rotates" do
    subject.rotate
    subject.top.should == 2
    subject.right.should == 3
    subject.bottom.should == 4
    subject.left.should == 1
  end

  it "to string" do
    subject.to_s.should == "[\"heart\", \"spade\", \"diamond\", \"clubs\"]"
    subject.rotate
    subject.to_s.should == "[\"spade\", \"diamond\", \"clubs\", \"heart\"]"
  end
end


describe Grid do
  it "has no fitted pieces" do
    Grid.new([stub]).fitted_pieces.should == []
  end

  describe "#piece_fits?" do
    it "checks if the piece fits in the first location" do
      piece = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      Grid.new(piece).piece_fits?(piece, 0).should be_true
    end

    it "doesn't fit in the second location on the top" do
      piece = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      grid = Grid.new(piece)
      grid.fitted_pieces = [piece]
      grid.piece_fits?(piece, 1).should be_false
    end

    it "does fit in the second location on the top" do
      piece = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      piece2 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, HEART], 0)
      grid = Grid.new(piece)
      grid.fitted_pieces = [piece, piece]
      grid.piece_fits?(piece2, 1).should be_true
      grid.piece_fits?(piece2, 2).should be_true
    end

    it "does fit the 5th location on the top and left" do
      piece = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      piece2 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, HEART], 0)
      grid = Grid.new(piece)
      grid.fitted_pieces = [piece, piece, piece, piece, piece]
      grid.piece_fits?(piece2, 5).should be_true
    end

    it "does fit in the 4 location on the top" do
      piece = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      piece2 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, HEART], 0)
      grid = Grid.new(piece)
      grid.fitted_pieces = [piece, piece, piece, piece]
      grid.piece_fits?(piece2, 4).should be_true
    end
  end

  describe "#solve" do
    # subject {set_up_grid}
    it "moves to the next location" do
      piece_1 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      piece_2 = Piece.new([SPADE, INNER_SPADE, INNER_CLUBS, HEART], 1)
      grid = Grid.new([piece_1, piece_2])
      grid.solve
      grid.fitted_pieces.to_s.should == "[[\"diamond\", \"i_heart\", \"i_diamond\", \"spade\"], [\"spade\", \"i_spade\", \"i_clubs\", \"heart\"]]"
      grid.location.should == 2
    end

    it "rotates the piece to make it fit to the next location" do
      piece_1 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      piece_2 = Piece.new([INNER_SPADE, INNER_CLUBS, HEART, SPADE], 1)
      grid = Grid.new([piece_1, piece_2])
      grid.solve
      grid.fitted_pieces.to_s.should == "[[\"diamond\", \"i_heart\", \"i_diamond\", \"spade\"], [\"spade\", \"i_spade\", \"i_clubs\", \"heart\"]]"
      grid.location.should == 2
    end

    it "moves the piece to the last position if it doesn't fit" do
      piece_1 = Piece.new([INNER_SPADE, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      piece_2 = Piece.new([INNER_SPADE, INNER_CLUBS, SPADE, SPADE], 1)
      piece_3 = Piece.new([INNER_SPADE, INNER_CLUBS, HEART, CLUBS], 2)
      grid = Grid.new([piece_1, piece_2, piece_3])
      grid.solve
      grid.fitted_pieces.map(&:id).should == [0,2,1]
    end

    it "moves the first piece to the last position if it doesn't fit" do
      piece_1 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
      piece_2 = Piece.new([INNER_SPADE, INNER_CLUBS, CLUBS, SPADE], 1)
      piece_3 = Piece.new([INNER_SPADE, INNER_CLUBS, HEART, CLUBS], 2)
      grid = Grid.new([piece_2, piece_3, piece_1])
      grid.solve
      grid.fitted_pieces.map(&:id).should == [0,2,1]
    end
  end
end

def set_up_grid
  piece_1 = Piece.new([DIAMOND, INNER_HEART, INNER_DIAMOND, SPADE], 0)
  piece_2 = Piece.new([SPADE, INNER_SPADE, INNER_CLUBS, HEART], 1)
  piece_3 = Piece.new([DIAMOND, INNER_SPADE, INNER_HEART, SPADE], 2)
  piece_4 = Piece.new([DIAMOND, INNER_DIAMOND, INNER_HEART, HEART], 3)
  piece_5 = Piece.new([CLUBS, INNER_CLUBS, INNER_DIAMOND, DIAMOND], 4)
  piece_6 = Piece.new([HEART, INNER_SPADE, INNER_HEART, CLUBS], 5)
  piece_7 = Piece.new([SPADE, INNER_HEART, INNER_CLUBS, SPADE], 6)
  piece_8 = Piece.new([DIAMOND, INNER_CLUBS, INNER_CLUBS, HEART], 7)
  piece_9 = Piece.new([HEART, INNER_DIAMOND, INNER_CLUBS, CLUBS], 8)
  Grid.new([piece_1, piece_2,piece_3,piece_4,piece_5,piece_6,piece_7,piece_8,piece_9])
end