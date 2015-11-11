% --- PUSH_N ---

push_n(Board, Player, X, Y, Count, NewX, Y):- nth1(X, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              XX is X-1,
                                              push_n(Board, Player, XX, Y, NewCount, NewX, Y),
                                              Count is NewCount+1.

push_n(_, _, X, Y, 0, NewX, Y):- X \= 0,
                                 NewX is X.

push_n(_, _, X, Y, 0, NewX, Y):- X == 0,
                                 NewX is X+1.

% --- PUSH_S ---

push_s(Board, Player, X, Y, Count, NewX, Y):- nth1(X, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              XX is X+1,
                                              push_s(Board, Player, XX, Y, NewCount, NewX, Y),
                                              Count is NewCount+1.

push_s(Board, _, X, Y, 0, NewX, Y):- nth1(X, Board, Line),
                                     length(Line,L),
                                     X \= L,
                                     NewX is X.

push_s(Board, _, X, Y, 0, NewX, Y):- nth1(X, Board, Line),
                                     length(Line,L),
                                     X == L,
                                     NewX is X.

% --- PUSH_E ---

push_e(Board, Player, X, Y, Count, X, NewY):- nth1(X, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              YY is Y+1,
                                              push_e(Board, Player, X, YY, NewCount, X, NewY),
                                              Count is NewCount+1.

push_e(Board, _, X, Y, 0, X, NewY):- nth1(X, Board, Line),
                                     length(Line,L),
                                     Y \= L,
                                     NewY is Y.

push_e(Board, _, X, Y, 0, X, NewY):- nth1(X, Board, Line),
                                     length(Line,L),
                                     Y == L,
                                     NewY is Y.

% --- PUSH_O ---

push_o(Board, Player, X, Y, Count, X, NewY):- nth1(X, Board, Line),
                                              nth1(Y, Line, Stone),
                                              Stone == Player,
                                              YY is Y-1,
                                              push_o(Board, Player, X, YY, NewCount, X, NewY),
                                              Count is NewCount+1.

push_o(_, _, X, Y, 0, X, NewY):- Y \= 0,
                                 NewY is Y.

push_o(_, _, X, Y, 0, X, NewY):- Y == 0,
                                 NewY is Y.

% --- PUSH_NE ---

push_ne(Board, Player, X, Y, Count, NewX, NewY):- nth1(X, Board, Line),
                                                  nth1(Y, Line, Stone),
                                                  Stone == Player,
                                                  XX is X-1,
                                                  YY is Y+1,
                                                  push_ne(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_ne(_, _, X, Y, 0, NewX, NewY):- X == 0,
                                     NewX is X+1,
                                     NewY is Y-1.

push_ne(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

% --- PUSH_SO ---

push_so(Board, Player, X, Y, Count, NewX, NewY):- nth1(X, Board, Line),
                                                  nth1(Y, Line, Stone),
                                                  Stone == Player,
                                                  XX is X+1,
                                                  YY is Y-1,
                                                  push_so(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_so(_, _, X, Y, 0, NewX, NewY):- Y == 0,
                                     NewX is X-1,
                                     NewY is Y+1.

push_so(_, _, X, Y, 0, NewX, NewY):- NewX is X,
                                     NewY is Y.

% --- PUSH_NO ---

push_no(Board, Player, X, Y, Count, NewX, NewY):- nth1(X, Board, Line),
                                                  nth1(Y, Line, Stone),
                                                  Stone == Player,
                                                  XX is X-1,
                                                  YY is Y-1,
                                                  push_no(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_no(_, _, X, Y, 0, NewX, NewY):- X \= 0,
                                     NewX is X,
                                     NewY is Y.

push_no(_, _, X, Y, 0, NewX, NewY):- X == 0,
                                     NewX is X+1,
                                     NewY is Y+1.

% --- PUSH_SE ---

push_se(Board, Player, X, Y, Count, NewX, NewY):- nth1(X, Board, Line),
                                                  nth1(Y, Line, Stone),
                                                  Stone == Player,
                                                  XX is X+1,
                                                  YY is Y+1,
                                                  push_se(Board, Player, XX, YY, NewCount, NewX, NewY),
                                                  Count is NewCount+1.

push_se(Board, _, X, Y, 0, NewX, NewY):- nth1(X, Board, Line),
                                         length(Line,L),
                                         X \= L,
                                         NewX is X,
                                         NewY is Y.

push_se(Board, _, X, Y, 0, NewX, NewY):- nth1(X, Board, Line),
                                         length(Line,L),
                                         X == L,
                                         NewX is X-1,
                                         NewY is Y-1.

valid_push(Board, NextX, NextY, Valid):- nth1(NextX, Board, NextLine),
                                         nth1(NextY, NextLine, NextStone),
                                         NextStone == 0,
                                         Valid is 1, !.
               
valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      Orientation == 'n',
                                                      NextX == 1,
                                                      Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 's',
                                                      NextX == L,
                                                      Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'e',
                                                      NextY == L,
                                                      Valid is 1, !.     
      
valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      Orientation == 'o',
                                                      NextY == 1,
                                                      Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'ne',
                                                      NextY == L,
                                                      Valid is 1, !.

valid_push(_, NextX, _, Valid, Orientation):- Orientation == 'ne',
                                              NextX == 1,
                                              Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'se',
                                                      NextX == L,
                                                      Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'se',
                                                      NextY == L,
                                                      Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      length(NextLine, L),
                                                      Orientation == 'so',
                                                      NextX == L,
                                                      Valid is 1, !.

valid_push(_, _, NextY, Valid, Orientation):- Orientation == 'so',
                                              NextY == 1,
                                              Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      Orientation == 'no',
                                                      NextX == 1,
                                                      Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, Orientation):- nth1(NextX, Board, NextLine),
                                                      nth1(NextY, NextLine, _),
                                                      Orientation == 'no',
                                                      NextY == 1,
                                                      Valid is 1, !.

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

update_board_n(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_n(Board, X, Y, NumStones, Result):- NewX is X-NumStones,
                                                 XX is NewX+1,
                                                 nth1(XX, Board, Line2),
                                                 nth1(Y, Line2, Stone2),
                                                 replace(Board, NewX, Y, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 update_board_n(NewBoard, X, Y, NewNumStones, Result).

update_board_s(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_s(Board, X, Y, NumStones, Result):- NewX is X+NumStones,
                                                 XX is NewX-1,
                                                 nth1(XX, Board, Line2),
                                                 nth1(Y, Line2, Stone2),
                                                 replace(Board, NewX, Y, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 update_board_s(NewBoard, X, Y, NewNumStones, Result).

update_board_e(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_e(Board, X, Y, NumStones, Result):- NewY is Y+NumStones,
                                                 YY is NewY-1,
                                                 nth1(X, Board, Line2),
                                                 nth1(YY, Line2, Stone2),
                                                 replace(Board, X, NewY, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 update_board_e(NewBoard, X, Y, NewNumStones, Result).

update_board_o(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_o(Board, X, Y, NumStones, Result):- NewY is Y-NumStones,
                                                 YY is NewY+1,
                                                 nth1(X, Board, Line2),
                                                 nth1(YY, Line2, Stone2),
                                                 replace(Board, X, NewY, Stone2, NewBoard), 
                                                 NewNumStones is NumStones-1,
                                                 update_board_o(NewBoard, X, Y, NewNumStones, Result).

update_board_ne(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_ne(Board, X, Y, NumStones, Result):- NewX is X-NumStones,
                                                  NewY is Y+NumStones,
                                                  XX is NewX+1,
                                                  YY is NewY-1,
                                                  nth1(XX, Board, Line2),
                                                  nth1(YY, Line2, Stone2),
                                                  replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                  NewNumStones is NumStones-1,
                                                  update_board_ne(NewBoard, X, Y, NewNumStones, Result).

update_board_so(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_so(Board, X, Y, NumStones, Result):- NewX is X+NumStones,
                                                  NewY is Y-NumStones,
                                                  XX is NewX-1,
                                                  YY is NewY+1,
                                                  nth1(XX, Board, Line2),
                                                  nth1(YY, Line2, Stone2),
                                                  replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                  NewNumStones is NumStones-1,
                                                  update_board_so(NewBoard, X, Y, NewNumStones, Result).

update_board_no(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_no(Board, X, Y, NumStones, Result):- NewX is X-NumStones,
                                                  NewY is Y-NumStones,
                                                  XX is NewX+1,
                                                  YY is NewY+1,
                                                  nth1(XX, Board, Line2),
                                                  nth1(YY, Line2, Stone2),
                                                  replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                  NewNumStones is NumStones-1,
                                                  update_board_no(NewBoard, X, Y, NewNumStones, Result).

update_board_se(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_se(Board, X, Y, NumStones, Result):- NewX is X+NumStones,
                                                  NewY is Y+NumStones,
                                                  XX is NewX-1,
                                                  YY is NewY-1,
                                                  nth1(XX, Board, Line2),
                                                  nth1(YY, Line2, Stone2),
                                                  replace(Board, NewX, NewY, Stone2, NewBoard), 
                                                  NewNumStones is NumStones-1,
                                                  update_board_se(NewBoard, X, Y, NewNumStones, Result).

get_op_player(Player, Opposite):- Opposite is 2 // Player.

add_to_pool([], _, 1, []).

add_to_pool([PoolH|PoolT], Stone, Count, NewPool):- PoolH == 0,
                                                    Count == 0,
                                                    add_to_pool(PoolT, Stone, 1, TmpPool),
                                                    append([Stone], TmpPool, NewPool).

add_to_pool([PoolH|PoolT], Stone, Count, NewPool):- add_to_pool(PoolT, Stone, Count, TmpPool),
                                                    append([PoolH], TmpPool, NewPool),!.

% --- PUSH NORTH ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 'n',
                                                         push_n(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_n(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         valid_push(Board, NextX, NextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_n(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 'n',
                                                               push_n(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_n(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               Count > OppositeCount,
                                                               OppositeCount > 0,
                                                               valid_push(Board, NextX, NextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount-1,
                                                               update_board_n(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH SOUTH ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 's',
                                                         push_s(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_s(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         valid_push(Board, NextX, NextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_s(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 's',
                                                               push_s(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_s(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               NOppositeCount is OppositeCount+1,
                                                               Count > OppositeCount, !,
                                                               NOppositeCount > 0,
                                                               valid_push(Board, NextX, NextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount,
                                                               update_board_s(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH EAST ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 'e',
                                                         push_e(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_e(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         valid_push(Board, NextX, NextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_e(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 'e',
                                                               push_e(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_e(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               NOppositeCount is OppositeCount+1,
                                                               Count > OppositeCount, !,
                                                               NOppositeCount > 0,
                                                               SuperNextY is NextY-1,
                                                               valid_push(Board, NextX, SuperNextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount-1,
                                                               update_board_e(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH WEST ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 'o',
                                                         push_o(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_o(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         valid_push(Board, NextX, NextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_o(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 'o',
                                                               push_o(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_o(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               NOppositeCount is OppositeCount+1,
                                                               Count > OppositeCount, !,
                                                               NOppositeCount > 0,
                                                               SuperNextY is NextY+1,
                                                               valid_push(Board, NextX, SuperNextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount-1,
                                                               update_board_o(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH NORTHEAST ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 'ne',
                                                         push_ne(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_ne(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         valid_push(Board, NextX, NextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_ne(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 'ne',
                                                               push_ne(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_ne(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               Count > OppositeCount, !,
                                                               OppositeCount > 0,
                                                               valid_push(Board, NextX, NextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount-1,
                                                               update_board_ne(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% -- PUSH SOUTHEAST ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 'se',
                                                         push_se(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_se(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         SuperNextX is NextX+1,
                                                         SuperNextY is NextY+1,
                                                         valid_push(Board, SuperNextX, SuperNextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_se(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 'se',
                                                               push_se(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_se(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               NOppositeCount is OppositeCount+1,
                                                               Count > OppositeCount,
                                                               NOppositeCount > 0,
                                                               SuperNextX is NextX+1,
                                                               SuperNextY is NextY+1,
                                                               valid_push(Board, SuperNextX, SuperNextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount-1,
                                                               update_board_se(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH SOUTHWEST ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 'so',
                                                         push_so(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_so(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         valid_push(Board, NextX, NextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_so(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 'so',
                                                               push_so(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_so(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               Count > OppositeCount, !,
                                                               OppositeCount > 0,
                                                               valid_push(Board, NextX, NextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount-1,
                                                               update_board_so(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH NORTHWEST ---

push(Board,Player,X,Y,Orientation, Pool, Pool, Result):- nth1(X, Board, Line),
                                                         nth1(Y, Line, Stone),
                                                         Stone == Player,
                                                         Orientation == 'no',
                                                         push_no(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                         get_op_player(Player, Opposite),
                                                         push_no(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                         Count > OppositeCount,
                                                         OppositeCount > 0,
                                                         valid_push(Board, NextX, NextY, Valid),
                                                         Valid == 1,
                                                         NumStones is Count+OppositeCount,
                                                         update_board_no(Board, X, Y, NumStones, Result).

push(Board,Player,X,Y,Orientation, Pool, PoolResult, Result):- nth1(X, Board, Line),
                                                               nth1(Y, Line, Stone),
                                                               Stone == Player,
                                                               Orientation == 'no',
                                                               push_no(Board, Player, X, Y, Count, OppositeX, OppositeY),
                                                               get_op_player(Player, Opposite),
                                                               push_no(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
                                                               Count > OppositeCount, !,
                                                               OppositeCount > 0,
                                                               valid_push(Board, NextX, NextY, Valid, Orientation),
                                                               Valid == 1,
                                                               NumStones is Count+OppositeCount-1,
                                                               update_board_no(Board, X, Y, NumStones, Result),
                                                               add_to_pool(Pool, Opposite, 0, PoolResult).

% verificar se a célula depois das peças adversárias é vazia ou limite do board