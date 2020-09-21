
package MyFsmPack1 is
  type fsm_state1 is (idle,data_accept,compute_data);
end MyFsmPack1;
---------------------------------------------------------------

---------------------------------------------------------------
library work;
use work.MyFsmPack1.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;


entity gcdsin1 is
port(clk : in bit:='1';
reset:in bit;
din: in bit_vector(15 downto 0);
dout: out bit_vector(15 downto 0);
start: in bit;
done: out bit;
erdy: in bit;
srdy: out bit
);
end entity; 
architecture Behave of gcdsin1 is           --- declaring signals which are coming from divider as well as internal signals
	signal start2,chksrdy,newinputs,flag1 : bit;
	signal errorr,e,s : bit:='0';	
	signal state_sig1: fsm_state1; 
	--signal count,countgcd: integer:=0;
	signal cc:bit:='0';
	signal input_ready: bit;
    signal output_accept : bit:='0';
    signal divider_ready: bit :='1';
	signal output_ready: bit;
	signal dividend: bit_vector(15 downto 0);
	signal divisor : bit_vector(15 downto 0);
	signal quotient : bit_vector(15 downto 0);
	signal remainder : bit_vector(15 downto 0);	
	signal ip1,ip2,ip3,ip4,ip5,ip6,ip7,ip8: bit_vector(15 downto 0);

	component dividerrr    ---calling divider and assigning it as a component
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
		 errorr : out bit
		 );
end component;
begin
 process
 variable county,countgcd,count: integer:=0;  --count is for counting the input numbers and coutgcd is for computation process
begin
wait until clk='1';  --wait until edge trigger comes
if reset='0'then   -- if reset is 0 then start the system
if e='1' then   --e is the internal flag which when set starts serially inputing the data and setting it to the registers
	if count=0 then
	ip1<=din;
	s<='1';   ---s is an internal flag setting it indicating it as data has arrived
	count:=count+1;	--increment count
	elsif count=1 then
	ip2<=din;
	s<='1';
	count:=count+1;	
	elsif count=2 then 
	ip3<=din;
	s<='1';
count:=count+1;	
	elsif count=3 then
	ip4<=din;
	s<='1';
count:=count+1;	
	elsif count=4 then
	ip5<=din;
	s<='1';
count:=count+1;	
	elsif count=5 then
	ip6<=din;
	s<='1';
count:=count+1;	
	elsif count=6 then
	ip7<=din;
	s<='1';
count:=count+1;	
	elsif count=7 then
	ip8<=din;
	s<='0';   ---once all the input comes set s to 0 saying that all the data has come
count:=count+1;	
	end if;

	
	
end if;
	if count=8  then   ---if count is 8 it indicates that now the data inputing has to be haulted
	s<='0';   -- set s flag 0 
		start2<='1';  --set start2 1 which is internal flag to say that now computation can begin
		count:=0;   --set the count to 0 to restart the counting for next set of inputs when appropriate signal comes
	else
		start2<='0';   
	end if;

