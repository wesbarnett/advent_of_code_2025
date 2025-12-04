#!/usr/bin/env awk -f

BEGIN { FS="" }
{  
    for (x = 1; x <= NF; x++) {
        grid[x, NR] = $x == "@" 
    }
}
END {
    able_to_remove = 1
    while (able_to_remove) {
        able_to_remove = 0
        for (y = 1; y <= NR; y++) {
            for (x = 1; x <= NF; x++) {
                if (grid[x, y] && ((grid[x-1, y-1] + grid[x, y-1] + grid[x+1, y-1] + grid[x-1, y] + grid[x+1, y] + grid[x-1, y+1] + grid[x, y+1] + grid[x+1, y+1]) < 4)) {
                    grid[x, y] = 0
                    res += 1
                    able_to_remove = 1
                }
            }
        }
    }
    print res
}
