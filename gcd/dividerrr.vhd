

package MyFsmPack is
  type fsm_state is (idle,compute,waitt);
end MyFsmPack;
---------------------------------------------------------------

---------------------------------------------------------------
library work;
use work.MyFsmPack.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;
-----------------------------------------------------------------
entity dividerrr is 
   port (clk : in bit;
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
  end entity;
  -------------------------------------------------------
architecture Behave of dividerrr is
 function to_unsigned  ( p : BIT_VECTOR) return unsigned is
        alias j: BIT_VECTOR ( p'length-1 downto 0 ) is p;
        variable temp7 : unsigned ( p'length-1 downto 0 );
    begin
        for l in temp7'range loop
            case j(l) is
                when '0' => temp7(l) := '0';
                when '1' => temp7(l) := '1';
            end case;
        end loop;
        return temp7;
    end;
------------------------------------------------------------------------------------------------------------------------------
function To_bitvector ( w : unsigned ; hh : BIT := '0') return bit_vector is  --- Function for bit_vector to overcome absence of ieee.std_logic_1164.all
        alias uu: unsigned ( w'length-1 downto 0 ) is w;
        variable temp7 : bit_vector ( w'length-1 downto 0 );
    begin
        for y in temp7'range loop
            case uu(y) is
                when '0'  => temp7(y) := '0';
                when '1' => temp7(y) := '1';
                when others => temp7(y) := hh;
            end case;
        end loop;
        return temp7;
    end;
-------------------------------------------------------------------------------------------------------------------------------
 signal state_sig: fsm_state; 
 signal done,c : bit;
begin
process(c,divisor,dividend)
		variable N,Q,R:unsigned (15 downto 0) ;
		variable D: unsigned(15 downto 0) ;
		variable i:integer;
begin
---------------------------------------------------------------------------------------------------------------
N := (to_unsigned(dividend));
D := (to_unsigned(divisor));

--------------------------------------------------------------------------------------------------
Q := "0000000000000000";                 -- initialize quotient and remainder to zero
R := "0000000000000000" ;  
   
if(c='1')then 
	if (divisor ="0000000000000000") then 
		errorr <= '1';
		quotient<="0000000000000000";
		remainder<="0000000000000000";
		
	else
		errorr<='0';          
		for i in 15 downto 0 loop    -- where n is number of bits in N
		R := R sll 1;          -- left-shift R by 1 bit
		R(0) := N(i);         -- set the least-significant bit of R equal to bit i of the numerator
			if (R >= D) then
				R := R - D;
				Q(i) := '1';
				
				
			end if;			
		end loop;
		
			remainder<=to_bitvector(R);
			quotient<=to_bitvector(Q);
				done<='1';
	end if;
	done<='1';
end if;
end process;
-----------------------------------------------------------------------------------------------------------------------
process(done,clk,state_sig)
   variable nstate: fsm_state;
begin
   nstate := state_sig;
   case state_sig is
     when  idle =>
		divider_ready<='1';	 
       if(input_ready='1') then
			c<='1';
			nstate := compute;
		elsif (input_ready='0')then
			nstate:=idle;				
	   end if;
     when compute =>
        divider_ready<='0';
	   if(done = '1') then
         nstate := waitt;
		 output_ready<='1';
       end if;
     when waitt =>
       if(output_accept='1') then
	   divider_ready<='1';
	   output_ready<='0';
		 nstate := idle;
       end if;
   end case;           
   if(clk'event and clk = '1') then
     if(reset='1') then
       state_sig <= idle;
     else
       state_sig <= nstate;
     end if;
   end if;
         
end process;
end Behave;


