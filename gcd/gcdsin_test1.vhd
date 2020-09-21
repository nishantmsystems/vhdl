library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_bit.all;


entity gcdsin_test1 is
end entity; 
architecture Behave of gcdsin_test1 is
	signal clk :  bit:='1';
	signal reset:bit:='0';
	signal din: bit_vector(15 downto 0);
	signal dout : bit_vector(15 downto 0);
	signal start: bit;
    signal done : bit;
    signal erdy: bit;
	signal srdy: bit;
	
component gcdsin1
    port( 	clk : in bit;
			reset:in bit;
			din: in bit_vector(15 downto 0);
			dout: out bit_vector(15 downto 0);
			start: in bit;
			done: out bit;
			erdy: in bit;
			srdy: out bit);
end component;


begin
process
begin
clk<=not clk;
wait for 5 ns;
end process;
 process 
	file vector_file: text is in "testvectorsgcd.txt";
    variable err_flag : boolean := false;
	variable aa,bb,cc,dd,ee,ff,gg,hh,rr:integer;
	variable gcd1:bit_vector(15 downto 0);
	variable L:line;
	variable space:character;
	begin 
	wait until clk='1';
	reset<='1';

if done='0' then
		start<='0';
end if;		
	wait until clk='1';
		reset<='0';
		wait until clk='1';
		wait until clk='1';
		wait until clk='1';		
		erdy<='0';   -- make erdy 0 
		while not endfile(vector_file) loop	
		wait until clk='1';
		reset<='0';
		readline(vector_file,L);
		read (L,aa);
		if srdy='1' then   --if srdy is 1 indicate that it is ready to take data
		din<=bit_VECTOR(to_unsigned(aa,din'length));
		end if;
		erdy<='1';  --indicate that data has been sent
		wait until clk='1';
		read (L,bb);
		if srdy='1' then
		din<= bit_vector(to_unsigned(bb,din'length));
		end if;
		erdy<='1';
		wait until clk='1';
		read (L,cc);
		if srdy='1' then
		din<= bit_vector(to_unsigned(cc,din'length));
		end if;
		erdy<='1';
		wait until clk='1';
		read (L,dd);
		if srdy='1' then
		din<= bit_vector(to_unsigned(dd,din'length));
		end if;
		erdy<='1';
		wait until clk='1';
		read (L,ee);
		if srdy='1' then
		din<= bit_vector(to_unsigned(ee,din'length));
		end if;
		erdy<='1';
		wait until clk='1';
		read (L,ff);
		if srdy='1' then
		din<= bit_vector(to_unsigned(ff,din'length));
		end if;
		erdy<='1';
		wait until clk='1';
		read (L,gg);
		if srdy='1' then
		din<= bit_vector(to_unsigned(gg,din'length));
		end if;
		erdy<='1';
		wait until clk='1';
		read (L,hh);
		if srdy='1' then
		din<= bit_vector(to_unsigned(hh,din'length));
		erdy<='0';  ---once all the input comes erdy=0
		end if;

		wait until clk='1';
		start<='1';    --when all the input comes assign start =1 indicating computation start
		wait until clk='1';
		erdy<='0';
		
		
		read (L,rr);
		wait until srdy='0' ;
	
		gcd1:= bit_vector(to_unsigned(rr,din'length));
			wait until done='1';  --once the computation is complete indicate done =1 
		start<='0';

		wait until clk='1';
	--	wait until clk='1';
	--	start<='0';
erdy<='1';
		--end if;	
end loop;
-----------------------------------------------------------------------------------------------------------------------------------------	
		wait for 20 ns;
		assert(dout = gcd1)
		report "Error in gcd." severity failure;
		
    assert false report "************Test Completed.****************" severity note;
  wait;
  end process;  
  dut: gcdsin1 
     port map(clk=>clk,
		 reset=> reset,
		 din=>din,
         dout=>dout,
         start=>start,
		 done=>done,
		 erdy=>erdy,
		srdy=>srdy);
	
end Behave;

