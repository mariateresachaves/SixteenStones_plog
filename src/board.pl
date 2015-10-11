/*

TRANSLATE - convert a number to figure (_, O or X)
The first parameter is a possible board cell number.
The second parameter is the respective translation to a figure.

*/

translate(0, '_').
translate(1, 'O').
translate(2, 'X').

/*

MAKE_LINE - make a game board line
Size - The size of the line
Line - Line to be returned

*/

make_line(0, []).
make_line(Size, Line):- NewSize is Size-1,
                        make_line(NewSize, NewLine), 
                        append(NewLine, [0], Line).

/*

PRINT_LINE - print a line of the board
H - The H (head) is a board cell represented by one of the following numbers: 0, 1 or 2
T - The T (tail) is the others cells of that line
*/
                                         
print_line([]):- write(' |').

print_line([H|T]):- write(' | '),
                    translate(H, C), %convert number to figure (_, O or X)
                    write(C),
                    print_line(T).
                                                
/*

PRINT_BOARD- print a size NxN board
H - The H (head) is a line
T - The T (tail) is the other lines

*/
                                                
print_board([]).
print_board([H|T]):- print_line(H), nl,
                     print_board(T).

/*

MAKE_BOARD - make a board of size NxN
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
   | _ | x | _ | o | o |
   | o | _ | x | x | x |
   | x | _ | _ | o | x |
   | _ | _ | o | o | _ |
   | x | x | o | o | _ |
    
   
   _ - 0
   o - 1
   x - 2
*/