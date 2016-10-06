with system;
with last_chance_handler;  pragma unreferenced (last_chance_handler);

with stm32.device;
with stm32.usarts; 
with stm32;
with ada.real_time;  use ada.real_time;

with leds; pragma unreferenced (leds); -- task blinking_leds
with serial;

procedure main is
   pragma priority (system.priority'first);
   counter : integer := 0;
begin

   serial.initialize_gpio
     (tx_pin => stm32.device.PB6,
      rx_pin => stm32.device.PB7,
      af     => stm32.device.GPIO_AF_7_USART1);

   serial.configure
     (device      => stm32.device.USART_1'access,
      baud_rate   => 115200,
      mode        => stm32.usarts.TX_MODE,
      parity      => stm32.usarts.NO_PARITY,
      data_bits   => stm32.usarts.WORD_LENGTH_8,
      end_bits    => stm32.usarts.STOPBITS_1,
      control     => stm32.usarts.NO_FLOW_CONTROL);

   loop

      delay until clock + milliseconds (100);

      serial.put (stm32.device.USART_1,
         "[" & integer'image(counter) & "]  hello, world!" & ASCII.CR);

      if counter < integer'last then
         counter := counter + 1;
      else
         counter := 0;
      end if;

   end loop;

end main;
