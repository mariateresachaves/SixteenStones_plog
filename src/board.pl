




make_line(0, []).
make_line(Size, Line):- NewSize is Size-1,
                        make_line(NewSize, NewLine), 
                        append(NewLine, [0], Line).

print_board([]).
print_board([H|T]):- print_line(H), nl,
                     print_board(T).

print_line([]):- write('|').
print_line([H|T]):- write('| _ '),
                    write(H),
                    write(' _ '),
                    print_line(T).

make_board(Size, Board):- make_board(Size, 0, Board).

make_board(S, S, []).

make_board(Size, Counter, Board):- NewCounter is Counter + 1,
                                   make_line(Size, Line),
                                   make_board(Size, NewCounter, NewBoard),
                                   append(NewBoard, Line, Board).

        
/*
   | _   _ | _ x _ | _   _ | _ o _ | _ o _ |
   | _ o _ | _   _ | _ x _ | _ x _ | _ x _ |
   | _ x _ | _   _ | _   _ | _ o _ | _ x _ |
   | _   _ | _   _ | _ o _ | _ o _ | _   _ |
   | _ x _ | _ x _ | _ o _ | _ o _ | _   _ |
    
   
   _ - 0
   o - 1
   x - 2
   */