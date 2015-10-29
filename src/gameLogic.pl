:-use_module(library(lists)).
:-consult('board.pl').

/*

INITIALIZE_BOARD - Players choose the initial position of their stones
Size - Board's size
Board - Game board of size NxN
    
*/

initialize_board(Size, Board):- Player is 1,
                                write('Player 1: '),
                                read(X-Y),
                                print(Player),
                                nl,
                                print(X),
                                nl,
                                print(Y).