%Pool do jogador adversário

push_n(Board, Player, X, Y, Count, NewX, Y):- XX is X-1,
                                              nth1(XX, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              push_n(Board, Player, XX, Y, NewCount, NewX, Y),
                                              Count is NewCount+1.

push_n(_, _, X, _, 0, NewX, _):- NewX is X.

push_s(Board, Player, X, Y, Count, NewX, Y):- XX is X+1,
                                              nth1(XX, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              push_s(Board, Player, XX, Y, NewCount, NewX, Y),
                                              Count is NewCount+1.

push_s(_, _, X, _, 0, NewX, _):- NewX is X.

push_e(Board, Player, X, Y, Count, X, NewY):- YY is Y+1,
                                              nth1(X, Board, Line),
                                              nth1(YY, Line, Stone),
                                              Stone == Player,
                                              push_e(Board, Player, X, YY, NewCount, X, NewY),
                                              Count is NewCount+1.

push_e(_, _, _, Y, 0, _, NewY):- NewY is Y.

push_o(Board, Player, X, Y, Count, X, NewY):- YY is Y-1,
                                              nth1(X, Board, Line),
                                              nth1(YY, Line, Stone),
                                              Stone == Player,
                                              push_o(Board, Player, X, YY, NewCount, X, NewY),
                                              Count is NewCount+1.

push_o(_, _, _, Y, 0, _, NewY):- NewY is Y.

push_ne(Board, Player, X, Y, Count, NewX, NewY):- XX is X-1,
                                                  YY is Y+1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_ne(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_ne(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

push_so(Board, Player, X, Y, Count, NewX, NewY):- XX is X+1,
                                                  YY is Y-1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_so(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_so(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

push_no(Board, Player, X, Y, Count, NewX, NewY):- XX is X-1,
                                                  YY is Y-1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_no(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_no(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

push_se(Board, Player, X, Y, Count, NewX, NewY):- XX is X+1,
                                                  YY is Y+1,
                                                  nth1(XX, Board, Line),
                                                  nth1(YY, Line, Stone),
                                                  Stone == Player,
                                                  push_se(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_se(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

get_op_player(Player, Opposite):- Opposite is 2 // Player.

valid_push(Board, NextX, NextY, Valid):- nth1(NextX, Board, NextLine),
                                               nth1(NextY, NextLine, NextStone),
                                               NextStone == 0,
                                               Valid = 1.
               
valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      Orientation == 'n',
                                                      NextX == 0,
                                                      Valid = 1.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 's',
                                                      NextX == L,
                                                      Valid = 1.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'e',
                                                      NextY == L,
                                                      Valid = 1.           
      
valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      Orientation == 'o',
                                                      NextY == 0,
                                                      Valid = 1.                                        

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'ne',
                                                      NextY == L,
                                                      NextX == 0,
                                                      Valid = 1. 

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'se',
                                                      NextY == L,
                                                      NextX == L,
                                                      Valid = 1.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'so',
                                                      NextY == 0,
                                                      NextX == L,
                                                      Valid = 1.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      Orientation == 'no',
                                                      NextY == 0,
                                                      NextX == 0,
                                                      Valid = 1.

before_list(L, N, R):- before_list(L, N, 0, R).

before_list([H|T], N, Counter, R):- N > Counter - 1,
                                    NewCounter is Counter + 1,
                                    before_list(T, N, NewCounter, LR),
                                    append([H], LR, R).

before_list(_, N, N, []).

after_list(L, N, R):- after_list(L, N, 0, R).

after_list([_|T], N, Counter, R):- N >= Counter,
                                   NewCounter is Counter + 1,
                                   after_list(T, N, NewCounter, R).

after_list([H|T], N, Counter, R):- Counter > N,
                                   NewCounter is Counter + 1,
                                   after_list(T, N, NewCounter, LR),
                                   append([H], LR, R).

remove_last([_], []).

remove_last([H|T], [H|NewList]) :- remove_last(T, NewList).

remove_first([_|T], T).

push_column_n(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

push_column_n(Board, X, Y, NumStones, Result):- NewX is X-NumStones,
                                                XX is NewX+1,
                                                nth1(XX, Board, Line2),
                                                nth1(Y, Line2, Stone2),
                                                replace(Board, NewX, Y, Stone2, NewBoard), 
                                                NewNumStones is NumStones-1,
                                                push_column_n(NewBoard, X, Y, NewNumStones, Result).

push_column_s(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

push_column_s(Board, X, Y, NumStones, Result):- NewX is X+NumStones,
                                                XX is NewX-1,
                                                nth1(XX, Board, Line2),
                                                nth1(Y, Line2, Stone2),
                                                replace(Board, NewX, Y, Stone2, NewBoard), 
                                                NewNumStones is NumStones-1,
                                                push_column_s(NewBoard, X, Y, NewNumStones, Result).

push_column_ne(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

push_column_ne(Board, X, Y, NumStones, Result):- NewX is X-NumStones,
                                                 NewY is Y+NumStones,
                                                 XX is NewX+1,
                                                 YY is NewY-1,
                                                 nth1(XX, Board, Line2),
                                                 nth1(YY, Line2, Stone2),
                                                 replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 push_column_ne(NewBoard, X, Y, NewNumStones, Result).

push_column_so(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

push_column_so(Board, X, Y, NumStones, Result):- NewX is X+NumStones,
                                                 NewY is Y-NumStones,
                                                 XX is NewX-1,
                                                 YY is NewY+1,
                                                 nth1(XX, Board, Line2),
                                                 nth1(YY, Line2, Stone2),
                                                 replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 push_column_so(NewBoard, X, Y, NewNumStones, Result).

push_column_no(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

push_column_no(Board, X, Y, NumStones, Result):- NewX is X-NumStones,
                                                 NewY is Y-NumStones,
                                                 XX is NewX+1,
                                                 YY is NewY+1,
                                                 nth1(XX, Board, Line2),
                                                 nth1(YY, Line2, Stone2),
                                                 replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 push_column_no(NewBoard, X, Y, NewNumStones, Result).

push_column_se(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

push_column_se(Board, X, Y, NumStones, Result):- NewX is X+NumStones,
                                                 NewY is Y+NumStones,
                                                 XX is NewX-1,
                                                 YY is NewY-1,
                                                 nth1(XX, Board, Line2),
                                                 nth1(YY, Line2, Stone2),
                                                 replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 push_column_se(NewBoard, X, Y, NewNumStones, Result).

push_Stones(Board, X, Y, NewBoard, Orientation, Stone):- Orientation == 'e',
                                                         nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         after_list(Line, Y, After),
                                                         before_list(Line, Y, Before),
                                                         append(Before, [0], Tmp),
                                                         append(Tmp, After, TmpFinal),
                                                         remove_last(TmpFinal, FinalList),
                                                         after_list(Board, X, After),
                                                         before_list(Board, X, Before),
                                                         append(Before, FinalList, B),
                                                         append(B, After, NewBoard).

push_Stones(Board, X, Y, NewBoard, Orientation, Stone):- Orientation == 'o',
                                                         nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         after_list(Line, Y, After),
                                                         before_list(Line, Y, Before),
                                                         append(Before, [0], Tmp),
                                                         append(Tmp, After, TmpFinal),
                                                         remove_first(TmpFinal, FinalList),
                                                         after_list(Board, X, After),
                                                         before_list(Board, X, Before),
                                                         append(Before, FinalList, B),
                                                         append(B, After, NewBoard).

push_Stones(Board, X, Y, NewBoard, Orientation, Stone):- Orientation == 'n',
                                                         nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         after_list(Line, Y, After),
                                                         before_list(Line, Y, Before),
                                                         append(Before, [0], Tmp),
                                                         append(Tmp, After, TmpFinal),
                                                         remove_first(TmpFinal, FinalList),
                                                         after_list(Board, X, After),
                                                         before_list(Board, X, Before),
                                                         append(Before, FinalList, B),
                                                         append(B, After, NewBoard).

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'n',
                                           push_n(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_n(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 's',
                                           push_s(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_s(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'e',
                                           push_e(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_e(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'o',
                                           push_o(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_o(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'ne',
                                           push_ne(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_ne(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'se',
                                           push_se(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_se(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'so',
                                           push_so(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_so(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.

push(Board,Player,X,Y,Orientation, Pool):- nth1(X, Board, Line),
                                           nth1(Y, Line, Stone),
                                           Stone == Player,
                                           Orientation == 'no',
                                           push_no(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                           get_op_player(Player, Opposite),
                                           push_no(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                           Count > OppositeCount-1,
                                           valid_push(Board, NextX, NextY, Valid, Orientation),
                                           Valid == 1.



% verificar se existe uma peça do jogador nessa posição
% verificar o número de peças consecutivas que tem depois da coordenada X-Y na direção orientação
% verificar depois dessas peças o número de peças adversárias consecutivas que existem naquela direção
% verificar se a célula depois das peças adversárias é vazia ou limite do board

% |
% | 
% | 
% | o
% | o o o o   o o x     x x |
% | x o o o o o o x x x x x |  o
% _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

% N-1
% 2 - 1
% 7 - 6
                                                     
% 1,1,1,1,0
% Stone = 0
% 1,1,2,0,0,2,2
% Stone = 1
% 1,1,1,1,0,1
% Stone = 1
% 1,1,1,1,0,1,1
%Stone = 2
% 1,1,1,1,0,1,2