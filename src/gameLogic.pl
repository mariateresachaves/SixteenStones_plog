:-use_module(library(lists)).
:-consult('board.pl').
:-consult('movements.pl').

replace(Board, X , Y , Player , NewBoard ):- append(RowPfx, [Row|RowSfx], Board),
                                             XX is X-1,
                                             length(RowPfx, XX),
                                             append(ColPfx, [_|ColSfx], Row),
                                             YY is Y-1,
                                             length(ColPfx, YY),
                                             append(ColPfx, [Player|ColSfx], NewRow),
                                             append(RowPfx, [NewRow|RowSfx], NewBoard).

getStone(Board, X, Y, Stone):- nth1(X, Board, Line),
                               nth1(Y, Line, Stone).

update_board(Board, NewBoard, X, Y, Player, Valid):- getStone(Board, X, Y, Stone),
                                                     write(Stone),
                                                     nl,
                                                     Stone == 0,
                                                     replace(Board, X, Y, Player, NewBoard),
                                                     Valid is 1.

update_board(_, _, _, _, _, 0).

play(Board, NewBoard, Player):- read(X-Y),
                                update_board(Board, NewBoard, X, Y, Player, Valid),
                                Valid == 1,
                                write(NewBoard).

play(Board, NewBoard, Player):- read(X-Y),
                                update_board(Board, NewBoard, X, Y, Player, Valid),
                                Valid == 0,
                                play(Board, NewBoard, Player).

/*
INIT_BOARD_TURN - Players choose the initial position of their stones
Board - Game board of size NxN
Size - Board's size
*/

init_board_turn(B, B, 0).

init_board_turn(Board, ResultBoard, Turns):- write('Player 1: '),
                                             play(Board, NewBoard, 1),
                                             write('Player 2: '),
                                             play(NewBoard, NewBoard2, 2),
                                             NewTurns is Turns-1,
                                             init_board_turn(NewBoard2, ResultBoard, NewTurns).

/*
INITIALIZE_BOARD - Players play (8/5)*Size turns
Board - Game board of size NxN
Size - Board's size
*/

initialize_board(Board, Size):- make_board(Size, Board),
                                Turns is round((8/5)*Size),
                                init_board_turn(Board, ResultBoard, Turns).

