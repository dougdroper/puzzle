
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

describe "Solve" do

  it "solves" do
    grid = set_up_grid
    grid.solve(0)
    grid.fitted_pieces.count.should == 9
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

# [ ["spade", "diamond", "i_heart", "i_diamond"], ["i_clubs", "clubs", "heart", "i_diamond"],   ["i_clubs", "heart", "diamond", "i_clubs"],
#   ["heart", "spade", "i_spade", "i_clubs"],     ["i_heart", "clubs", "heart", "i_spade"],     ["i_diamond", "diamond", "clubs", "i_clubs"],
#   ["spade", "diamond", "i_spade", "i_heart"],   ["i_heart", "heart", "diamond", "i_diamond"], ["i_clubs", "spade", "spade", "i_heart"]]







