module RAutomation
  module Adapter
    module WinFfi
      class TextField < Control
        include WaitHelper
        include Locators

        # Default locators used for searching text fields.
        DEFAULT_LOCATORS = {:class => /edit/i}

        # @see RAutomation::TextField#set
        def set(text,opts)                    
          if opts && opts[:no_wait]
            hwnd = Functions.control_hwnd(@window.hwnd, @locators)
            @window.activate
            @window.active? &&
                      Functions.set_control_focus(hwnd) &&
                      Functions.set_control_text(hwnd, text) &&
                      value == text
            
          else
            raise "Cannot set value on a disabled text field" if self.respond_to?("disabled?") && disabled?
            wait_until do
              hwnd = Functions.control_hwnd(@window.hwnd, @locators)
              @window.activate
              @window.active? &&
                      Functions.set_control_focus(hwnd) &&
                      Functions.set_control_text(hwnd, text) &&
                      value == text
            end
          end
          
        end

        # @see RAutomation::TextField#clear
        def clear
          raise "Cannot set value on a disabled text field" if disabled?
          set ""
        end

        # @see RAutomation::TextField#value
        def value
          Functions.control_value(hwnd)
        end

        # @see RAutomation::TextField#hwnd
        def hwnd
          Functions.control_hwnd(@window.hwnd, @locators)
        end

      end
    end
  end
end
