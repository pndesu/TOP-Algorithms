class LinkedList
    def initialize(value)
        @head = Node.new(value)
        @current = @head
    end

    def append(value)
        new_node = Node.new(value)
        @current.next_node = new_node
        @current = new_node
    end

    def prepend(value)
        new_node = Node.new(value)
        new_node.next_node = @head
        @head = new_node
    end

    def size
        length = 0
        fake_head = @head
        return 1 if @head.next_node == nil
        until fake_head.next_node == nil
            fake_head = fake_head.next_node
            length += 1
        end
        length + 1
    end

    def head
        @head.value
    end

    def tail
        @current.value
    end

    def at(index)
        if (index + 1 > self.size)
            puts "Out of bound!"
            return
        end
        fake_head = @head
        until index == 0
            fake_head = fake_head.next_node
            index -= 1
        end
        fake_head.value
    end

    def at_raw(index)
        if (index + 1 > self.size)
            puts "Out of bound!"
            return
        end
        fake_head = @head
        until index == 0
            fake_head = fake_head.next_node
            index -= 1
        end
        fake_head
    end

    def pop
        if self.size == 1
            @head = nil
            @current = @head
        else
            fake_head = @head
            until fake_head.next_node.next_node == nil
                fake_head = fake_head.next_node
            end
            @current = fake_head
            deleted_node = @current.next_node
            @current.next_node = nil
            return deleted_node
        end
    end

    def contain?(value)
        fake_head = @head
        until fake_head.value == value
            return false if fake_head.next_node == nil
            fake_head = fake_head.next_node
        end
        return true
    end

    def find(value)
        fake_head = @head
        index = 0
        until fake_head.value == value
            return nil if fake_head.next_node == nil
            fake_head = fake_head.next_node
            index += 1
        end
        return index
    end

    def to_s
        fake_head = @head
        text = "( #{fake_head.value} ) -> "
        until fake_head.next_node == nil
            fake_head = fake_head.next_node
            text += "( #{fake_head.value} ) -> "
        end
        text += "nil" if fake_head.next_node == nil
        text
    end

    def insert_at(value, index)
        if (index + 1 > self.size)
            append(value)
        elsif index == 0
            prepend(value)
        else
            n_node =  self.at_raw(index)
            p_node = self.at_raw(index-1)
            new_node = Node.new(value)
            new_node.next_node = n_node
            p_node.next_node = new_node
        end
    end

    def remove_at(index)
        if (index == 0 && self.size > 1)
            @head = @head.next_node
        elsif index == self.size - 1
            pop
        else
            fake_head = self.at_raw(index - 1)
            temp = fake_head
            fake_head.next_node = fake_head.next_node.next_node
            deleted_node = temp.next_node.next_node
            temp.next_node.next_node = nil
            return deleted_node
        end
    end
end

class Node
    attr_accessor :value, :next_node
    def initialize(value)
        @value = value
        @next_node = nil
    end
end
