class Instruction #abstract class
  def execute(data_memory, pc) #abstract method
  end
end

#Instruction is the super class and all the classes below are subclasses which inherit this Instruction class
# and define the abstract method called execute.

class VarInt < Instruction
  def initialize(x, i)
    @x, @i = x, MutableInteger.new(i.to_i)
  end

  def execute(data_memory, pc)
    data_memory[@x] = @i
    pc += 1
  end
end

class VarList < Instruction
  def initialize(l, els=[])
    @list1, @str_elements = l, els
  end

  def execute(data_memory, pc)
    if @str_elements != nil
      if @str_elements.include?(',') #to check if there are more than one comma separated values in the second argument of VARLIST
        inputlist = @str_elements[0..-1].split(/\s*,\s*/).map { |value| value =~ /^\d+$/ ? value.to_i : value}
      else
        inputlist = [@str_elements]
      end
      #puts "#{inputlist}"
      temp=LinkedList.new
        for i in inputlist
          if data_memory.key?(i)
            temp.append data_memory[i]
          else
            temp.append MutableInteger.new(i.to_i)
          end
        end
  else
    temp=LinkedList.new
  end
    data_memory[@list1] = temp
    pc += 1
  end
  end

class Combine < Instruction
  def initialize(l1, l2)
    @list1, @list2 = l1, l2
  end

  def execute(data_memory, pc)
    list1 = data_memory[@list1]
    list2 = data_memory[@list2]
    combined_list = LinkedList.new #new list containing result
    append_to_combined = lambda do |node| #lambda function
      while node
        combined_list.append(node.value)
        node = node.next
      end
    end
    append_to_combined.call(list1.head)
    append_to_combined.call(list2.head)
    data_memory[@list2] = combined_list
    pc += 1
  end
end

class Getel < Instruction
  def initialize(var, i, l)
    @var, @i, @l = var, i.to_i, l
  end

  def execute(data_memory, pc)
    list1 = data_memory[@l]
    cn = list1.head
    j=0
    while j<@i
      cn=cn.next
      j+=1
    end
      data_memory[@var] = cn.value
    pc += 1
  end
end

class Addels < Instruction
  def initialize(x, y)
    @x, @y = x, y
  end

  def execute(data_memory, pc)
    data_memory[@x] = data_memory[@x].value + (data_memory.key?(@y) ? data_memory[@y].value : @y.to_i)
    pc += 1
  end
end

class Setel < Instruction
  def initialize(val, i, l)
    @val, @i, @l = val, i.to_i, l
  end

  def execute(data_memory, pc)
    list1 = data_memory[@l]
    cn = list1.head
    j=0
    while j<@i
      cn=cn.next
      j+=1
    end
    cn.value=data_memory.key?(@val) ? data_memory[@val] : @val
    pc += 1
  end
end

class Chs < Instruction
  def initialize(x)
    @x = x
  end

  def execute(data_memory, pc)
    if data_memory[@x].is_a?(MutableInteger)
      data_memory[@x].value = -(data_memory[@x].value)
    else

    end
    pc += 1
  end
end

class Ifs < Instruction
  def initialize(x,i)
    @x, @i = x, i.to_i
  end

  def execute(data_memory, pc)
    if (data_memory[@x].is_a?(MutableInteger) and data_memory[@x].value == 0) or (data_memory[@x].is_a?(LinkedList) and data_memory[@x].head == nil)
      pc=@i
    else
      pc+=1
    end
    pc
  end
end

class Copyl < Instruction
  def initialize(l1, l2)
    @list1, @list2 = l1, l2
  end

  def execute(data_memory, pc)
    list2 = data_memory[@list2]
    list3 = list2.deep_copy
    data_memory[@list1] = list3
    pc += 1
  end
end

