library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 

entity tb_voltmeter is 

end tb_voltmeter;


architecture tb of tb_voltmeter is
	component Voltmeter is -- declare the component
	   Port ( clk                           : in  STD_LOGIC;
           reset                         : in  STD_LOGIC;
		   MUXSELECTSYNC					 :	in STD_LOGIC;
		   FrequpSYNC					 	 : in STD_LOGIC;
		   FreqdownSYNC						 : in STD_LOGIC;
		   AmpupSYNC					 	 :	in STD_LOGIC;
		   AmpdownSYNC					 	 :	in STD_LOGIC;
		   wave_selectSYNC					 : in std_logic_vector (2 downto 0);
		   Freq_or_ampSYNC					 : in std_logic;
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0);
		   PWMout						 : out STD_LOGIC;
		   PWMout_Buzzer				 : out STD_LOGIC
          );
           
end component;


-- Inputs
	signal clk : std_logic ;
	signal reset : std_logic ;
	signal MUXSELECTSYNC : std_logic;
-- Outputs
	signal LEDR : STD_LOGIC_VECTOR (9 downto 0);
	signal HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : STD_LOGIC_VECTOR (7 downto 0);
	signal FrequpSYNC	:STD_LOGIC;
	signal FreqdownSYNC:STD_LOGIC;
	signal AmpupSYNC:  STD_LOGIC;
	signal AmpdownSYNC		:	STD_LOGIC;
	signal wave_selectSYNC	:  std_logic_vector (2 downto 0);
	signal  Freq_or_ampSYNC		: std_logic;
	signal input: std_logic;
	signal output: std_logic;
	signal PWMout: std_logic;
	signal PWMout_Buzzer : std_logic;
--CLK Period Constant
	constant clk_period:	  time:= 10ns;

--INSTANTIATE VOLTMETER AS UUT	
begin
UUT: Voltmeter port map 				(clk=>clk,
										reset=>reset,
										MUXSELECTSYNC => MUXSELECTSYNC,
										LEDR=>LEDR,
										HEX0=>HEX0,
										HEX1=>HEX1,
										HEX2=>HEX2,
										HEX3=>HEX3,
										HEX4=>HEX4,
										HEX5=>HEX5,
										FrequpSYNC=>FrequpSYNC,
										FreqdownSYNC=>FreqdownSYNC,
										AmpupSYNC=>AmpupSYNC,
										AmpdownSYNC=>AmpdownSYNC,
										wave_selectSYNC=>wave_selectSYNC,
										Freq_or_ampSYNC=>Freq_or_ampSYNC,
										PWMout=>PWMout,
										PWMout_Buzzer=>PWMout_Buzzer
										);
										

	--STIM PROCESS

clk_process : process
begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;

reset_process : process
begin
	reset <= '0';
	wait for 200 ns;
	reset<= '1';
	wait for 50 ns;
	reset <= '0';
	wait;
end process;

Select_process : process
begin
	 MUXSELECTSYNC<= '1';
	wait;
end process;

FrequpSYNC_process: process
begin
	FrequpSYNC <= '0';
	wait for 400 ns;
	FrequpSYNC <= '1';
	wait for clk_period/3;
	
end process;

FreqdownSYNC_process: process
begin
	wait for 3000 ns;
	FreqdownSYNC <= '0';
	wait for 400 ns;
	FreqdownSYNC <= '1';
	wait for clk_period/3;
end process;

AmpupSYNC_process: process
begin		
	 wait for 6000 ns;
	 AmpupSYNC	<= '0';
	wait for 800 ns;
	 AmpupSYNC	 <= '1';
	wait for clk_period/3;
end process;

AmpdownSYNC_process: process
begin	
	 wait for 12000 ns;
	 AmpdownSYNC	<= '0';
	wait for 1000 ns;
	 AmpdownSYNC	 <= '1';
	wait for clk_period/3;
end process;

Awave_selectSYNC_process: process
begin
	 
	  wait for 2000 ns;
	  wave_selectSYNC	<= "001";
	   wait for 2000 ns;
	  wave_selectSYNC	<= "010";
	  wait for 1000 ns;
	  wave_selectSYNC	<= "100";

	wait for clk_period/3;
end process;

Freq_or_ampSYNC_process: process
begin
	 Freq_or_ampSYNC <= '0';
	wait for 2000 ns;
	 Freq_or_ampSYNC <= '1';
	wait for clk_period/3;
end process;
	
end tb;