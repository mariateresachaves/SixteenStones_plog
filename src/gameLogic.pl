:-use_module(library(lists)).
:-consult('board.pl').
:-consult('movements.pl').

replace(Board, X , Y , Player , NewBoard ):- 
        append(RowPfx, [Row|RowSfx], Board),
        XX is X-1,
        length(RowPfx, XX),
        append(ColPfx, [_|ColSfx], Row),
        YY is Y-1,
        length(ColPfx, YY),
        append(ColPfx, [Player|ColSfx], NewRow),
        append(RowPfx, [NewRow|RowSfx], NewBoard).

getStone(Board, X, Y, Stone):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone).

update_board(Board, NewBoard, X, Y, Player, Valid):- 
        getStone(Board, X, Y, Stone),
        Stone == 0,
        replace(Board, X, Y, Player, NewBoard),
        Valid is 1.

update_board(_, _, _, _, _, 0).

play(Board, NewBoard, Player):- 
        read(X-Y),
        update_board(Board, NewBoard, X, Y, Player, Valid),
        Valid == 1,
        write(NewBoard),nl.

play(Board, NewBoard, Player):- 
        read(X-Y),
        update_board(Board, NewBoard, X, Y, Player, Valid),
        Valid == 0,
        play(Board, NewBoard, Player).

/*
INIT_BOARD_TURN - Players choose the initial position of their stones
Board - Game board of size NxN
Size - Board's size
*/

init_board_turn(B, B, 0).

init_board_turn(Board, ResultBoard, Turns):- 
        Turns > 0,
        nth0(0,Board,Line),
        length(Line, Size),
        write('Player 1: '), nl,
        play(Board, NewBoard, 1),
        nl, write('Actual board'), nl,
        draw_board(Size, NewBoard), nl,
        write('Player 2: '), nl,
        play(NewBoard, NewBoard2, 2),
        nl, write('Actual board'), nl,
        draw_board(Size, NewBoard2), nl,
        NewTurns is Turns-1,
        init_board_turn(NewBoard2, ResultBoard, NewTurns).

/*
INITIALIZE_BOARD - Players play (8/5)*Size turns
Board - Game board of size NxN
Size - Board's size
*/

count_stones_line([H|T], Player, Stones):-
    H == Player, !,
    count_stones_line(T, Player, NewStones),
    Stones is NewStones+1.

count_stones_line([_|T], Player, Stones):-
    count_stones_line(T, Player, Stones).

count_stones_line([], _, 0).

count_stones_board([], _, 0).
    
count_stones_board([BH|BT], P, S):-
    count_stones_line(BH, P, LS),
    count_stones_board(BT, P, SS),
    S is SS + LS.

initialize_board(_, Size, _):- 
        Size < 5,
        write('Invalid size for board! Please pick a number higher than 5 that is also a multiple of 5! '),!,
        fail.

initialize_board(_, Size, _):- 
        Remain is mod(Size,5),
        Remain \= 0,
        write('Invalid size for board! Please pick a number higher than 5 that is also a multiple of 5! '),!,
        fail.

initialize_board(Board, Size, ResultBoard):- 
        make_board(Size, Board),
        Turns is round((8/5)*Size),
        make_line(Turns, Pool1),
        make_line(Turns, Pool2),
        write('--- Initialize Board ---'), nl,
        draw_board(Size, Board), nl,
        init_board_turn(Board, ResultBoard, Turns),
        game_loop(ResultBoard, Pool1, Pool2, RB, RP1, RP2),
        %game_loop([[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[1,2,2,0,0],[1,0,0,0,0]], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], RB, RP1, RP2),
        draw_board(Size, RB, RP1, RP2).

game_loop(Board, Pool1, Pool2, ResultBoard, ResultPool1, ResultPool2):-  
        write('entrei no loop'),
        count_stones_board(Board, 1, SP1),
        write('Stones P1: '),
        write(SP1),
        SP1 > 1,
        count_stones_board(Board, 2, SP2),
        SP2 > 1,
        write('--- Turn ---'), nl,
        write('Player 1: '),
        play_ask_move(Board, 1, [0,0,0], Pool2, Pool1, RB, RP2, RP1),
        write('Player 2: '),
        play_ask_move(RB, 2, [0,0,0], Pool1, Pool2, RB2, RP1, RP2),
        game_loop(RB2, RP1, RP2, ResultBoard, ResultPool1, ResultPool2).

game_loop(Board, Pool1, Pool2, ResultBoard, ResultPool1, ResultPool2):- 
        write('entrei no loop2'),
        count_stones_board(Board, 2, SP2),
        SP2 > 1,
        write('--- Turn ---'), nl,
        write('Player 1: '),
        play_ask_move(Board, 1, [0,0,0], Pool2, Pool1, RB, RP2, RP1),
        write('Player 2: '),
        play_ask_move(RB, 2, [0,0,0], Pool1, Pool2, RB2, RP1, RP2),
        game_loop(RB2, RP1, RP2, ResultBoard, ResultPool1, ResultPool2).

game_loop(Board, Pool1, Pool2, ResultBoard, ResultPool1, ResultPool2):-  
        write('entrei no loop3'),
        count_stones_board(Board, 1, SP1),
        SP1 > 1,
        write('--- Turn ---'), nl,
        write('Player 1: '),
        play_ask_move(Board, 1, [0,0,0], Pool2, Pool1, RB, RP2, RP1),
        write('Player 2: '),
        play_ask_move(RB, 2, [0,0,0], Pool1, Pool2, RB2, RP1, RP2),
        game_loop(RB2, RP1, RP2, ResultBoard, ResultPool1, ResultPool2).

