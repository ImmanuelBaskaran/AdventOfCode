program DataFiles;
{$MACRO ON}
{$define size:=99}
type
  Matrix = array[0..size-1,0..size-1] of Integer;
var
   CurrChar: char;
   f: file of char;
   Trees: Matrix;
   i,j,sum,working : Longint;
   treeIndex: integer;

function IsNumericChar(s: char): boolean;
begin
   if not (s in ['0'..'9']) then
      exit(false);

   exit(true);
end;

function checkLeft(treeMatrix: Matrix; x: ShortInt; y: ShortInt): Integer;
var
   i : integer;
begin
   for i:=y-1 downto 0 do begin
      if treeMatrix[x,i] >= treeMatrix[x,y] then
         exit(y-i);
   end;
   exit(y);
end;

function checkRight(treeMatrix: Matrix; x: ShortInt; y: ShortInt): Integer;
var
   i : integer;
begin
   for i:=y+1 to size-1 do begin
      if treeMatrix[x,i] >= treeMatrix[x,y] then
         exit(i-y);
   end;
   exit(i-y);
end;

function checkUp(treeMatrix: Matrix; x: ShortInt; y: ShortInt): Integer;
var
   i : integer;
begin
   for i:=x-1 downto 0 do begin
      if treeMatrix[i,y] >= treeMatrix[x,y] then
         exit(x-i);
   end;
   exit(x);
end;

function checkDown(treeMatrix: Matrix; x: ShortInt; y: ShortInt): Integer;
var
   i : integer;
begin
   for i:=x+1 to size-1 do begin
      if treeMatrix[i,y] >= treeMatrix[x,y] then
         exit(i-x);
   end;
   exit(i-x);
end;


begin

   treeIndex := 0;
   sum := -1;
   assign(f, 'input.txt');
   reset(f);
   while not eof(f) do
   begin
      read(f,CurrChar);
      if IsNumericChar(CurrChar) then begin
         Trees[treeIndex div size,treeIndex mod size] := ord(CurrChar)-48;
         treeIndex := treeIndex+1;
      end;
   end;
   
   close(f);

   for i:=1 to size-2 do
   begin  
      for j:=1 to size-2 do begin
            working := checkLeft(Trees,i,j) * checkRight(Trees,i,j) * checkUp(Trees,i,j) * checkDown(Trees,i,j);
            if working > sum then
               sum := working;
               
         end;
   end;
   writeln(sum);
end.