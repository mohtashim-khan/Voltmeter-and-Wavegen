library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Freq_select_counter is     
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           up : in  STD_LOGIC; -- active-high enable
		   down : in std_logic;-- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR (4 downto 0)
         );
end Freq_select_counter;

architecture Behavioral of Freq_select_counter is
  signal current_count : std_logic_vector(4 downto 0);
  
BEGIN
   
   count: process(clk,reset)

	begin 
       if (reset = '1') then 
          current_count <= "00000" ;
		  
		elsif(current_count = "10001") then
		current_count <= "00000";
		elsif(current_count = "11111") then
        current_count <= "10000";  
       elsif (rising_edge(clk)) then 
			if(up = '1') then
          current_count <= current_count + '1';
			elsif(down = '1') then
		  current_count <= current_count- '1';
          end if;
			 
		end if;
			 
   end process;
   
   value <= current_count; 
   
END Behavioral;
