function alen(A, i, k) {
    k = 0
    for(i in A) k++
    return k
}

function qsort(A, idx) {
    n = alen(A)
    for (i = 1; i <= n; i++) idx[i] = i
    qsort_(A, idx, 1, n)
}

function qsort_(A, idx, first, last) {
    if (first < last) {
        p = partition(A, idx, first, last)
        qsort_(A, idx, first, p-1)
        qsort_(A, idx, p+1, last) 
    }
}

function swap(A, a, b) {
    t = A[a]; A[a] = A[b]; A[b] = t
}

function partition(A, idx, first, last) {

    pivot = A[first]
    left = first
    right = last

    while (left < right) {
        while (left <= right && A[left] <= pivot) left += 1
        while (left <= right && A[right] >= pivot) right -= 1

        if (right >= left) {
            swap(A, left, right)
            swap(idx, left, right)
        }
    }
    swap(A, first, right)
    swap(idx, first, right)

    return right
}
