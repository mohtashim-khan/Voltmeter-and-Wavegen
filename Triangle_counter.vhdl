library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Triangle_counter is     
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           enable : in  STD_LOGIC; -- active-high enable
                                   -- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR (9 downto 0)
         );
end Triangle_counter;

architecture Behavioral of Triangle_counter is
  signal current_count : std_logic_vector(9 downto 0);
  signal check : integer := 0;   
  
BEGIN
   
   count: process(clk,reset,check,enable)

	begin 
       if (reset = '1') then 
          current_count <= "0000000000" ;
          
       elsif (rising_edge(clk)) then 
		if(enable = '1') then
			if(check = 0) then
				if(current_count < "1111111110") then
				current_count <= current_count + "10";
				end if;
				
				if(current_count = "1111111100") then
				check <= 1;
				end if;
				
			else
				if(current_count > "000000000") then
				current_count <= current_count - "10";
				end if;
			
				if(current_count = "0000000010") then
				check <= 0;
				end if;
			
			
		end if;
	end if;
	end if;		 
  end process;
  
   
   value <= current_count; 
   
END Behavioral;
