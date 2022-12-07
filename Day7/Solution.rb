# frozen_string_literal: true
class Node
  attr_accessor :children, :value, :size, :parent, :type

  def initialize(value,children,size,parent,type)
    @value = value
    @children = children
    @size = size
    @parent = parent
    @type = type
  end
end

def create_file_structure(file_data, root)

  # mode 0 = traversal mode
  # mode 1 = listing mode
  index = 1
  mode = 0
  current = root
  while index < file_data.length do
    line = file_data[index].split(" ")
    if mode == 0
      if line[1] == "cd"
        if line[2] == ".."
          current = current.parent
        else
          current.children.each { |node|
            if node.value == line[2]
              current = node
              break
            end
          }
        end
      elsif line[1] == "ls"
        mode = 1
      end
      index += 1
    else
      if line[0] == "$"
        mode = 0
      else
        if line[0] == "dir"
          current.children.append(Node.new(line[1], [], 0, current,"dir"))
        else
          current.children.append(Node.new(line[1], [], line[0].to_i, current,"file"))
        end
        index += 1
      end
    end
  end
end

def calculate_dir_filesizes(node)
  if node.children.length > 0
    node.children.each { |child_node|
      node.size += calculate_dir_filesizes(child_node)
    }
  end
  node.size
end

def get_sum_of_directories_under(node,limit)
  accumulation = 0
  if node.children.length > 0
    node.children.each { |child_node|
      if child_node.type == "dir"
        accumulation += get_sum_of_directories_under(child_node,limit)
      end
    }
  end
  if node.size < limit
    accumulation+node.size
  else
    accumulation
  end
end

def get_smallest_of_directories_over(node,limit)
  accumulation = 70000000
  if node.children.length > 0
    node.children.each { |child_node|
      if child_node.type == "dir"
        accumulation = [accumulation, get_sum_of_directories_over(child_node,limit) ].min
      end
    }
  end
  if node.size > limit
    accumulation = [accumulation, node.size ].min
  end
  accumulation
end

file = File.open("input.txt")
file_data = file.readlines.map(&:chomp)

root = Node.new("/",[],0,nil,"dir")

create_file_structure(file_data, root)
calculate_dir_filesizes(root)

puts(get_sum_of_directories_under(root,100000))

puts(get_smallest_of_directories_over(root,30000000-(70000000-root.size)))