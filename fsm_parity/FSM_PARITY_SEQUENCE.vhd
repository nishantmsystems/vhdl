package MyFsmPack is
  type fsm_state is (A, B, C, D, E,F);
  type input_symbol is (reset, P,Q);
  type output_symbol is (M,N);
---------------------------------------------------------------
component fsm_for_parity is 
   port (X: in input_symbol;
           Y: out output_symbol;
          clk: in bit);
  end component;
end MyFsmPack;
---------------------------------------------------------------
library work;
use work.MyFsmPack.all;
entity fsm_for_parity is 
  port (X: in input_symbol;
        Y: out output_symbol;
        clk: in bit);
end entity fsm_for_parity;
-----------------------------------------------------------------
architecture Behave of fsm_for_parity is
  signal state_sig: fsm_state; 
begin
process(X,clk,state_sig)
   variable nstate: fsm_state;
   variable vY: output_symbol;
begin
   
   nstate := state_sig;
   vY := N;

   case state_sig is
     when  A => 
       if(X = p) then
         nstate := B;
		 elsif(X=q) then
		 nstate:=F;
		 end if;
     when B =>
       if(X = p) then
         nstate := C;
       elsif (X = q) then
         nstate := F;
       end if;
     when C =>
       if(X = q) then
         nstate := D;
       elsif (X=p) then
         nstate := B;
       end if;
     when D =>
       if(X = q) then
         nstate := E;
		 vY := M;
       elsif (X=p) then
         nstate := F;
       end if;
     when E =>
         if(X = q) then
           nstate := D;
         elsif (X = p) then
           nstate := F;
         end if;
		 
	when F=>
		if (X=p) then
		  nstate := F;
		elsif (X=q) then
		  nstate :=F;
		end if;
   end case;          

 
   if(X = reset) then
     Y <= N;
	
   else
     Y <= vY;
   end if;

   if(clk'event and clk = '1') then
     if(X = reset) then
       state_sig <= A;
     else
       state_sig <= nstate;
     end if;
   end if;
         
end process;
end Behave;


