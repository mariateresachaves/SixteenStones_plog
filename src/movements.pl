%Pool do jogador adversário

push_n(Board, Player, X, Y, Count, X, NewY):- YY is Y+1,
                                              nth1(X, Board, Line),
                                              nth1(YY, Line, Stone),
                                              Stone == Player,
                                              push_n(Board, Player, X, YY, NewCount, X, NewY),
                                              Count is NewCount+1.

push_n(_, _, _, Y, 0, _, NewY):- NewY is Y.

push_s(Board, Player, X, Y, Count, X, NewY):- YY is Y-1,
                                              nth1(X, Board, Line),
                                              nth1(YY, Line, Stone),
                                              Stone == Player,
                                              push_s(Board, Player, X, YY, NewCount, X, NewY),
                                              Count is NewCount+1.

push_s(_, _, _, Y, 0, _, NewY):- NewY is Y.

push_e(Board, Player, X, Y, Count, NewX, Y):- XX is X+1,
                                              nth1(XX, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              push_e(Board, Player, XX, Y, NewCount, NewX, Y),
                                              Count is NewCount+1.

push_e(_, _, X, _, 0, NewX, _):- NewX is X.

push_o(Board, Player, X, Y, Count, NewX, Y):- XX is X-1,
                                              nth1(XX, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              push_o(Board, Player, XX, Y, NewCount, NewX, Y),
                                              Count is NewCount+1.

push_o(_, _, X, _, 0, NewX, _):- NewX is X.

push_ne(Board, Player, X, Y, Count, NewX, NewY):- XX is X+1,
                                                  YY is Y+1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_ne(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_ne(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

push_so(Board, Player, X, Y, Count, NewX, NewY):- XX is X-1,
                                                  YY is Y-1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_so(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_so(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

push_no(Board, Player, X, Y, Count, NewX, NewY):- XX is X-1,
                                                  YY is Y+1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_no(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_no(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

push_se(Board, Player, X, Y, Count, NewX, NewY):- XX is X+1,
                                                  YY is Y-1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_se(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_se(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

get_op_player(Player, Opposite):- Opposite is 2 // Player.

valid_push(Board, NextX, NextY, Size, Valid):- nth1(NextX, Board, NextLine),
                                               nth1(NextY, NextLine, NextStone),
                                               NextStone == 0,
                                               Valid = 1.
               
valid_push(Board, NextX, NextY, Size, Valid):- nth1(NextX, Board, NextLine),
                                               nth1(NextY, NextLine, NextStone),
                                               length(NextLine, L),
                                               
                           Valid = 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'n',
                                           push_n(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_n(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           
                                           NextStone == 0,
                                           Orientation == 's',
                                           push_s(Board, Player, X, Y, Count, NewX, NewY),
                                           Orientation == 'e',
                                           push_e(Board, Player, X, Y, Count, NewX, NewY),
                                           Orientation == 'o',
                                           push_o(Board, Player, X, Y, Count, NewX, NewY),
                                           Orientation == 'ne',
                                           push_ne(Board, Player, X, Y, Count, NewX, NewY),
                                           Orientation == 'so',
                                           push_so(Board, Player, X, Y, Count, NewX, NewY),
                                           Orientation == 'no',
                                           push_no(Board, Player, X, Y, Count, NewX, NewY),
                                           Orientation == 'se',
                                           push_se(Board, Player, X, Y, Count, NewX, NewY).

% verificar se existe uma peça do jogador nessa posição
% verificar o número de peças consecutivas que tem depois da coordenada X-Y na direção orientação
% verificar depois dessas peças o número de peças adversárias consecutivas que existem naquela direção
% verificar se a célula depois das peças adversárias é vazia ou limite do board

% |
% | 
% | 
% | o
% | o o o o o o o x x x x x |
% | x o o o o o o x x x x x |  o
% _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

% N-1
% 2 - 1
% 7 - 6
                                                     
% 