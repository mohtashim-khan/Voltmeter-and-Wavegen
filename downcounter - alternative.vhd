library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity downcounter is
  Generic ( period: integer:= 1000;-- number to count       
            WIDTH  : integer:= 10  -- minimum bits to represent binary value of period, i.e.
			                          -- WIDTH = CEILING(LOG(period),2),1)
								           -- 10 = CEILING(LOG(1000),2),1), or
								           -- 1000 <= 2^10 (where <= is less than or equal to)
		  );
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           enable : in  STD_LOGIC; -- active-high enable
           zero   : out STD_LOGIC; -- creates a positive pulse every time current_count hits zero
		                             -- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0) -- outputs the current_count value, if needed
         );
end downcounter;

architecture Behavioral of downcounter is
  signal current_count : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  
  constant max_count : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := 
                       STD_LOGIC_VECTOR(to_unsigned(period - 1, WIDTH));
  constant zeros     : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');
  
BEGIN
   
   count: process(clk) begin
     if (rising_edge(clk)) then 
       if (reset = '1') then 
          current_count <= max_count;
          zero          <= '0';
       elsif (enable = '1') then 
          if (current_count = zeros) then
            current_count <= max_count;
            zero          <= '1';
          else 
            current_count <= current_count - '1';
            zero          <= '0';
          end if;
       else 
          zero <= '0';
       end if;
     end if;
   end process;
   
   value <= current_count; 
   
END Behavioral;

