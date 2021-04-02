library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end clock_divider;

architecture Behavioral of clock_divider is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal onehertz, tensseconds, onesminutes, singlesec : STD_LOGIC;
signal singleSeconds, singleMinutes : STD_LOGIC_VECTOR(3 downto 0);
signal tenSeconds, tensMinutes : STD_LOGIC_VECTOR(3 downto 0);
-- Add signals here

-- Components declarations
component downcounter is
   Generic ( period : integer:= 4;
             WIDTH  : integer:= 3
           );
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

BEGIN
   
   oneHzClock: downcounter
   generic map(
               period => (50000),--(50000000) -- divide by 50_000_000 to divide 50 MHz down to 1 Hz 
                                 -- for simulation, use 50_000, to increase the simulation speed
               WIDTH  => 26      -- 26 bits are required to hold the binary value of 10_1111_1010_1111_0000_1000_0000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable,
               zero   => onehertz,
               value  => open  -- Leave open since we won't display this value
            );
   
   singleSecondsClock: downcounter
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onehertz,
               zero   => singlesec,
               value  => singleSeconds -- binary value of seconds we decode to drive the 7-segment display        
            );
   
   tensSecondsClock: downcounter
   generic map(
               period => (6),   -- Counts numbers between 0 and 5 -> that's 6 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => singlesec,
               zero   => tensseconds,
               value  => tenSeconds -- binary value of tens of seconds we decode to drive the 7-segment display        
            );
   
   singleMinutesClock: downcounter
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => tensseconds,
               zero   => onesminutes,
               value  => singleMinutes -- binary value of minutes we decode to drive the 7-segment display        
            );
   
   tensMinutesClock: downcounter
   generic map(
               period => (6),   -- Counts numbers between 0 and 5 -> that's 6 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onesminutes,
               zero   => open, -- we dont' need a clock signal from this, so leave open
               value  => tensMinutes -- binary value of tens of minutes we decode to drive the 7-segment display        
            );
   
   -- Connect internal signals to outputs
   sec_dig1 <= singleSeconds;
   sec_dig2 <= tenSeconds;
   min_dig1 <= singleMinutes;
   min_dig2 <= tensMinutes;
   
END Behavioral;