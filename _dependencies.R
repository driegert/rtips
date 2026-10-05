# Package declarations for renv (implicit snapshot mode).
#
# The tip .qmd files are mostly "coming soon" stubs without R chunks yet, so
# renv::dependencies() finds nothing to record. This file declares the packages
# the series needs; renv.lock is written from it. As tips get their real code,
# the library() calls in the .qmd files take over and this can shrink.

library(tidyverse)   # dplyr, tidyr, ggplot2, readr, tibble — parts 1-4
library(infer)       # part 5: hypothesis tests and confidence intervals
library(tidymodels)  # part 6: specs, workflows, metrics, tuning (pulls in tune)
library(readxl)      # owid-co2-data.xlsx
library(kableExtra)  # part 7: tables
library(openintro)   # us_temperature dataset (part 5, confidence intervals tip)
library(knitr)       # chunk evaluation
library(rmarkdown)   # rendering
library(yaml)        # config/front-matter parsing
