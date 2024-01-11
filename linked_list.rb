class LinkedList
  attr_accessor :head

  def append(value)
    if @head.nil?
      @head = Node.new(value)
    else
      cn = @head
      cn = cn.next until cn.next.nil?
      cn.next = Node.new(value)
    end
  end

  def deep_copy
    return nil if @head.nil?
    copied_list = LinkedList.new
    cn = @head
    while cn
      if cn.value.is_a?(LinkedList)
        copied_list.append(cn.value.deep_copy)
      else
        copied_list.append(cn.value.clone)
      end
      cn = cn.next
    end
    copied_list
  end

  def to_s
    cn = @head
    elements = []
    while cn
      elements << cn.value.to_s
      cn = cn.next
    end
    "[#{elements.join(', ')}]"
  end
end
