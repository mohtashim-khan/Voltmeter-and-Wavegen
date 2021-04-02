library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;
 
entity Voltmeter is
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
           
end Voltmeter;

architecture Behavioral of Voltmeter is

Signal A, Num_Hex0, Num_Hex1, Num_Hex2, Num_Hex3, Num_Hex4, Num_Hex5 :   STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');   
Signal DP_in:   STD_LOGIC_VECTOR (5 downto 0);
Signal ADC_read,rsp_data,q_outputs_1,q_outputs_2 : STD_LOGIC_VECTOR (11 downto 0);
Signal voltage: STD_LOGIC_VECTOR (12 downto 0);
Signal busy: STD_LOGIC;
signal response_valid_out_i1,response_valid_out_i2,response_valid_out_i3 : STD_LOGIC_VECTOR(0 downto 0);
Signal bcd: STD_LOGIC_VECTOR(15 DOWNTO 0);
Signal Q_temp1 : std_logic_vector(11 downto 0);
Signal MUXOUT : std_logic_vector (12 downto 0);
Signal distance_signal: STD_LOGIC_VECTOR(12 DOWNTO 0);
signal Freq_select, Freq_select_buzzer: std_logic_vector (4 downto 0);
signal Amp_select_signal, Amp_select_buzzer: std_logic_vector (3 downto 0);
signal Frequp_signal, Freqdown_signal, Ampup_signal, Ampdown_signal: std_logic;
signal clk_pulse, PWM_OUT : std_logic;
signal clk_pulse_buzzer : std_logic;
signal MUXSELECT, Frequp, Freqdown, Ampup, Ampdown, Freq_or_amp: std_logic;
signal wave_select: std_logic_vector (2 downto 0); 



component SyncInputs is 
	Port(
		   clk								 : in std_logic;
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
End Component;
		   
component Mux is -- declare the component
	 Port (	input1               	: in  STD_LOGIC_VECTOR (12 downto 0);
			input2					: in  STD_LOGIC_VECTOR (12 downto 0);
			S                     	: in  STD_LOGIC;
            MUXOUT					: out STD_LOGIC_VECTOR (12 downto 0)
			);
End Component;			
			

Component SevenSegment is
    Port( Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
          Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
          DP_in                                                 : in  STD_LOGIC_VECTOR (5 downto 0)
			);
End Component ; 

Component  ADC_Conversion is
    Port( MAX10_CLK1_50      : in STD_LOGIC;
          response_valid_out : out STD_LOGIC;
          ADC_out            : out STD_LOGIC_VECTOR (11 downto 0)
         );
End Component ;

Component binary_bcd IS
   PORT(
      clk     : IN  STD_LOGIC;                      --system clock
      reset   : IN  STD_LOGIC;                      --active low asynchronus reset
      ena     : IN  STD_LOGIC;                      --latches in new binary number and starts conversion
      binary  : IN  STD_LOGIC_VECTOR(12 DOWNTO 0);  --binary number to convert
      busy    : OUT STD_LOGIC;                      --indicates conversion in progress
      bcd     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)   --resulting BCD number
		);           
END Component;

Component registers is
   generic(bits : integer);
   port
     ( 
      clk       : in  std_logic;
      reset     : in  std_logic;
      enable    : in  std_logic;
      d_inputs  : in  std_logic_vector(bits-1 downto 0);
      q_outputs : out std_logic_vector(bits-1 downto 0)  
     );
END Component;

Component averager is
  port(
    clk, reset : in std_logic;
    Din : in  std_logic_vector(11 downto 0);
    EN  : in  std_logic; -- response_valid_out
    Q   : out std_logic_vector(11 downto 0)
    );
  end Component;
  
  component voltage2distance
   PORT(
      clk            :  IN    STD_LOGIC;                                
      reset          :  IN    STD_LOGIC;                                
      voltage        :  IN    STD_LOGIC_VECTOR(12 DOWNTO 0);                           
      distance       :  OUT   STD_LOGIC_VECTOR(12 DOWNTO 0)
	  );  
END Component;

  component wave_gen
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           clk_pulse :  in STD_LOGIC;
			Amp_select: in STD_LOGIC_VECTOR(3 downto 0);
			wave_select: in std_logic_vector(2 downto 0);
           PWM_OUT : out STD_LOGIC
          ); 
