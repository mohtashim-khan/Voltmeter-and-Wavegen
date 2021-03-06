-- This is example code that uses the downcounter module to create the signals 
-- to drive the 7-segment displays for a countdown timer. This code is 
-- provided to you to show an example of how to use the downcounter module, 
-- if it is of use to your project.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

entity clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
		   freq_select: in std_logic_vector(4 downto 0);
		   pulse_out : out STD_LOGIC
		   
           );
end clock_divider;

architecture Behavioral of clock_divider is
-- Signals:
signal pulse1,pulse2,pulse3,pulse4,pulse5,pulse6,pulse7,pulse8,pulse9,pulse10,pulse11,pulse12,pulse13,pulse14,pulse15,pulse16,pulse17 : STD_LOGIC;
signal S : std_logic_vector (3 downto 0);

-- Components declarations
component downcounter is
   Generic ( period  : natural); -- number to count
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0)
           );
end component;

component FREQMUX16 is
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
end component;

BEGIN
   
   Clock1: downcounter
   generic map(period => 49) --49
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse1 , -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
   Clock2: downcounter
   generic map(period => 52)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse2 , -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
	Clock3: downcounter
   generic map(period => 56)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse3 , -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
	Clock4: downcounter
   generic map(period => 60)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse4, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
	Clock5: downcounter
   generic map(period => 65)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse5, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
	Clock6: downcounter
   generic map(period => 71)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse6, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
	Clock7: downcounter
   generic map(period => 78)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse7, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
	Clock8: downcounter
   generic map(period => 87)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse8, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
	Clock9: downcounter
   generic map(period => 98)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse9, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock10: downcounter
   generic map(period => 112)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse10, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock11: downcounter
   generic map(period => 130)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse11, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock12: downcounter
   generic map(period => 156)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse12, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock13: downcounter
   generic map(period => 195)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse13, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock14: downcounter
   generic map(period => 260)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse14, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock15: downcounter
   generic map(period => 391)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse15, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock16: downcounter
   generic map(period => 781)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse16, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
  Clock17: downcounter
   generic map(period => 48828)
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable, -- if system is enabled, this this counting
               zero   => pulse17, -- this is a 1-clock cycle pulse every second
               value  => open  -- Leave open since we won't display this value
            );
			
	FREQMUX: FREQMUX16
	port map (
				input1 => pulse1 ,
				input2 => pulse2 ,
				input3 => pulse3 ,
				input4 => pulse4 ,
				input5 => pulse5 ,
				input6 => pulse6 ,
				input7 => pulse7 ,
				input8 => pulse8 ,
				input9 => pulse9,
				input10 => pulse10 ,
				input11 => pulse11 ,
				input12 => pulse12 ,
				input13 => pulse13 ,
				input14 => pulse14 ,
				input15 => pulse15 ,
				input16 => pulse16 ,
				input17 => pulse17 ,
				S => freq_select,
				MUXOUT => pulse_out
			
			 );
		
  
   
END Behavioral;