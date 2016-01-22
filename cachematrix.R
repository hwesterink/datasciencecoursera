## This file contains two functions that can invert an invertable matrix
## and store the result in cache. If the user tries to invert a matrix
## that is already stored in cache, the functions will retrieve the stored
## inverted matrix automatically and return it to the user.


## The function makeCacheMatrix() creates a Cache Matrix where the inverse
## matrix will be stored. The argument in this fuction is the matrix that
## has to be inverted.
## The output of this function is a list containing subfunctions that must be
## used as input to the function cacheSolve.

makeCacheMatrix <- function(x = matrix())  {
    m <- NULL
    set <- function(y)  {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) m <<- inverse
    getinverse <- function() m
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## The function cacheSolve uses the output (a list of functions) from the
## makeCacheMatrix function as input argument. After this argument additional
## input for the Solve function used by cacheSolve can be added.
## This function first checkes whether there already is an inverse matrix
## stored in cache. If so it retreaves this inverse and returns it from the
## function. If the inverse matrix is not available it will be computed,
## stored in cache and returned from the function.
## The output of this function is the inverse of the matrix that was used as
## input to the previous function (makeCacheMatrix()).

cacheSolve <- function(x, ...)  {
    m <- x$getinverse()
    if(!is.null(m))  {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}
