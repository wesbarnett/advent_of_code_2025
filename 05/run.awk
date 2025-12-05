#!/usr/bin/env gawk -f
#
function helper(x0, x1, first, last) {
    if (first < last) {
        split_point = partition(x0, x1, first, last)
        helper(x0, x1, first, split_point-1)
        helper(x0, x1, split_point+1, last) 
    }
}

function qsort(x0, x1, nr) {
    helper(x0, x1, 1, nr)
}

function partition(x0, x1, first, last) {

    pivot_val = x0[first]
    left = first
    right = last

    while (left < right) {

        while (left <= right && x0[left] <= pivot_val) {
            left += 1
        }

        while (left <= right && x0[right] >= pivot_val) {
            right -= 1
        }

        if (right >= left) {
            tmp = x0[left]
            x0[left] = x0[right]
            x0[right] = tmp

            tmp = x1[left]
            x1[left] = x1[right]
            x1[right] = tmp
        }

    }

    tmp = x0[first]
    x0[first] = x0[right]
    x0[right] = tmp

    tmp = x1[first]
    x1[first] = x1[right]
    x1[right] = tmp

    return right
}

BEGIN { FS = "-" }
/^[0-9]+-[0-9]+$/ { 
    x0[NR] = $1
    x1[NR] = $2
    n = NR
}
/^[0-9]+$/ { 
    for (i=1; i<=n; i++) {
        if (x0[i] <= $0 && $0 <= x1[i]) {
            r += 1
            next
        }
    }
}
END { 
    print "PART 1:", r 

    # Sort ranges by start of range
    qsort(x0, x1, n)

    k = 1
    for (i = 1; i <= n; i++) {
        start = x0[i]
        end = x1[i]

        if (merged_1[k-1] >= end) {
            continue
        }

        for (j = i+1; j <= n; j++) {
            if (x0[j] <= end) {
                end = end > x1[j] ? end : x1[j]
            }
        }

        merged_0[k] = start
        merged_1[k] = end
        k++
    }

    for (i = 1; i <= k-1; i++) {
        r2 += merged_1[i] - merged_0[i] + 1
    }
    print "PART 2:", r2
}
