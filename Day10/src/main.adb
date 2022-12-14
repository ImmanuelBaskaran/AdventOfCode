with Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Containers.Vectors;
procedure Main is
   package Int_IO is new Ada.Text_IO.Integer_IO (Integer);
   package SU   renames Ada.Strings.Unbounded;
   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Integer_Vectors;

   type Screen is array (1 .. 240) of Character;

   File : File_Type;
   X: Integer;
   cycle: Integer;
   line: SU.Unbounded_String;
   opCode: SU.Unbounded_String;
   operand: SU.Unbounded_String;
   cycleCheckpoints: Integer_Vectors.Vector;
   instructionQueue : Integer_Vectors.Vector;
   sumOfSignalStrengths: Integer;

   cathodeScreen : Screen := (others => '.');
begin
   X := 1;
   cycle := 1;
   cycleCheckpoints := 20 & 60 & 100 & 140  & 180  & 220;
   sumOfSignalStrengths := 0;

   Open (File => File,
         Mode => In_File,
         Name => "./input.txt");

   While not  End_Of_File (File) Loop

      if (cycle rem 40) >= X and (cycle rem 40) <= X + 2 then
         cathodeScreen (cycle) := '#';
      end if;

      if cycleCheckpoints.Contains(cycle) then
         sumOfSignalStrengths := sumOfSignalStrengths + (X * cycle);
      end if;
      if Integer(instructionQueue.Length) > 0 then
         X := X + instructionQueue.First_Element;
         instructionQueue.Delete_First;
      else
         line := SU.To_Unbounded_String (Get_Line (File));
         opCode := SU.To_Unbounded_String (SU.To_String(line) (1 .. 4));
         if SU.To_String(opCode) = "addx" then
            operand := SU.To_Unbounded_String (SU.To_String(line) (6 .. SU.Length(line)));
            instructionQueue.Append (Integer'Value (SU.To_String (operand)));
         end if;
      end if;

      for index in Integer range 1 .. 240 loop
         Put (cathodeScreen (index));
         if index rem 40 = 0 then
            New_Line;
         end if;
      end loop;
      Int_IO.Put (X); New_Line;
      New_Line;

      cycle := cycle + 1;
   end loop;
   if Integer(instructionQueue.Length) > 0 then
      X := X + instructionQueue.First_Element;
      instructionQueue.Delete_First ;
   end if;

   Close (File);
   Int_IO.Put (sumOfSignalStrengths); New_Line;

   for index in Integer range 1 .. 240 loop
      Put (cathodeScreen (index));
      if index rem 40 = 0 then
         New_Line;
      end if;
   end loop;
   null;
end Main;
