crea_inv_matrix <- function(mx)  {
    inv_matrix <- matrix(0, mx, mx)
    for(i in 1:mx)  {
        inv_matrix[i, i:mx] <- 1
    }
    inv_matrix
}