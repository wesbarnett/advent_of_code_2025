#!/usr/bin/env awk -f

BEGIN { FS="" }
{  
    for (x = 1; x <= NF; x++) {
        grid[x, NR] = $x == "@" 
    }
}
END {
    for (y = 1; y <= NR; y++) {
        for (x = 1; x <= NF; x++) {
            if (grid[x, y] && ((grid[x-1, y-1] + grid[x, y-1] + grid[x+1, y-1] + grid[x-1, y] + grid[x+1, y] + grid[x-1, y+1] + grid[x, y+1] + grid[x+1, y+1]) < 4)) {
                res += 1
            }
        }
    }
    print res
}
