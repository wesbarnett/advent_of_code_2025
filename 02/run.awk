#!/usr/bin/env awk -f
#
# Invalid ID is a number that is made up only of some sequence of digits repeated twice
#

BEGIN { FS = ",|-" }
{
    for (f = 1; f <= NF; f+=2) {

        for (n = $f; n <= $(f+1); n++) {

            len = length(n)
            if (len % 2 != 0) continue

            m = len / 2
            first = substr(n, 1, m)
            second = substr(n, m+1)

            if (first == second) r += n
        }
    }
}
END { print r }
