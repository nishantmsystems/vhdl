library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_bit.all;


entity dividerr_test is
end entity; 
architecture Behave of dividerr_test is      --- ports from the divider dut are made signals for testing
	signal clk :  bit:='1';
	signal reset:bit:='1';
	signal input_ready: bit;
    signal output_accept : bit:='0';
    signal divider_ready: bit :='1';
	signal output_ready: bit;
	signal dividend: bit_vector(15 downto 0):="0000000000000000";
	signal divisor : bit_vector(15 downto 0):="0000000000000000";
	signal quotient : bit_vector(15 downto 0):="0000000000000000";
	signal remainder : bit_vector(15 downto 0):="0000000000000000";
	signal errorr : bit:='0';	  
component dividerrr    -- divider component
    port( clk : in bit;
		 reset:in bit;
		 input_ready: in bit;
         output_accept :in bit;
         divider_ready: out bit;
		 output_ready:out bit;
		 dividend: in bit_vector(15 downto 0);
		 divisor : in bit_vector(15 downto 0);
	     quotient : out bit_vector(15 downto 0);
		 remainder : out bit_vector(15 downto 0);
		 errorr : out bit);
end component;

begin
process
begin
clk<=not clk;
wait for 5 ns;
end process;
 process 
	file vector_file: text is in "testvectors.txt";      ---file containing test vectors
    variable err_flag : boolean := false;     ---- error_flag variable to set the flag for error check
	variable xx,yy,rr,qq:integer;
	variable remainder1,quotient1:bit_vector(15 downto 0);
	variable L:line;
	variable space:character;
	begin 
	wait until clk='1';     ----wait until positive edge trigger is coming
	output_accept<='0';   --Once the clk comes make output accept 0 
	 if(divider_ready='1')then   --- when divider ready is 1 then make reset 0 to start the process.
		reset<='0';
		input_ready<='1'; -- make input_ready high indicating that the environment is ready to give the inputs sets
		wait until clk='1';  ---wait till positive edge trigger
		input_ready<='0';   ---make input ready 0 to toggle input ready
	while not endfile(vector_file) loop  ---while file doesnt end 
	
		readline(vector_file,L);    --read the number of column and assign it to L storing it to a vector file
		read (L,xx);       --read the first column
		divisor<=bit_VECTOR(to_unsigned(xx,divisor'length));
		read (L,yy);         --read the second column
		dividend<= bit_vector(to_unsigned(yy,dividend'length));
	---D  N  R Q--- This is the sequence of test vector table
	wait until output_ready='1';  ---once the input is recieved it waits till the computation is completed.Once the computation is completed it sets output ready 1
		output_accept<='1';  -- once output ready is 1 it sends to the environment.The environment if ready accepts the output and sets output accept=1
		wait until clk='1';
		wait until clk='1';
		output_accept<='0';   ---once the output is accepted make output_accept 0
		read (L,rr);     --- read remainder from file
		remainder1:= bit_vector(to_unsigned(rr,remainder'length));
		read (L,qq);    --read quotient from file
		quotient1:= bit_vector(to_unsigned(qq,quotient'length));
	
	wait for 10 ns;
		assert(remainder = remainder1)   --if the remainder from file matches with the remainder calculated from the system assert success else assert failure
		report "Error in remainder." severity failure;
		assert(quotient=quotient1)
		report "Error in quotient." severity failure;
if (divider_ready='1') then    --- if divider_ready is 1 then set input ready to 1 and then 0 toggle to say that now its full with previous computation
--wait until clk='1';
input_ready<='1';
wait until clk='1';
input_ready<='0';
end if;
		end loop;
	end if;
   assert false report "************Test Completed.****************" severity note;
wait;
  end process;  

  dut: dividerrr 
     port map( clk =>clk,
		 reset=> reset,
		 input_ready=>input_ready,
         output_accept=>output_accept,
         divider_ready=>divider_ready,
		 output_ready=>output_ready,
		dividend=>dividend,
		divisor=>divisor,
		quotient=>quotient,
		remainder=>remainder,
		errorr=>errorr);
end Behave;

