#!/usr/bin/env gawk -f

BEGIN { FS = "-" }
/^[0-9]+-[0-9]+$/ { 
    x0[NR] = $1
    x1[NR] = $2

    # sorting needed for merging overlapping ranges
    for (i = NR; x0[i] <= x0[i-1]; i--) {
        t = x0[i-1]; x0[i-1] = x0[i]; x0[i] = t
        t = x1[i-1]; x1[i-1] = x1[i]; x1[i] = t
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
    # requires ranges to be sorted by lower bound
    k = 1
    for (i = 1; i <= n; i++) {
        m0[k] = x0[i]
        m1[k] = x1[i]

        # Already merged
        # Upper bound of merged is greater than this upper bound
        if (m1[k-1] >= m1[k]) continue

        for (j = i+1; j <= n; j++) {
            # Upper bound of current is in range of candidate
            # Move upper bound to candidate's upper bound
            if (x0[j] <= m1[k] && m1[k] <= x1[j]) {
                m1[k] = x1[j]
            }
        }
        k++
    }
    for (i = 1; i <= k-1; i++) r2 += m1[i] - m0[i] + 1
    print "PART 2:", r2
}
