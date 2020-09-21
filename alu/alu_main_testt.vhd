library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_bit.all;


entity alu_main_testt is
end entity; 
architecture Behave of alu_main_testt is
 
	  
	SIGNAL  x,y: bit_VECTOR(7 downto 0):="00000000";
	SIGNAL  z: bit_VECTOR(7 downto 0):="00000000";
	SIGNAL  op_code :bit_vector(1 downto 0):="00";
component alu_main3 
    port(  x,y : in  bit_vector (7 downto 0);
           z : out   bit_vector(7 downto 0);
           op_code : in   bit_vector(1 downto 0));
end component;

begin
  process 
  file vector_file: text is in "testvectors.txt";
    variable err_flag : boolean := false;
	variable xx,yy,zz,opp:integer;
	variable z1:bit_vector(7 downto 0);
	variable L:line;
	variable space:character;
  begin
  
while not endfile(vector_file) loop

readline(vector_file,L);

read (L,opp);
op_code<=bit_VECTOR(to_unsigned(opp,op_code'length));
read (L,xx);
x<= bit_vector(to_unsigned(xx,8));
read (L,yy);
y<= bit_vector(to_unsigned(yy,y'length));
read (L,zz);
z1:= bit_vector(to_unsigned(zz,z1'length));
wait for 5 ns;
assert(z = z1)
  report "Error in output." severity failure;
		
	end loop;
	

    assert false report "************Test Completed.Your Design is Tested for 256 combinations****************" severity note;
    wait;
  end process;  

  dut: alu_main3 
     port map( x=>x,
		y=>y,
		z=>z,
		op_code=>op_code);

end Behave;

