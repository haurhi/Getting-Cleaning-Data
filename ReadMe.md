# Getting-Cleaning-Data
Course Project

This is a coure project for the getting and Cleaning Data in the Data Science Specialization offered by JHU.

For the project, four files are provided in the repository:
- run_analysis.R
- CodeBook.md
- ReadMe.md
- tidy_set.txt

Here are the steps for creating a tidy dataset:

1. Read the filepaths and relevant files into R
2. Subset the test and train set and use rbind() command to merge them
3. Extract the terms with 'mean' and 'std'
4. Change the variable ('activity') into factors
5. Summarize the average of each variable based on each subject and the corresponding activities
6. Save the final result as a txt file