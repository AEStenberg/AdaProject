with Rotate_Package; use Rotate_Package;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package Part_Package is
   Make_Error : exception;
   type Int_Arr is array (1..3) of Integer;
   type Part_Type is
      record
	 Dimensions : Int_Arr;
	 S : String(1..1000);
	 S_Length : Integer;
      end record;
   type Part_Array is array(positive range <>) of Part_Type;
   type Figure_Type is
      record
	 Figure_Number : Integer;
	 Dimensions : Int_Arr;
	 S : String(1..1000);
	 S_Length : Integer;
      end record;
   type Part_Information is
      record
	 Dimensions : Int_Arr;
	 X, Y, Z : Integer := 0;
	 RotX, RotY, RotZ : Integer := 0;
	 Ox, Oy, Oz : Integer := 0;
	 S : String(1..1000);
	 S_Length : Integer;
	 Placed : Boolean := False;
      end record;
   type Part_Information_Array is array(Positive range <>) of Part_Information;
   
   procedure Put(F : in Figure_Type);
   procedure Convert_String_To_Parts(S : in String; P : in out Part_Array; L : in out Integer);
   procedure Convert_String_To_Figure(S : in String; F : in out Figure_Type);
   procedure Place_Part(F : in out Figure_Type; Del : in Part_Type;
						Placed_Part : in out Part_Information; Found_Place : in out Boolean);  
   procedure Empty_String(F : in out Figure_Type);
   procedure Count_Offset(Part : in out Part_Information);

   function Make_Figure(F : in Figure_Type; D : in Part_Type) return Figure_Type;
   function Figure_Number(F : in Figure_Type) return Integer;
   function Length(F : in Figure_Type) return Integer;
   function Length(P : in Part_Array) return Integer;
   function Equals(F : in Figure_Type; I, N : in Integer) return Boolean;
   
   function Coords(D : in Part_Type) return Int_Arr;
   function Get_Part(P : in Part_Array; I : in Integer) return Part_Type;
   function Get_Row(D : in Part_Type; Y, Z : in Integer) return String;
   
end Part_Package; 
