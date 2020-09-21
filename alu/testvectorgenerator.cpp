
#include<stdio.h>
#include<conio.h>
using namespace std;

#include<stdio.h>
 
int main() {
   unsigned char i = 0,j=0,k=0,l=0,m=0,n=0,o=0;
   
 
   for (i = 0; i <= 256; i++)
    {
   		for(j=0;j<=256;j++)
		   {
   		   
	     		 k=i+j;
	      
	     		 printf("%d         %d         %d      %d      \n", o,i,j,k);
     	 		 if(j==255)
				   {
    					break;
				   }	  
    		}
 				if(i==255)
				 {
    				break;
				 }
   }
   
   
      
	o=1;
    for (i = 0; i <= 256; i++) 
	{
   		for(j=0;j<=256;j++)
		   {
   				l=i-j;
	     
	      		printf("%d         %d         %d      %d      \n", o,i,j,l);
     	 		if(j==255)
				  {
    				break;
				  }  
     	  
    	   }
 	if(i==255)
	 {
    	break;
	 }
   }

    o=2;
    for (i = 0; i <= 255; i++)
	 {
   		for(j=0;j<=255;j++)
		   {
   		   	if(i<=8)
			  {
			  	m= j << i ;
		      }
 		   else
 			 {
 			 	m=0;
			  }
	    
	      printf("%d         %d         %d      %u      \n", o,j,i,m);
     	   if(j==255)
			{
    			break;
			}  
   		  }
 		if(i==255)
		 {
    	break;
		}  
   } 
   
   
    o=3;
    for (i = 0; i <= 255; i++)
	 {
   		for(j=0;j<=255;j++)
		   {
   		   		if(i<=8)
				{
			  
					m= j >> i ;
				}
 			   else
 			   {
  					m=0;
  				}
	    
	      printf("%d         %d         %d      %u      \n", o,j,i,m);
     	   if(j==255)
			{
    			break;
			}  
   		 }
 		if(i==255)
		 {
    		break;
		}  
   }
   
   
   return (0);
   
}
