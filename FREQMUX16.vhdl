library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity FREQMUX16 is
    Port (	input1               	: in  STD_LOGIC;
			input2					: in  STD_LOGIC;
			input3					: in  STD_LOGIC;
			input4					: in  STD_LOGIC;
			input5					: in  STD_LOGIC;
			input6					: in  STD_LOGIC;
			input7					: in  STD_LOGIC;
			input8					: in  STD_LOGIC;
			input9					: in  STD_LOGIC;
			input10					: in  STD_LOGIC;
			input11					: in  STD_LOGIC;
			input12					: in  STD_LOGIC;
			input13					: in  STD_LOGIC;
			input14					: in  STD_LOGIC;
			input15					: in  STD_LOGIC;
			input16					: in  STD_LOGIC;
			input17					: in  STD_LOGIC;
			S                     	: in  STD_LOGIC_VECTOR(4 DOWNTO 0);
         MUXOUT					: out STD_LOGIC
          );
end FREQMUX16;

architecture Behavioral of FREQMUX16 is
		
	begin
		with S select
			MUXOUT <= input1 when "00000",
					  input2 when "00001",
					  input3 when "00010",
					  input4 when "00011",
					  input5 when "00100",
					  input6 when "00101",
					  input7 when "00110",
					  input8 when "00111",
					  input9 when "01000",
					  input10 when "01001",
					  input11 when "01010",
					  input12 when "01011",
					  input13 when "01100",
					  input14 when "01101",
					  input15 when "01110",
					  input16 when "01111",
					  input17 when "10000",
					  '0' when others;


end Behavioral;