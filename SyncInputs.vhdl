library ieee;
use ieee.std_logic_1164.all;

entity SyncInputs is 
	Port(
		   clk								 : in STD_LOGIC;
		   reset							 : in std_logic;
		   MUXSELECTSYNC					 :	in STD_LOGIC;
		   FrequpSYNC					 	 : in STD_LOGIC;
		   FreqdownSYNC						 : in STD_LOGIC;
		   AmpupSYNC					 	 :	in STD_LOGIC;
		   AmpdownSYNC					 	 :	in STD_LOGIC;
		   wave_selectSYNC					 : in std_logic_vector (2 downto 0);
		   Freq_or_ampSYNC					 : in std_logic;
		   MUXSELECT					 :	out STD_LOGIC;
		   Frequp					 	 : out STD_LOGIC;
		   Freqdown						 : out STD_LOGIC;
		   Ampup					 	 :	out STD_LOGIC;
		   Ampdown					 	 :	out STD_LOGIC;
		   wave_select					 : out std_logic_vector (2 downto 0);
		   Freq_or_amp					 : out std_logic
		   );
End SyncInputs;

architecture Behavioral of SyncInputs is

signal 		   MUXSELECTSYNC1					 : STD_LOGIC;
signal		   FrequpSYNC1					 	 : STD_LOGIC;
signal		   FreqdownSYNC1						 : STD_LOGIC;
signal		   AmpupSYNC1					 	 : STD_LOGIC;
signal		   AmpdownSYNC1					 	 :	STD_LOGIC;
signal		   wave_selectSYNC1					 : std_logic_vector (2 downto 0);
signal		   Freq_or_ampSYNC1					 : std_logic;
begin

 process (clk, reset)
   begin
      if reset = '1' then
		   MUXSELECT		<= '0';
		   Frequp			<= '0';
		   Freqdown			<= ('0');
		   Ampup			<= ('0');
		   Ampdown			<= ('0');
		   wave_select		<= (others=>'0');
		   Freq_or_amp		<= ('0');
		   
		elsif (rising_edge(clk)) then
           MUXSELECTSYNC1		<= MUXSELECTSYNC;
		   FrequpSYNC1			<= FrequpSYNC;
		   FreqdownSYNC1		<=FreqdownSYNC;
		   AmpupSYNC1			<=  AmpupSYNC;
		   AmpdownSYNC1			<=	AmpdownSYNC;
		   wave_selectSYNC1		<= wave_selectSYNC;
		   Freq_or_ampSYNC1		<= Freq_or_ampSYNC;
		   MUXSELECT		<= MUXSELECTSYNC1;
		   Frequp			<= FrequpSYNC1;
		   Freqdown			<=FreqdownSYNC1;
		   Ampup			<=  AmpupSYNC1;
		   Ampdown			<=	AmpdownSYNC1;
		   wave_select		<= wave_selectSYNC1;
		   Freq_or_amp		<= Freq_or_ampSYNC1;
      end if;
   end process;

end;