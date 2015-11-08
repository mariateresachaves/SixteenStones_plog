/*

TRANSLATE - Convert a number to figure (_, O or X)
The first parameter is a possible board cell number.
The second parameter is the respective translation to a figure.

*/

translate(0, ' ').
translate(1, 'O').
translate(2, 'X').

/*

MAKE_LINE - Make a game board line
Size - The size of the line
Line - Line to be returned

*/

make_line(0, []).
make_line(Size, Line):- NewSize is Size-1,
                        make_line(NewSize, NewLine), 
                        append(NewLine, [0], Line).

/*

MAKE_BOARD - Make a board of size NxN
Size - Board's size
Counter - Size's counter (starts in 0 and ends when Size = Counter)
Board - Game board of size NxN

*/
                                        %Using cut (!) to ensure SICStus doesn't give more solutions
make_board(Size, Board):- make_board(Size, 0, Board), !.
                
make_board(S, S, []). %When Size = Counter

make_board(Size, Counter, Board):- Size > Counter,
                                   NewCounter is Counter + 1,
                                   make_line(Size, Line),
                                   make_board(Size, NewCounter, NewBoard),
                                   append(NewBoard, [Line], Board). 
                                                        %append the Line to NewBoard, thus creating the final Board

/*

DRAW_BOARD - Make board of size NxN and print it
Size - Board's size
Board - Game board of size NxN

*/

draw_board(Size, Board) :- %make_board(Size, Board),
                           draw_border(Size),
                           draw_board_lines(Size, Board),
                           nl,
                           write('Player 1'),
                           nl,
                           draw_pools([1,1,1,1,1,0,0,1,1,1,1,1,1,0,0,1],Size),
                           nl,
                           write('Player 2'),
                           nl,
                           draw_pools([2,0,2,0,0,0,2,0,2,0,2,0,0,0,2,0],Size).

/*

DRAW_BORDER - Draw board limit
Size - Board's size
 
*/

draw_border(0):- nl, !.

draw_border(Size):- NewSize is Size - 1,
                    write('-----------'),
                    draw_border(NewSize).

/*

DRAW_BOARD_LINES - Draw each board line
Size - Board's size
Board - Game board of size NxN
      
*/

draw_board_lines(_, []).

draw_board_lines(Size, [H|T]):- draw_empty(Size),
                                draw_line(Size, H),
                                draw_empty(Size),
                                draw_border(Size),
                                draw_board_lines(Size, T).

/*

DRAW_EMPTY - Draw the board line without the characters
Size - Board's size
      
*/

draw_empty(0):- write('|'),
                nl, !.

draw_empty(Size):- write('|          '),
                   Size > 0,
                   NewSize is Size-1,
                   draw_empty(NewSize).

/*
   
DRAW_LINE - Draw the board line with the characters
Size - Board's size
Board - Game board of size NxN
   
*/

draw_line(0,_):- write('|'),
                 nl, !.

draw_line(Size, [H|T]):- NewSize is Size-1,
                         write('|    '),
                         translate(H,Char),
                         write(Char),
                         write('     '),
                         draw_line(NewSize, T).

/*
  
DRAW_POOLS - draw each players pool
Stones - List of players' stones
Size - Board's size
    
*/

draw_pools(Stones, Size):- PoolSize is round((8/5)*Size),
                           draw_border(PoolSize),
                           draw_empty(PoolSize),
                           draw_line(PoolSize, Stones),
                           draw_empty(PoolSize),
                           draw_border(PoolSize),
                           nl,!.
                           


/* ---------------------------------------------------
   |         |         |         |         |         |  
   |         |    X    |         |    O    |    O    | 
   |         |         |         |         |         | 
   ---------------------------------------------------
   |         |         |         |         |         |  
   |    O    |         |    X    |    X    |    X    | 
   |         |         |         |         |         | 
   ---------------------------------------------------
   |         |         |         |         |         |  
   |    X    |         |         |    O    |    X    | 
   |         |         |         |         |         | 
   ---------------------------------------------------
   |         |         |         |         |         |  
   |         |         |    O    |    O    |         | 
   |         |         |         |         |         | 
   ---------------------------------------------------
   |         |         |         |         |         |  
   |    X    |    X    |    O    |    O    |         | 
   |         |         |         |         |         | 
   ---------------------------------------------------
   
   -----------------------------------------------------------------------
   |         |         |         |         |         |         |         |
   |         |         |         |         |         |         |         |
   |         |         |         |         |         |         |         |
   -----------------------------------------------------------------------
   
   -----------------------------------------------------------------------
   |         |         |         |         |         |         |         |
   |         |         |         |         |         |         |         |
   |         |         |         |         |         |         |         |
   -----------------------------------------------------------------------
   
   | _ | x | _ | o | o |
   | o | _ | x | x | x |
   | x | _ | _ | o | x |
   | _ | _ | o | o | _ |
   | x | x | o | o | _ |
    
   
   _ - 0
   o - 1
   x - 2
*/