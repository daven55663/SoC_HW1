#include <stdio.h>
#include "xparameters.h"
#include "xgpio.h"

#define LIMIT_VALUE 100  // 要寫入的限制值

int main()
{
    XGpio Gpio_Limit;


    XGpio_Initialize(&Gpio_Limit, XPAR_AXI_GPIO_0_DEVICE_ID);

    // 設定 GPIO 為輸出方向（由 PS 輸出數值）
    XGpio_SetDataDirection(&Gpio_Limit, 1, 0x00);  // Channel 1, 全部為輸出

    // 寫入數值到 PL 模組 (HW1) 的 i_limit
    XGpio_DiscreteWrite(&Gpio_Limit, 1, LIMIT_VALUE);

    printf("已寫入限制值: %d\n", LIMIT_VALUE);

    while(1) {
        
    }

    return 0;
}
