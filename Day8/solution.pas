program DataFiles;
{$MACRO ON}
{$define size:=99}
type
  Matrix = array[0..size-1,0..size-1] of Integer;
var
   CurrChar: char;
   f: file of char;
   Trees: Matrix;
   i,j,sum : integer;
   treeIndex: integer;

function IsNumericChar(s: char): boolean;
begin
   if not (s in ['0'..'9']) then
      exit(false);

   exit(true);
end;

function checkLeft(treeMatrix: Matrix; x: ShortInt; y: ShortInt): boolean;
var
   i : integer;
begin
   for i:=y-1 downto 0 do begin
      if treeMatrix[x,i] >= treeMatrix[x,y] then
         exit(false);
   end;
   exit(true);
end;

function checkRight(treeMatrix: Matrix; x: ShortInt; y: ShortInt): boolean;
var
   i : integer;
begin
   for i:=y+1 to size-1 do begin
      if treeMatrix[x,i] >= treeMatrix[x,y] then
         exit(false);
   end;
   exit(true);
end;

function checkUp(treeMatrix: Matrix; x: ShortInt; y: ShortInt): boolean;
var
   i : integer;
begin
   for i:=x-1 downto 0 do begin
      if treeMatrix[i,y] >= treeMatrix[x,y] then
         exit(false);
   end;
   exit(true);
end;

function checkDown(treeMatrix: Matrix; x: ShortInt; y: ShortInt): boolean;
var
   i : integer;
begin
   for i:=x+1 to size-1 do begin
      if treeMatrix[i,y] >= treeMatrix[x,y] then
         exit(false);
   end;
   exit(true);
end;


begin

   treeIndex := 0;
   sum := 0;
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

   for i:=0 to size-1 do
   begin  
      for j:=0 to size-1 do
         if checkLeft(Trees,i,j) or checkRight(Trees,i,j) or checkUp(Trees,i,j) or checkDown(Trees,i,j) then begin
            sum := sum + 1;
         end;
   end;  

   writeln(sum);

end.