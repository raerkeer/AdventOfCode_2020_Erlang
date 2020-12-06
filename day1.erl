-module(day1).
-export([run/0]).

run()->
    process_list(load_file("day1input.txt")).

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ element(1, string:to_integer(Substr)) || Substr <- string:tokens(StringContent, "\n")]. 

process_list(L)->
    [{X, Y, X*Y} || X <- L, Y <- L, X + Y =:= 2020 ].

