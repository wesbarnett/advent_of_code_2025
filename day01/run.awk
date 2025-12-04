#!/usr/bin/env awk -f
BEGIN { x = 50 }
{
    n = substr($1, 2)
    if (substr($1,1,1) == "L") n = -n
    x = (x + n) % 100
    r += x == 0
}
END { print r }
