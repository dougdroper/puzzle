from PIL import Image

pieces = {
"piece_1" : ["diamond", "i_heart", "i_diamond", "spade"],
"piece_2" : ["spade", "i_spade", "i_clubs", "heart"],
"piece_3" : ["diamond", "i_spade", "i_heart", "spade"],
"piece_4" : ["diamond", "i_diamond", "i_heart", "heart"],
"piece_5" : ["clubs", "i_clubs", "i_diamond", "diamond"],
"piece_6" : ["heart", "i_spade", "i_heart", "clubs"],
"piece_7" : ["spade", "i_heart", "i_clubs", "spade"],
"piece_8" : ["diamond", "i_clubs", "i_clubs", "heart"],
"piece_9" : ["heart", "i_diamond", "i_clubs", "clubs"]
}

solution1 = [["i_heart", "spade", "diamond", "i_spade"],
["i_clubs", "heart", "spade", "i_spade"],
["i_diamond", "spade", "diamond", "i_heart"],
["i_diamond", "i_heart", "heart", "diamond"],
["i_spade", "i_heart", "clubs", "heart"],
["i_diamond", "i_clubs", "clubs", "heart"],
["i_heart", "i_clubs", "spade", "spade"],
["i_clubs", "i_diamond", "diamond", "clubs"],
["i_clubs", "i_clubs", "heart", "diamond"]]

def create_solution_image(soln):
	composite = Image.open('solution.png')
	x,y = 0,0
	for piece in soln:
		name, rotation = get_piece_and_rotation(piece)
		input = Image.open(name+'.png')
		output = input.rotate(rotation)
		composite.paste(output, (x*160,y*160))
		x+=1
		if x == 3:
			x = 0
			y += 1

	composite.save('solution.png')


def get_piece_and_rotation(piece):
	for name, val in pieces.items():
		for i in range(0,4):
			if val == rotate(piece, i):
				return (name, i*-90) #negative for clockwise rotation

def rotate(piece, rot):
	rot = rot % len(piece)
	return piece[rot:] + piece[:rot]

if __name__ == '__main__':

	create_solution_image(solution1)
