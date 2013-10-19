--Carl Einarson carei692
--Per Wennberg perwe710
--Jonas Alvenäs jonal168

package Projekt is
   
   type Part_Array is private;                                                          -- Har koll på alla delarna
   type Figure_Type is private;                                                         -- Har koll på hur Figuren ser ut
   type Part_Type is private;                                                           -- Har koll på hur en del ser ut
   type Previous_Coordinates is private;                                                -- Har koll på delarnas positioner i Schematic
   
   procedure Rotate_X (Part : in out Part_Type);                                        -- Roterar en del i X-led
   procedure Rotate_Y (Part : in out Part_Type);                                        -- Roterar en del i Y-led
   
   function Create_Figure(Item : in Figure_Type) return Figure_Type;                    -- Skapar en kopia av en figur
   function Create_Part (Item : in Part_Type) return Part_Type;                         -- Skapar en kopia av en del
   
   function Allowed_Placement(Schematic : in Figure_Type;                               -- Kollar om delen får placeras på en viss position 
			      Part_Placement : in Figure_Type) return Boolean;
   
   procedure Put_Part (Schematic : in out Figure_Type;                                  -- Sätter in del(I) i figuren om en tillåten plats hittas
		       Prev : in out Previous_Coordinates;                              -- Hittas ingen tillåten plats ska funktionen gå tillbaka till föregående bit och omplacera den
		       Part : in Part_Type; I : in Integer); 
   
   procedure Remove_Coordinates (Schematic : in out Figure_Type;                        -- Tar bort föregående position ifrån arrayen med positioner
				 Prev : in out Previous_Coordinates;                     
				 I : in Integer);
   
   procedure Move_Part (Schematic : in out Figure_Type;                                 -- Testar att sätta en del på en ny position (börjar ifrån föregående pos)
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
