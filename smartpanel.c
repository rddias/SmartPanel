#include "stm8s.h"
#include "stm8s_gpio.h"
#include "stm8s_clk.h"
#include "stm8s_tim4.h"
#include "smartpanel.h"
#include "stm8s_itc.h"

#define DELAY_1s 1000

#define TIM4_PERIOD       124
#define POWER_SW_PORT GPIOA
#define POWER_SW_PIN GPIO_PIN_3
#define CARRIER_PORT GPIOC
#define CARRIER_PIN  GPIO_PIN_5

static void Set_Device_Clk(void);
static void Set_Device_GPIO(void);
static void Set_Device_TIM4(void);
static void Set_Device_UART(void);

static volatile uint32_t counter_1s = DELAY_1s;
static volatile uint8_t flag_1s = 0;

uint8_t *pText = "SMART PANEL PLC TEST\n";

void InitDevice()
{
	Set_Device_Clk();
	Set_Device_GPIO();
	Set_Device_TIM4();
	Set_Device_UART();
	Enable_Carrier();
}

static void Set_Device_Clk()
{
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
}

static void Set_Device_GPIO()
{
 /* configure all STM8S001 pins as input with pull up */
	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT); // pin 1
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // pin 5
	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // pin 6 (PB4 has no pull-up - configure it as output low)
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // pin 7
	GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT); // pin 8
	
	GPIO_Init(POWER_SW_PORT, POWER_SW_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(CARRIER_PORT, CARRIER_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
}

static void Set_Device_TIM4()
{
  /* TIM4 configuration:
   - TIM4CLK is set to 2 MHz, the TIM4 Prescaler is equal to 8 so the TIM1 counter
   clock used is 2 MHz / 16 = 125 KHz
  - With 2 MHz we can generate time base:
      max time base is 2.048 ms if TIM4_PERIOD = 255 --> (255 + 1) / 125K  = 2.048 ms
      min time base is 16 us if TIM4_PERIOD = 1     --> (  1 + 1) / 125K  =      16 us
  - In this example we need to generate a time base equal to 1 ms
   so TIM4_PERIOD = (0.001 * 125000 - 1) = 124 */

  /* Time base configuration */
  TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIM4_PERIOD); //TIM4_TimeBaseInit(TIM4_PRESCALER_128, TIM4_PERIOD);
  /* Clear TIM4 update flag */
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  /* Enable update interrupt */
  TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  
  /* enable interrupts */
  enableInterrupts();

  /* Enable TIM4 */
  TIM4_Cmd(ENABLE);
}

static void Set_Device_UART()
{
	/* Deinitializes the UART1 and UART3 peripheral */
	UART1_DeInit();
    /* UART1 configuration -------------------------------------------------*/
    /* UART1 configured as follow:
          - BaudRate = 9600 baud  
          - Word Length = 8 Bits
          - One Stop Bit
          - No parity
          - Receive and transmit enabled
          - UART1 Clock disabled
     */
    /* Configure the UART1 */
	UART1_Init((uint32_t)9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO,
                UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
    
	/* Enable UART1 Transmit interrupt*/
	//UART1_ITConfig(UART1_IT_TXE, ENABLE);    
	/* Enable UART1 Receive interrupt */
	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
	 
    /* Enable general interrupts */
	enableInterrupts();    
		
	//SEND DATA TESTING
		    /* Write one byte to the transmit data register */
	

}

void Enable_Carrier()
{
	CLK_CCOCmd(ENABLE);
	CLK_CCOConfig(CLK_OUTPUT_HSI);
}

void Disable_Carrier()
{
	CLK_CCOCmd(DISABLE);
}

void Timer_OVF()
{
	counter_1s--;
	if(!counter_1s)
	{
		flag_1s = 1;
		counter_1s = DELAY_1s;
	}	
}

uint8_t Delay_Timeout()
{
	uint8_t fl;

	fl = flag_1s;
  flag_1s = 0;
	return fl;
}

void Toggle_Power_Switch()
{
	GPIO_WriteReverse(POWER_SW_PORT, POWER_SW_PIN);
}

void Enable_Power_Switch()
{
	GPIO_WriteHigh(POWER_SW_PORT, POWER_SW_PIN);
}

void Disable_Power_Switch()
{
	GPIO_WriteLow(POWER_SW_PORT, POWER_SW_PIN);
}

void send_Data_UART(uint8_t size, uint8_t *data)
{
	if(!size)
		return;
	
	while(size){
		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET){
		}
			UART1_SendData8(*data++);
			size--;
		}
}