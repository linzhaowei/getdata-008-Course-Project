# Getting and Cleaning Data Course Project

## Introduction
This is a repo for my Getting and Cleaning Data Course Project on Coursera. The run_analysis.R script processes a raw dataset and saves a new "tidy" dataset in txt format.

## Raw Data
The original dataset contains 10299 instances with 561 attributes, collected from 30 test subjects using the Samsung Galaxy S smartphone.
More details can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The dataset can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## How to use the script
This repo contains one R script called run_analysis.R, which will run in the working directory.
Before running it, you will need to extract the data set into a folder named "data" in the working directory.  
To run the script, type: `source("run_analysis.R")`
When the script finishes running, a tidy dataset in txt format ("data_tidy.txt") will be saved in the working directory.

## The Codebook
The Codebook explains the transformations made to the dataset and the reasoning behind the transformations. 

## Further reading
To find out more about tidy datasets, do read Hadley Wickham's paper Tidy Data.
http://vita.had.co.nz/papers/tidy-data.pdf
