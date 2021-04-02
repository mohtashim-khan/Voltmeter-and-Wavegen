library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity highlow_square is
   PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           enable : in  STD_LOGIC; -- active-high enable
		   Ampselect : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		   
                                   -- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR (9 downto 0) -- outputs the current_count value, if needed
         );
end highlow_square;

architecture Behavioral of highlow_square is
signal duty_cycle_sig : std_logic_vector (9 downto 0);
signal current_count : std_logic_vector(9 downto 0);
signal check : integer := 0;  
type array_duty is array (0 to 15) of integer;
constant dutyCycle_LUT : array_duty:= ((1023), (960), (896), (832),(768), (704),(640), (576),(512), (448),(384), (320),(256), (192),(128), (32));

										

begin
   
   count: process(clk,reset,check,enable)

	begin 
       if (reset = '1') then 
          current_count <= "0000000000" ;
		  value <= "0000000000";
          
       elsif (rising_edge(clk)) then 
		if(enable = '1') then
			if(check = 0) then
				if(current_count < "1111111110") then
				current_count <= current_count + "10";
				end if;
				
				if(current_count = "1111111100") then
				check <= 1;
				value <= duty_cycle_sig;
				end if;
				
			else
				if(current_count > "000000000") then 
				current_count <= current_count - "10";
				end if;
			
				if(current_count = "0000000010") then
				check <= 0;
				value <= "0000000000";
				end if;
			
			
		end if;
	end if;
end if;		 

end process;
  
duty_cycle_sig <= std_logic_vector(to_unsigned(DutyCycle_LUT(to_integer(unsigned(Ampselect))),duty_cycle_sig'length));   
-- duty_cycle_sig <= "0000000000";   
END Behavioral;