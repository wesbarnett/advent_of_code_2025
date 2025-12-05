#!/usr/bin/env awk -f

BEGIN { FS = "-" }
/^[0-9]+-[0-9]+$/ { 

    # sorting needed for merging overlapping ranges
    # sorts on lower bound
    # insertion sort, based on isort3 
    # https://books.google.com/books?id=kse_7qbWbjsC&pg=PA116#v=onepage&q&f=false
    for (j = NR; j > 1 && x[0, j-1] > $1; j--) {
        x[0, j] = x[0, j-1]
        x[1, j] = x[1, j-1]
    }
    x[0, j] = $1
    x[1, j] = $2

    n = NR
}
/^[0-9]+$/ { 
    for (i = 1; i <= n; i++) {
        if (x[0, i] <= $0 && $0 <= x[1, i]) {
            r += 1
            next
        }
    }
}
END { 
    print "PART 1:", r 

    # merge overlapping ranges
    # requires ranges to be sorted by lower bound
    # https://www.geeksforgeeks.org/dsa/merging-intervals/#expected-approach-checking-overlapping-intervals-only-onlogn-time-and-o1-space
    for (k = i = 1; i <= n; i++) {

        # If current interval overlaps with last interval, merge them
        if (x[0, i] <= m[1, k-1]) {
            m[1, k-1] = m[1, k-1] > x[1, i] ? m[1, k-1] : x[1, i]
        }
        # otherwise, add the current interval to the merged array
        else {
            m[0, k] = x[0, i]
            m[1, k] = x[1, i]
            k++
        }

    }
    for (i = 1; i <= k-1; i++) r2 += m[1, i] - m[0, i] + 1
    print "PART 2:", r2
}
