library(checkpoint)
checkpoint("2016-10-01", use.knitr = TRUE)

setwd("~/Projects/Sandbox/Workflow")

Sys.time0 <- Sys.time()

sink("script.log")
files <- c("header.yaml",
           "preamble.Rmd",
           "generateMarkdown.Rmd")
f <- file("master.Rmd", open = "w")
for (i in 1:length(files)) {
    x <- readLines(files[i])
    writeLines(x, f)
    if (i < length(files)) {writeLines("\n---\n", f)}
}
close(f)
library(knitr)
library(rmarkdown)
opts_chunk$set(fig.path = "figures/")
knit("master.Rmd", output = "README.md")
# pandoc("../docs/index.md", format = "html")
file.remove("master.Rmd")
sink()

sink("session.log")
list(completionDateTime = Sys.time(),
     executionTime = Sys.time() - Sys.time0,
     sessionInfo = sessionInfo())
sink()
