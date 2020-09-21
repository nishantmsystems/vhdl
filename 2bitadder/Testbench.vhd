entity Testbench is
end entity;
architecture Behave of Testbench is
  signal x0,x1,y0,y1,s0,s1: bit := '0';
  component TwoBitAdder 
    port(x0,x1,y0,y1: in bit; s0,s1: out bit);
  end component;

  type InputVecArray is array (natural range <>) of bit_vector(1 downto 0);
  constant xInputVectors: InputVecArray(0 to 3) :=
	( 0 => ('0','0'), 1 => ('0','1'), 2 => ('1','0'), 3 => ('1','1'));
  constant yInputVectors: InputVecArray(0 to 3) :=
	( 0 => ('0','0'), 1 => ('0','1'), 2 => ('1','0'), 3 => ('1','1'));
begin
  process 
    variable err_flag : boolean := false;
  begin
    
    for I in 0 to 3 loop

	x0 <= xInputVectors(I)(0);
	x1 <= xInputVectors(I)(1);

      for J in 0 to 3 loop

	  y0 <= yInputVectors(J)(0);
	  y1 <= yInputVectors(J)(1);
 
          wait for 5 ns;

	  assert (s0 = (x0 xor y0)) 
                 report "sum-bit-0 error." severity error;
          assert (s1 = ((x0 and y0) xor x1 xor y1)) 
                 report "sum-bit-1 error." severity error;

      end loop;
    end loop;

    assert false report "test completed." severity note;
    wait;
  end process;

  dut: TwoBitAdder 
     port map(x0 => x0,
              x1 => x1,
              y0 => y0,
              y1 => y1,
              s0 => s0,
              s1 => s1);

end Behave;

