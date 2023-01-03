class Tree
    attr_reader :root
    def initialize(arr)
        arr = arr.uniq.sort
        @root = build_tree(arr)
    end

    def build_tree(arr)
        return nil if arr.length == 0
        mid = (arr.length - 1) / 2
        root = Node.new(arr[mid])
        root.left = build_tree(arr[0,mid])
        root.right = build_tree(arr[mid+1..-1])
        return root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert(value, root = @root)
        return Node.new(value) if root == nil
        if value > root.value
            root.right = insert(value, root.right)
        elsif value < root.value
            root.left = insert(value, root.left)
        end
        root
    end

    def find_leftmost(root)
        return root if root.left == nil
        root = find_leftmost(root.left)
        root
    end

    def delete(value, root = @root)
        return root if root == nil
        if (value < root.value)
            root.left = delete(value, root.left)
        elsif (value > root.value)
            root.right = delete(value, root.right)
        else
            if (root.right == nil && root.left == nil)
                return nil
            elsif root.left == nil
                return temp = root.right
            elsif root.right == nil
                return temp = root.left
            else
                leftmost_node = find_leftmost(root.right)
                root.value = leftmost_node.value  
                root.right = delete(leftmost_node.value, root.right)
            end
        end
        return root
    end

    def find(value, root = @root)
        if (root == nil)
            puts "Node not found!"
            return nil
        end
        if (value < root.value)
            value = find(value, root.left)
        elsif (value > root.value)
            value = find(value, root.right)
        else
            root
        end
    end

    def level_order()
        queue = [@root]
        values = []
        until queue.length == 0 do
            queue.each do |node|
                queue.push(node.left) if node.left != nil
                queue.push(node.right) if node.right != nil
                (block_given?)? values << yield(node.value) : values << node.value
                queue.delete(node)
                break
            end
        end
        p values
    end

    def preorder(arr = [], root = @root)
        return if root == nil
        (block_given?)? arr << yield(root.value) : arr << root.value
        preorder(arr, root.left)
        preorder(arr, root.right)
        arr
    end

    def inorder(arr = [], root = @root)
        return if root == nil
        inorder(arr, root.left)
        (block_given?)? arr << yield(root.value) : arr << root.value
        inorder(arr, root.right)
        arr
    end

    def postorder(arr = [], root = @root)
        return if root == nil
        postorder(arr, root.left)
        postorder(arr, root.right)
        (block_given?)? arr << yield(root.value) : arr << root.value
        arr
    end

    def height(node = @root, count = -1)
        return count if node.nil?
    
        count += 1
        [height(node.left, count), height(node.right, count)].max
    end
    
    def depth(value, root = @root, count = 0)
        return count if root.nil? || value == root.value
        if value < root.value
            count += 1
            depth(value, root.left, count)
        else
            count += 1
            depth(value, root.right, count)
        end
    end

    def balanced?(left = @root.left, right = @root.right, root = @root)
        return if root.left.nil? || root.right.nil?
        return false if (height(left) - height(right)).abs > 1
        balanced?(root.left, root.right, root.left)
        balanced?(root.left, root.right, root.right)
        return true
    end

    def rebalance()
        unless balanced?
            @root = build_tree(self.inorder)
        end
        self.pretty_print
    end
end
class Node
    attr_accessor :value, :left, :right
    def initialize(value)
        @value = value
        @left = nil
        @right = nil
    end
end

arr = (Array.new(15) { rand(1..100) })
tree = Tree.new(arr)
puts tree.balanced?
tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder
tree.insert(150)
tree.insert(120)
tree.insert(200)
puts tree.balanced?
tree.rebalance
puts tree.balanced?
tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder