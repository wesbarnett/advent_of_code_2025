#!/usr/bin/env awk -f

function sum_neighbs(g, x, y) {
    return   g[x-1, y-1] + g[x, y-1] + g[x+1, y-1]\
           + g[x-1, y]               + g[x+1, y]\
           + g[x-1, y+1] + g[x, y+1] + g[x+1, y+1]
}

BEGIN { FS="" }
{ for (x = 1; x <= NF; x++) g[x, NR] = $x == "@" }
END {
    for (y = 1; y <= NR; y++) {
        for (x = 1; x <= NF; x++) {
            if (g[x, y] && sum_neighbs(g, x, y) < 4) {
                r += 1
            }
        }
    }
    print r
    
    v = 1
    r = 0
    while (v) {
        v = 0
        for (y = 1; y <= NR; y++) {
            for (x = 1; x <= NF; x++) {
                if (g[x, y] && sum_neighbs(g, x, y) < 4) {
                    r += 1
                    g[x, y] = 0
                    v = 1
                }
            }
        }
    }
    print r
}
