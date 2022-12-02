
-module('Solution').
-export([part1/0,part2/0]).

score_game(WinOrLoseConditions,Elf,You) ->
  dict:fetch({Elf, You},WinOrLoseConditions).


readlines(FileName) ->
  {ok, Device} = file:open(FileName, [read]),
  get_all_lines(Device, []).

get_all_lines(Device, Accum) ->
  case io:get_line(Device, "") of
    eof  -> file:close(Device), Accum;
    Line -> get_all_lines(Device, Accum ++ [Line])
  end.

evaluateGame(WinOrLoseConditions,Line) ->
  score_game(WinOrLoseConditions,string:slice(Line, 0, 1),string:slice(Line, 2, 2)).

part1() ->
  WinOrLoseConditions = dict:from_list([{{"A","X"}, 4}, {{"A","Y"}, 8}, {{"A","Z"}, 3},
    {{"B","X"}, 1}, {{"B","Y"}, 5}, {{"B","Z"}, 9},
    {{"C","X"}, 7}, {{"C","Y"}, 2}, {{"C","Z"}, 6}]),
  Lines = readlines("input.txt"),

  Scores = lists:map(fun(X) -> evaluateGame(WinOrLoseConditions,string:slice(X, 0, 3)) end, Lines),
  Total = lists:foldr(fun(Val,Acc) -> Val+Acc end,0,Scores),

  io:format("~p ~n",[Total]).

part2() ->
  WinOrLoseConditions = dict:from_list([{{"A","X"}, 3}, {{"A","Y"}, 4}, {{"A","Z"}, 8},
    {{"B","X"}, 1}, {{"B","Y"}, 5}, {{"B","Z"}, 9},
    {{"C","X"}, 2}, {{"C","Y"}, 6}, {{"C","Z"}, 7}]),
  Lines = readlines("input.txt"),

  Scores = lists:map(fun(X) -> evaluateGame(WinOrLoseConditions,string:slice(X, 0, 3)) end, Lines),
  Total = lists:foldr(fun(Val,Acc) -> Val+Acc end,0,Scores),

  io:format("~p ~n",[Total]).