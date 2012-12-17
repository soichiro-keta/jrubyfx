#!/usr/bin/env jruby
=begin
JRubyFXML - Write JavaFX and FXML in Ruby
Copyright (C) 2012 Patrick Plenefisch

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as 
published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end

# Require JRubyFXML library so we can get FXApplication and FXController
require 'jrubyfxml'

# Inherit from FXApplication to create our Application
class SimpleFXApplication < FXApplication
  # we must override start to get a stage on application initialization
  def start(stage)
    # assign the title
    stage.title = "Simple JavaFX FXML App in pure Ruby"
    
    # Load our FXML using our controller. width and height are optional, as is
    # either :fill => Color:: OR (not both) :depth_buffer => boolean. If you
    # have a custom initialize function, pass in arguments as :intialize => [args]
    @ctrlr = SimpleFXController.load_fxml("Demo.fxml", stage, :width => 620,
      :height => 480, :initialize => ["Arguments", "are supported"])
    
    # finally, show our app
    stage.show
  end
end

# Inherit from FXController to create our controller for this FXML file.
# You will need one Controller per FXML file under normal conditions.
class SimpleFXController < FXController
  
  # Here we declare that AnchorPane is a fx:id in the file
  fx_id :AnchorPane
  
  # Initialize is optional
  def initialize(first, second)
    puts "Ruby new"
    puts "#{first} #{second}"
  end
  
  # This is how events are defined in code.
  # This will be called from FXML by onAction="#click"
  fx_handler :click do 
    puts "Clicked Green"
  end
  
  # fx_action_handler and fx_handler all the same for standard ActionEvents
  fx_action_handler :clickbl do
    puts "Clicked Black"
    p @AnchorPane
  end
  
  # If you want to capture the ActionEvent object, just request it like this
  fx_handler :clickre do |arg|
    puts "Clicked Red"
    p arg
  end
  
  # For key events, you must use fx_key_handler
  fx_key_handler :keyPressed do |e|
    puts "You pressed a key!"
    puts "Alt: #{e.alt_down?} Ctrl: #{e.control_down?} Shift: #{e.shift_down?} Meta (Windows): #{e.meta_down?} Shortcut: #{e.shortcut_down?}"
    puts "Key Code: #{e.code} Character: #{e.character.to_i} Text: '#{e.text}'"
  end
  
  # For Context menu event, you must use fx_context_handler
  fx_context_handler :cmenu do
    puts "Context Menu Requested"
  end
  
  # Full list of mappings:
  # fx_key_handler is for KeyEvent
  # fx_mouse_handler is for MouseEvent
  # fx_touch_handler is for TouchEvent
  # fx_gesture_handler is for GestureEvent
  # fx_context_handler is for ContextMenuEvent
  # fx_context_menu_handler is for ContextMenuEvent
  # fx_drag_handler is for DragEvent
  # fx_ime_handler is for InputMethodEvent
  # fx_input_method_handler is for InputMethodEvent
  # fx_window_handler is for WindowEvent
  # fx_action_handler is for ActionEvent
  # fx_generic_handler is for Event
  # 
  # And if you need a custom Event, you can use:
  # fx_handler :name, YourCustomEvent do |e| ... end
end

# Launch our application!
SimpleFXApplication.launch
