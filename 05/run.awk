#!/usr/bin/env gawk -f

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

    # Naively just take the size of each range and add them
    for (i=1; i<=n; i++) {
        c[i] = x1[i] - x0[i] + 1
        r2 += c[i]
    }

    # Now remove overlaps where we double counted
    for (i=1; i<n; i++) {
        for (j=i+1; j<=n; j++) {
            if (x0[i] <= x1[j] && x0[j] <= x1[i]) {
                overlap = (x1[i] < x1[j] ? x1[i] : x1[j]) - (x0[i] > x0[j] ? x0[i] : x0[j]) + 1
                # Careful not to remove the same overlap twice
                if (c[i] > 0) {
                    r2 -= c[i] < overlap ? c[i] : overlap
                }
                c[i] -= overlap
            }
        }
    }
    print "PART 2:", r2
}
