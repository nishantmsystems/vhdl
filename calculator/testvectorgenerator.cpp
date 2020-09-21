
#include<stdio.h>
#include<conio.h>
using namespace std;

#include<stdio.h>
 
int main() {
   unsigned char i = 0,j=0,k=0,l=0,m=0,n=0,o=13,p,g;
    
   for (i = 0; i <= 9; i++)
    {
   		for(j=0;j<=9;j++)
		   {
   		   
	     		 k=i+j;
	      
	     		 printf("%d         %d         %d      %d      \n",i ,o,j,k);
     	 		 if(j==9)
				   {
    					break;
				   }	  
    		}
 				if(i==9)
				 {
    				break;
				 }
   }
   
   
      
	o=14;
   for (i = 0; i <= 9; i++) 
	{
  		for(j=0;j<=9;j++)
		  		  		   {
		  		  		   	if(i>=j)
		  		  		   	{
								   
   				l=i-j;
   			}
	else 
	{
	l=i-j;
	l=(15+l)+1;
	}
	      		 printf("%d         %d         %d      %d      \n",i ,o,j,l);
    	 		if(j==9)
				  {
    				break;
				  }  
     	  
    	   }
 	if(i==9)
	 {
    	break;
	 }
	   }
	   

//
     
	o=12;
   for (i = 0; i <= 9; i++) 
	{
  		for(j=0;j<=9;j++)
		  		  		   {
		
   				l=i*j;
	
	      		 printf("%d         %d         %d      %d      \n",i ,o,j,l);
    	 		if(j==9)
				  {
    				break;
				  }  
//     	  
    	   }
 	if(i==9)
	 {
    	break;
	 }
	   }
	o=15;
   for (i = 0; i <= 9; i++) 
	{
  		for(j=0;j<=9;j++)
		  		  		   {
		
		if(j!=0)
		if (i>=j)
		{
		
		{
	
   				l=i/j;
	
	      		 printf("%d         %d         %d      %d      \n",i ,o,j,l);
	      	}
	      }
    	 		if(j==9)
				  {
    				break;
				  }  
     	  
    	   }
 	if(i==9)
	 {
    	break;
	 }
}
   return (0);
   
}
