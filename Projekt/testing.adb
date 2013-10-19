with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Rotate_Package; use Rotate_Package;
with Part_Package; use Part_Package;

procedure Testing is
   S : String(1..69);
   SD : String(1..116);
   F, Part : Figure_Type;
   D : Part_Array(1..20);
   P : Part_Type;
   PI : Part_Information;
   NS : String(1..8);
   X, Y, Z : Integer;
   
   procedure Make (X,Y,Z : in Integer; S : in String; Length : in Integer; P : in out Part_Type) is
   begin
      P.Dimensions(1) := X;
      P.Dimensions(2) := Y;
      P.Dimensions(3) := Z;
      P.S(1..8) := NS;
      P.S_Length := NS'Length;
   end Make;
   
begin
   --S := "10:27:54 F 1 5x2x5 10001111110000011111000001111100000111111000111111";
   --  SD := "10:27:54 D 8 2x2x1 1110 3x2x1 111100 3x2x1 111010 3x2x1 110011 2x2x2 11101000 2x2x2 11001010 2x2x2 11000101 2x1x1 11";
   --  Convert_String_To_Figure(S, F);
   --  Convert_String_To_Parts(SD, D);
   --  Part := Make_Figure(F, D(1));
   --  Put(Part);
   --  Rotate_X(D(1).Dimensions(1), D(1).Dimensions(2), D(1).Dimensions(3), D(1).S);
   --  Part := Make_Figure(F, D(1));
   --  Put(Part);
   --  New_Line;
   --  Put(D(1).S(1..4));
   --  Put(D(1).Dimensions(1),3);
   --  Put(D(1).Dimensions(2),3);
   --  Put(D(1).Dimensions(3),3);
   
   NS := "11000101";
   X := 2;
   Y := 2;
   Z := 2;
   
   P.S(1..8) := "11000101";
   P.Dimensions(1) := 2;
   P.Dimensions(2) := 2;
   P.Dimensions(3) := 2;
   P.S_Length := 8;
   
   --  F.Figure_Number := 1;
   --  F.Dimensions(1) := 3;
   --  F.Dimensions(2) := 2;
   --  F.Dimensions(3) := 2;
   --  F.S(1..12) := "010111010111";
   --  F.S_Length := 12;
   
   
   --  Make(X,Y,Z,NS,NS'Length, P);  
   
   --  Part := Make_Figure(F, P);
   Rotate_Y(X, Y, Z, NS);
   New_Line;
   Put(NS);
   Rotate_Y(X, Y, Z, NS);
   New_Line;
   Put(NS);
   New_Line;
   Rotate_X(X, Y, Z, NS);
   Put(NS);
   --  Rotate_Z(X, Y, Z, NS);
   
   --  Make(X,Y,Z,NS,NS'Length, P);
   
   --  Part := Make_Figure(F, P);
   
   
end Testing;
   
