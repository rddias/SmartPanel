/* MAIN.C file */
#include "stm8s.h"
#include "stm8s_gpio.h"
#include "stm8s_clk.h"
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
	GPIOB->DDR |= GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_3 |	GPIO_PIN_6 | GPIO_PIN_7; \
	GPIOC->DDR |= GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_7; \
	GPIOD->DDR |= GPIO_PIN_0 | GPIO_PIN_2 | GPIO_PIN_4 | GPIO_PIN_7; \
	GPIOE->DDR |= GPIO_PIN_5; \
	GPIOF->DDR |= GPIO_PIN_4; \
}
/* pin for testing */
#define TEST_PORT GPIOA
#define TEST_PIN GPIO_PIN_3
//#define HSE_TEST
/* Example of firmware for STM8S001: recommended startup + test of pins
functionality */
main()
{
	 /* -------------STM8S001 startup-------------- */
	 /* configure unbonded pins */
	 CONFIG_UNUSED_PINS_STM8S001;
	 /* delay for SWIM connection: ~5seconds */
	 STARTUP_SWIM_DELAY_5S;
	 /* ------------------------------------------- */
	
	 /* configure all STM8S001 pins as input with pull up */
	 GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT); // pin 1
	 GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // pin 5
	 GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // pin 6 (PB4 has no pull-up - configure it as output low)
	 GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // pin 7
	 GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT); // pin 8
	
	 /* disable peripherals clocks to decrease consumption */
	 CLK->PCKENR1 = 0x00;
	 CLK->PCKENR2 = 0x00;
	
	 /* for testing external HSE clock */
	 /* make sure that option bit EXTCLK=1 */
	 #ifdef HSE_TEST
	 /* test HSE (external clock) - apply input clock on PA1 (pin 1) */
	 GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // CCO is on PC4 (pin 7)
	 CLK_CCOConfig(CLK_OUTPUT_CPU); // clock out on PC4/CCO (pin 7)
	 CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE,
	 CLK_CURRENTCLOCKSTATE_DISABLE); //set HSE as clock
	 #endif //HSE_TEST
	 /* initialize tested pin */
	 GPIO_Init(TEST_PORT, TEST_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
	 while (1)
	 {
		 /* toggle with tested pin */
		 GPIO_WriteReverse(TEST_PORT, TEST_PIN);
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