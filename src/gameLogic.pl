:-use_module(library(lists)).
:-consult('board.pl').

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
% loop de round((8/5)*Size*2 vezes - n�mero de pe�as de cada jogador - alternando entre cada jogador
% verificar no board se na posi��o X-Y existe alguma pe�a
% se n�o existir atualizar o board
% se j� existir uma pe�a nessa posi��o pedir novamente uma posi��o ao utilizador

% DIOGO
% pedir jogada ao jogador
%       pode ser push move ou sacrifice

% DIOGO
% verificar se a jogada � v�lida
% se jogada � v�lida efectuar jogada

% TERESA
% verificar jogadas dispon�veis
% caso n�o hajam jogadas dispon�veis terminar turno do jogador
% se ainda tiver jogadas dispon�veis volta a pedir jogada ao jogador

% TERESA
% verificar se o jogo terminou - n�mero de pe�as no board de um dos jogadores � 1
% se n�o terminou troca de jogador e faz outra vez o ciclo de turno