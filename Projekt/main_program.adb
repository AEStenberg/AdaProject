with Network_Package; use Network_Package;
with Part_Package; use Part_Package;
with Test_Package; use Test_Package;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main_Program is
   S : String(1..1000) := (others => ' ');
   L : Integer := 1;
   P : Part_Array(1..20);
   F : Figure_Type;
   Length : Integer := 0;
   Solved : Boolean := False;
   PI : Part_Information_Array(1..20);
begin
   Server_Connection("localhost", 1234);
   Empty_String(F);
   S := (others => ' ');
   Get_String(S, L);
   Convert_String_To_Parts(S, P, Length);
   loop
      Empty_String(F);
      S := (others => ' ');
      Get_String(S, L);
      exit when Server_Message(S) = "Q";
      if Server_Message(S) = "F" then
   	 Convert_String_To_Figure(S, F);
   	 Try_Figure(F, P, Length, PI, Solved);
   	 if Solved then
	    Send_Results(F,PI,Length);
	    Solved := False;
   	 else
	    Put("Given up!");
   	    Give_Up(Figure_Number(F));
   	 end if;
      end if;
   end loop;
   Close_Connection;
end Main_Program;
