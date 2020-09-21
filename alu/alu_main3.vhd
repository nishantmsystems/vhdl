library ieee;
use ieee.numeric_bit.all;

entity alu_main3 is
    Port ( x,y : in  bit_vector (7 downto 0);
           z : out   bit_vector(7 downto 0);
           op_code : in   bit_vector(1 downto 0));
end alu_main3;
architecture Behavioral of alu_main3 is 
 function to_unsigned  ( p : BIT_VECTOR        ) return unsigned is
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
begin
process(op_code,x,y)
variable temp1,temp3: unsigned(7 downto 0);
variable temp2:integer;
variable xtemp,ytemp:unsigned(7 downto 0);
begin

xtemp:=to_unsigned(x);
ytemp:=to_unsigned(y);

if op_code<="00" then
temp1:=xtemp+ytemp;


elsif op_code<="01" then 
temp1:=xtemp-ytemp;


elsif op_code<="10" then
temp2:=to_integer(ytemp);
temp1:=xtemp sll temp2;

elsif op_code<="11" then
temp2:=to_integer(ytemp);
temp1:=xtemp srl temp2;

end if;

z<=to_bitvector(temp1);

end process;

end Behavioral;