-module(day4).
-export([run/0]).

run()->
    Lines = load_file("day4input.txt"),
    Passports = lists:map(fun(Line) -> parse_line(Line) end, Lines),
    { length(valid_passports_part1(Passports)), length(valid_passports_part2(Passports)) }.

parse_line(Line) ->
    lists:map(fun(T) -> list_to_tuple(string:tokens(T, ":")) end, string:tokens(Line, " ")).

valid_passports_part1(Passports)->
    lists:filter(fun(Passport) -> is_valid(Passport) end, Passports).

is_valid(Passport)-> 
    lists:keymember("byr", 1, Passport) and lists:keymember("iyr", 1, Passport) and
    lists:keymember("eyr", 1, Passport) and lists:keymember("hgt", 1, Passport) and
    lists:keymember("hcl", 1, Passport) and lists:keymember("ecl", 1, Passport) and
    lists:keymember("pid", 1, Passport).

valid_passports_part2(Passports)->
    PassportsPart1 = valid_passports_part1(Passports),
    [Passport || Passport <- PassportsPart1, lists:all(fun(Field) -> is_valid2(Field) end, Passport)].

is_valid2({"byr", Value})->
    {Int, _} = string:to_integer(Value),
    (Int >= 1920) and (Int =< 2002);
is_valid2({"iyr", Value})->
    {Int, _} = string:to_integer(Value),
    (Int >= 2010) and (Int =< 2020);
is_valid2({"eyr", Value})->
    {Int, _} = string:to_integer(Value),
    (Int >= 2020) and (Int =< 2030);
is_valid2({"hgt", Value})->
    case string:to_integer(Value) of
        {Cm, "cm"} -> (Cm >= 150) and (Cm =< 193);
        {In, "in"} -> (In >= 59) and (In =< 76);
        _ -> false
    end;
is_valid2({"hcl", Value})->
    {ok, MP} = re:compile("^#[0-9a-f]{6}$"),
    case re:run(Value, MP) of
        {match, _} -> true;
        _ -> false
    end;
is_valid2({"ecl", Value})->
    lists:member(Value, ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]);
is_valid2({"pid", Value})->
    {ok, MP} = re:compile("^[0-9]{9}$"),
    case re:run(Value, MP) of
        {match, _} -> true;
        _ -> false
    end;
is_valid2({"cid",_}) -> true;
is_valid2(_)->false.

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ string:join(string:replace(Line, "\n", " ", all), "") || Line <- string:split(StringContent, "\n\n", all)].