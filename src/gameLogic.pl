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

initialize_board(Board, Size, ResultBoard):- 
        make_board(Size, Board),
        Turns is round((8/5)*Size),
        make_line(Turns, Pool1),
        make_line(Turns, Pool2),
        write('--- Initialize Board ---'), nl,
        draw_board(Size, Board), nl,
        init_board_turn(Board, ResultBoard, Turns),
        game_loop([[1,2,1,2,2],[0,2,0,1,0],[0,0,1,1,0],[1,2,2,2,0],[1,2,0,0,1]], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], RB, RP1, RP2),
        draw_board(Size, RB, RP1, RP2).

game_loop(Board, Pool1, Pool2, ResultBoard, ResultPool1, ResultPool2):-  
        write('--- Turn ---'), nl,
        write('Player 1: '),
        play_ask_move(Board, 1, [0,0,0], Pool2, RB, RP2),
        write('Player 2: '),
        play_ask_move(RB, 2, [0,0,0], Pool1, RB2, RP1),
        game_loop(RB2, RP1, RP2, ResultBoard, ResultPool1, ResultPool2).

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

play_ask_move(Board, Player, Moves, OppositePool, ResultBoard, ResultOppositePool):- 
        nl, write('Pick your next move (push, move, sacrifice, finish)?'), nl,
        read(Play), nl,
        ask_move(Board, Play, Player, Moves, OppositePool, ResultBoard, ResultOppositePool).

play_ask_move(Board, _, _, OppositePool, Board, OppositePool).

ask_move(_, 'finish', _, _, _, _).

ask_move(Board, 'push', Player, Moves, OppositePool, ResultBoard, ResultOppositePool) :- 
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
        play_ask_move(RB, Player, L, ROP, ResultBoard, ResultOppositePool).

ask_move(Board, 'push', Player, Moves, OppositePool, ResultBoard, ResultOppositePool) :-
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
        play_ask_move(RB, Player, L, ROP, ResultBoard, ResultOppositePool).

% --- ASK_MOVE MOVE ---

ask_move(Board, 'move', Player, Moves, OppositePool, ResultBoard, ResultOppositePool) :-
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
        play_ask_move(RB, Player, L, ROP, ResultBoard, ResultOppositePool).

ask_move(Board, 'move', Player, Moves, OppositePool, ResultBoard, ResultOppositePool) :-
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
        play_ask_move(RB, Player, L, ROP, ResultBoard, ResultOppositePool).

% --- ASK_MOVE SACRIFICE ---

/*
ask_move(Board,Player, Moves) :- 
        Player = 1, !,
        nl, write('Player 1s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
        read(Play), nl,                                
        Play = 'sacrifice', !,
        write('Piece to sacrifice? (X-Y): '),
        read(PieceX-PieceY), nl.
        %sacrificePlay(Board,Player,PieceX,PieceY).

ask_move(Board,Player, Moves) :- 
        Player = 2, !,
        nl, write('Player 2s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
        read(Play), nl,                                
        Play = 'sacrifice', !,
        write('Piece to sacrifice? (X-Y): '),
        read(PieceX-PieceY), nl.
        %sacrificePlay(Board,Player,PieceX,PieceY).
        
*/