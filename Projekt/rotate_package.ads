with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
package Rotate_Package is
   
   Move_Error : exception;
   
   function Move_X(Current : in String; X : in Integer) return String;
   function Move_Y(Current : in String; X, Y, Z : in Integer) return String;
   function Move_Z(Current : in String; X, Y, Z : in Integer) return String;
   
   procedure Rotate_X(Cx, Cy, Cz : in out Integer;
		      Str : in out String);
   procedure Rotate_Y(Cx, Cy, Cz : in out Integer;
		      Str : in out String);
   procedure Rotate_Z(Cx, Cy, Cz : in out Integer;
		      Str : in out String);
end Rotate_Package;
