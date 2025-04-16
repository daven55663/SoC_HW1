#include <stdio.h>
#include "xparameters.h"
#include "xgpio.h"

#define LIMIT_VALUE 100  // 璶糶

int main()
{
    XGpio Gpio_Limit;


    XGpio_Initialize(&Gpio_Limit, XPAR_AXI_GPIO_0_DEVICE_ID);

    // 砞﹚ GPIO 块よパ PS 块计
    XGpio_SetDataDirection(&Gpio_Limit, 1, 0x00);  // Channel 1, 场块

    // 糶计 PL 家舱 (HW1)  i_limit
    XGpio_DiscreteWrite(&Gpio_Limit, 1, LIMIT_VALUE);

    printf("糶: %d\n", LIMIT_VALUE);

    while(1) {
        // 硂柑 LED 皗脅┪单
    }

    return 0;
}
