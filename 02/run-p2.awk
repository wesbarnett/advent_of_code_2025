#!/usr/bin/env awk -f
#
# Invalid ID is a number that is made up only of some sequence of digits repeated twice
#

BEGIN { FS = ",|-" }
{
    for (f = 1; f <= NF; f+=2) {

        for (n = $f; n <= $(f+1); n++) {

            len = length(n)

            for (w = 1; w < len; w++) {

                if (len % w != 0) continue
                invalid_for_this_window = 1

                for (i = 1; i <= (len-w); i+=w) {
                    first = substr(n, i, w)
                    second = substr(n, i+w, w)

                    if (first != second) {
                        invalid_for_this_window = 0
                        break
                    }

                }

                if (invalid_for_this_window) {
                    r += n
                    break

                }
            }
        }
    }
}
END { print r }