END Component;


component downcounter
   Generic ( period : natural := 1000); -- number to count       
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           enable : in  STD_LOGIC; -- active-high enable
           zero   : out STD_LOGIC; -- creates a positive pulse every time current_count hits zero
                                   -- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
         ); 
END Component;


component buttonpulse is
    Port (	clk 		: in STD_LOGIC;
			reset 					: in STD_LOGIC;
			input               	: in  STD_LOGIC;
			output_pulse					: out STD_LOGIC
			);
end component;

component Freq_select_counter is     
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           up : in  STD_LOGIC; -- active-high enable
		   down : in std_logic;-- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR (4 downto 0)
         );
end component;

component Amp_select_counter is     
    PORT ( clk    : in  STD_LOGIC; -- clock to be divided
           reset  : in  STD_LOGIC; -- active-high reset
           up : in  STD_LOGIC; -- active-high enable
		   down : in std_logic;-- useful to enable another device, like to slow down a counter
           value  : out STD_LOGIC_VECTOR (3 downto 0)
         );
end component;


component clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
		   freq_select: in std_logic_vector(4 downto 0);
		   pulse_out : out STD_LOGIC
		   
           );
end component;

component FreqandAmpModulation is
   PORT ( 	clk    : in  STD_LOGIC; 
			reset  : in  STD_LOGIC;
			SelectFreqorAmp : in STD_LOGIC;
			distance : in  STD_LOGIC_VECTOR (12 downto 0);
			Freqselectout  : out STD_LOGIC_VECTOR (4 downto 0);
			Ampselectout : out STD_LOGIC_VECTOR  (3 downto 0)
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
   Num_Hex0 <= bcd(3  downto  0); 
   Num_Hex1 <= bcd(7  downto  4);
   Num_Hex2 <= bcd(11 downto  8);
--   Num_Hex4 <= "1111";
--   Num_Hex5 <= "1111";
   with bcd (15 downto 12) select
	Num_Hex3 <= "1111" when "0000",
				bcd(15 downto 12) when others;
   
   
   Num_Hex4 <= bcd(3 downto 0) when (unsigned(distance_signal) = 3333) and (MUXSELECT = '0') else "1111";
   Num_Hex5 <= bcd(3 downto 0) when (unsigned(distance_signal) = 3333) and (MUXSELECT = '0') else "1111";   
   --DP_in    <= "001000";-- position of the decimal point in the display
   
   with MUXSELECT select
   DP_in <= "000100" when '0',
			"001000" when '1',
			"000000" when others;
									


INPUTSYNC: SyncInputs
Port MAP	( 
			clk => clk,
			reset => reset,
			MUXSELECTSYNC => MUXSELECTSYNC,
		   FrequpSYNC => FrequpSYNC,
		   FreqdownSYNC => FreqdownSYNC,
		   AmpupSYNC => AmpupSYNC,
		   AmpdownSYNC => AmpdownSYNC,
		   wave_selectSYNC => wave_selectSYNC,
		   Freq_or_ampSYNC => Freq_or_ampSYNC,
		   MUXSELECT => MUXSELECT,
		   Frequp => Frequp,
		   Freqdown => Freqdown,
		   Ampup => Ampup,
		   Ampdown => Ampdown,
		   wave_select => wave_select,
		   Freq_or_amp => Freq_or_amp
		   );

BUZZER_WAVE_GEN: square
Port map   ( reset => reset,
			 clk => clk,
             clk_pulse => clk_pulse_buzzer,
			 Amp_select => Amp_select_buzzer,
             pwm_out => PWMout_Buzzer
           );
BUZZER_FRQ_OR_AMP: FreqandAmpModulation
				port map (
			clk => clk,    
			reset => reset,  
			SelectFreqorAmp => Freq_or_amp, 
			distance => distance_signal,			
			Freqselectout => Freq_select_buzzer,  
			Ampselectout => Amp_select_buzzer
			);
			
BUZZER_FRQ_ClK_DIVIDER: clock_divider
		port map(
			clk  => clk,
           reset => reset,
           enable => '1',		   
		   freq_select => Freq_select_buzzer,
		   pulse_out => clk_pulse_buzzer
           ); 
									
WAVEGEN: 	wave_gen
		port map(
				clk			=> clk,
				reset		=> reset,
				clk_pulse => clk_pulse,
				Amp_select => Amp_select_signal,
				wave_select => wave_select,
				PWM_OUT => PWM_OUT
				);
                  
Clockdivider: 	clock_divider
		port map(
			clk  => clk,
           reset => reset,
           enable => '1',		   
		   freq_select => Freq_select,
		   pulse_out => clk_pulse
           );
freqcounter:	Freq_select_counter
		port map(
			clk => clk,
			reset => reset,
			up => Frequp_signal,
			down => Freqdown_signal,
			value => freq_select
			);
AMPcounter:	Amp_select_counter
		port map(
			clk => clk,
			reset => reset,
			up => Ampup_signal,
			down => Ampdown_signal,
			value => Amp_select_signal
			);
Freq_up_button: buttonpulse
		port map (
		clk => clk,
		reset => reset,
		input => Frequp,
		output_pulse => Frequp_signal
		);
Freq_down_button: buttonpulse
		port map (
		clk => clk,
		reset => reset,
		input => Freqdown,
		output_pulse => Freqdown_signal
		);
		
Amp_down_button: buttonpulse
		port map (
		clk => clk,
		reset => reset,
		input => Ampdown,
		output_pulse => Ampdown_signal
		);

Amp_up_button: buttonpulse
		port map (
		clk => clk,
		reset => reset,
		input => Ampup,
		output_pulse => Ampup_signal
		);

PWMout <= PWM_OUT;
                  				  
   
ave :    averager
         port map(
                  clk       => clk,
                  reset     => reset,
                  Din       => q_outputs_2,
                  EN        => response_valid_out_i3(0),
                  Q         => Q_temp1
                  );
   
sync1 : registers 
        generic map(bits => 12)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => ADC_read,
                 q_outputs => q_outputs_1
                );