game_loop(Board, _, _, _, _, _):-
        write('entrei no loop4'),
        count_stones_board(Board, 1, SP1),
        SP1 == 1,
        write('Player 2 wins!'), nl.

game_loop(Board, _, _, _, _, _):-
        write('entrei no loop5'),
        count_stones_board(Board, 2, SP2),
        SP2 == 1,
        write('Player 1 wins!'), nl.

% --- REPLACE_ELEM ---

replace_elem(L, N, Elem, LR):- 
        replace_elem(L, N, 0, Elem, LR), !.

replace_elem([_|T], N, Counter, Elem, LR):- 
        N == Counter,
        NewCounter is Counter + 1,
        replace_elem(T, N, NewCounter, Elem, NLR),
        append([Elem], NLR, LR).

replace_elem([H|T], N, Counter, Elem, LR):- 
        NewCounter is Counter + 1,
        replace_elem(T, N, NewCounter, Elem, NLR),
        append([H], NLR, LR).

replace_elem([], _, _, _, []).

% --- ASK_MOVE PUSH ---

play_ask_move(Board, Player, Moves, OppositePool, Pool, ResultBoard, ResultOppositePool, ResultPool):- 
        nl, write('Pick your next move (push, move, sacrifice, finish)?'), nl,
        read(Play), nl,
        ask_move(Board, Play, Player, Moves, OppositePool, Pool, ResultBoard, ResultOppositePool, ResultPool).

play_ask_move(Board, _, _, OppositePool, Pool, Board, OppositePool, Pool).

ask_move(_, 'finish', _, _, _, _, _, _).

ask_move(Board, 'push', Player, Moves, OppositePool, _, ResultBoard, ResultOppositePool, _) :- 
        nth0(0, Moves, Elem),
        Elem == 0,
        replace_elem(Moves, 0, 1, L),
        write('Stone to push? (X-Y): '),
        read(X-Y), nl,
        write('Which way to push to? (n,s,e,w,nw,ne,se,sw)'),
        read(Orientation), nl,
        push(Board, Player, X, Y, Orientation, OppositePool, ROP, RB),
        nth0(0,Board,Line),
        length(Line, Size),
        get_op_player(Player, OppositePlayer),
        draw_board(Size, RB, ROP, OppositePlayer),nl,!,
        play_ask_move(RB, Player, L, ROP, _, ResultBoard, ResultOppositePool, _).

ask_move(Board, 'push', Player, Moves, OppositePool, _, ResultBoard, ResultOppositePool, _) :-
        nth0(0, Moves, Elem0),
        Elem0 == 1,
        nth0(2, Moves, Elem2),
        Elem2 == 1,
        replace_elem(Moves, 0, 2, L),
        write('Stone to push? (X-Y): '),
        read(X-Y), nl,
        write('Which way to push to? (n,s,e,w,nw,ne,se,sw)'),
        read(Orientation), nl,
        push(Board, Player, X, Y, Orientation, OppositePool, ROP, RB),
        play_ask_move(RB, Player, L, ROP, _, ResultBoard, ResultOppositePool, _).

% --- ASK_MOVE MOVE ---

ask_move(Board, 'move', Player, Moves, OppositePool, _, ResultBoard, ResultOppositePool, _) :-
        nth0(1, Moves, Elem),
        Elem == 0,
        replace_elem(Moves, 1, 1, L),
        write('Stone to move? (X-Y): '),
        read(X-Y), nl,
        write('Which way to move to? (n,s,e,w,nw,ne,se,sw)'),
        read(Orientation), nl,
        nth0(0, Board, Line),
        length(Line, Size),
        move(Board, Player, X, Y, Orientation, OppositePool, ROP, RB),
        get_op_player(Player, OppositePlayer),
        draw_board(Size, RB, ROP, OppositePlayer),nl,!,
        play_ask_move(RB, Player, L, ROP, _, ResultBoard, ResultOppositePool, _).

ask_move(Board, 'move', Player, Moves, OppositePool, _, ResultBoard, ResultOppositePool, _) :-
        nth0(1, Moves, Elem1),
        Elem1 == 1,
        nth0(2, Moves, Elem2),
        Elem2 == 1,
        replace_elem(Moves, 1, 2, L),
        write('Piece to move? (X-Y): '),
        read(X-Y), nl,
        write('Which way to move to? (n,s,e,w,nw,ne,se,sw)'),
        read(Orientation), nl,
        move(Board, Player, X, Y, Orientation, OppositePool, ROP, RB),
        play_ask_move(RB, Player, L, ROP, _, ResultBoard, ResultOppositePool, _).

% --- ASK_MOVE SACRIFICE ---

ask_move(Board, 'sacrifice', Player, Moves, _, Pool, _, _, ResultPool) :- 
        nth0(2, Moves, Elem),
        Elem == 0,
        replace_elem(Moves, 2, 1, L),
        sacrifice(Pool, ResultPool),
        nth0(0,Board,Line),
        length(Line, Size),
        draw_board(Size, Board, Pool, Player),nl,!,
        play_ask_move(Board, Player, L, _, Pool, Board, _, ResultPool).