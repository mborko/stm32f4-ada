
with stm32.usarts;
with stm32.gpio; use stm32.gpio;

package serial is

   type serial_periph is record
      device   : access stm32.usarts.usart;
      tx_pin   : stm32.gpio.gpio_point;
      rx_pin   : stm32.gpio.gpio_point;
   end record;

   procedure initialize_gpio
     (tx_pin   : stm32.gpio.gpio_point;
      rx_pin   : stm32.gpio.gpio_point;
      af       : stm32.GPIO_Alternate_Function);

   procedure configure
     (device    : access stm32.usarts.usart;
      baud_rate : stm32.usarts.baud_rates;
      mode      : stm32.usarts.UART_Modes   := stm32.usarts.TX_RX_MODE;
      parity    : stm32.usarts.parities     := stm32.usarts.NO_PARITY;
      data_bits : stm32.usarts.word_lengths := stm32.usarts.WORD_LENGTH_8;
      end_bits  : stm32.usarts.stop_bits    := stm32.usarts.STOPBITS_1;
      control   : stm32.usarts.flow_control := stm32.usarts.NO_FLOW_CONTROL);

   procedure await_send_ready (device : stm32.usarts.usart);

   procedure putc
     (device   : in out stm32.usarts.usart;
      c        : character);

   procedure put
     (device   : in out stm32.usarts.usart;
      s        : string);

end serial;
