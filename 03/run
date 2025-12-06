#!/usr/bin/env awk -f
#
# Find the largest possible combination of two digits (part 1) and twelve digits (part 2); digits must be in order, but
# don't have to be adjacent
#
# pass '-v size=2' for part 1 and '-v size=12' for part 2

BEGIN { FS="" }

{
    max_i = 0
    x = ""
    for (j=1; j<=size; j++) {
        max = 0
        # Find the largest number in the window. Window size is based on how many digits are required in the number,
        # where the most recent found digit to the left is, and the size of the number being scanned
        for (i=max_i+1; i<=NF-size+j; i++) {
            if ($i > max) {
                max = $i
                max_i = i
            }
        }
        x = x max
    }
    r += x
}

END { print r }
