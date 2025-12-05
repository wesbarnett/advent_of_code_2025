#!/usr/bin/env gawk -f

@include "qsort.awk"

function merge_ranges(n, x0, x1, merged_0, merged_1,     i) {
    # Merge ranges together, eliminating overlaps
    # Inputs:
    #   n = size of input arrays
    #   x0 = array of lower ends of ranges
    #   x1 = array of upper ends of ranges
    #   merged_0 = array of upper ends of merged ranges
    #   merged_1 = array of upper ends of merged ranges
    # Returns: size of output arrays

    # Sort x0 and get back the sorted index as well to use with x1
    qsort(x0, idx)

    k = 1
    for (i = 1; i <= n; i++) {
        start = x0[i]
        end = x1[idx[i]]

        if (merged_1[k-1] >= end) continue

        for (j = i+1; j <= n; j++) {
            if (x0[j] <= end) {
                end = end > x1[idx[j]] ? end : x1[idx[j]]
            }
        }

        merged_0[k] = start
        merged_1[k] = end
        k++
    }
    return k-1
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

    n = merge_ranges(n, x0, x1, merged_0, merged_1)
    for (i = 1; i <= n; i++) r2 += merged_1[i] - merged_0[i] + 1
    print "PART 2:", r2
}
