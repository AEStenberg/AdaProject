--Carl Einarson carei692
--Per Wennberg perwe710
--Jonas Alven�s jonal168

package Projekt is
   
   type Part_Array is private;                                                          -- Har koll p� alla delarna
   type Figure_Type is private;                                                         -- Har koll p� hur Figuren ser ut
   type Part_Type is private;                                                           -- Har koll p� hur en del ser ut
   type Previous_Coordinates is private;                                                -- Har koll p� delarnas positioner i Schematic
   
   procedure Rotate_X (Part : in out Part_Type);                                        -- Roterar en del i X-led
   procedure Rotate_Y (Part : in out Part_Type);                                        -- Roterar en del i Y-led
   
   function Create_Figure(Item : in Figure_Type) return Figure_Type;                    -- Skapar en kopia av en figur
   function Create_Part (Item : in Part_Type) return Part_Type;                         -- Skapar en kopia av en del
   
   function Allowed_Placement(Schematic : in Figure_Type;                               -- Kollar om delen f�r placeras p� en viss position 
			      Part_Placement : in Figure_Type) return Boolean;
   
   procedure Put_Part (Schematic : in out Figure_Type;                                  -- S�tter in del(I) i figuren om en till�ten plats hittas
		       Prev : in out Previous_Coordinates;                              -- Hittas ingen till�ten plats ska funktionen g� tillbaka till f�reg�ende bit och omplacera den
		       Part : in Part_Type; I : in Integer); 
   
   procedure Remove_Coordinates (Schematic : in out Figure_Type;                        -- Tar bort f�reg�ende position ifr�n arrayen med positioner
				 Prev : in out Previous_Coordinates;                     
				 I : in Integer);
   
   procedure Move_Part (Schematic : in out Figure_Type;                                 -- Testar att s�tta en del p� en ny position (b�rjar ifr�n f�reg�ende pos)
			Prev : in out Previous_Coordinates;
			Part : in Part_Type);
   
   
   
   
private
   
   type Part_Array is array (1..10) of Part_Type;
   
   type Previous_Coordinates is
      record
	 Nr : Integer;
	 Figure : Figure_Type;
      end record;
   
   type Figure_Type is
      record
	 Length, Height, Depth : Integer;
      end record;
   
   type Part_Type is
      record
	 Number, Length, Height, Depth :Integer;
	 Parts : Int_Array; 
      end record;
   
end Projekt;
