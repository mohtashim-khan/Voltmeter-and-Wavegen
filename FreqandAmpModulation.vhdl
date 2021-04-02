library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FreqandAmpModulation is
   PORT ( clk    : in  STD_LOGIC; 
           reset  : in  STD_LOGIC;
			SelectFreqorAmp : in STD_LOGIC;
           distance : in  STD_LOGIC_VECTOR (12 downto 0);
           Freqselectout  : out STD_LOGIC_VECTOR (4 downto 0);
		   Ampselectout : out STD_LOGIC_VECTOR  (3 downto 0)
         );
end FreqandAmpModulation;

architecture Behavioral of FreqandAmpModulation is

signal distance_integer : integer; 
signal freqout : STD_LOGIC_VECTOR(4 downto 0);
signal Ampout : STD_LOGIC_VECTOR (3 downto 0);										

begin

distance_integer <= to_integer(unsigned(distance));

freq_process: process(clk, reset, distance)
begin 
if(reset = '1') then
Freqselectout <= "11111";

elsif(SelectFreqorAmp = '1') then 
freqselectout <= "01100";

elsif(rising_edge(clk)) then
	
	if(distance_integer < 400) then
	freqselectout <= "00000"; 					

	elsif(400 < distance_integer and distance_integer < 581) then
	freqselectout <= "00001";
	
	
	elsif(581 < distance_integer and distance_integer < 762) then
	freqselectout <= "00010";
	
	
	elsif(762 < distance_integer and distance_integer < 943) then
	freqselectout <= "00011";
	
	
	elsif(943 < distance_integer and distance_integer < 1124) then
	freqselectout <= "00100";
	
	
	elsif(1124 < distance_integer and distance_integer < 1305) then
	freqselectout <= "00101";
	
	
	elsif(1305 < distance_integer and distance_integer < 1486) then
	freqselectout <= "00110";
	
	
	elsif(1486 < distance_integer and distance_integer < 1667) then
	freqselectout <= "00111";
	
	
	elsif(1667 < distance_integer and distance_integer < 1848) then
	freqselectout <= "01000";
	
	
	elsif(1848 < distance_integer and distance_integer < 2029) then
	freqselectout <= "01001";
	
	
	elsif(2029 < distance_integer and distance_integer < 2210) then
	freqselectout <= "01010";
	
	
	elsif(2210 < distance_integer and distance_integer < 2391) then
	freqselectout <= "01011";
	
	
	elsif(2391 < distance_integer and distance_integer < 2572) then
	freqselectout <= "01100";
	
	
	elsif(2572 < distance_integer and distance_integer < 2753) then
	freqselectout <= "01101";
	
	
	elsif(2753 < distance_integer and distance_integer < 2934) then
	freqselectout <= "01110";
	
	
	elsif(2934 < distance_integer and distance_integer < 3115) then
	freqselectout <= "01111";
	
	
	elsif(3115 < distance_integer and distance_integer < 3296) then
	freqselectout <= "10000";
	
	
	elsif(3296 < distance_integer) then
	freqselectout <= "11111";
	
	end if;
	end if;
end process;

Amp_process: process(clk, reset, distance)
begin 
if(reset = '1') then
Ampselectout <= "1111";

elsif(SelectFreqorAmp = '0') then
Ampselectout <= "0000";

elsif(rising_edge(clk)) then
	
	if(distance_integer < 400) then
	Ampselectout <= "0000";
	 					

	elsif(400 < distance_integer and distance_integer < 581) then
	Ampselectout <= "0001";
	
	
	
	elsif(581 < distance_integer and distance_integer < 762) then
	Ampselectout <= "0010";
	
	
	elsif(762 < distance_integer and distance_integer < 943) then
	Ampselectout <= "0011";
	
	
	elsif(943 < distance_integer and distance_integer < 1124) then
	Ampselectout <= "0100";
	
	
	elsif(1124 < distance_integer and distance_integer < 1305) then
	Ampselectout <= "0101";
	
	
	elsif(1305 < distance_integer and distance_integer < 1486) then
	Ampselectout <= "0110";
	
	
	elsif(1486 < distance_integer and distance_integer < 1667) then
	Ampselectout <= "0111";
	
	
	elsif(1667 < distance_integer and distance_integer < 1848) then
	Ampselectout <= "1000";
	
	
	elsif(1848 < distance_integer and distance_integer < 2029) then
	Ampselectout <= "1001";
	
	
	elsif(2029 < distance_integer and distance_integer < 2210) then
	Ampselectout <= "1010";
	
	
	elsif(2210 < distance_integer and distance_integer < 2391) then
	Ampselectout <= "1011";
	
	
	elsif(2391 < distance_integer and distance_integer < 2572) then
	Ampselectout <= "1100";
	
	
	elsif(2572 < distance_integer and distance_integer < 2753) then
	Ampselectout <= "1101";
	
	
	elsif(2753 < distance_integer and distance_integer < 2934) then
	Ampselectout <= "1110";
	
	
	elsif(2934 < distance_integer and distance_integer < 3115) then
	Ampselectout <= "1111";
	
	
	elsif(3115 < distance_integer and distance_integer < 3296) then
	Ampselectout <= "1111";
	
	
	elsif(3296 < distance_integer) then
	Ampselectout <= "1111";
	
	end if;
	end if;
end process;      
  
END Behavioral;