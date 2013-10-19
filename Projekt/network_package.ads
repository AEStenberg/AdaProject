with TJa.Sockets; use TJa.Sockets;
with Part_Package; use Part_Package;
with Ada.Text_IO; use Ada.Text_IO;


package Network_Package is
   Socket : Socket_Type;
   procedure Server_Connection(Server_Address : in String;
			       Portnr : in Integer);
   procedure Close_Connection;
   procedure Get_String(S : in out String; L : in out Integer);
   procedure Send_String(S: in String);
   procedure Give_Up(Figure_Number : in Integer);
   procedure Send_Results(F : in Figure_Type; P : in Part_Information_Array; L : in Integer);
   
   function Part_Message (Time : in String; A : in Integer; Part_String : in String) return String;
   function Rotate_Part_Message(Rot_X, Rot_Y, Rot_Z, Tra_X, Tra_Y, Tra_Z : in Integer) return String;
   function Give_Up_Message(Figure_Number : in Integer) return String;
   function Server_Message(S : in String) return String;
   function Time return String;
   
end Network_Package;
