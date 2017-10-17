# Introduction

This repository contains the R code, Codebook and Readme which together make up my submission for the Week 4 project of the 'Getting & Cleaning Data' Coursera module.

This readme describes the project structure; how the scripts work and how they are connected.

Credit goes to David Hood who has written a really useful guide, which introduces different ways to think about the project. This guide can be found [here]( https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/).

# Files

* `CodeBook.md` - Describes everything about the data. This includes the source and processing approach, as well as the details of the tidy output.
* `Markdown Analysis.Rmd` - R Markdown file I used to build & debug data processing script
* `run_analysis.R` - Final R script for submission to coursera.
* `TidyData.txt` - Tidy Data in a format convenient to read back into R. 180 Rows of observations (participants x activities) with 88 columns (1 variable each)

# Structure
The project structure is simple, with the `run_analysis.R` file containing all the code to read in, process and write out the data. The code in `run_analysis.R` is a duplicate of the code found in the markdown document `Markdown Analysis.Rmd` without the extra explanatory text.
