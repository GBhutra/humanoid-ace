#include<avr/io.h>
#include<util/delay.h>
#include<xslcd.h>
#include <avr/interrupt.h>

void USARTInit(uint16_t);
char USARTReadChar(void);
void USARTWriteChar(char);

void USARTInit(uint16_t ubrr_value)
{
 UBRRL = ubrr_value;
 UBRRH = (ubrr_value>>8);
 UCSRC=(1<<URSEL)|(3<<UCSZ0);
 UCSRB=(1<<RXEN)|(1<<TXEN);
}

char USARTReadChar(void)
{
 while(!(UCSRA & (1<<RXC)));
 return UDR;
}

void USARTWriteChar(char data)
{
 while(!(UCSRA & (1<<UDRE)));
 UDR=data;
}


int main(void)
{
 unsigned char data;
 unsigned char add1,add2;
 unsigned char vl,vh,value;
 TCCR1A|=(1<<COM1A1)|(1<<COM1B1)|(1<<WGM11);        
 TCCR1B|=(1<<WGM13)|(1<<WGM12)|(1<<CS11)|(1<<CS10); 
 ICR1=2499; 
 value = 0x00;
 InitLCD();
 USARTInit(51);
 LCDClear();
 LCDWriteStringXY(0,0,"Initialising...");
 _delay_ms(160);
 
 DDRD|=(1<<PD4)|(1<<PD5);
 while(1)
 {
  LCDClear();
  LCDWriteStringXY(0,0,"La1=");
  LCDWriteStringXY(0,1,"La3=");
  data = USARTReadChar();
  _delay_ms(100);
  add1 = data & 0xf0;

  switch (add1)
  {
   case 0x00:
   vl = data & 0x0f;
   data = USARTReadChar();
   add2 = data & 0xf0;
   if (add2 == 0x80)
	{
	 vh = data<<4;
	 value =  vl | vh;
	 if (value >= 5 && value <= 170)
	 {
	  OCR1A = 58+(1.55*value);
	  LCDWriteIntXY(5,0,value,3);
     }
	 else 
	 LCDWriteStringXY(5,0,"invalid angle");
	 break;
    }
   else 
   break;
   break;
  
   case 0x10:
   vl = data & 0x0f;
   data = USARTReadChar();
   add2 = data & 0xf0;
   if (add2 == 0x90)
	{
	 vh = data<<4;
	 value =  vl | vh;
	 if (value >= 64 && value <= 170)
     {
      OCR1B = 58+(1.55*value);
	  LCDWriteIntXY(5,1,value,3);
     }
	 else
	 LCDWriteStringXY(4,1,"invalid angle");
	 break;
    }
   else 
   break;
   break;
   default:
   add1 = 0xff;
  }
 }
 return 1;
}
