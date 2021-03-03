program game2084;
uses Crt;
const
    MAX_MAP = 8;
    WALL = -5;
    NOTHING = 0;
    UP = 93;
    RIGHT = 92;
    LEFT = 91;
    DOWN = 90;
type 
    type_game = record 
	lin,col:integer;
	map: array [1..MAX_MAP,1..MAX_MAP] of integer;
	score:integer;
    end;
    type_coord = record
	lin,col:integer;
    end;

var 
    game:type_game;
    end_game:boolean;

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

function IsSpaceFree(var game:type_game; direction,i,j:integer):boolean;
(* Returns true If the next direction is free *)
(* Otherwise returns false *)
begin
    case direction of
	UP:IsSpaceFree:= game.map[i-1,j] = NOTHING;
	RIGHT:IsSpaceFree:= game.map[i,j+1] = NOTHING;
	LEFT:IsSpaceFree:= game.map[i,j-1] = NOTHING;
	DOWN:IsSpaceFree:= game.map[i+1,j] = NOTHING;
    end;
end;

function MoveNumber(var game:type_game; i,j,k,l,direction:integer):boolean;
(* Move the number in position [i,j] to position [k,l] *)
(* returns true If the movement is possible*)
(* returns false If the movement is not possible *)
(* sum them If the position [k,l] have an igual number *)
begin
    MoveNumber:=false;
    if game.map[i,j] > 0 then
	begin
	    if IsSpaceFree(game,direction,i,j) then
		begin
		    MoveNumber:=true;
		    game.map[k,l]:=game.map[i,j];
		    game.map[i,j]:=NOTHING;
		end
	    else if game.map[k,l] = game.map[i,j] then
		begin
		    MoveNumber:=true;
		    game.map[k,l]:=game.map[i,j]*2;
		    game.map[i,j]:=NOTHING;
		end;
	end;
end;

function move_up(var game:type_game):boolean;
var i,j:integer;
begin
    move_up:=false;
    with game do
	begin
	    for i:=lin downto 2 do
		for j:=col downto 1 do
		    MoveNumber(game,i,j,i-1,j,UP);
	end;
end;

function move_down(var game:type_game):boolean;
var i,j:integer;
begin
    move_down:=false;
    with game do
	begin
	    for i:=2 to lin do
		for j:=1 to col do
		    MoveNumber(game,i,j,i+1,j,DOWN);
	end;
end;

function move_right(var game:type_game):boolean;
var i,j:integer;
begin
    move_right:=false;
    with game do
	begin
	    for i:=2 to lin do
		for j:=1 to col do
		    MoveNumber(game,i,j,i,j+1,RIGHT);
	end;
end;

function move_left(var game:type_game):boolean;
var i,j:integer;
begin
    move_left:=false;
    with game do
	begin
	    for i:=lin downto 2 do
		for j:=col downto 1 do
		    MoveNumber(game,i,j,i,j-1,LEFT);
	end;
end;



begin
    end_game:=false;
    initializing_game(game);

    repeat 
	print_map(game);
	repeat 
	until KeyPressed;
	case ReadKey of
	    #0:begin
		case ReadKey of
		    #72:move_up(game);
		    #77:move_right(game);
		    #75:move_left(game);
		    #80:move_down(game);
		end;
	    end;
	    #27:end_game:=true;
	end;
    until end_game;
end.
