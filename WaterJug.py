
def max_subarray_sum(arr):
    current_sum = arr[0]
    max_sum = arr[0]

    for num in arr[1:]:
        current_sum = max(num, current_sum + num)
        max_sum = max(max_sum, current_sum)

    return max_sum


def min_subarray_sum(arr):
    current_sum = arr[0]
    min_sum = arr[0]

    for num in arr[1:]:
        current_sum = min(num, current_sum + num)
        min_sum = min(min_sum, current_sum)

    return min_sum


arr = [-2, 3, -1, 5, -4]

print("Maximum subarray sum:", max_subarray_sum(arr))
print("Minimum subarray sum:", min_subarray_sum(arr))
