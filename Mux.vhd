library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity Mux is
    Port (	input1               	: in  STD_LOGIC_VECTOR (12 downto 0);
			input2					: in  STD_LOGIC_VECTOR (12 downto 0);
			S                     	: in  STD_LOGIC;
            MUXOUT					: out STD_LOGIC_VECTOR (12 downto 0)
          );
end Mux;

architecture Behavioral of Mux is
		
	begin
		with S select
			MUXOUT <= input1 when '0',
					  input2 when '1',
					  "0000000000000" when others;


end Behavioral;