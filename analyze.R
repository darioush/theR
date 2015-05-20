source('~/coverage-paper/data/util.R')
source('~/coverage-paper/data/a12.R')


library(data.table)
library(sqldf)
load_data <- function (path) {
  tsj <<- fread(paste0(path, "testselection_joined.csv"))
  tsj$experiment <<- paste(tsj$base, tsj$select_from, sep="_")
  tsj$BID <<- paste(tsj$project, tsj$version, sep="_")
  tsi <<- fread(paste0(path, "testselection_ri.csv"))
  tsi$BID <<- paste(tsi$project, tsi$version, sep="_")
}

consistency_checks <- function(tsj) {
  
}

algs <- c("G", "GE", "GRE", "GREQ")
experiments <-c("0_B.F", "0_G", "B_G", "0_B.F.G")  #c(list("0_B.F"), list("0_G", "0_R"), list("B_G", "B_R"), list("0_B.F.G", "0_B.F.R"))
exps <- data.frame(pool=experiments, names=c("dev", "sel_gen", "aug", "sel_all"))

sel_experiments <- function(tsj) {
  for (exp in experiments) {
    mask <- F
    for (pool in exp) {
      mask <- mask | tsj$experiment==pool
    }
    subset(tsj, mask)
  }
}

plotForAlg <- function(sre_agg, alg) {
  hist(sre_agg$avg_faults[which(sre_agg$algorithm==alg)], main=alg)
}

plotAllAlg <- function(sre_agg) {
  for (alg in algs) {
    plotForAlg(sre_agg, alg)
  }
}