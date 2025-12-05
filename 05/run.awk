#!/usr/bin/env awk -f

BEGIN { FS = "-" }
/^[0-9]+-[0-9]+$/ { 

    # sorting needed for merging overlapping ranges
    # based on isort3
    for (j = NR; j > 1 && x[0, j-1] > $1; j--) {
        x[0, j] = x[0, j-1]
        x[1, j] = x[1, j-1]
    }
    x[0, j] = $1
    x[1, j] = $2

    n = NR
}
/^[0-9]+$/ { 
    for (i=1; i<=n; i++) {
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
    k = 1
    for (i = 1; i < n; i++) {
        m[0, k] = x[0, i]
        m[1, k] = x[1, i]

        # Already merged
        # Upper bound of merged is greater than this upper bound
        if (m[1, k-1] >= m[1, k]) continue

        for (j = i+1; j <= n; j++) {
            # Upper bound of current is in range of candidate
            # Move upper bound to candidate's upper bound
            if (x[0, j] <= m[1, k] && m[1, k] <= x[1, j]) {
                m[1, k] = x[1, j]
            }
        }
        k++
    }
    for (i = 1; i <= k-1; i++) r2 += m[1, i] - m[0, i] + 1
    print "PART 2:", r2
}
