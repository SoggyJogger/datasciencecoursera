## Code for Coursera course: R Programming, week 3 assignment

## Contains two functions that together will cache the inverse of a matrix (to
## test, first run 1 on a matrix, then run 2 on the object assigned to 1;
## run function 2 twice to observe it will prioritize cached data the second time).

## 1. The makeCacheMatrix() function creates a special 'matrix' object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setInverse <- function(solve) m <<- solve
  getInverse <- function() m
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}

## 2. The cacheSolve() function computes the inverse of the special 'matrix' returned by makeCacheMatrix()
## above. If the inverse has already been calculated (and the matrix has not changed), then cacheSolve()
## should retrieve the inverse from the cached value.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getInverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setInverse(m)
  m
}

## end of script
