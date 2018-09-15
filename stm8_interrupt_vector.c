/*	BASIC INTERRUPT VECTOR TABLE FOR STM8 devices
 *	Copyright (c) 2007 STMicroelectronics
 */
#include "stm8s_it.h"
typedef void @far (*interrupt_handler_t)(void);

struct interrupt_vector {
	unsigned char interrupt_instruction;
	interrupt_handler_t interrupt_handler;
};

@far @interrupt void NonHandledInterrupt_ (void)
{
	/* in order to detect unexpected events during development, 
	   it is recommended to set a breakpoint on the following instruction
	*/
	return;
}

extern void _stext();     /* startup routine */

struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */
	{0x82, NonHandledInterrupt_}, /* trap  */
	{0x82, NonHandledInterrupt_}, /* irq0  */
	{0x82, NonHandledInterrupt_}, /* irq1  */
	{0x82, NonHandledInterrupt_}, /* irq2  */
	{0x82, NonHandledInterrupt_}, /* irq3  */
	{0x82, NonHandledInterrupt_}, /* irq4  */
	{0x82, NonHandledInterrupt_}, /* irq5  */
	{0x82, NonHandledInterrupt_}, /* irq6  */
	{0x82, NonHandledInterrupt_}, /* irq7  */
	{0x82, NonHandledInterrupt_}, /* irq8  */
	{0x82, NonHandledInterrupt_}, /* irq9  */
	{0x82, NonHandledInterrupt_}, /* irq10 */
	{0x82, NonHandledInterrupt_}, /* irq11 */
	{0x82, NonHandledInterrupt_}, /* irq12 */
	{0x82, NonHandledInterrupt_}, /* irq13 */
	{0x82, NonHandledInterrupt_}, /* irq14 */
	{0x82, NonHandledInterrupt_}, /* irq15 */
	{0x82, NonHandledInterrupt_}, /* irq16 */
	{0x82, NonHandledInterrupt_}, /* irq17 */
  {0x82, NonHandledInterrupt_}, /* USART1 RX data full irq18 0x8050 */
	{0x82, NonHandledInterrupt_}, /* irq19 */
	{0x82, NonHandledInterrupt_}, /* irq20 */
	{0x82, NonHandledInterrupt_}, /* irq21 */
	{0x82, NonHandledInterrupt_}, /* irq22 */
  {0x82, (interrupt_handler_t)TIM4_UPD_OVF_IRQHandler}, /* TIM4 vof            irq23 0x8064 */
	{0x82, NonHandledInterrupt_}, /* FLASH               irq24 0x8068 */
	{0x82, NonHandledInterrupt_}, /* irq25 */
	{0x82, NonHandledInterrupt_}, /* irq26 */
	{0x82, NonHandledInterrupt_}, /* irq27 */
	{0x82, NonHandledInterrupt_}, /* irq28 */
	{0x82, NonHandledInterrupt_}, /* irq29 */
};
