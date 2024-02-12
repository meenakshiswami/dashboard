

library(shinydashboard)
library(survminer)
library(DT)
library(survival)
library(haven)
library(shiny)
library(gt)
library(tidyverse)
library(shinydashboardPlus)
library(plotly)
library(reshape2)
set.seed(35)
dat <-  data.frame(Subject = 1:15, 
                   Months = sample(5:20, 15, replace=TRUE),
                   Treated = sample(0:1, 15, replace=TRUE),
                   Stage = sample(1:4, 15, replace=TRUE),
                   Continued = sample(0:15, 15, replace=TRUE))
dat <-  dat %>%
  group_by(Subject) %>%
  mutate(
    Complete = sample(c(4:(max(Months)-1),NA), 1,
                      prob = c(rep(1, length(4:(max(Months)-1))),5), replace=TRUE),
    Partial = sample(c(4:(max(Months)-1),NA), 1,
                     prob = c(rep(1, length(4:(max(Months)-1))),5), replace=TRUE),
    Durable = sample(c(-0.5,NA), 1, replace=TRUE)
  )
dat$Subject <- factor(dat$Subject, levels=dat$Subject[order(dat$Months)])
dat.m <- melt(dat %>% select(Subject, Months, Complete, Partial, Durable),
              id.var=c("Subject","Months"), na.rm = TRUE)
adrs <- data.frame(
  id = c(1:56),
  type = sample(rep(c("laMCC", "metMCC"), times = 28)),
  response = c(30,sort(runif(n=53, min = -10,max =19),decreasing=TRUE),-25,-31),
  dose = sample(rep(c(80, 150), 28))
)
#  assign Best Overall Response (BOR)
adrs$BOR = c("PD", rep(c("SD"), times = 54), "PR")
# Specify the path to  XPT file# Read the XPT file into R
xpt_file_path <- "C:/Users/Devendra/Downloads/adamdata/xpt/adtte.xpt"
adtte1 <- read_xpt(xpt_file_path)
adae1 <- read_xpt("C:/Users/Devendra/Downloads/adamdata/xpt/adae.xpt")
adlbsi1 <- read_xpt("C:/Users/Devendra/Downloads/adamdata/xpt/adlbsi.xpt")
lbshift <- read_xpt("C:/Users/Devendra/Downloads/labshift.xpt")