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

--  The main program uses the DMA controller to send a block of characters
--  to a USART. The characters are sent once per execution of the program.
--  Successful execution will be indicated by a slowly blinking green LED, in
--  addition to the characters appearing on a display conected to the USART.
--  Errors are indicated by flashing colors at higher rates (see the source
--  code). Note that all the LEDs flash before the characters are sent, as a
--  confirmation of overall execution.

--  The file declares the main procedure for the demonstration.

with STM32;                  use STM32;
with STM32.DMA;              use STM32.DMA;
with STM32.GPIO;             use STM32.GPIO;
with STM32.USARTs;           use STM32.USARTs;

with STM32.Device;           use STM32.Device;
with STM32.Board;            use STM32.Board;

with Ada.Real_Time;          use Ada.Real_Time;

with Peripherals;            use Peripherals;
with STM32F4_DMA_Interrupts; use STM32F4_DMA_Interrupts;

procedure Main is

   type Data is array (1 .. 17) of Character; -- arbitrary size and component
   for Data'Component_Size use 8;

   --   Source_Block  : constant Data := "1234567890123456";
   Source_Block : Data := "                " & Character'Enum_Val(16#ff#);
   Destination_Block : Data := "1234567890123456" & Character'Enum_Val(16#ff#);

   Bytes_To_Transfer : constant := Data'Length;

   Event_Kind : DMA_Interrupt;

   procedure Initialize_DMA;

   procedure Blink_LEDs;

   ------------------------------
   -- Initialize_Communication --
   ------------------------------
   procedure Initialize_Communication is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (Com_Transceiver);
      Enable_Clock (Com_RX_Pin & Com_TX_Pin);

      Configuration.Mode := Mode_AF;
      Configuration.Speed := Speed_100MHz;
      Configuration.Output_Type := Push_Pull;
      Configuration.Resistors := Pull_Up;
      Configure_IO (Com_RX_Pin & Com_TX_Pin, Config => Configuration);
      Configure_Alternate_Function (Com_RX_Pin & Com_TX_Pin,  AF => Com_Transceiver_AF);

      Disable (Com_Transceiver);

      Set_Baud_Rate    (Com_Transceiver, 115_200);
      Set_Mode         (Com_Transceiver, Tx_Rx_Mode);
      Set_Stop_Bits    (Com_Transceiver, Stopbits_1);
      Set_Word_Length  (Com_Transceiver, Word_Length_8);
      Set_Parity       (Com_Transceiver, No_Parity);
      Set_Flow_Control (Com_Transceiver, No_Flow_Control);

      Enable (Com_Transceiver);
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


   --------------------
   -- Initialize_DMA --
   --------------------

   procedure Initialize_DMA is
      Configuration : DMA_Stream_Configuration;
   begin
      Enable_Clock (Controller);

      Configuration.Channel                      := Com_Tx_Channel;
      Configuration.Direction                    := Memory_To_Peripheral;
      Configuration.Increment_Peripheral_Address := False;
      Configuration.Increment_Memory_Address     := True;
      Configuration.Peripheral_Data_Format       := Bytes;
      Configuration.Memory_Data_Format           := Bytes;
      Configuration.Operation_Mode               := Normal_Mode;
      Configuration.Priority                     := Priority_Very_High;
      Configuration.FIFO_Enabled                 := True;
      Configuration.FIFO_Threshold               := FIFO_Threshold_Full_Configuration;
      Configuration.Memory_Burst_Size            := Memory_Burst_Single;
      Configuration.Peripheral_Burst_Size        := Peripheral_Burst_Single;

      Configure (Controller, Com_Tx_Stream, Configuration);
      --  note the controller is disabled by the call to Configure

      Configuration.Channel                      := Debug_Tx_Channel;
      Configuration.Direction                    := Memory_To_Peripheral;
      Configuration.Increment_Peripheral_Address := False;
      Configuration.Increment_Memory_Address     := True;
      Configuration.Peripheral_Data_Format       := Bytes;
      Configuration.Memory_Data_Format           := Bytes;
      Configuration.Operation_Mode               := Normal_Mode;
      Configuration.Priority                     := Priority_Very_High;
      Configuration.FIFO_Enabled                 := True;
      Configuration.FIFO_Threshold               := FIFO_Threshold_Full_Configuration;
      Configuration.Memory_Burst_Size            := Memory_Burst_Single;
      Configuration.Peripheral_Burst_Size        := Peripheral_Burst_Single;

      Configure (Controller, Debug_Tx_Stream, Configuration);
      --  note the controller is disabled by the call to Configure

      Configuration.Channel                      := Com_Rx_Channel;
      Configuration.Direction                    := Peripheral_To_Memory;
      Configuration.Increment_Peripheral_Address := False;
      Configuration.Increment_Memory_Address     := True;
      Configuration.Peripheral_Data_Format       := Bytes;
      Configuration.Memory_Data_Format           := Bytes;
      Configuration.Operation_Mode               := Circular_Mode;
      Configuration.Priority                     := Priority_Very_High;
      Configuration.FIFO_Enabled                 := True;
      Configuration.FIFO_Threshold               := FIFO_Threshold_Full_Configuration;
      Configuration.Memory_Burst_Size            := Memory_Burst_Single;
      Configuration.Peripheral_Burst_Size        := Peripheral_Burst_Single;

      Configure (Controller, Com_Rx_Stream, Configuration);
   end Initialize_DMA;


   ----------------
   -- Blink_LEDs --
   ----------------

   procedure Blink_LEDs is
   begin
      for K in 1 .. 3 loop
         All_LEDs_On;
         delay until Clock + Milliseconds (100);
         All_LEDs_Off;
         delay until Clock + Milliseconds (100);
      end loop;
   end Blink_LEDs;

