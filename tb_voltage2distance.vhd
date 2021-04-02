library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 

entity tb_voltage2distance is 

end tb_voltage2distance;


architecture tb of tb_voltage2distance is
	component Voltage2distance is -- declare the component
	 PORT(
      clk            :  IN    STD_LOGIC;                                
      reset          :  IN    STD_LOGIC;                                
      voltage        :  IN    STD_LOGIC_VECTOR(12 DOWNTO 0);                           
      distance       :  OUT   STD_LOGIC_VECTOR(12 DOWNTO 0) 
          );
end component;


-- Inputs
	signal clk : std_logic ;
	signal reset : std_logic ;
	signal voltage : std_logic_vector(12 downto 0);
-- Outputs
	signal distance : STD_LOGIC_VECTOR (12 downto 0);
	
--CLK Period Constant
	constant clk_period:	  time:= 10ns;

--INSTANTIATE VOLTMETER AS UUT	
begin
UUT: Voltage2distance port map 			(clk=>clk,
										reset=>reset,
										voltage => voltage,
										distance=> distance
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

voltage_process : process
begin
	voltage <= std_logic_vector(to_unsigned(1000, voltage'length));
	wait for 1000 ns;
	voltage  <= std_logic_vector(to_unsigned(500, voltage'length));
	wait for 1000 ns;
	voltage <= std_logic_vector(to_unsigned(200, voltage'length));
	wait for 1000 ns;
	
end process;


	
end tb;