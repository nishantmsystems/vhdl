


entity PriorityEncoder1Test is
end entity; 
architecture Behave of PriorityEncoder1Test is
  
	  
	SIGNAL x: bit_VECTOR(7 downto 0):="00000000";
	SIGNAL s: bit_VECTOR(2 downto 0):="000";
	SIGNAL N :  bit :='0';
component PriorityEncoder1 
    port(x: IN bit_VECTOR(7 downto 0);
         s: OUT bit_VECTOR(2 downto 0);
         N: OUT bit);
end component;

  type InputArray is array (natural range <>) of bit_vector(1 downto 0);
  constant xInput: InputArray(0 to 3) :=
	( 0 => ('0','0'), 1 => ('0','1'), 2 => ('1','0'), 3 => ('1','1'));

begin
  process 
    variable err_flag : boolean := false;
  begin
    
    for A in 0 to 3 loop

	
	x(7) <= xInput(A)(1);
	x(6) <= xInput(A)(0);

	
      for B in 0 to 3 loop

	  
	  x(5) <= xInput(B)(1);
	  x(4) <= xInput(B)(0);

		for C in 0 to 3 loop
		
		
			x(3) <= xInput(C)(1);
			x(2) <= xInput(C)(0);
			
				for D in 0 to 3 loop
			
				x(1) <= xInput(D)(1);
				x(0) <= xInput(D)(0);
			wait for 1000 ns;

			
		assert (s(0) = ((x(1) and ( not(x(0)))) or (x(3) and (not(x(2))) and (not(x(1))) and (not(x(0)))) or (x(5) and (not(x(4))) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0)))) or (x(7) and (not(x(6))) and (not(x(5))) and (not(x(4))) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0))))))
        report "Error in S0." severity error;
		
		assert (s(1) =((x(2) and (not(x(1))) and (not(x(0)))) or (x(3) and (not(x(2))) and (not(x(1))) and (not(x(0)))) or (x(6) and (not(x(5)))and (not(x(4))) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0)))) or (x(7) and (not(x(6))) and (not(x(5)))and (not(x(4))) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0))))))
        report "Error in S1." severity error;
		
		assert (s(2) = ((x(5) and (not(x(4))) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0)))) or (x(4) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0)))) or (x(7) and (not(x(6))) and (not(x(5)))and (not(x(4))) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0)))) or (x(6) and (not(x(5)))and (not(x(4))) and (not(x(3))) and (not(x(2))) and (not(x(1))) and (not(x(0))))))
        report "Error in S2." severity error;
		
		assert (N = ((not(x(7))) and  (not(x(6))) and(not(x(5))) and (not(x(4))) and (not(x(3)))  and (not(x(2))) and (not(x(1))) and (not(x(0)))))
		report "Error in S2." severity error;		
			
				end loop;
			end loop;
		end loop;
	end loop;
	

    assert false report "************Test Completed.Your Design is Tested for 256 combinations****************" severity note;
    wait;
  end process;  

  dut: PriorityEncoder1 
     port map( x(7) => x(7),
		x(6) => x(6),
		x(5) => x(5),
		x(4)=> x(4), 
		 x(3)=> x(3),
		x(2)=> x(2),
		x(1) => x(1),
		x(0) => x(0), 
		s(2) => s(2),
		s(1) => s(1),
		s(0) => s(0),
		N => N);

end Behave;

