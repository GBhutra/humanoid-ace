#include<avr/io.h>
#include<util/delay.h>
#include<xslcd.h>
#include <avr/interrupt.h>

void USARTInit(uint16_t);
char USARTReadChar(void);
void USARTWriteChar(char);
void wait(void);
void forward(void);
void left(void);
void right(void);
void stop(void);
void backward(void);

void forward(void)
{
 PORTB = 0x40;
 PORTD = 0x20;
 LCDWriteStringXY(0,0,">> forward <<");
}

void left(void)
{
 PORTB = 0x40;
 PORTD = 0x10;
 LCDWriteStringXY(0,0,">>   left  <<<");
}

void right(void)
{
 PORTB = 0x80;
 PORTD = 0x20;
 LCDWriteStringXY(0,0,">>  right  <<<");
}

void stop(void)
{
 PORTB = 0x00;
 PORTD = 0x00;
 LCDWriteStringXY(0,0,">>>  stop  <<<");
}

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

void Wait()
{
 uint8_t i;
 for(i=0;i<50;i++)
 {
  _delay_loop_2(0);
  _delay_loop_2(0);
  _delay_loop_2(0);
 }
}


int main(void)
{
 DDRD = 0xfe;
 DDRB = 0xff;
 unsigned char data;
 unsigned char add1,add2;
 unsigned char vl,vh,value;
 value = 0x00;
 InitLCD();
 USARTInit(51);
 LCDClear();
 LCDWriteStringXY(0,0,"Initialising...");
 _delay_ms(160);
 LCDClear();
 // LCDWriteStringXY(0,0,"M7=");
 // LCDWriteStringXY(0,1,"M8=");
 DDRD|=(1<<PD4)|(1<<PD5);
 while(1)
 {
  data = USARTReadChar();
  _delay_ms(100);
  add1 = data & 0xf0;

  switch (add1)
  {
   case 0x60:
   vl = data & 0x0f;
   data = USARTReadChar();
   add2 = data & 0xf0;
   if (add2 == 0xe0)
	{
	 vh = data<<4;
	 value =  vl | vh;
	 switch (value)
     {
       case 1:
       forward();
	   _delay_ms(50);
	   stop();
	   _delay_ms(50);
	   break;
	   case 2:
	   right();
	   _delay_ms(50);
	   stop();
	   _delay_ms(50);
	   break;
       case 3:
	   left();
       _delay_ms(50);
	   stop();
	   _delay_ms(50);
	   break;
	   default:
	   stop();
	   break;
     }
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
 




