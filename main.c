
/* MAIN.C file */
#include "stm8s.h"
#include "stm8s_gpio.h"
#include "stm8s_clk.h"
#include "stm8s_tim4.h"
#include "smartpanel.h"

#ifdef _COSMIC_
#define ASM _asm
#endif
#ifdef _IAR_
#define ASM asm
#endif

/* This delay should be added just after reset to have access to SWIM pin
and to be able to reprogram the device after power on (otherwise the device
will be locked) */
#define STARTUP_SWIM_DELAY_5S \
{ \
	ASM(" PUSHW X \n" \
	" PUSH A \n" \
	" LDW X, #0xFFFF \n" \
	"loop1: LD A, #50 \n" \
	\
	"loop2: DEC A \n" \
	" JRNE loop2 \n" \
	\
	" DECW X \n" \
	" JRNE loop1 \n" \
	\
	" POP A \n" \
	" POPW X " ); \
}
/* not connected pins as output low state (the best EMC immunity)
(PA2, PB0, PB1, PB2, PB3, PB6, PB7, PC1, PC2, PC7, PD0, PD2, PD4, PD7, PE5,
PF4) */
#define CONFIG_UNUSED_PINS_STM8S001 \
{ \
	GPIOA->DDR |= GPIO_PIN_2; \
	GPIOB->DDR |= GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_3 | GPIO_PIN_6 | GPIO_PIN_7; \
	GPIOC->DDR |= GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_7; \
	GPIOD->DDR |= GPIO_PIN_0 | GPIO_PIN_2 | GPIO_PIN_4 | GPIO_PIN_7; \
	GPIOE->DDR |= GPIO_PIN_5; \
	GPIOF->DDR |= GPIO_PIN_4; \
}

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/


/* Example of firmware for STM8S001: recommended startup + test of pins
functionality */
main()
{
	uint32_t i,j;
 /* -------------STM8S001 startup-------------- */
 /* configure unbonded pins */
	CONFIG_UNUSED_PINS_STM8S001;
 /* delay for SWIM connection: ~5seconds */
	STARTUP_SWIM_DELAY_5S;
 /* ------------------------------------------- */
	
	InitDevice();

	while (1)
	{
		if(Delay_Timeout())
		{
			Toggle_Power_Switch();
		//	for(i=0;i<1000;i++)
		//		j++;
			send_Data_UART(14, pText);
		}
	}
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {	
		
  }
}
#endif