#include <stdio.h>
#include "xparameters.h"
#include "xgpio.h"

#define LIMIT_VALUE 100  // �n�g�J�������

int main()
{
    XGpio Gpio_Limit;


    XGpio_Initialize(&Gpio_Limit, XPAR_AXI_GPIO_0_DEVICE_ID);

    // �]�w GPIO ����X��V�]�� PS ��X�ƭȡ^
    XGpio_SetDataDirection(&Gpio_Limit, 1, 0x00);  // Channel 1, ��������X

    // �g�J�ƭȨ� PL �Ҳ� (HW1) �� i_limit
    XGpio_DiscreteWrite(&Gpio_Limit, 1, LIMIT_VALUE);

    printf("�w�g�J�����: %d\n", LIMIT_VALUE);

    while(1) {
        // �A�i�H�b�o�̥[�@�� LED �{�{�ε��ԥ\��
    }

    return 0;
}
