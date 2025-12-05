#!/usr/bin/env gawk -f

BEGIN { FS = "-" }
/^[0-9]+-[0-9]+$/ { 
    x0[NR] = $1
    x1[NR] = $2

    # sorting needed for merging overlapping ranges
    j = NR
    while (x0[j] <= x0[j-1]) {
        tmp = x0[j-1]
        x0[j-1] = x0[j]
        x0[j] = tmp

        tmp = x1[j-1]
        x1[j-1] = x1[j]
        x1[j] = tmp
        j--
    }
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

    # merge overlapping ranges
    k = 1
    for (i = 1; i <= n; i++) {
        start = x0[i]
        end = x1[i]

        if (merged_1[k-1] >= end) continue

        for (j = i+1; j <= n; j++) {
            if (x0[j] <= end) {
                end = end > x1[j] ? end : x1[j]
            }
        }

        merged_0[k] = start
        merged_1[k] = end
        k++
    }
    for (i = 1; i <= k-1; i++) r2 += merged_1[i] - merged_0[i] + 1
    print "PART 2:", r2
}
