-module(day1).
-export([run/0]).

% A simple "brute force" solution

run()->
    Numbers = load_file("day1input.txt"),
    {part1(Numbers), part2(Numbers)}.

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ element(1, string:to_integer(Substr)) || Substr <- string:tokens(StringContent, "\n")]. 

part1(L)->
    [H | _] = [{X, Y, X*Y} || X <- L, Y <- L, X + Y =:= 2020],
    H.

part2(L)->
    [H | _] = [{X, Y, Z, X*Y*Z} || X <- L, Y <- L, Z <- L, X + Y + Z =:= 2020],
    H.