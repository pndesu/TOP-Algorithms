def fibs(num)
    p [0] if num == 1
    p [0,1] if num == 2
    if num > 2
        arr = [0,1]
        for i in 3..num
            arr << arr[i-2] + arr[i-3]
        end
        p arr
    end
end

def fibs_rec(num)
    return [0] if num == 0
    return [0,1] if num == 1
    arr = fibs_rec(num - 1)
    arr << arr[-2] + arr[-1]
end

p fibs_rec(8)