library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 

entity switch is
    Port ( 
           input : in STD_LOGIC;
			clk	: in STD_LOGIC;
           output : out STD_LOGIC
			  
			  
           );
end switch;

architecture Behavioral of switch is
	begin
 
	switch: process(clk)
		
		begin

			if rising_edge(clk) then
				
				output <= input;
				
			end if;
			
	end process switch;
  

end Behavioral;
