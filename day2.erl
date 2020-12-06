-module(day2).
-export([run/0]).

run()->
    ParsedLines = load_file("day2input.txt"),
    {part1(ParsedLines), part2(ParsedLines)}.

part1(ParsedLines)->
    ValidLines = [ Line || Line <- ParsedLines, is_valid1(Line)],
    length(ValidLines).

part2(ParsedLines)->
    ValidLines = [ Line || Line <- ParsedLines, is_valid2(Line)],
    length(ValidLines).

is_valid1({From, To, Char, Pw}) ->
    N = length([[X] || X <- Pw, [X] =:= Char]),
    (N >= From) and (N =< To).

is_valid2({Idx1, Idx2, Char, Pw}) ->
    (string:slice(Pw, Idx1-1, 1) =:= Char) xor (string:slice(Pw, Idx2-1, 1) =:= Char).

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ parse(Line) || Line <- string:tokens(StringContent, "\n")]. 

parse(Line)->
    {ok, MP} = re:compile("([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)"),
    {_,[_,From, To, Char, Pw]} = re:run(Line, MP),
    {extract_num(Line, From), extract_num(Line, To), extract_str(Line, Char), extract_str(Line, Pw)}.

extract_str(String, {Start, End})->
    string:slice(String, Start, End).

extract_num(String, {Start, End})->
    Str = string:slice(String, Start, End),
    {Int, _} = string:to_integer(Str),
    Int.