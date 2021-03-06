library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity buttonpulse is
    Port (	clk 					: in STD_LOGIC;
			reset 					: in STD_LOGIC;
			input               	: in  STD_LOGIC;
			output_pulse					: out STD_LOGIC
			);
end buttonpulse;

architecture Behavioral of buttonpulse is
	signal past_input : std_logic;	
	begin
	
	edgedetect_process: process (input, clk, reset)
	begin
		if(rising_edge(clk)) then
		past_input <= input;
		end if;
	end process;
	output_pulse <= not past_input AND input;

end Behavioral;