sync2 : registers 
        generic map(bits => 12)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => q_outputs_1,
                 q_outputs => q_outputs_2
                );
                
sync3 : registers
        generic map(bits => 1)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => response_valid_out_i1,
                 q_outputs => response_valid_out_i2
                );

sync4 : registers
        generic map(bits => 1)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => response_valid_out_i2,
                 q_outputs => response_valid_out_i3
                );                
                
SevenSegment_ins: SevenSegment  
                  PORT MAP( Num_Hex0 => Num_Hex0,
                            Num_Hex1 => Num_Hex1,
                            Num_Hex2 => Num_Hex2,
                            Num_Hex3 => Num_Hex3,
                            Num_Hex4 => Num_Hex4,
                            Num_Hex5 => Num_Hex5,
                            Hex0     => Hex0,
                            Hex1     => Hex1,
                            Hex2     => Hex2,
                            Hex3     => Hex3,
                            Hex4     => Hex4,
                            Hex5     => Hex5,
                            DP_in    => DP_in
                          );
                                     
ADC_Conversion_ins:  ADC_Conversion  PORT MAP(      
                                     MAX10_CLK1_50       => clk,
                                     response_valid_out  => response_valid_out_i1(0),
                                     ADC_out             => ADC_read);
									 
voltage2distance_ins: voltage2distance PORT MAP(
										clk            => clk,                                
										reset          => reset,                               
										voltage        => voltage,                           
										distance       => distance_signal 
										);

mux_ins			 :	Mux PORT MAP (
								input1 => distance_signal,
								input2 => voltage,
								S => MUXSELECT,
								MUXOUT => MUXOUT
								);


 
LEDR(9 downto 0) <=Q_temp1(11 downto 2); -- gives visual display of upper binary bits to the LEDs on board

-- in line below, can change the scaling factor (i.e. 2500), to calibrate the voltage reading to a reference voltmeter
voltage <= std_logic_vector(resize(unsigned(Q_temp1)*2500*2/4096,voltage'length));  -- Converting ADC_read a 12 bit binary to voltage readable numbers



binary_bcd_ins: binary_bcd                               
   PORT MAP(
      clk      => clk,                          
      reset    => reset,                                 
      ena      => '1',                           
      binary   => MUXOUT,    
      busy     => busy,                         
      bcd      => bcd         
      );
end Behavioral;