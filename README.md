# SoC_HW1
# 🔧 專案簡介

本專案展示如何使用 **Xilinx Zynq SoC** 的 **AXI GPIO** 介面，透過 **Processing System (PS)** 控制 **Programmable Logic (PL)** 端的外部裝置。在本專案中，我們將資料從 C 程式寫入 GPIO，控制 PL 中的 **VHDL 模組** 執行計數邏輯，並透過 LED 顯示計數結果。

本系統透過：

- **AXI GPIO**：將 PS 寫入的 8-bit 資料傳給 PL（`i_limit`）
- **VHDL 模組 `HW1`**：從 0 開始每次 +4 遞增計數，直到達到 `i_limit`，再重置
- **LED 輸出**：將計數結果透過 8 顆 LED 顯示

---
## 🧱 系統架構圖
![image](https://github.com/daven55663/SoC_HW1/blob/main/%E6%93%B7%E5%8F%96.PNG)



```md

```

---

## 📋 硬體需求

| 項目         | 說明                                               |
|--------------|----------------------------------------------------|
| 開發板       | EGO-ZX7 Zynq-7000 SoC 開發板（XC7Z020CLG484-1）     |
| 處理器       | 雙核心 ARM Cortex-A9，最高時脈約 866 MHz           |
| 可程式邏輯   | PL 端使用自訂 VHDL 模組 `HW1`，透過 AXI GPIO 控制   |
| LED 燈       | 8 顆，與 PL 模組 `o_led[7:0]` 對應                    |

---

## 💻 程式碼說明

### `main.c`（執行於 PS）

- 初始化 AXI GPIO
- 將 `i_limit = 100` 寫入 PL
- 開始由 VHDL 控制計數與 LED

```c
#include "xgpio.h"
#include "xparameters.h"

int main() {
    XGpio Gpio_Limit;
    XGpio_Initialize(&Gpio_Limit, XPAR_AXI_GPIO_0_DEVICE_ID);
    XGpio_SetDataDirection(&Gpio_Limit, 1, 0x00);  // PS -> PL
    XGpio_DiscreteWrite(&Gpio_Limit, 1, 100);      // 設定計數上限為 100
    while(1);  // 無限等待，硬體自動執行
}
```

---

### `HW1.vhdl`（執行於 PL）

- 接收 `i_limit`
- 用除頻器慢速計數
- LED 每次輸出 `o_count` 的數值

```vhdl
process (clk)
begin
    if rising_edge(clk) then
        tmp <= tmp + 1;
    end if;
end process;

slow_clk <= tmp(25);  -- 除頻用
```

完整 VHDL 可見 [`HW1.vhdl`](./src/HW1.vhdl)

---

## 🧪 測試方式

1. 開啟 Vivado 並匯入 block design（PS + AXI GPIO + 自訂 IP `HW1`）
2. 確認 AXI GPIO 通道輸出至 `i_limit`、LED 接至 `o_led`
3. Build Bitstream → Export Hardware → Launch SDK
4. 上傳 `main.c`，燒錄並執行

---

## 📎 補充

- 若要加快測試速度，可將除頻位改成 `tmp(1)` 觀察 LED 閃爍
- 若有其他模組，如 UART、AXI BRAM，可擴充至更複雜架構
## 影片
https://www.youtube.com/shorts/VQ42d9FvCsA
