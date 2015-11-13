/*
   ****** PUSH ******
*/

% --- PUSH_N ---

push_n(Board, Player, X, Y, Count, NewX, Y):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        XX is X-1,
        push_n(Board, Player, XX, Y, NewCount, NewX, Y),
        Count is NewCount+1.

push_n(_, _, X, Y, 0, NewX, Y):- 
        X \= 0,
        NewX is X.

push_n(_, _, X, Y, 0, NewX, Y):- 
        X == 0,
        NewX is X+1.

% --- PUSH_S ---

push_s(Board, Player, X, Y, Count, NewX, Y):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        XX is X+1,
        push_s(Board, Player, XX, Y, NewCount, NewX, Y),
        Count is NewCount+1.

push_s(Board, _, X, Y, 0, NewX, Y):- 
        nth1(X, Board, Line),
        length(Line,L),
        X \= L,
        NewX is X.

push_s(Board, _, X, Y, 0, NewX, Y):- 
        nth1(X, Board, Line),
        length(Line,L),
        X == L,
        NewX is X.

% --- PUSH_E ---

push_e(Board, Player, X, Y, Count, X, NewY):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        YY is Y+1,
        push_e(Board, Player, X, YY, NewCount, X, NewY),
        Count is NewCount+1.

push_e(Board, _, X, Y, 0, X, NewY):- 
        nth1(X, Board, Line),
        length(Line,L),
        Y \= L,
        NewY is Y.

push_e(Board, _, X, Y, 0, X, NewY):- 
        nth1(X, Board, Line),
        length(Line,L),
        Y == L,
        NewY is Y.

% --- PUSH_W ---

push_w(Board, Player, X, Y, Count, X, NewY):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        YY is Y-1,
        push_w(Board, Player, X, YY, NewCount, X, NewY),
        Count is NewCount+1.

push_w(_, _, X, Y, 0, X, NewY):- 
        Y \= 0,
        NewY is Y.

push_w(_, _, X, Y, 0, X, NewY):- 
        Y == 0,
        NewY is Y.

% --- PUSH_NE ---

push_ne(Board, Player, X, Y, Count, NewX, NewY):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        XX is X-1,
        YY is Y+1,
        push_ne(Board, Player, XX, YY, NewCount, NewX, NewY),
        Count is NewCount+1.

push_ne(_, _, X, Y, 0, NewX, NewY):- 
        X == 0,
        NewX is X+1,
        NewY is Y-1.

push_ne(_, _, X, Y, 0, NewX, NewY):- 
        NewX is X,
        NewY is Y.

% --- PUSH_SW ---

push_sw(Board, Player, X, Y, Count, NewX, NewY):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        XX is X+1,
        YY is Y-1,
        push_sw(Board, Player, XX, YY, NewCount, NewX, NewY),
        Count is NewCount+1.

push_sw(_, _, X, Y, 0, NewX, NewY):- 
        Y == 0,
        NewX is X-1,
        NewY is Y+1.

push_sw(_, _, X, Y, 0, NewX, NewY):- 
        NewX is X,
        NewY is Y.

% --- PUSH_NW ---

push_nw(Board, Player, X, Y, Count, NewX, NewY):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        XX is X-1,
        YY is Y-1,
        push_nw(Board, Player, XX, YY, NewCount, NewX, NewY),
        Count is NewCount+1.

push_nw(_, _, X, Y, 0, NewX, NewY):- 
        X \= 0,
        NewX is X,
        NewY is Y.

push_nw(_, _, X, Y, 0, NewX, NewY):- 
        X == 0,
        NewX is X+1,
        NewY is Y+1.

% --- PUSH_SE ---

push_se(Board, Player, X, Y, Count, NewX, NewY):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        XX is X+1,
        YY is Y+1,
        push_se(Board, Player, XX, YY, NewCount, NewX, NewY),
        Count is NewCount+1.

push_se(Board, _, X, Y, 0, NewX, NewY):- 
        nth1(X, Board, Line),
        length(Line,L),
        X \= L,
        NewX is X,
        NewY is Y.

