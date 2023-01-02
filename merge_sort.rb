def merge_sort(arr)
    return arr if arr.length == 1
    half_left = arr[0..arr.length / 2 - 1]
    half_right = arr[arr.length / 2..arr.length - 1]
    half_left = merge_sort(half_left)
    half_right = merge_sort(half_right)
    sorted_arr = []
    
    until (half_left.length == 0 && half_right.length == 0) do
        if (half_left.length != 0 && half_right.length == 0)
            half_left.each {|value| sorted_arr << value}
            break
        end
        if (half_left.length == 0 && half_right.length != 0)
            half_right.each {|value| sorted_arr << value}
            break
        end

        if half_left[0] <= half_right[0]
            sorted_arr << half_left[0]
            half_left.delete_at(0)
        elsif half_left[0] > half_right[0]
            sorted_arr << half_right[0]
            half_right.delete_at(0)
        end
    end
    sorted_arr
end

arr = [5,3,1,2,4,7,6,10,9,11]
p merge_sort(arr)