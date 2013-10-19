package body Network_Package is
   
   procedure Login is
      In_String : String(1..20);
      L : Integer;
   begin
      Put("Skriv in Användarnamn");
      New_Line;
      Get_Line(In_String, L);
      Put_Line(Socket, In_String(1..L));
      Put("Skriv in lösenord");
      New_Line;
      Get_Line(In_String, L);
      Put_Line(Socket, In_String(1..L));
      Get_Line(Socket, In_String, L);
      Put(In_String(1..L));
      Put_Line(Socket, "13:03:00 N AwesomeMan");
      New_Line;
   end Login;
   
   procedure Server_Connection(Server_Address : in String;
			       Portnr : in Integer) is 
   begin
      Initiate(Socket);
      Connect(Socket, Server_Address, Portnr);
      Login;
   end Server_Connection;   
   
   procedure Get_String(S : in out String; 
			L : in out Integer) is
   begin
      Get_Line(Socket, S, L);
   end Get_String;
   
    procedure Send_String(S : in String) is
   begin
      Put_Line(Socket, S);
   end Send_String;
   
   procedure Give_Up(Figure_Number : in Integer) is
   begin
      Send_String(Give_Up_Message(Figure_Number));
   end Give_Up;  
   
   procedure Close_Connection is
   begin
      Close(Socket);
   end Close_Connection;   
   
   function Time return String is
   begin
      return "13:00:04";
   end Time;
   
    procedure Send_Results(F : in Figure_Type; P : in Part_Information_Array; L : in Integer) is
       S : String(1..500) := (others => ' ');
       S2 : String(1..2);
       K : Integer := 14;
   begin
      S(1..8) := Time;
      S(10) := 'P';
      S2 := Integer'Image(L);
      S(12) := S2(2);
      for I in 1..L loop
	 S(K..K+12) := Rotate_Part_Message(P(I).RotX, P(I).RotY, P(I).RotZ, (P(I).X+P(I).Ox), (P(I).Y+P(I).Oy), (P(I).Z+P(I).Oz));
	 K := K + 14;
      end loop;
      Put(S(1..K-2));
      New_Line;
      Send_String(S(1..K-2));
   end Send_Results;
   
   function Server_Message(S : in String) return String is
   begin
      return S(10..10);
   end Server_Message;   
   
   function Part_Message(Time : in String; A : in Integer; Part_String : in String) return String is
   begin
      return "a";
   end Part_Message;
   
   function Rotate_Part_Message(Rot_X, Rot_Y, Rot_Z, Tra_X, Tra_Y, Tra_Z : in Integer) return String is
   begin
      return "!" & Integer'Image(Rot_X) & Integer'Image(Rot_Y) & Integer'Image(Rot_Z) & 
	Integer'Image(Tra_X) & Integer'Image(Tra_Y) & Integer'Image(Tra_Z);
   end Rotate_Part_Message;
   
   function Give_Up_Message(Figure_Number : in Integer) return String is
   begin
      return Time & " G" & Integer'Image(Figure_Number);
   end Give_Up_Message;
   
end Network_Package;
