library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity counter is     
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           enable : in  STD_LOGIC; -- active-high enable
                                   -- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR (9 downto 0)
         );
end counter;

architecture Behavioral of counter is
  signal current_count : std_logic_vector(9 downto 0);
  
BEGIN
   
   count: process(clk,reset)

	begin 
       if (reset = '1') then 
          current_count <= "0000000000" ;
          
       elsif (rising_edge(clk)) then 
			if(enable = '1') then
          current_count <= current_count + '1';
          end if;
			 
		end if;
			 
   end process;
   
   value <= current_count; 
   
END Behavioral;