begin
   Initialize_LEDs;

   Blink_LEDs; --  just to signal that we are indeed running...

   Initialize_Communication;
   Initialize_DebugIO;

   Initialize_DMA;

   Enable (Com_Transceiver);
   Enable (Debug_Transceiver);

   declare
      Status_LED : User_LED;
      Interval   : Integer := 100;  -- milliseconds between blinks, arbitrary
   begin

      Start_Transfer (Controller,
                      Com_Rx_Stream,
                      Source  => Data_Register_Address (Com_Transceiver),
                      Destination => Destination_Block'Address,
                      Data_Count  => Bytes_To_Transfer);
      Enable_DMA_Receive_Requests (Com_Transceiver);

      loop
         delay until clock + milliseconds (70); -- should be 70ms
         toggle (blue);

         --
         --  Transmit over Com_DMA
         --
         Start_Transfer_with_Interrupts (Controller,
                                         Com_Tx_Stream,
                                         Source  => Source_Block'Address,
                                         Destination => Data_Register_Address (Com_Transceiver),
                                         Data_Count  => Bytes_To_Transfer);
         Enable_DMA_Transmit_Requests (Com_Transceiver);
         Handler.Await_Event (Event_Kind);

         --
         --  Receive over Com_DMA
         --
         --           Start_Transfer_with_Interrupts (Controller,
         --                     Com_Rx_Stream,
         --                     Source  => Data_Register_Address (Com_Transceiver),
         --                     Destination => Destination_Block'Address,
         --                     Data_Count  => Bytes_To_Transfer);
         --           Enable_DMA_Receive_Requests (Com_Transceiver);
         --           Handler.Await_Event (Event_Kind);
         --
         --           case Event_Kind is
         --           when FIFO_Error_Interrupt             => Status_LED := Orange;
         --           when Transfer_Error_Interrupt         => Status_LED := Red;
         --           when Half_Transfer_Complete_Interrupt => Status_LED := Green;
         --           when Transfer_Complete_Interrupt      => Status_LED := Green;
         --              Interval := 200;
         --              --  also change the blink rate, to distinguish from the HTCI
         --           when Direct_Mode_Error_Interrupt      => Status_LED := Blue;
         --           end case;
         --
         --           Turn_On (Status_LED);
         --           delay until Clock + Milliseconds (Interval);
         --
         --           Turn_Off (Status_LED);
         --           delay until Clock + Milliseconds (Interval);

         --
         --  Transmit over Debug_DMA
         --
         Start_Transfer_with_Interrupts (Controller,
                                         Debug_Tx_Stream,
                                         Source  => Destination_Block'Address,
                                         Destination => Data_Register_Address (Debug_Transceiver),
                                         Data_Count  => Bytes_To_Transfer);
         Enable_DMA_Transmit_Requests (Debug_Transceiver);
         Handler.Await_Event (Event_Kind);
      end loop;
   end;
end Main;
