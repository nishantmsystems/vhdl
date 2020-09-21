
library work;
use work.MyFsmPack.all;
entity FSM_PARITY_SEQUENCE_TEST is

end entity;


architecture Behave of FSM_PARITY_SEQUENCE_TEST  is
  signal X: input_symbol;
  signal Y: output_symbol;
  signal clk: bit := '0';

  type InputVector is array (natural range <>) of input_symbol;
  type OutputVector is array (natural range <>) of output_symbol;

  constant input_trace: InputVector(0 to 26) := (0 => reset, 1 => p, 2 => p, 3 => q, 4 =>q,5=>q,6=>p,7=>q,8=>reset,9=>p,10=>p,11=>p,12=>q,13=>reset,14=>q,15=>p,16=>p,17=>q,18=>q,19=>reset,20=>p,21=>p,22=>q,23=>q,24=>q,25=>q,26=>p);
  constant output_trace: OutputVector(0 to 26) := (0 => N, 1 => N, 2 => N, 3 => N, 4 => M,5=>N,6=>N,7=>N,8=>N,9=>N,10=>N,11=>N,12=>N,13=>N,14=>N,15=>N,16=>N,17=>N,18=>N,19=>N,20=>N,21=>N,22=>N,23=>M,24=>N,25=>M,26=>N);
begin
  clk <= not clk after 5 ns;
  dut: fsm_for_parity port map(X =>X , Y => Y, clk => clk);


  process
  begin 
	for I in 0 to 26 loop
		X <= input_trace(I);
		wait for 1 ns;
		assert (Y = output_trace(I)) report 
				"output-mismatch"
				severity error;

		wait until clk = '1';
        end loop;
	
	assert false report "test-over." severity note;
	wait;
  end process;
  
end Behave;