push_se(Board, _, X, Y, 0, NewX, NewY):- 
        nth1(X, Board, Line),
        length(Line,L),
        X == L,
        NewX is X-1,
        NewY is Y-1.

% --- VALID_PUSH ---

valid_push(Board, NextX, NextY, Valid):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, NextStone),
        NextStone == 0,
        Valid is 1, !.

% --- VALID_PUSH N ---

valid_push(Board, NextX, NextY, Valid, Orientation):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        Orientation == 'n',
        NextX == 1,
        Valid is 1, !.

% --- VALID_PUSH S ---

valid_push(Board, NextX, NextY, Valid, Orientation):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        length(NextLine, L),
        Orientation == 's',
        NextX == L,
        Valid is 1, !.

% --- VALID_PUSH E ---

valid_push(Board, NextX, NextY, Valid, 'e'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        length(NextLine, L),
        NextY == L,
        Valid is 1, !.     
      
% --- VALID_PUSH W ---

valid_push(Board, NextX, NextY, Valid, 'w'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        NextY == 1,
        Valid is 1, !.

% --- VALID_PUSH NE ---

valid_push(Board, NextX, NextY, Valid, 'ne'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        length(NextLine, L),
        NextY == L,
        Valid is 1, !.

valid_push(_, NextX, _, Valid, 'ne'):- 
        NextX == 1,
        Valid is 1, !.

% --- VALID_PUSH SE ---

valid_push(Board, NextX, NextY, Valid, 'se'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        length(NextLine, L),
        NextX == L,
        Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, 'se'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        length(NextLine, L),
        NextY == L,
        Valid is 1, !.

% --- VALID_PUSH SW ---

valid_push(Board, NextX, NextY, Valid, 'sw'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        length(NextLine, L),
        NextX == L,
        Valid is 1, !.

valid_push(_, _, NextY, Valid, 'sw'):- 
        NextY == 1,
        Valid is 1, !.

% --- VALID_PUSH NW ---

valid_push(Board, NextX, NextY, Valid, 'nw'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        NextX == 1,
        Valid is 1, !.

valid_push(Board, NextX, NextY, Valid, 'nw'):- 
        nth1(NextX, Board, NextLine),
        nth1(NextY, NextLine, _),
        NextY == 1,
        Valid is 1, !.

% --- BEFORE_LIST ---

before_list(L, N, R):- 
        before_list(L, N, 0, R).

before_list([H|T], N, Counter, R):- 
        N > Counter - 1,
        NewCounter is Counter + 1,
        before_list(T, N, NewCounter, LR),
        append([H], LR, R).

before_list(_, N, N, []).

% --- AFTER_LIST ---

after_list(L, N, R):- 
        after_list(L, N, 0, R).

after_list([_|T], N, Counter, R):- 
        N >= Counter,
        NewCounter is Counter + 1,
        after_list(T, N, NewCounter, R).

after_list([H|T], N, Counter, R):- 
        Counter > N,
        NewCounter is Counter + 1,
        after_list(T, N, NewCounter, LR),
        append([H], LR, R).

% --- REMOVE_LAST ---

remove_last([_], []).

remove_last([H|T], [H|NewList]) :- 
        remove_last(T, NewList).

remove_first([_|T], T).

% --- UPDATE_BOARD_N ---

update_board_n(Board, X, Y, 1, NewBoard):- 
        replace(Board, X, Y, 0, NewBoard).

update_board_n(Board, X, Y, NumStones, Result):- 
        NewX is X-NumStones,
        XX is NewX+1,
        nth1(XX, Board, Line2),
        nth1(Y, Line2, Stone2),
        replace(Board, NewX, Y, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_n(NewBoard, X, Y, NewNumStones, Result).

% --- UPDATE_BOARD_S ---

update_board_s(Board, X, Y, 1, NewBoard):- 
        replace(Board, X, Y, 0, NewBoard).

update_board_s(Board, X, Y, NumStones, Result):- 
        NewX is X+NumStones,
        XX is NewX-1,
        nth1(XX, Board, Line2),
        nth1(Y, Line2, Stone2),
        replace(Board, NewX, Y, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_s(NewBoard, X, Y, NewNumStones, Result).

% --- UPDATE_BOARD_E ---

update_board_e(Board, X, Y, 1, NewBoard):- 
        replace(Board, X, Y, 0, NewBoard).

update_board_e(Board, X, Y, NumStones, Result):- 
        NewY is Y+NumStones,
        YY is NewY-1,
        nth1(X, Board, Line2),
        nth1(YY, Line2, Stone2),
        replace(Board, X, NewY, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_e(NewBoard, X, Y, NewNumStones, Result).

% --- UPDATE_BOARD_W ---

update_board_w(Board, X, Y, 1, NewBoard):- 
        replace(Board, X, Y, 0, NewBoard).

update_board_w(Board, X, Y, NumStones, Result):- 
        NewY is Y-NumStones,
        YY is NewY+1,
        nth1(X, Board, Line2),
        nth1(YY, Line2, Stone2),
        replace(Board, X, NewY, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_w(NewBoard, X, Y, NewNumStones, Result).

% --- UPDATE_BOARD_NE ---

update_board_ne(Board, X, Y, 1, NewBoard):- 
        replace(Board, X, Y, 0, NewBoard).

update_board_ne(Board, X, Y, NumStones, Result):- 
        NewX is X-NumStones,
        NewY is Y+NumStones,
        XX is NewX+1,
        YY is NewY-1,
        nth1(XX, Board, Line2),
        nth1(YY, Line2, Stone2),
        replace(Board, NewX, NewY, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_ne(NewBoard, X, Y, NewNumStones, Result).

% --- UPDATE_BOARD_SW ---

update_board_sw(Board, X, Y, 1, NewBoard):- replace(Board, X, Y, 0, NewBoard).

update_board_sw(Board, X, Y, NumStones, Result):- 
        NewX is X+NumStones,
        NewY is Y-NumStones,
        XX is NewX-1,
        YY is NewY+1,
        nth1(XX, Board, Line2),
        nth1(YY, Line2, Stone2),
        replace(Board, NewX, NewY, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_sw(NewBoard, X, Y, NewNumStones, Result).

% --- UPDATE_BOARD_NW ---

update_board_nw(Board, X, Y, 1, NewBoard):- 
        replace(Board, X, Y, 0, NewBoard).

update_board_nw(Board, X, Y, NumStones, Result):- 
        NewX is X-NumStones,
        NewY is Y-NumStones,
        XX is NewX+1,
        YY is NewY+1,
        nth1(XX, Board, Line2),
        nth1(YY, Line2, Stone2),
        replace(Board, NewX, NewY, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_nw(NewBoard, X, Y, NewNumStones, Result).

% --- UPDATE_BOARD_SE ---

update_board_se(Board, X, Y, 1, NewBoard):- 
        replace(Board, X, Y, 0, NewBoard).

update_board_se(Board, X, Y, NumStones, Result):- 
        NewX is X+NumStones,
        NewY is Y+NumStones,
        XX is NewX-1,
        YY is NewY-1,
        nth1(XX, Board, Line2),
        nth1(YY, Line2, Stone2),
        replace(Board, NewX, NewY, Stone2, NewBoard), 
        NewNumStones is NumStones-1,
        update_board_se(NewBoard, X, Y, NewNumStones, Result).

% --- GET_OP_PLAYER ---

get_op_player(Player, Opposite):- 
        Opposite is 2 // Player.

% --- ADD_TO_POOL ---

add_to_pool([], _, 1, []).

add_to_pool([PoolH|PoolT], Stone, Count, NewPool):- 
        PoolH == 0,
        Count == 0,
        add_to_pool(PoolT, Stone, 1, TmpPool),
        append([Stone], TmpPool, NewPool).

add_to_pool([PoolH|PoolT], Stone, Count, NewPool):- 
        add_to_pool(PoolT, Stone, Count, TmpPool),
        append([PoolH], TmpPool, NewPool),!.

% --- PUSH NORTH ---

push(Board, Player, X, Y, 'n', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_n(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_n(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_n(Board, X, Y, NumStones, Result).

push(Board, Player, X, Y, 'n', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_n(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_n(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid, 'n'),
        Valid == 1,
        NumStones is Count+OppositeCount-1,
        update_board_n(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH SOUTH ---

push(Board, Player, X, Y, 's', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_s(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_s(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_s(Board, X, Y, NumStones, Result).

push(Board, Player, X, Y, 's', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_s(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_s(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        NOppositeCount is OppositeCount+1,
        Count > OppositeCount, !,
        NOppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid, 's'),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_s(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH EAST ---

push(Board, Player, X, Y, 'e', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_e(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_e(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_e(Board, X, Y, NumStones, Result).

push(Board, Player, X, Y, 'e', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_e(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_e(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        NOppositeCount is OppositeCount+1,
        Count > OppositeCount, !,
        NOppositeCount > 0,
        SuperNextY is NextY-1,
        valid_push(Board, NextX, SuperNextY, Valid, 'e'),
        Valid == 1,
        NumStones is Count+OppositeCount-1,
        update_board_e(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH WEST ---

push(Board, Player, X, Y, 'w', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_w(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_w(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_w(Board, X, Y, NumStones, Result).

push(Board, Player, X, Y, 'w', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_w(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_w(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        NOppositeCount is OppositeCount+1,
        Count > OppositeCount, !,
        NOppositeCount > 0,
        SuperNextY is NextY+1,
        valid_push(Board, NextX, SuperNextY, Valid, 'w'),
        Valid == 1,
        NumStones is Count+OppositeCount-1,
        update_board_w(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH NORTHEAST ---

push(Board, Player, X, Y, 'ne', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_ne(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_ne(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_ne(Board, X, Y, NumStones, Result).

push(Board, Player, X, Y, 'ne', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_ne(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_ne(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount, !,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid, 'ne'),
        Valid == 1,
        NumStones is Count+OppositeCount-1,
        update_board_ne(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

% -- PUSH SOUTHEAST ---

push(Board, Player, X, Y, 'se', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
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

push(Board, Player, X, Y, 'se', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_se(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_se(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        NOppositeCount is OppositeCount+1,
        Count > OppositeCount,
        NOppositeCount > 0,
        SuperNextX is NextX+1,
        SuperNextY is NextY+1,
        valid_push(Board, SuperNextX, SuperNextY, Valid, 'se'),
        Valid == 1,
        NumStones is Count+OppositeCount-1,
        update_board_se(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH SOUTHWEST ---

push(Board, Player, X, Y, 'sw', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_sw(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_sw(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_sw(Board, X, Y, NumStones, Result).

push(Board, Player, X, Y, 'sw', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_sw(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_sw(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount, !,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid, 'sw'),
        Valid == 1,
        NumStones is Count+OppositeCount-1,
        update_board_sw(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

% --- PUSH NORTHWEST ---

push(Board, Player, X, Y, 'nw', Pool, Pool, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_nw(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_nw(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid),
        Valid == 1,
        NumStones is Count+OppositeCount,
        update_board_nw(Board, X, Y, NumStones, Result).

push(Board, Player, X, Y, 'nw', Pool, PoolResult, Result):- 
        nth1(X, Board, Line),
        nth1(Y, Line, Stone),
        Stone == Player,
        push_nw(Board, Player, X, Y, Count, OppositeX, OppositeY),
        get_op_player(Player, Opposite),
        push_nw(Board, Opposite, OppositeX, OppositeY, OppositeCount, NextX, NextY),
        Count > OppositeCount, !,
        OppositeCount > 0,
        valid_push(Board, NextX, NextY, Valid, 'nw'),
        Valid == 1,
        NumStones is Count+OppositeCount-1,
        update_board_nw(Board, X, Y, NumStones, Result),
        add_to_pool(Pool, Opposite, 0, PoolResult).

/*
   ****** MOVE ******
*/

move(Board, 1, X, Y, Orientation, Pool, ResultPool, ResultBoard) :-
        getStone(Board,X,Y,Stone),
        Stone == 1,
        get_position_from_orientation(X, Y, Orientation, NewX, NewY),
        check_empty_cell(Board, NewX, NewY),
        move_aux(Board, X, Y, NewX, NewY, ReturnBoard),
        check_capture_status(ReturnBoard, NewX, NewY, 1, Pool, ResultCaptures),
        remove_captured_stones(ReturnBoard, 2, ResultCaptures, Pool, ResultPool, ResultBoard).

move(Board, 2, X, Y, Orientation, Pool, ResultPool, ResultBoard) :-
        getStone(Board,X,Y,Stone),
        Stone == 2,
        get_position_from_orientation(X, Y, Orientation, NewX, NewY),
        check_empty_cell(Board, NewX, NewY),
        move_aux(Board, X, Y, NewX, NewY, ReturnBoard),
        check_capture_status(ReturnBoard, NewX, NewY, 2, _, ResultCaptures),
        remove_captured_stones(ReturnBoard, 1, ResultCaptures, Pool, ResultPool, ResultBoard).

% --- REMOVE_CAPTURED_STONES ---

remove_captured_stones(Board, _, [], Pool, Pool, Board).

remove_captured_stones(Board, OppositePlayer, [X-Y], Pool, ResultPool, ResultBoard):-
        replace(Board, X, Y, 0, RB),
        add_to_pool(Pool, OppositePlayer, 0, RP),
        remove_captured_stones(RB, OppositePlayer, [], RP, ResultPool, ResultBoard).

remove_captured_stones(Board, OppositePlayer, [X-Y|TC], Pool, ResultPool, ResultBoard):-
        replace(Board, X, Y, 0, RB),
        add_to_pool(Pool, OppositePlayer, 0, RP),
        remove_captured_stones(RB, OppositePlayer, TC, RP, ResultPool, ResultBoard).

% --- CHECK_CAPTURE_STATUS ---

check_capture_status(Board, NewX, NewY, Player, _, ResultCaptures) :- 
        check_capture_status(Board, 'n', NewX, NewY, Player, [], RC1),
        check_capture_status(Board, 's', NewX, NewY, Player, RC1, RC2),
        check_capture_status(Board, 'e', NewX, NewY, Player, RC2, RC3),
        check_capture_status(Board, 'w', NewX, NewY, Player, RC3, RC4),
        check_capture_status(Board, 'nw', NewX, NewY, Player, RC4, RC5),
        check_capture_status(Board, 'ne', NewX, NewY, Player, RC5, RC6),
        check_capture_status(Board, 'sw', NewX, NewY, Player, RC6, RC7),
        check_capture_status(Board, 'se', NewX, NewY, Player, RC7, ResultCaptures), !.

check_capture_status(Board, Orientation, NewX, NewY, Player, CL, RCL) :- 
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_op_player(Player, OppositePlayer),
        get_position_from_orientation(NewX, NewY, Orientation, CheckX, CheckY),
        getStone(Board, CheckX, CheckY, CheckStone),
        CheckStone == OppositePlayer,
        get_position_from_orientation(CheckX, CheckY, Orientation, SurroundX, SurroundY),
        getStone(Board, SurroundX, SurroundY, PossibleSurroundStone),
        PossibleSurroundStone == Player,
        append(CL, [CheckX-CheckY], RCL).

check_capture_status(Board, Orientation, NewX, NewY, Player, CL, RCL) :- 
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, CheckX, _),
        CheckX == 0,
        append(CL, [], RCL).
   
check_capture_status(Board, Orientation, NewX, NewY, Player, CL, RCL) :- 
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, _, CheckY),
        CheckY == 0,
        append(CL, [], RCL).

check_capture_status(Board, Orientation, NewX, NewY, Player, CL, RCL) :- 
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, CheckX, _),
        CheckX > 0,
        append(CL, [], RCL).

check_capture_status(Board, Orientation, NewX, NewY, Player, CL, RCL) :- 
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, _, CheckY),
        CheckY > 0,
        append(CL, [], RCL).

check_capture_status(Board, Orientation, NewX, NewY, Player, CL, RCL) :- 
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, CheckX, _),
        nth1(1,Board,Line),
        length(Line,Size),
        CheckX > Size,
        append(CL, [], RCL).

check_capture_status(Board, Orientation, NewX, NewY, Player, CL, RCL) :- 
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, _, CheckY),
        nth1(1,Board,Line),
        length(Line,Size),
        CheckY > Size,
        append(CL, [], RCL).

check_capture_status(Board, Orientation, NewX, NewY, Player, CL, CL):-
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_op_player(Player, OppositePlayer),
        get_position_from_orientation(NewX, NewY, Orientation, CheckX, CheckY),
        getStone(Board, CheckX, CheckY, CheckStone),
        CheckStone \= OppositePlayer.

check_capture_status(Board, Orientation, NewX, NewY, Player, _, _):-
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, CheckX, _),
        CheckX == 0.

check_capture_status(Board, Orientation, NewX, NewY, Player, _, _):-
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, CheckX, _),
        nth1(1,Board,Line),
        length(Line,Size),
        CheckX == Size.

check_capture_status(Board, Orientation, NewX, NewY, Player, _, _):-
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, _, CheckY),
        CheckY == 0.

check_capture_status(Board, Orientation, NewX, NewY, Player, _, _):-
        getStone(Board, NewX, NewY, PlayerStone),
        PlayerStone == Player,
        get_position_from_orientation(NewX, NewY, Orientation, _, CheckY),
        nth1(1,Board,Line),
        length(Line,Size),
        CheckY == Size.

check_capture_status(_, _, _, _, _, Captures, Captures).
                
% --- MOVE_AUX ---

move_aux(Board, X, Y, NewX, NewY, ReturnBoard) :- 
        getStone(Board, X, Y, Stone),
        replace(Board, NewX, NewY, Stone, TempBoard),
        replace(TempBoard, X, Y, 0, ReturnBoard).

% --- CHECK_EMPTY_CELL ---

check_empty_cell(Board, X, Y) :- 
        getStone(Board, X, Y, Stone),                                            
        Stone == 0.

% --- GET_POSITION_FROM_ORIENTATION N ---

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 'n' ,!,
        NewX is X-1,
        NewY is Y.                        

% --- GET_POSITION_FROM_ORIENTATION S ---

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 's' ,!,
        NewX is X+1,
        NewY is Y.

% --- GET_POSITION_FROM_ORIENTATION E ---

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 'e' ,!,
        NewX is X,
        NewY is Y+1.

% --- GET_POSITION_FROM_ORIENTATION  W ---

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 'w' ,!,
        NewX is X,
        NewY is Y-1.           

% --- GET_POSITION_FROM_ORIENTATION NW ---                

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 'nw' ,!,
        NewX is X-1,
        NewY is Y-1.

% --- GET_POSITION_FROM_ORIENTATION NE ---

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 'ne' ,!,
        NewX is X-1,
        NewY is Y+1. 

% --- GET_POSITION_FROM_ORIENTATION SW ---

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 'sw' ,!,
        NewX is X+1,
        NewY is Y-1.

% --- GET_POSITION_FROM_ORIENTATION SE ---

get_position_from_orientation(X, Y, Orientation, NewX, NewY) :- 
        Orientation == 'se' ,!,
        NewX is X+1,
        NewY is Y+1.

/*
   ****** SACRIFICE ******
*/

sacrifice(Pool, ResultPool) :-
        nth1(1,Pool,Stone),
        Stone \= 0,
        remove_first(Pool,RP),
        append(RP,[0],ResultPool).

sacrifice(Pool, Pool).