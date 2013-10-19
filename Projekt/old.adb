 procedure Move(Part : in out Figure_Type; X,Y,Z : in out Integer; C : in Character) is
      Var : Integer := 0;
   begin
      if C = 'X' then
	 begin
	    Part.S := Move_X(Part.S,Part.Dimensions(1));
	 exception
	    when Move_Error => 
	       X := 0;
	       Y := Y + 1;
	       Var := 1;
	 end;
      elsif C = 'Y' then
	 begin
	    Part.S := Move_Y(Part.S, Part.Dimensions(1), Part.Dimensions(2), Part.Dimensions(3));
	 exception
	    when Move_Error =>
	       X := 0;
	       Y := 0;
	       Z := Z + 1;
	       Var := 2;
	 end;
      elsif C = 'Z' then
	 begin
	    Part.S := Move_Z(Part.S,Part.Dimensions(1), Part.Dimensions(2), Part.Dimensions(3));
	 exception
	    when Move_Error => 
	       X := X_Max(Part);
	       Y := Y_Max(Part);
	       Z := Z_Max(Part);
	       Var := 3;
	 end;
      end if;
      loop
	 if Var = 1 then
	    begin
	       Part.S := Move_Y(Part.S, Part.Dimensions(1), Part.Dimensions(2), Part.Dimensions(3));
	    exception
	       when Move_Error =>
		  Reset(X,Y,Z);
		  Var := 2;
	    end;
	 elsif Var = 2 then
	    begin
	       Part.S := Move_Z(Part.S, Part.Dimensions(1), Part.Dimensions(2), Part.Dimensions(3));
	    exception
	       when Move_Error =>
		  Var := 3;
	    end;
	 else
	    exit;
	 end if;
      end loop;
	 
   end Move;
   
   
    procedure Place_Part(F : in out Figure_Type; Del : in Part_Type; 
						 Placed_Part : in out Part_Information; Found_Place : in out Boolean) is
       
       X,Y,Z, RotX,RotY,RotZ : Integer := 0;
       Xmax : Integer := X_Max(F);
       Ymax : Integer := Y_Max(F);
       Zmax : Integer := Z_Max(F);
       D : Part_Type := Del;
       Part : Figure_Type := Make_Figure(F, D);
       Rotated : Boolean := False;
       Old : Boolean := False;
    begin
       
       if Old_Place(Placed_Part) then
	  Remove_Part(F , Placed_Part);
	  Part.S := Placed_Part.S;
	  X := Placed_Part.X;
	  Y := Placed_Part.Y;
	  Z := Placed_Part.Z;
	  RotX := Placed_Part.RotX;
	  RotY := Placed_Part.RotY;
	  RotZ := Placed_Part.RotZ;
	  Count_Offset(Placed_Part);
	  Placed_Part.Placed := False;
	  Old := True;
       end if;
       loop
	  if Rotated then
	     begin
		Part := Make_Figure(F,D);
	     exception
		when Make_Error =>
		   X := Xmax;
		   Y := Ymax;
		   Z := Zmax;
		   Old := True;
		   Rotated := False;
	     end;
	  end if;
	  if not Old then
	     if Place_Ok(F, Part) then
		Put_Part(F, Part);
		Placing_Part(Placed_Part, Part, X, Y, Z, RotX, RotY, RotZ);
		Found_Place := True;
		exit;
	     end if;
	  else
	     Old := False;
	  end if;
	  
	  if X < Xmax then
	     X := X + 1;
	     Move(Part,X,Y,Z,'X');
	  elsif Y < Ymax then
	     X := 0;
	     Y := Y + 1;
	     Move(Part,X,Y,Z,'Y');
	  elsif Z < Zmax then
	     X := 0;
	     Y := 0;
	     Z := Z + 1;
	     Move(Part,X,Y,Z,'Z');
	  elsif RotX < 3 then
	     Reset(X,Y,Z);
	     RotX := Rotx + 1;
	     Rotate_X(D.Dimensions(1), D.Dimensions(2), D.Dimensions(3), D.S);
	     Rotated := True;
	  elsif RotY < 3 then
	     Reset(X,Y,Z);
	     RotX := 0;
	     RotY := RotY + 1;
	     Rotate_Y(D.Dimensions(1), D.Dimensions(2), D.Dimensions(3), D.S);
	     Rotated := True;
	  elsif RotZ < 3 then
	     Reset(X,Y,Z);
	     RotX := 0;
	     RotY := 0;
	     RotZ := RotZ + 1;
	     Rotate_Z(D.Dimensions(1), D.Dimensions(2), D.Dimensions(3), D.S);
	     Rotated := True;
	  else
	     Found_Place := False;
	     exit;
	  end if;
       end loop;
    end Place_Part;
