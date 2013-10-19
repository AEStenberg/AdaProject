with Part_Package; use Part_Package;

package Test_Package is
   
   procedure Try_Figure (F : in Figure_Type; 
			 P : in Part_Array; Length : in Integer; 
					    Placed_Parts : in out Part_Information_Array; Solved : in out Boolean);
   
end Test_Package;
