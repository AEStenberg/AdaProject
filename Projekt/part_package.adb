package body Part_Package is
   
   procedure Put(F : in Figure_Type) is
      Y : Integer := 1;
      X : Integer := 1;
   begin
      Put("FIGUR:");
      New_Line;
      for I in 1..F.S_Length loop
	 Put(F.S(I));
	 if X = F.Dimensions(1) then
	    if Y = F.Dimensions(2) then
	       New_Line;
	       Y := 0;
	    end if;
	    Y := Y + 1;
	    X := 0;
	    New_Line;
	 end if;
	 X := X + 1;
      end loop;
      New_Line;
   end Put;
   
   function Figure_Number(F : in Figure_Type) return Integer is
   begin
      return F.Figure_Number;
   end Figure_Number;
   
   function Length(F : in Figure_Type) return Integer is
   begin
      return F.S_Length;
   end Length;
   
   function Length(P : in Part_Array) return Integer is
   begin
      return P'Last;
   end Length;
   
   function Length_Of_String(S : in String) return Integer is
      I : Integer := 1;
   begin
      loop
	 exit when I > S'Last;
	 exit when S(I) /= '0' and then S(I) /= '1';
	 I := I + 1;
      end loop;
      return (I - 1);
   end Length_Of_String;
   
   function Equals(F : in Figure_Type; I, N : in Integer) return Boolean is
   begin 
      return Integer'Value(F.S(I..I)) = N;
   end Equals;
   
   function Amount(S : in String) return Integer is
      I : Integer := 0;
      D : Integer := 12;
   begin
      loop
	 exit when S(D) = ' ';
	 I := I*10 + Integer'Value(S(D..D));
	 D := D + 1;
      end loop;
      D := D + 1;
      return I;
   end Amount;
   
   function Get_Part(P : in Part_Array; I : in Integer) return Part_Type is
   begin
      return P(I);
   end Get_Part;
   
   function Coords (D : in Part_Type) return Int_Arr is
   begin
      return D.Dimensions;
   end Coords;
   
   procedure Count_Offset (Part : in out Part_Information) is
      S : String(1..8) := "00000100";
      X,Y,Z : Integer := 2;
      K, H : Integer := 0;
   begin
      for I in 1..Part.RotX loop
      	 Rotate_X(X,Y,Z,S);
      end loop;
      for I in 1..Part.RotY loop
      	 Rotate_Y(X,Y,Z,S);
      end loop;
      for I in 1..Part.RotZ loop
      	 Rotate_Z(X,Y,Z,S);
      end loop;
      Rotate_Z(X,Y,Z,S);
      for I in 1..8 loop 
      	 if S(I) = '1' then
      	    K := I;
	    exit;
      	 end if;
      end loop;
      
      case K is
	 when 1 =>
	    Part.Ox := Part.Dimensions(1) + 1;
	    Part.Oz := Part.Dimensions(3) + 1;
      	 when 2 =>
	    Part.Oz := Part.Dimensions(3) + 1;
      	 when 3 =>
	    Part.Ox := Part.Dimensions(1) + 1;
	    Part.Oy := Part.Dimensions(2) + 1;
	    Part.Oz := Part.Dimensions(3) + 1;
	 when 4 =>
	    Part.Oy := Part.Dimensions(2) + 1;
	    Part.Oz := Part.Dimensions(3) + 1;
	 when 5 =>
	    Part.Ox := Part.Dimensions(1) + 1;    
	 when 6 =>
	    null;
	 when 7 =>
	    Part.Ox := Part.Dimensions(1) + 1;
	    Part.Oy := Part.Dimensions(2) + 1;
      	 when 8 =>
	    Part.Oy := Part.Dimensions(2) + 1;
      	 when others =>
      	    Put("ERROR!!");
      end case;
      
      
   end Count_Offset;
   
   procedure Get_String_To_Space(S : in String; D, K : in out Integer; Str : out String) is
   begin
      loop
	 exit when D>S'Last;
	 exit when S(D) = ' ';
	 Str(K) := S(D);
	 K := K + 1;
	 D := D + 1;
      end loop;
      K := K - 1;
      D := D + 1;
   end Get_String_To_Space;
   
   procedure Convert_String_To_Parts (S : in String; P : in out Part_Array; L : in out Integer) is
      D : Integer := 14;
      K : Integer := 1;
   begin
      L := Amount(S);
      for I in 1..L loop
	 if L > 9 then
	    D := D + 1;
	 end if;
	 P(I).Dimensions(1) := Integer'Value(S(D..D));
	 D := D + 2;
	 P(I).Dimensions(2) := Integer'Value(S(D..D));
	 D := D + 2;
	 P(I).Dimensions(3) := Integer'Value(S(D..D));
	 D := D + 2;
	 Get_String_To_Space(S, D, K, P(I).S);
	 P(I).S_Length := Length_Of_String(P(I).S);
	 K := 1;
      end loop;
   end Convert_String_To_Parts;
   
   procedure Convert_String_To_Figure (S : in String; F : in out Figure_Type) is
      D : Integer := 14;
      K : Integer := 1;
      I : Integer;
   begin
      I := Amount(S);
      F.Figure_Number := I;
      if I > 9 then
	 D := D+1;
      end if;
      F.Dimensions(1) := Integer'Value(S(D..D));
      D := D + 2;
      F.Dimensions(2) := Integer'Value(S(D..D));
      D := D + 2;
      F.Dimensions(3) := Integer'Value(S(D..D));
      D := D + 2;
      Get_String_To_Space(S, D, K, F.S);
      F.S_Length := Length_Of_String(F.S);
   end Convert_String_To_Figure;
   
   procedure Empty_String(F : in out Figure_Type) is
   begin
      F.S := (others => ' ');
   end Empty_String;
   
   function Empty(F : in Figure_Type) return Figure_Type is
      Temp : Figure_Type;
   begin
      Temp.Dimensions := F.Dimensions;
      Temp.S := (others => '0');
      Temp.S_Length := F.S_Length;
      return Temp;
   end Empty;
   
   function Get_Row(F : in Figure_Type; Y, Z : in Integer) return String is
      X : Integer := F.Dimensions(1);
      K : Integer := (X*F.Dimensions(2)*(Z-1) + (Y-1)*X) + 1;
      S : String(1..X);
   begin
      for I in K..(K+X-1) loop
	 S(I-(K-1)) := F.S(I);
      end loop;
      return S;
   end Get_Row;
   
   function Get_Row(D : in Part_Type; Y, Z : in Integer) return String is
      X : Integer := D.Dimensions(1);
      K : Integer := (X*D.Dimensions(2)*(Z-1) + (Y-1)*X) + 1;
      S : String(1..X);
   begin
      for I in K..(K+X-1) loop
	 S(I-(K-1)) := D.S(I);
      end loop;
      return S;
   end Get_Row;
   
   function Ones(D : in String) return Integer is
      X : Integer := 0;
   begin
      for I in 1..D'Length loop
	 if D(I) = '1' then
	    X := X + 1;
	 end if;
      end loop;
      return X;
   end Ones;
   
   procedure Put_Row(New_String : in out String; Old_String : in String; New_X, New_Y, X, Y, Z, DiffY : in Integer) is
      Row : Integer := (Y+DiffY)*New_X+ (Z-1)*New_Y*New_X - New_X + 1;
      Old : Integer := 1;
   begin
      for I in Row..Row+X-1 loop
	 New_String(I) := Old_String(Old);
	 Old := Old + 1;
      end loop;
   end Put_Row;
      
   function Make_Figure (F : in Figure_Type; D : in Part_Type) return Figure_Type is
      Temp : Figure_Type := Empty(F);
      X : Integer := D.Dimensions(1);
      FX : Integer := F.Dimensions(1);
      FY : Integer := F.Dimensions(2);
      SY : Integer := FY - D.Dimensions(2);
      S : String(1..X);
   begin
      if Ones(D.S(1..D.S_Length)) /= 4 then
	 Put("Fel i Delen!?");
	 New_Line;
	 Put("Antal: ");
	 Put(Ones(D.S(1..D.S_Length)),0);
	 New_Line;
      end if;
      Temp.S_Length := F.S_Length;
      for Z in 1..D.Dimensions(3) loop
	 for Y in 1..D.Dimensions(2) loop
	    S := Get_Row(D, Y, Z);
	    begin
	       Put_Row(Temp.S, S, FX, FY, X, Y, Z, SY);
	    exception
	       when others =>
		  raise Make_Error;
	    end;
	 end loop;
      end loop;
      return Temp;
   end Make_Figure;
      
   
   function Place_Ok(F : in Figure_Type; D : in Figure_Type) return Boolean is
   begin
      for I in 1..F.S_Length loop
	 if D.S(I) = '1' then
	    if not (D.S(I) = F.S(I)) then
	       return False;
	    end if;
	 end if;
      end loop;
      return True;      
   end Place_Ok;
   
   procedure Put_Part(F : in out Figure_Type; D : in Figure_Type) is   
   begin
      for I in 1..F.S_Length loop
	 if D.S(I) = '1' then
	    F.S(I) := '2';
	 end if;
      end loop;
   end Put_Part;
   
   function X_Max(F : in Figure_Type) return Integer is
   begin
      return F.Dimensions(1);
   end X_Max;
   
   function Y_Max(F : in Figure_Type) return Integer is
   begin
      return F.Dimensions(2);
   end Y_Max;
   
   function Z_Max(F : in Figure_Type) return Integer is
   begin
      return F.Dimensions(3);
   end Z_Max;
   
   procedure Reset(X, Y, Z : in out Integer) is
   begin
      X := 0;
      Y := 0;
      Z := 0;
   end Reset;
   
   function Old_Place(Placed_Part : in Part_Information) return Boolean is
   begin
      return Placed_Part.Placed;
   end Old_Place;
   
   procedure Remove_Part(F : in out Figure_Type; Part : in out Part_Information) is
   begin
      for I in 1..F.S_Length loop
	 if Part.S(I) = '1' then
	    F.S(I) := '1';
	 end if;
      end loop;
   end Remove_Part;
   
   procedure Placing_Part(Placed_Part : in out Part_Information; Part : in Figure_Type; X, Y, Z, Rot_X, Rot_Y, Rot_Z : in Integer) is
   begin
      Placed_Part.Dimensions := Part.Dimensions;
      Placed_Part.X := X;
      Placed_Part.Y := Y;
      Placed_Part.Z := Z;
      Placed_Part.RotX := Rot_X;
      Placed_Part.RotY := Rot_Y;
      Placed_Part.RotZ := Rot_Z;
      Placed_Part.S(1..Part.S_Length) := Part.S(1..Part.S_Length);
      Placed_Part.S_Length := Part.S_Length;
      Placed_Part.Placed := True;
   end Placing_Part;
   
   
   procedure Place_Part(F : in out Figure_Type; Del : in Part_Type; 
   						Placed_Part : in out Part_Information; Found_Place : in out Boolean) is
      X, Y, Z : Integer := 0;
      Xmax : Integer := X_Max(F);
      Ymax : Integer := Y_Max(F);
      Zmax : Integer := Z_Max(F);
      Rot_X, Rot_Y, Rot_Z : Integer := 0;
      D : Part_Type := Del;
      Part : Figure_Type := Make_Figure(F, D);
      Old : Boolean := False;
      Rotated : Boolean := False;
      TESTA : Boolean := False;
   begin
      if Old_Place(Placed_Part) then
	 Remove_Part(F, Placed_Part);
   	 Part.S := Placed_Part.S;
   	 X := Placed_Part.X;
   	 Y := Placed_Part.Y;
   	 Z := Placed_Part.Z;
   	 Rot_X := Placed_Part.RotX;
   	 Rot_Y := Placed_Part.RotY;
   	 Rot_Z := Placed_Part.RotZ;
   	 Placed_Part.Placed := False;
   	 Old := True;
      end if;
      loop
	 if D.S_Length = 8 and then Rot_Y = 2 and then Rot_X = 1 then
	    New_Line;
	    Put("X, Y, Z ");
	    Put(X, 3);
	    Put(Y, 3);
	    Put(Z, 3);
	    New_Line;
	 end if;
	 
	 if Rotated then
	    begin
	       Part := Make_Figure(F,D);
	       Rotated := False;
	    exception
	       when Make_Error =>
		  X := XMax;
		  Y := YMax;
		  Z := Zmax;
		  Old := True;
		  Rotated := False;
	    end;
	 end if;
	 if not Old then
	    if Place_Ok(F, Part) then
	       Put_Part(F, Part);
	       Placing_Part(Placed_Part, Part, X, Y, Z, Rot_X, Rot_Y, Rot_Z);
	       Found_Place := True;
	       exit;
	    end if;
	 else
	    Old := False;
	 end if;
	 if X < Xmax then
   	    begin
   	       X := X + 1;
	       if D.S_Length = 8 and then Rot_Y = 2 and then Rot_X = 1 then
		  Put("X ROTATE!!!");
		  New_Line;
		  Put("Before: ");
		  Put(Part.S(1..Part.S_Length));
		  New_Line;
	       end if;
   	       Part.S(1..Part.S_Length) := Move_X(Part.S(1..Part.S_Length), Part.Dimensions(1));
	       if D.S_Length = 8 and then Rot_Y = 2 and then Rot_X = 1 then
		  Put("After : ");
		  Put(Part.S(1..Part.S_Length));
		  New_Line;
	       end if;
   	    exception 
   	       when Move_Error =>
   		  X := Xmax;
   	    end;
   	 elsif Y < Ymax then
   	    begin
	       X := 0;
	       Y := Y + 1;
   	       Part.S(1..Part.S_Length) := Move_Y(Part.S(1..Part.S_Length), Part.Dimensions(1), Part.Dimensions(2), Part.Dimensions(3));
   	    exception
   	       when Move_Error =>
		  Y := Ymax;
	    end;
   	 elsif Z < Zmax then
   	    begin
	       X := 0;
	       Y := 0;
	       Z := Z + 1;
   	       Part.S(1..Part.S_Length) := Move_Z(Part.S(1..Part.S_Length), Part.Dimensions(1), Part.Dimensions(2), Part.Dimensions(3));
   	    exception
   	       when Move_Error =>
   		  X := Xmax;
		  Y := Ymax;
   		  Z := Zmax;
   	    end;
   	 elsif Rot_Z < 3 then
	    Rot_Z := Rot_Z + 1;
	    Reset(X, Y, Z);
	    Rotate_Z(D.Dimensions(1), D.Dimensions(2), D.Dimensions(3), D.S(1..D.S_Length));
	    Rotated := True;
   	 elsif Rot_Y < 3 then
	    Rot_Z := 0;
	    Rot_Y := Rot_Y + 1;
	    Reset(X, Y, Z);
	    D  := Del;
	    for I in 1..Rot_X loop
	       Rotate_X(D.Dimensions(1), D.Dimensions(2), D.Dimensions(3), D.S(1..D.S_Length));
	    end loop;
	    for I in 1..Rot_Y loop
	       Rotate_Y(D.Dimensions(1), D.Dimensions(2), D.Dimensions(3), D.S(1..D.S_Length));
	    end loop;
	    Rotated := True;	      
   	 elsif Rot_X < 3 then
	    Rot_Z := 0;
	    Rot_Y := 0;
	    Rot_X := Rot_X + 1;
	    Reset(X,Y,Z);
	    D := Del;
	    for I in 1..Rot_X loop
	       Rotate_X(D.Dimensions(1), D.Dimensions(2), D.Dimensions(3), D.S(1..D.S_Length));
	    end loop;
	    Rotated := True;
   	 else
   	    Found_Place := False;
   	    exit;
   	 end if;
      end loop;
   end Place_Part;   
   
   
end Part_Package;
