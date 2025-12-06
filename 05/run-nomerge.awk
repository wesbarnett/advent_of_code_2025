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

    for (i = 1; i <= n; i++) {
        if (x[0, i] > h) r2 += x[1, i] - x[0, i] + 1
        else if (x[1, i] > h) r2 += x[1, i] - h
        h = h > x[1, i] ? h : x[1, i]
    }
    print "PART 2:", r2
}
