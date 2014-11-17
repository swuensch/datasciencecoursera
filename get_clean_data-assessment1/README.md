# Getting and cleaning data: Peer assessment 1

The contribution to this assignment consists of two files:

- R script: analysis.R 
- Produced code book: data_dict.txt

The R script downloads the original data set from the internet and unzips it in the current working directory. We read the feature vectors for the test and training set as well as the labels and the subjects and combine each of them to one data set.

The selected columns of the combined feature matrix are finally aggregated by subject and activity.

This result gets printed to file *aggregated_data.txt*. A code book assembled automatically based on the selected features.