% TERESA
% loop de round((8/5)*Size*2 vezes - número de peças de cada jogador - alternando entre cada jogador
% verificar no board se na posição X-Y existe alguma peça
% se não existir atualizar o board
% se já existir uma peça nessa posição pedir novamente uma posição ao utilizador

replace_elem(L, N, Elem, LR):- replace_elem(L, N, 0, Elem, LR), !.

replace_elem([_|T], N, Counter, Elem, LR):- N == Counter,
                                            NewCounter is Counter + 1,
                                            replace_elem(T, N, NewCounter, Elem, NLR),
                                            append([Elem], NLR, LR).

replace_elem([H|T], N, Counter, Elem, LR):- NewCounter is Counter + 1,
                                            replace_elem(T, N, NewCounter, Elem, NLR),
                                            append([H], NLR, LR).

replace_elem([], _, _, _, []).

turn_loop(Board, Player, Moves):- ask_move(Board, Player, Moves).

% DIOGO
% pedir jogada ao jogador
%       pode ser push move ou sacrifice

ask_move(Board, Player, Moves) :- Player is 1,
                                  nl, write('Player 1s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
                                  read(Play), nl,          
                                  Play == 'push',
                                  nth0(0,Moves,Elem),
                                  Elem == 0,
                                  replace_elem(Moves, 0, 1, L),
                                  write(L),
                                  write('Piece to push? (X-Y): '),
                                  read(PieceX-PieceY), nl,
                                  write('Which way to push to? (n,s,e,w,nw,ne,se,sw)'),
                                  read(Orientation), nl.
                                  %pushPlay(Board,Player,PieceX,PieceY,Orientation).

ask_move(Board,Player, Moves) :- Player = 1, !,
                                 nl, write('Player 1s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
                                 read(Play), nl,                                
                                 Play == 'move', 
                                 nth0(0,Moves,Elem),
                                 Elem == 0, !,
                                 replace_elem(Moves, 1, 1, L),
                                 write(L),
                                 write('Piece to move? (X-Y): '),
                                 read(PieceX-PieceY), nl,
                                 write('Which way to move to? (n,s,e,w,nw,ne,se,sw)'),
                                 read(Orientation), nl.
                                 %movePlay(Board,Player,PieceX,PieceY,Orientation).

ask_move(Board,Player, Moves) :- Player = 1, !,
                                 nl, write('Player 1s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
                                 read(Play), nl,                                
                                 Play = 'sacrifice', !,
                                 write('Piece to sacrifice? (X-Y): '),
                                 read(PieceX-PieceY), nl.
                                 %sacrificePlay(Board,Player,PieceX,PieceY).

ask_move(Board,Player, Moves) :- Player = 2, !,
                                 nl, write('Player 2s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
                                 read(Play), nl,                                
                                 Play == 'push', 
                                 nth0(0,Moves,Elem),
                                 Elem == 0, !,
                                 replace_elem(Moves, 0, 1, L),
                                 write(L),
                                 write('Piece to push? (X-Y): '),
                                 read(PieceX-PieceY), nl,
                                 write('Which way to push to? (n,s,e,w,nw,ne,se,sw)'),
                                 read(Orientation), nl.
                                 %pushPlay(Board,Player,PieceX,PieceY,Orientation).

ask_move(Board,Player, Moves) :- Player = 2, !,
                                 nl, write('Player 2s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
                                 read(Play), nl,                                
                                 Play == 'move',
                                 nth0(0,Moves,Elem),
                                 Elem == 0, !,
                                 replace_elem(Moves, 1, 1, L),
                                 write(L),
                                 write('Piece to move? (X-Y): '),
                                 read(PieceX-PieceY), nl,
                                 write('Which way to move to? (n,s,e,w,nw,ne,se,sw)'),
                                 read(Orientation), nl.
                                 %movePlay(Board,Player,PieceX,PieceY,Orientation).

ask_move(Board,Player, Moves) :- Player = 2, !,
                                 nl, write('Player 2s turn, pick your next move (Push, Move, Sacrifice)?'), nl,
                                 read(Play), nl,                                
                                 Play = 'sacrifice', !,
                                 write('Piece to sacrifice? (X-Y): '),
                                 read(PieceX-PieceY), nl.
                                 %sacrificePlay(Board,Player,PieceX,PieceY).

% DIOGO
% verificar se a jogada é válida
% se jogada é válida efectuar jogada

% TERESA
% verificar jogadas disponíveis
% caso não hajam jogadas disponíveis terminar turno do jogador
% se ainda tiver jogadas disponíveis volta a pedir jogada ao jogador

% TERESA
% verificar se o jogo terminou - número de peças no board de um dos jogadores é 1
% se não terminou troca de jogador e faz outra vez o ciclo de turno

% DIOGO
% Jogada Move
% Move a peça e verifica se captura alguma peça adversária

movePlay(Board,BoardSize,Player,PieceX,PieceY,Orientation) :-
    Player = 1, !,
    check_piece_player(Board,Player,PieceX,PieceY),
    get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY),
    check_empty_cell(Board,NewX,NewY),
    move_aux(Board,BoardSize,Player,PieceX,PieceY,NewPieceX,NewPieceY,ReturnBoard).
    %check_capture_status(Board,NewPieceX,NewPieceY).

move_aux(Board,BoardSize,PieceX,PieceY,NewPieceX, NewPieceY, ReturnBoard) :- %draw_board(BoardSize,Board),
                                                                             getStone(Board,PieceX,PieceY,Stone),
                                                                             replace(Board,NewPieceX,NewPieceY,Stone,TempBoard),
                                                                             replace(TempBoard,PieceX,PieceY,0,ReturnBoard).
                                                                             %draw_board(BoardSize,ReturnBoard).

check_piece_player(Board,Player,PieceX,PieceY) :- getStone(Board,PieceX,PieceY,Stone),
                                                  Player == 1, !,
                                                  Stone == 1.
    

check_piece_player(Board,Player,PieceX,PieceY) :- getStone(Board,PieceX,PieceY,Stone),
                                                  Player == 2, !,
                                                  Stone == 2.
    

check_empty_cell(Board,X,Y) :- getStone(Board,X,Y,Stone),                                            
                               Stone == 0.   
    

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 'n' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceY-1 > 0,
                                                                                NewX is PieceX,
                                                                                NewY is PieceY-1,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize.                                                                    

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 's' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceY+1 < BoardSize,
                                                                                NewX is PieceX,
                                                                                NewY is PieceY+1,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize.

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 'e' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceX+1 < BoardSize,
                                                                                NewX is PieceX+1,
                                                                                NewY is PieceY,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize.

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 'w' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceX-1 > 0,
                                                                                NewX is PieceX-1,
                                                                                NewY is PieceY,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize.                           

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 'nw' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceX-1 > 0,
                                                                                PieceY-1 > 0,
                                                                                NewX is PieceX-1,
                                                                                NewY is PieceY-1,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize.  

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 'ne' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceX+1 < BoardSize,
                                                                                PieceY-1 > 0,
                                                                                NewX is PieceX+1,
                                                                                NewY is PieceY-1,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize. 

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 'sw' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceX-1 > 0,
                                                                                PieceY+1 < BoardSize,
                                                                                NewX is PieceX-1,
                                                                                NewY is PieceY+1,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize. 

get_position_from_orientation(BoardSize,PieceX,PieceY,Orientation,NewX,NewY) :- Orientation == 'se' ,!,
                                                                                PieceX > 0,
                                                                                PieceY > 0,
                                                                                PieceX+1 < BoardSize,
                                                                                PieceY+1 < BoardSize,
                                                                                NewX is PieceX+1,
                                                                                NewY is PieceY+1,
                                                                                NewX < BoardSize,
                                                                                NewY < BoardSize. 

% for testing purposes only
% Board = [[0, 0, 0, 1, 1],[0, 0, 0, 0, 0],[0, 0, 0, 0, 0],[1, 0, 0, 0, 0],[1, 0, 0, 0, 2]].                                                                   
