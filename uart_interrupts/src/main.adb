------------------------------------------------------------------------------
--                                                                          --
--                 Copyright (C) 2015-2016, AdaCore                         --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of STMicroelectronics nor the names of its       --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

--  A demonstration of using the USART device.  Note it requires a program on
--  the host to see the output and interact with the program on the board.

--  The file declares the main procedure for the demonstration.

with STM32;			use STM32;
with STM32.Board;		use STM32.Board;
with STM32.GPIO;		use STM32.GPIO;
with STM32.USARTs;		use STM32.USARTs;
with STM32.Device;		use STM32.Device;

with Ada.Synchronous_Task_Control; use Ada.Synchronous_Task_Control;
with ada.real_time;  use ada.real_time;

with Peripherals;		use Peripherals;
with Serial_Port;		use Serial_Port;

with Last_Chance_Handler;	pragma Unreferenced (Last_Chance_Handler);

procedure Main is

   type Sequence is range -1 .. 238; -- maximum Sequence Number 0xEE
   sequence_number : Sequence := -1;
   function get_sqnr return Sequence is
   begin
      if sequence_number < Sequence'Last then
         sequence_number := sequence_number + 1;
      else
         sequence_number := 0;
      end if;
      return sequence_number;
   end get_sqnr;

   Outgoing : aliased Message (Physical_Size => MESSAGE_SIZE);
   Received : aliased Message (Physical_Size => MESSAGE_SIZE);
   Debug : aliased Message (Physical_Size => DEBUG_MESSAGE_SIZE);

   ------------------------------
   -- Initialize_Communication --
   ------------------------------

   procedure Initialize_Communication is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (Transceiver);
      Enable_Clock (RX_Pin & TX_Pin);

      Configuration.Mode := Mode_AF;
      Configuration.Speed := Speed_100MHz;
      Configuration.Output_Type := Push_Pull;
      Configuration.Resistors := Pull_Up;
      Configure_IO (RX_Pin & TX_Pin, Config => Configuration);
      Configure_Alternate_Function (RX_Pin & TX_Pin,  AF => Transceiver_AF);

      Disable (Transceiver);

      Set_Baud_Rate    (Transceiver, 115_200);
      Set_Mode         (Transceiver, Tx_Rx_Mode);
      Set_Stop_Bits    (Transceiver, Stopbits_1);
      Set_Word_Length  (Transceiver, Word_Length_8);
      Set_Parity       (Transceiver, No_Parity);
      Set_Flow_Control (Transceiver, No_Flow_Control);

      Enable (Transceiver);
   end Initialize_Communication;

   ------------------------
   -- Initialize_DebugIO --
   ------------------------

   procedure Initialize_DebugIO is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (Debug_Transceiver);
      Enable_Clock (Debug_RX_Pin & Debug_TX_Pin);

      Configuration.Mode := Mode_AF;
      Configuration.Speed := Speed_100MHz;
      Configuration.Output_Type := Push_Pull;
      Configuration.Resistors := Pull_Up;

      Configure_IO (Debug_RX_Pin & Debug_TX_Pin, Config => Configuration);

      Configure_Alternate_Function (Debug_RX_Pin & Debug_TX_Pin,  AF => Debug_Transceiver_AF);

      Disable (Debug_Transceiver);

      Set_Baud_Rate    (Debug_Transceiver, 115_200);
      Set_Mode         (Debug_Transceiver, Tx_Mode);
      Set_Stop_Bits    (Debug_Transceiver, Stopbits_1);
      Set_Word_Length  (Debug_Transceiver, Word_Length_8);
      Set_Parity       (Debug_Transceiver, No_Parity);
      Set_Flow_Control (Debug_Transceiver, No_Flow_Control);

      Enable (Debug_Transceiver);
   end Initialize_DebugIO;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      Initialize_Communication;
      Initialize_DebugIO;
      -- STM32 Init functions
      initialize_leds;
   end Initialize;


begin
   Initialize;

   loop
      delay until clock + milliseconds (70);
      toggle (blue);


      Set (Outgoing, To => Character'Enum_Val(get_sqnr) & "               " );	-- 15 spaces
      --  Set (Outgoing, To => Character'Enum_Val(get_sqnr) & " " );			-- only one space
      Peripherals.COM.Start_Sending (Outgoing'Unchecked_Access);
      Suspend_Until_True (Outgoing.Transmission_Complete);

      -- if Interrupt_Enabled (Transceiver, Received_Data_Not_Empty) = false then
      --   Received.Terminator := '["5E"]';  -- Caret  '^'
         Peripherals.COM.Start_Receiving (Received'Unchecked_Access);
      -- else
         if Current_State( Received.Reception_Complete ) then
            Set (green);
            Set (Debug, To => "Received : " & As_String (Received));
            Peripherals.Debug_COM.Start_Sending (Debug'Unchecked_Access);
            -- Disable_Interrupts (Transceiver, Received_Data_Not_Empty);
            Set_False (Received.Reception_Complete);
            Clear (green);
         end if;
      -- end if;

   end loop;
end Main;


