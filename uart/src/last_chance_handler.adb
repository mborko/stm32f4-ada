
with stm32.board;       use stm32.board;
with stm32.gpio;        use stm32.gpio;
with stm32.device;

with serial;

with ada.real_time;     use ada.real_time;
with ada.unchecked_conversion;

package body last_chance_handler is

   procedure put (ptr : system.address);

   ---------
   -- put --
   ---------

   procedure put (ptr : system.address) is

      type c_string_ptr is access string (1 .. positive'last) with
        storage_size => 0, size => standard'address_size;

      function as_c_string_ptr is new ada.unchecked_conversion
        (system.address, c_string_ptr);

      msg_str : constant c_string_ptr := as_c_string_ptr (ptr);

   begin
      for j in msg_str'range loop
         exit when msg_str (j) = character'val (0);
         serial.putc (stm32.device.USART_1, msg_str (j));
      end loop;
   end put;

   -------------------------
   -- last_chance_handler --
   -------------------------

   procedure last_chance_handler (msg : system.address; line : integer) is
   begin
      initialize_leds;  -- in case no other use in the application
      all_leds_off;
      turn_on (red);

      if line /= 0 then
         serial.put (stm32.device.USART_1, ">>> exception at ");
         put (msg);
         serial.put (stm32.device.USART_1, " line");
         serial.put (stm32.device.USART_1, line'img);
      else
         serial.put (stm32.device.USART_1, ">>> user-defined exception, message: ");
         put (msg);
      end if;

      serial.putc (stm32.device.USART_1, ASCII.CR);

      loop
         toggle (red);
         delay until clock + milliseconds (500);
      end loop;
   end last_chance_handler;

end last_chance_handler;
