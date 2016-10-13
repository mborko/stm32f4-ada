------------------------------------------------------------------------------
--                                                                          --
--                    Copyright (C) 2015, AdaCore                           --
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

with STM32.DMA;         use STM32.DMA;
with STM32.USARTs;  use STM32.USARTs;

with Peripherals;       use Peripherals;

package STM32F4_DMA_Interrupts is

   protected Handler is
      pragma Interrupt_Priority;

      entry Await_Event (Occurrence : out DMA_Interrupt);

   private

      Event_Occurred : Boolean := False;
      Event_Kind     : DMA_Interrupt;

      procedure IRQ_Com_Tx_Handler;
      procedure IRQ_Com_Rx_Handler;
      procedure IRQ_Debug_Tx_Handler;
      procedure IRQ_Handler (Stream : DMA_Stream_Selector; Transceiver : in out USART);

      pragma Attach_Handler (IRQ_Com_Tx_Handler, DMA_Com_Tx_IRQ);
      pragma Attach_Handler (IRQ_Com_Rx_Handler, DMA_Com_Rx_IRQ);
      pragma Attach_Handler (IRQ_Debug_Tx_Handler, DMA_Debug_Tx_IRQ);

   end Handler;

end STM32F4_DMA_Interrupts;
