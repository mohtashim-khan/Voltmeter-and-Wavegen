library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity wave_gen is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           clk_pulse :  in STD_LOGIC;
		   Amp_select: in STD_LOGIC_VECTOR(3 downto 0);
		   wave_select: in std_logic_vector(2 downto 0);
           PWM_OUT : out STD_LOGIC
          );
end wave_gen;

architecture Behavioral of wave_gen is

    constant up : STD_LOGIC := '1';
    constant down : STD_LOGIC := '0'; 
    constant width : integer:= 10;
    type StateType is (S0,S1,S2);
    signal CurrentState,NextState: StateType;
    signal pwm_out_sawtooth,pwm_out_triangle, pwm_out_square, count_direction : STD_LOGIC;
    signal duty_cycle,counter : STD_LOGIC_VECTOR(width-1 downto 0);
 	  constant max_count: std_logic_vector(width-1 downto 0) := (others => '1');
 	
    constant zeros_count : std_logic_vector(width-1 downto 0) := (others => '0');   
 
    component Sawtooth is
	Port   ( reset      : in STD_LOGIC;
			 clk		: in STD_LOGIC;
             clk_pulse    : in STD_LOGIC;
             pwm_out    : out STD_LOGIC
           );
end component;

	component Triangle is     
	Port   ( reset      : in STD_LOGIC;
			 clk		: in STD_LOGIC;
             clk_pulse    : in STD_LOGIC;
             pwm_out    : out STD_LOGIC
           );
	end component;
	
	component Square is     
	Port   ( reset      : in STD_LOGIC;
				clk		: in STD_LOGIC;
             clk_pulse    : in STD_LOGIC;
				 Amp_select	:in STD_LOGIC_VECTOR(3 downto 0);
             pwm_out    : out STD_LOGIC
           );
	
    
end component;
    
begin

sawtooth_gen: sawtooth
	Port map   ( reset => reset,
			 clk => clk,
             clk_pulse => clk_pulse,
             pwm_out => pwm_out_sawtooth
           );

triangle_gen: Triangle
	Port map   ( reset => reset,
			 clk => clk,
             clk_pulse => clk_pulse,
             pwm_out => pwm_out_triangle
           );
        
square_gen: square
Port map   ( reset => reset,
			 clk => clk,
             clk_pulse => clk_pulse,
			 Amp_select => Amp_select,
             pwm_out => pwm_out_square
           );
    
	with wave_select select
   PWM_OUT <= pwm_out_sawtooth when "001",
			pwm_out_triangle when "010",
			pwm_out_square when "100" ,
			'0' when others;

end Behavioral;
    