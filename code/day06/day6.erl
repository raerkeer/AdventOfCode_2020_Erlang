-module(day6).
-export([run/0]).

run()->
    Groups = load_file("day6input.txt"),
    {part1(Groups), part2(Groups)}.

part1(Groups) -> 
    GroupAnswers = lists:map(fun(Group) -> string:join(string:replace(Group, "\n", "", all), "") end, Groups),
    lists:sum(lists:map(fun(Group) -> sets:size(sets:from_list(Group)) end, GroupAnswers)).

part2(Groups)-> 
    L = lists:map(fun(Group) -> process_group(Group) end, Groups),
    lists:sum(L).

process_group(Group)->
    L1 = string:split(Group, "\n", all),
    L2 = lists:map(fun(PersonAnswer) -> sets:from_list(PersonAnswer) end, L1),
    sets:size(sets:intersection(L2)).

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ Line || Line <- string:split(StringContent, "\n\n", all)].