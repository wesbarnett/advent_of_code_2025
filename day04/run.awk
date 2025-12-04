#!/usr/bin/env awk -f

BEGIN { FS="" }
{ for (x = 1; x <= NF; x++) g[x, NR] = $x == "@" }
END {
    for (y = 1; y <= NR; y++) {
        for (x = 1; x <= NF; x++) {
            if (g[x, y] &&\
            ( g[x-1, y-1] + g[x, y-1] + g[x+1, y-1]\
            + g[x-1, y]               + g[x+1, y]\
            + g[x-1, y+1] + g[x, y+1] + g[x+1, y+1] < 4)) {
                r += 1
            }
        }
    }
    print r
}
