-module(day1).
-export([run/0]).

% A simple "brute force" solution

-type day1_result() :: {Factor::pos_integer(), Factor::pos_integer(), Product::pos_integer()}.
-type day2_result() :: {Factor::pos_integer(), Factor::pos_integer(), Factor::pos_integer(), Product::pos_integer()}.
-spec run() -> {Day1::day1_result(), Day2::day2_result()}.

run()->
    Numbers = load_file("day1input.txt"),
    {part1(Numbers), part2(Numbers)}.

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ element(1, string:to_integer(Substr)) || Substr <- string:tokens(StringContent, "\n")]. 

part1(L)->
    hd([{X, Y, X*Y} || X <- L, Y <- L, X + Y =:= 2020]).

part2(L)->
    hd([{X, Y, Z, X*Y*Z} || X <- L, Y <- L, Z <- L, X + Y + Z =:= 2020]).