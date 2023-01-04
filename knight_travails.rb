class Knight
    attr_accessor :moves, :move_nodes, :knight
    def initialize(x, y)
        @knight = KnightMove.new(x,y)
    end

    def possible_knight_moves(x = knight.x, y = knight.y, parent = knight)
        x_moves_1 = [x+1, x-1].select{|i| i.between?(1,8)}
        x_moves_2 = [x+2, x-2].select{|i| i.between?(1,8)}
        y_moves_1 = [y+1, y-1].select{|i| i.between?(1,8)}
        y_moves_2 = [y+2, y-2].select{|i| i.between?(1,8)}
        x2y1 = x_moves_2.product(y_moves_1)
        x1y2 = x_moves_1.product(y_moves_2)
        moves = x2y1 + x1y2
        @move_nodes = moves.map{|move| KnightMove.new(move[0], move[1], parent)}
        @move_nodes
    end

    def check_destination(x, y, node)
        (node.x == x && node.y == y)? true : false
    end
    
    def create_next_moves(parent)
        parent.children = possible_knight_moves(parent.x, parent.y, parent)
    end

    def search(x, y)
        queue = possible_knight_moves()
        paths = []
        @length = -1
        until queue.length == 0 do
            queue.each do |parent|
                unless check_destination(x, y, parent)
                    create_next_moves(parent)
                    parent.children.each{|child| queue.push(child)}
                    queue.shift
                    break
                else
                    ancestors = find_ancestors(parent)
                    if (paths.length == 0 || ancestors.length == @length)
                        @length = ancestors.length
                        paths << ancestors
                    else
                        puts "There are #{paths.length} paths of #{paths[0].length - 1} turns from [#{knight.x}][#{knight.y}] to [#{x}][#{y}]:\n\n"
                        paths.each{|path| p path}
                        return
                    end
                end
            end
        end
    end

    def find_ancestors(node, arr = [])
        until node.parent == nil
            arr << [node.x, node.y]
            node = node.parent
        end
        arr << [node.x, node.y]
        arr.reverse
    end
end

class KnightMove
    attr_accessor :x, :y, :children, :parent
    def initialize(x,y, parent = nil)
        @x = x
        @y = y
        @children = []
        @parent  = parent
    end
end

knight = Knight.new(2,1)
knight.search(1,8)