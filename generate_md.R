generateDescription = function(name) {
  if (name == "activity_label") {
    return("Activity name")
  }
  
  if (name == "subject") {
    return("Identifier of a subject carrying out activity")
  }
  
  name = gsub("^time", " time of the", name)
  name = gsub("^frequency", " frequency of the", name)
  name = gsub("Body", " body", name)
  name = gsub("Acc", " acceleration", name)
  name = gsub("Gyro", " velocity", name)
  name = gsub("_mean", " mean values", name)
  name = gsub("_std", " standard deviations", name)
  name = gsub("Mag", " magnitude", name)
  name = gsub("Gravity", " gravity", name)
  name = gsub("_([X|Y|Z])", ", \\1 component", name)
  name = gsub("Freq", " frequency", name)
  name = gsub("Jerk", " Jerk", name)
  
  return(paste0("Mean value for the current activity for the current subject of", name))
}

write.CodeBook <- function(df = data.frame(), out.file = NULL, rm.exist = TRUE) {
  if (file.exists(out.file) && rm.exist) { unlink(out.file) }
  fconn <- file(out.file, open = "at")
  writeLines("Means of the wearable devices measurements codebook\n=====\n", fconn)
  
  for (v in names(df)) {
    col.values <- df[,v]
    dtype <- class(col.values)
    width <- max(nchar(as.character(col.values)))
    writeLines(sprintf("### %s", v), fconn)
    writeLines(sprintf("\tData Type: %s\n\tData Width: %s", dtype, width), fconn)    
    writeLines(sprintf("\tDescription: %s\n", generateDescription(v)), fconn) 
  }
  
  close(fconn)
}

mfile <- "CodeBook.md"
fd = read.table("means.txt", header = TRUE)
names(fd)
write.CodeBook(fd, out.file=mfile, rm.exist= TRUE)