#!/bin/awk -f
{
        search="."
        n = split($1, parts, search)
        result=""
        for (i = 1; i <= $2; i++) {
            if (i>1) {
                result= result "."
            }
            result = result parts[i]
        }
        print result
}

