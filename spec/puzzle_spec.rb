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

describe "piece fits" do
  it "fits if in loc 0" do
    piece_1 = Piece.new([SPADE, DIAMOND, INNER_HEART, INNER_DIAMOND], 0)
    Grid.new([]).piece_fits?(piece_1, 0).should == true
  end

  it "fits if left and right match" do
    piece_1 = Piece.new([SPADE, DIAMOND, INNER_HEART, INNER_DIAMOND], 0)
    piece_2 = Piece.new([SPADE, DIAMOND, INNER_HEART, INNER_DIAMOND], 0)
    grid = Grid.new([])
    grid.fitted_pieces = [piece_1, piece_2]
    grid.piece_fits?(piece_2, 1).should == true
  end

  it "fits if left and right match and top and bottom match" do
    piece_1 = Piece.new([SPADE, DIAMOND, INNER_HEART, INNER_DIAMOND], 0)
    piece_2 = Piece.new([INNER_CLUBS, CLUBS, HEART, INNER_DIAMOND], 1)
    piece_3 = Piece.new([INNER_CLUBS, HEART, DIAMOND, INNER_CLUBS], 2)
    piece_4 = Piece.new([HEART, SPADE, INNER_SPADE, CLUBS], 3)
    piece_5 = Piece.new([INNER_HEART, CLUBS, HEART, INNER_SPADE],4)
    grid = Grid.new([])
    grid.fitted_pieces = [piece_1, piece_2, piece_3, piece_4, piece_5]
    grid.piece_fits?(piece_5, 4).should == true
    grid.fitted_pieces = [piece_1, piece_2, piece_3, piece_5, piece_4]
    grid.piece_fits?(piece_4, 4).should == false
  end
end

describe "Solve" do
  it "solves" do
    grid = set_up_grid
    grid.solve(0)
    grid.fitted_pieces.count.should == 9
    puts grid.fitted_pieces.map(&:to_s)
  end
end

def set_up_grid
  piece_1 = Piece.new([SPADE, DIAMOND, INNER_HEART, INNER_DIAMOND], 1)
  piece_2 = Piece.new([INNER_CLUBS, CLUBS, HEART, INNER_DIAMOND], 2)
  piece_3 = Piece.new([INNER_CLUBS, HEART, DIAMOND, INNER_CLUBS], 3)
  piece_4 = Piece.new([HEART, SPADE, INNER_SPADE, CLUBS], 4)
  piece_5 = Piece.new([INNER_HEART, CLUBS, HEART, INNER_SPADE],5)
  piece_6 = Piece.new([INNER_DIAMOND, DIAMOND, CLUBS, INNER_CLUBS],6)
  piece_7 = Piece.new([SPADE, DIAMOND, INNER_SPADE, INNER_HEART], 7)
  piece_8 = Piece.new([INNER_HEART, HEART, DIAMOND, INNER_DIAMOND], 8)
  piece_9 = Piece.new([INNER_CLUBS, SPADE, SPADE, INNER_HEART], 9)
  Grid.new([piece_3, piece_2, piece_5, piece_7, piece_6, piece_4, piece_9, piece_1, piece_8])
end