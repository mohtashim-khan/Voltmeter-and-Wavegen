library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

entity Square is
   Port    ( reset      : in STD_LOGIC;
			 clk		: in STD_LOGIC;
             clk_pulse  : in STD_LOGIC;
			 Amp_select	: in std_logic_vector(3 downto 0);
             pwm_out    : out STD_LOGIC					--ADD MAXCOUNT TO CONTROL THE FREQUENCY OF THE SAWTOOTH
           );
end Square;

architecture Behavioral of Square is


signal duty_cycle_sig: STD_LOGIC_VECTOR (9 downto 0);

component PWM_DAC is
    Generic ( width : integer := 10	);
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           duty_cycle : in STD_LOGIC_VECTOR (width-1 downto 0);
           pwm_out : out STD_LOGIC
          );
end component;

component highlow_square is      
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           enable : in  STD_LOGIC; -- active-high enable
		   Ampselect : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		   
                                   -- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR (9 downto 0) -- outputs the current_count value, if needed
         );
end component;



begin

pwm: PWM_DAC
	generic map (width => 10)
    port map (
        reset => reset,
        clk => clk,
        duty_cycle => duty_cycle_sig,
        pwm_out => pwm_out
        );

duty_cycle_count : highlow_square 	
		port map(
				clk			=> clk,
				reset		=> reset,
				enable => clk_pulse,
				Ampselect => Amp_select,
				value => duty_cycle_sig
				);

--NEED A COUNTER(can just use clk for a 1khz freq) THAT COUNTS UP TO 1MS TO INCREMENT DUTYCYCLE BY A CERTAIN VALUE
-- NEED A SECOND DOWNCOUNTER IF WANTING A FREQUENCY LESS THAN 1khz
-- THE DUTYCYCLE IS THEN FED INTO THE PWM_DAC
--ONCE COUNTER REACHES MAX VALUE RESETS TO 0, WHICH ALSO RESETS DUTYCYCLE TO 0
-- THE MAX VALUE OF THE COUNTER IS AN INPUT THAT WILL BE FED USING AN EXTERNAL LUT
-- EXTERNAL LUT IS CONTROLLED BY EXTERNAL PUSH BUTTONS


  
end Behavioral;