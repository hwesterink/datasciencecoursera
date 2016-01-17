files_full <- list.files("diet_data", full.names = TRUE)
tmp2 <- lapply(files_full, read.csv)
comb_data <- do.call(rbind, tmp2)
str(comb_data)
