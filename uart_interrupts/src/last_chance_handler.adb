
with stm32.board;	use stm32.board;
with STM32.GPIO;	use STM32.GPIO;

with Ada.Synchronous_Task_Control; use Ada.Synchronous_Task_Control;
with Ada.Real_Time;     use Ada.Real_Time;
with Ada.Unchecked_Conversion;

with Peripherals;	use Peripherals;
with Serial_Port;	use Serial_Port;

package body last_chance_handler is

   Debug_Message : aliased Message (Physical_Size => DEBUG_MESSAGE_SIZE);

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
         Peripherals.Debug_COM.Transmit(msg_str (j));
      end loop;
   end put;

   -------------------------
   -- last_chance_handler --
   -------------------------

   procedure last_chance_handler (msg : system.address; line : integer) is
   begin
      all_leds_off;
      turn_on (red);

      if line /= 0 then
         Set (Debug_Message, To => ">>> exception at line" & line'img & " in file ");
         Peripherals.Debug_COM.Start_Sending (Debug_Message'Unchecked_Access);
         Suspend_Until_True (Debug_Message.Transmission_Complete);
         put(msg);
         Peripherals.Debug_COM.Transmit(ASCII.CR);
      else
         Set (Debug_Message, To => ">>> user-defined exception, message: ");
         Peripherals.Debug_COM.Start_Sending (Debug_Message'Unchecked_Access);
         Suspend_Until_True (Debug_Message.Transmission_Complete);
         put(msg);
         Peripherals.Debug_COM.Transmit(ASCII.CR);
      end if;

      loop
         toggle (red);
         delay until clock + milliseconds (250);
      end loop;
   end last_chance_handler;

end last_chance_handler;
