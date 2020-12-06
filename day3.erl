-module(day3).
-export([run/0]).

run()->
    Lines = load_file("day3input.txt"),
    {part1(Lines), part2(Lines)}.

% Part 1 %
part1(Lines)->
    count_trees(Lines, 0, 0).

count_trees([H | T], Pos, Count)->
    case string:slice(H, Pos, 1) of
        "." -> count_trees(T, (Pos + 3) rem length(H), Count);
        "#" -> count_trees(T, (Pos + 3) rem length(H), Count + 1)
    end;
count_trees([], _, Count) ->
    Count.

% Part 2 %
part2(Lines)->
    C1 = count_trees(Lines, 0, 0, 1, 1),
    C2 = count_trees(Lines, 0, 0, 3, 1),
    C3 = count_trees(Lines, 0, 0, 5, 1),
    C4 = count_trees(Lines, 0, 0, 7, 1),
    C5 = count_trees(Lines, 0, 0, 1, 2),
    {C1, C2, C3, C4, C5, C1*C2*C3*C4*C5}.

count_trees([H | T], Pos, Count, Right, Down)->
    case string:slice(H, Pos, 1) of
        "." -> count_trees(nthtail(Down-1, T), (Pos + Right) rem length(H), Count, Right, Down);
        "#" -> count_trees(nthtail(Down-1, T), (Pos + Right) rem length(H), Count + 1, Right, Down)
    end;
count_trees([], _, Count,_,_) ->
    Count.

nthtail(_, [])->[];
nthtail(N, L)-> lists:nthtail(N, L).

% Helper %
load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ Line || Line <- string:tokens(StringContent, "\n")].