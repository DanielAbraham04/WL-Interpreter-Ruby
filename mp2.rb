require_relative 'instruction'
require_relative 'wl_interpreter'
require_relative 'node'
require_relative 'linked_list'
require_relative 'mutable_integer'

interpreter = WLInterpreter.new
interpreter.load_program '/Users/danielabraham/Documents/RubyMine/mp2/input.wl' #filepath
interpreter.command_loop