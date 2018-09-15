#ifndef __SMARTPANEL_H
#define __SMARTPANEL_H

void InitDevice(void);
void Enable_Carrier(void);
void Disable_Carrier(void);
uint8_t Delay_Timeout(void);
void Timer_OVF(void);
void Toggle_Power_Switch(void);
void send_Data_UART(uint8_t size, uint8_t *data);

extern uint8_t *pText;

#endif