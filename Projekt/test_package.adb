with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Test_Package is
   
   function Full(F : in Figure_Type; I : in Integer) return Boolean is 
   begin
      for L in 1..Length(F) loop
	 if Equals(F, L, 1) then
	    return False;
	 end if;
      end loop;
      return True;
   end Full;
   
   procedure Try_Figure (F : in Figure_Type; 
			 P : in Part_Array; Length : in Integer; 
					    Placed_Parts : in out Part_Information_Array; Solved : in out Boolean) is
      Schematic : Figure_Type := F;
      I : Integer := 1;
      Found_Place : Boolean := False;
   begin
      loop
	 Found_Place := False;
	 if I = Length and then Full(Schematic, I) then
	    Solved := True;
	    for N in 1..I loop
	       Count_Offset(Placed_Parts(N));
	    end loop;
	    exit;
	 end if;
	 if I <= Length then
	    Place_Part(Schematic, Get_Part(P, I), Placed_Parts(I), Found_Place);
	    if Found_Place then
	       Put("Found for ");
	       Put(I, 0);
	       New_Line;
	       Put(Placed_Parts(I).X, 0);
	       Put(Placed_Parts(I).Y, 3);
	       Put(Placed_Parts(I).Z, 3);
	       Put(Placed_Parts(I).RotX, 3);
	       Put(Placed_Parts(I).RotY, 3);
	       Put(Placed_Parts(I).RotZ, 3);
	       New_Line;
	       Put(Placed_Parts(I).S(1..Placed_Parts(I).S_Length));
	       New_Line;
	       Put(Schematic.S(1..Schematic.S_Length));
	       New_Line;
	       I := I + 1;
	       Found_Place := False;
	    else
	       I := I - 1;
	       if I = 0 then
		  Solved := False;
		  exit;
	       end if;
	    end if;
	 else
	    I := I - 1;
	 end if;
      end loop;
   end Try_Figure;   
end Test_Package;
