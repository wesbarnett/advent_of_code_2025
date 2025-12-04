#!/usr/bin/env awk -f
BEGIN { x = 50 }
{
    n = substr($1, 2)

    # How many times did the dial turn when we added n
    r += int(n/100)

    if (substr($1,1,1) == "L") n = -n

    # Does the dial cross 0 when adding n to x?
    x += n % 100
    if (p != 0 && x <= 0 || x >= 100) r+= 1

    # Shift x to the correct range
    x %= 100
    if (x < 0) x += 100

    p = x
}
END { print r }
