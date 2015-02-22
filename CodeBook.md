Getting and Cleaning Data 
Course Project 2

Description

    This codebook.md file will provide additional, and more specific, information about the input data, R code and analysis process used in run_analysis.R

Source Data Set

    The source data for this assignment can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

    The data is presented across eight different input files, and describes an experiment that was conducted using a smartphone to analyze the movement in three dimensional space for a group of thirty volunteer test subjects.

Analysis Process

    I will walk through the code in run_analysis.R and use the comments in that file as reference points.

    - setting working directory
        here I simply set the directory from where I will be working

    - reading in the test data
        here I read in X_test.txt, Y_test.txt and subject_test.txt and store them into appropriately named data tables

    - reading in the training data
        here I read in X_train.txt, Y_train.txt and subject_train.txt and store them into appropriately named data tables

    - combining the data to create one data set
        here i use cbind and rbind functions to merge the test and train data sts

    - extract measurements for mean and standard deviation
        I create a logical vector using the grepl function

    - clean up variable names
        in a loop, i perform some transformations on the column names to make them more readable

    - reassign the clean names to the final data set
        using the dataset we just manipulated in the previous step

    - create a tidy data set
        this is where I do the final transformation and then write out the resulting data using write.table