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

    def find(value)
        if 
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

arr = [1,2,3,4,5,6,7]
tree = Tree.new(arr)
# tree.insert(8)
# tree.delete(1)
# tree.insert(0)
tree.pretty_print