if start='1' then   -- start = 1 indicates that now the computation can begin
start2<='1';  -- set start2 internal flag to 1 
flag1<='0';    --- set internal flag1 to 0 
	wait until clk='1';  --wait till positive edge trigger clk
	output_accept<='0';  -- make output accept 0 for divider handshake
	 if(divider_ready='1')then    --if divider ready is 1 then set input ready 1 saying divider is ready for inputs
		input_ready<='1';  --toggle the input ready after clks for continuous computation
		wait until clk='1';
		input_ready<='0';
			
		if countgcd<=6 then	  ---a counter countgcd is set to monitor no of elements counted so far
		if (Remainder="0000000000000000") then   ---if remainder is 0 then enter the loop
					---if input 1 is greater then input 2 then the greater is set as dividend and smaller as denominator
					---divide them. If remainder is 0 set ip1 as the previous divisor and new number as ip2.again check the greater condition and keep dividing till remainder is not equal to 0.
						if countgcd=0 then
							if ip1>ip2 then
								dividend<=ip1;
								divisor<=ip2;
							elsif ip1<=ip2 then 
								dividend<=ip2;
								divisor<=ip1;
							end if;
							countgcd:=countgcd+1;
							elsif countgcd=1 then
								ip1<=ip3;
								ip2<=divisor;
								if ip1>ip2 then
									dividend<=ip1;
									divisor<=ip2;
								elsif ip1<=ip2 then 
									dividend<=ip2;
									divisor<=ip1;
								end if;			
							countgcd:=countgcd+1;	
							elsif countgcd=2 then
								ip1<=ip4;
								ip2<=divisor;
								if ip1>ip2 then
									dividend<=ip1;
									divisor<=ip2;
								elsif ip1<=ip2 then 
									dividend<=ip2;
									divisor<=ip1;
								end if;
							countgcd:=countgcd+1;
							elsif countgcd=3 then
								ip1<=ip5;
								ip2<=divisor;
								if ip1>ip2 then
									dividend<=ip1;
									divisor<=ip2;
								elsif ip1<=ip2 then 
									dividend<=ip2;
									divisor<=ip1;
								end if;
							countgcd:=countgcd+1;
							elsif countgcd=4 then
								ip1<=ip6;
								ip2<=divisor;
								if ip1>ip2 then
									dividend<=ip1;
									divisor<=ip2;
								elsif ip1<=ip2 then 
									dividend<=ip2;
									divisor<=ip1;
								end if;
							countgcd:=countgcd+1;
							elsif countgcd=5 then
								ip1<=ip7;
								ip2<=divisor;
								if ip1>ip2 then
									dividend<=ip1;
									divisor<=ip2;
								elsif ip1<=ip2 then 
									dividend<=ip2;
									divisor<=ip1;
								end if;
							countgcd:=countgcd+1;
							elsif countgcd=6 then
								ip1<=ip8;
								ip2<=divisor;
								if ip1>ip2 then
									dividend<=ip1;
									divisor<=ip2;
								elsif ip1<=ip2 then 
									dividend<=ip2;
									divisor<=ip1;
								end if;
							countgcd:=countgcd+1;
							
					--else 
					--	flag1<='1';
					----	dout<=divisor;
					--	countgcd<=0;	
					end if;--when remainder is finite set the remainder as divisor and the new number as dividend.again continue the same process till all the numbers are covered.	
					elsif (Remainder/="0000000000000000") then
					dividend<=divisor;
					divisor<=Remainder;
					end if;
			wait until output_ready='1';---again check for the output ready handshake of divider to check if the division has completed
		output_accept<='1';
		wait until clk='1';
		wait until clk='1';
		output_accept<='0';		
		
		
		end if;	
		if countgcd>6 then   ---if all the numbers are covered set internal flag1 1 and toggle it to synchonize continuous operation
		flag1<='1';
		wait until clk='1';
		flag1<='0';  --once the flag is set 0 it signals completion of operation and the divisor is the final GCD
		dout<=divisor;
		
		countgcd:=0;
		end if;
			if (divider_ready='1') then   ---check the handshake of divider ready to see if it is ready to accept new data
							input_ready<='1';
							if  clk='1' then	
							input_ready<='0';
							end if;
			end if;	
	end if;
end if;
end if	;	
end process;  
------------------------------------------------------------------------------------------------------------	
									-----------Control Path-------------------
process(clk)
  variable nstate1: fsm_state1;
begin
   nstate1 := state_sig1;
   case state_sig1 is
		when idle =>     -- when in idle state initial it sets srdy =1
				srdy<='1'; ----when srdy =1 then if erdy =0 then set the internal e flag 1
			if erdy='0' then  --when this condition is satisfied then go to data accept to accept data
				e<='0';
				nstate1:=data_accept;
			end if;			
	    when data_accept =>
			 if erdy='1' then   ---now see if erdy is 1.if its 1 then set e flag 1 to start accepting data from environment
				e<='1';
				if s='1' then  --when data is accepted internal flag s is set hence setting srdy =1
					srdy<='1';							
				end if;
			elsif erdy='0' then  ---if erdy =0 it indicates no data to send.
			e<='0';
				if start2='1' then  --start2 is internal signal to signal that now computation can start
					if start='1' then  --now start is checked .If its 1 then e=0 saying no data is accepted as computation in process
					e<='0';
					nstate1:=compute_data;  ---go to compute state
					end if;
				end if;			  
			 end if;
		when compute_data =>
		   --after computation is complete set flag1 =1 saying that computation is complete with the help of flag done=1
			srdy<='0'; 
			if flag1='1' then
			done<='1';
			
			nstate1:=idle;---go to idle state after all the operation is completed
			
			if clk='1' then
			done<='0';
			e<='1';
			end if;
			srdy<='1';  ---set srdy =1 to restart next set of inputs
			end if;	
						
   end case;           
   if(clk'event and clk = '1') then
     if(reset='1') then
       state_sig1 <= idle;
     else
       state_sig1 <= nstate1;
     end if;
   end if;
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

