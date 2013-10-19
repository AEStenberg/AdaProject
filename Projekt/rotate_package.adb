package body Rotate_Package is
   
   function Last_Empty (Current : in String; X, Y, Z : in Integer) return Boolean is
      K : Integer := Current'Length - X*Y + 1;
   begin
      for I in K..K+X*Y-1 loop
	 if Current(I) = '1' then
	    return False;
	 end if;
      end loop;
      return True;
   end Last_Empty;
   
   
   function Move_X(Current : in String; X : in Integer) return String is
      Str_Temp : String(1..Current'Length) := (others => '0');
   begin
      for I in 1..Current'Length loop
	 if Current(I) = '1' then
	    if I mod X = 0 then
	       raise Move_Error;
	    else
	       Str_Temp(I+1) := '1';
	    end if;
	 end if;
      end loop;
      return Str_Temp;
   end Move_X;
    
   function Move_Y(Current : in String; X, Y, Z : in Integer) return String is
      Str_Temp : String(1..Current'Length) := (others => '0');
      Z_Part : Integer := X*Y;
   begin
      for I in 1..Current'Length loop
	 if Current(I) = '1' then
	    if I mod Z_Part > 0 and then I mod Z_Part <= X then
	       raise Move_Error;
	    end if;
	    Str_Temp(I-X) := '1';
	 end if;
      end loop;
      return Str_Temp;
   end Move_Y;
   
   function Move_Z(Current : in String; X, Y, Z : in Integer) return String is
      Str_Temp : String(1..Current'Length) := (others => '0');
   begin
      if not Last_Empty(Current, X, Y, Z) then
	 raise Move_Error;
      end if;
      for I in 1..Current'Length loop
	 if Current(I) = '1' then
	    Str_Temp(I+X*Y) := '1';
	 end if;
      end loop;
      return Str_Temp;
   end Move_Z;
      
   procedure Rotate_X(Cx, Cy, Cz: in out Integer;
		      Str : in out String) is
      New_Length : Integer := 1;
      X, Y, Z : Integer;
      New_Str : String(1..Str'Last);
   begin
      X := Cx;
      Y := Cy;
      Z := Cz;
      for L in 1..Y loop
	 for I in 1..Z loop
	    for K in 1..X loop
	       New_Str(New_Length) := Str(I*X*Y-X+K-(L-1)*X);
	       New_Length := New_Length+1;
	    end loop;
	 end loop;
      end loop;
      Cy := Z;
      Cz := Y;
      Str := New_Str;
   exception
      when others =>
	 New_Line;
	 Put("Rotate X Error");
	 New_Line;
	 Put(Cx,3);
	 Put(Cy,3);
	 Put(Cz,3);
	 New_Line;
	 Put(Str(1..X*Y*Z));
	 New_Line;
	 raise Move_Error;
   end Rotate_X;

   procedure Rotate_Y(Cx, Cy, Cz : in out Integer;
		      Str : in out String) is
      New_Length : Integer := 1;
      X, Y, Z : Integer;
      New_Str : String(1..Str'Last);
   begin
      X := Cx;
      Y := Cy;
      Z := Cz;
      for L in 1..X loop
	 for I in 1..Y loop
	    for K in 1..Z loop
	       New_Str(New_Length) := Str(X+(I-1)*X-(L-1)+(K-1)*X*Y);
	       New_Length := New_Length + 1;
	    end loop;
	 end loop;
      end loop;
      Cx := Z;
      Cz := X;
      Str := New_Str;
   exception
      when others =>
	 raise Move_Error;
   end Rotate_Y;
   
   procedure Rotate_Z(Cx, Cy, Cz : in out Integer;
   		      Str : in out String) is
      New_Length : Integer := 1;
      X, Y, Z : Integer;
      New_Str : String(1..Str'Last);
   begin
      X := Cx;
      Y := Cy;
      Z := Cz;
      for K in 1..Z loop
   	 for L in 1..X loop
   	    for I in 1..Y loop
   	       New_Str(New_Length) := Str((X*I - (L - 1)) + X*Y*(K-1));
   	       New_Length := New_Length+1;
	    end loop;
   	 end loop;
      end loop;
      Str := New_Str;
      Cx := Y;
      Cy := X;
   exception
      when others =>
   	 raise Move_Error;
   end Rotate_Z;
   
   --  procedure Rotate_Z(Cx, Cy, Cz : in Integer;
   --  		      Str : in out String) is
   --     New_Length : Integer;
   --     New_Str : String(1..Str'Last) := (others => ' ');
   --     Z_Led : Integer := Cx*Cy;
   --     Zd : Integer;
   --  begin
      
   --     for Z in 1..Cz loop
   --  	 Zd := (Z-1)*Z_Led;
   --  	 for Y in 1..Cy loop
   --  	    if X_Amount(Cx, Cy, Y, Z, Str) > Cy then
   --  	       raise Move_Error;
   --  	    end if;
   --  	 end loop;
   --  	 for X in 1..Cy loop
   --  	    New_Length := X*Cx+Zd;
   --  	    for Y in 1..Cx loop
   --  	       New_Str(New_Length) := Str(Zd + X*(Y-1)*Cx + 1);
   --  	       New_Length := New_Length - 1;
   --  	    end loop;
   --  	 end loop;
   --     end loop;
   --     Str := New_Str;
   --  end Rotate_Z;   
   
   
end Rotate_Package;
