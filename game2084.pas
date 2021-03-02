program game2084;
const
    MAX_MAP = 8;
    WALL = 5;
    NOTHING = 0;
type 
    type_game = record 
	lin,col:integer;
	map: array [1..MAX_MAP,1..MAX_MAP] of integer;
	score:integer;
    end;
    type_coord = record
	lin,col:integer;
    end;

var game:type_game;

procedure Create_Two(var game:type_game);
(* Create the number two in a random position on the map *)
var RanP:type_coord;
begin
    randomize;
    RanP.lin:=random(game.lin)+1;
    RanP.col:=random(game.col)+1;
    while game.map[RanP.lin,RanP.col] <> NOTHING do 
	begin
	    RanP.lin:=random(game.lin)+1;
	    RanP.col:=random(game.col)+1;
	end;
    game.map[RanP.lin,Ranp.Col]:=2;
end;

procedure initializing_game(var game:type_game);
var i,j:integer;
begin
    (* The map is 4x4 but we have one more line and columns for the walls *)
    game.lin:=5;
    game.col:=5;
    game.score:=0;


    for i:=1 to game.lin do
	for j:=1 to game.col do
	    begin
		if (i=1)or(j=1)or(i=game.lin)or(j=game.lin)then
		   game.map[i,j]:=WALL
		else
		    game.map[i,j]:=NOTHING;
	    end;
    Create_Two(game);
    Create_Two(game);
end;

procedure print_map(var game:type_game);
var i,j:integer;
begin
    for i:=1 to game.lin do
	begin
	    for j:=1 to game.col do
		write(game.map[i,j],' ');
	    writeln;
	end;
end;

begin
    initializing_game(game);
    print_map(game);
end.
