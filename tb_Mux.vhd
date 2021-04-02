library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 

entity tb_Mux is 

end tb_Mux;


architecture tb of tb_Mux is
	component Mux is -- declare the component
	 Port (	AVGIN               	: in  STD_LOGIC_VECTOR (11 downto 0);
			REGIN					: in  STD_LOGIC_VECTOR (11 downto 0);
			S                     	: in  STD_LOGIC;
            MUXOUT					: out STD_LOGIC_VECTOR (11 downto 0)
			);
			
end component;


-- Inputs
	signal AVGIN : STD_LOGIC_VECTOR (11 downto 0) ;
	signal REGIN : STD_LOGIC_VECTOR (11 downto 0) ;
	Signal S 	 : STD_LOGIC;
-- Outputs
	signal MUXOUT : STD_LOGIC_VECTOR (11 downto 0);

--INSTANTIATE Mux AS UUT	
begin
UUT: Mux port map 				(AVGIN=>AVGIN,
								REGIN=>REGIN,
								S=>S,
								MUXOUT=>MUXOUT);
	--STIM PROCESS

S_process : process
begin
	S <= '0';
	wait for 100 ns;
	S <= '1';
	wait for 100 ns;
end process;

AVGIN_process : process
begin
	AVGIN <= "000000000000";
	wait;
end process;



REGIN_process : process
begin 
	REGIN <= "111111111111";
	wait;	
end process;
	
end tb;