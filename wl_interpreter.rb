class WLInterpreter
  attr_reader :program_memory, :data_memory, :pc

  def initialize
    @program_memory = []
    @data_memory = {}
    @pc = 0
  end

  def load_program(filepath)
    File.readlines(filepath,chomp:true).each do |command|
      #Parse and load the instruction into program_memory
      if command =~ /VARINT (\w+) (\d+)/
        @program_memory << VarInt.new($1, $2)
      elsif command =~ /VARLIST (\w+)(?: (\w+(?:\s*,\s*\w*)*))?/
        @program_memory << VarList.new($1, $2)
      elsif command =~ /COMBINE (\w+) (\w+)/
        @program_memory << Combine.new($1, $2)
      elsif command =~ /GET (\w+) (\d+) (\w+)/
        @program_memory << Getel.new($1, $2, $3)
      elsif command =~ /ADD (\w+) (\w+)/
        @program_memory << Addels.new($1, $2)
      elsif command =~ /SET (\w+) (\d+) (\w+)/
        @program_memory << Setel.new($1, $2, $3)
      elsif command =~ /COPY (\w+) (\w+)/
        @program_memory << Copyl.new($1, $2)
      elsif command =~ /CHS (\w+)/
        @program_memory << Chs.new($1)
      elsif command =~ /IF (\w+) (\d+)/
        @program_memory << Ifs.new($1,$2)
      elsif command == "HLT"
        @program_memory << "HLT"
    end
    end
  end

  def command_loop
    terminate=false
    consoleprint = lambda do
      data_memory_str = @data_memory.map { |k, v| "#{k} = #{v.to_s}" }.join(', ')
      puts "PC: #{@pc}, Data Memory: { #{data_memory_str} }"
    end
    loop do
      if terminate == true
        break
      end
      print "Enter command (o, a, q): "
      cmd = gets.chomp
      case cmd
      when 'o' #execute a single line of code
        if @pc < @program_memory.length
          instruction = @program_memory[@pc]
          if instruction == "HLT" #handle HLT instruction
            consoleprint.call
            break
          else
            @pc = instruction.execute(@data_memory, @pc)
          end
          consoleprint.call
        else
          puts "No more instructions."
          consoleprint.call
          terminate = true
        end
      when 'a' #execute all instructions
        while @pc < @program_memory.length
          instruction = @program_memory[@pc]
          if instruction == "HLT"
            terminate=true
            break
          else
            @pc = instruction.execute(@data_memory, @pc)
          end
        end
        consoleprint.call
        break
      when 'q' #quit
        break
      else
        puts "Invalid command."
      end
    end
  end
end
