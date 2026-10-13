# File verification

library(tidyverse)

# Helper functions

# ** = I used this function in the practical exam as well.

# Function for checking for non-matches**. Prints all non-matching values in a 
# vector of target categories
print_nonmatch <- function(my_vector, target_categories) {
  nonmatch_strings <- my_vector[!my_vector %in% target_categories]
  intro_string <- str_c("Nonmatched strings in ", 
                        deparse(substitute(my_vector)), ":")
  print(intro_string)
  print(unique(nonmatch_strings))
  print(str_c("Number of nonmatched strings = ", 
              as.character(length(nonmatch_strings))))
}

# Function for checking for matches. Prints the number of rows in the 
# dataset that have a match in a target vector.
check_categories <- function(my_vector, target_categories) {
  num_matches <- length(my_vector[my_vector %in% target_categories])
  print(str_c("Number of correct rows in ", deparse(substitute(my_vector)), 
              " = ", as.character(num_matches)))
}

# Function for counting NAs**.
count_na <- function(my_vector) {
  na_count <- sum(is.na(my_vector))
  print(str_c("Number of NAs in ", 
              deparse(substitute(my_vector)), 
              ": ", as.character(na_count)))
}

# Function for checking for non-number characters**. Takes in a string vector, 
# returns all values that have some sort of non-number character.
check_nonnumber <- function(my_vector) {
  nonnumber_strings <- str_subset(my_vector, "^[0123456789.]+$", negate = TRUE)
  num_nonnumber <- length(nonnumber_strings)
  if (num_nonnumber == 0) {
    print("Number of non-number rows = 0")  
  } else {
    print(str_c("Number of non-nunber rows = ", as.character(num_nonnumber)))
    print("Non-number strings:")
    print(nonnumber_strings)
  }
}

# Function for checking if data is within a range.
# Takes in a number vector 'my_vector', sign for direction of range, and 
# benchmark value 'n'. Returns number of values not in range.
check_range <- function(my_vector, sign, n) {
  if(sign == "greater") {
    rows_g <- my_vector[my_vector > n & is.na(my_vector) == FALSE]
    numrows_g <- length(rows_g)
    numrows_correct_range <- numrows_g
  } else if (sign == "less") {
    rows_l <- my_vector[my_vector < n & is.na(my_vector) == FALSE]
    numrows_l <- length(rows_l)
    numrows_correct_range <- numrows_l
  } else if (sign == "greater than or equal to") {
    rows_ge <- my_vector[my_vector >= n & is.na(my_vector) == FALSE]
    numrows_ge <- length(rows_ge)
    numrows_correct_range <- numrows_ge
  } else if (sign == "less than or equal to") {
    rows_le <- my_vector[my_vector <= n & is.na(my_vector) == FALSE]
    numrows_le <- length(rows_le)
    numrows_correct_range <- numrows_le
  } else {
    numrows_correct_range <- -1
  }
  print(str_c("Number of rows in correct range = ",
              as.character(numrows_correct_range)))
}

# Function for checking if there are just-decimal rows
count_decimals <- function(my_vector) {
  decimals_nospace <- str_subset(my_vector, pattern = "^\\.+$")
  decimals_frontspace <- str_subset(my_vector, pattern = " \\.")
  decimals_backspace <- str_subset(my_vector, pattern = "\\. ")
  print("Number of decimals-only:")
  print(length(decimals_nospace))
  print("Number of space + decimal:")
  print(length(decimals_frontspace))
  print("Number of decimal + space:")
  print(length(decimals_backspace))
}

# Use this cell to write your code for Task 1

# Task 1a. File loading

clean_data_old <- read_csv("loyalty.csv")
test_data <- read_csv("test.csv")
training_data <- read_csv("train.csv")

# Task 1b. Data examination

str(clean_data_old)
# Dataset is 1,246 rows, 8 columns long. 
# Rows are different customers, columns are variables.

# 'spend' is a number. This is correct.
count_na(clean_data_old$spend) 
# No NAs. To do: round to 2 decimal places.

# 'first_month' is a character. It should be a number.
count_na(clean_data_old$first_month) 
# No NAs
check_nonnumber(clean_data_old$first_month) 
# No non-number rows
count_decimals(clean_data_old$first_month)
# 125 rows of just decimals "."

# 'items_in_first_month' is an integer. This is correct.
count_na(clean_data_old$items_in_first_month)
# No NAs

# 'region' is a character. This is correct.
check_categories(clean_data_old$region, c("Americas", "Asia/Pacific", "Europe", 
                                          "Middle East/Africa")) 
# Categories are correct as well. To-do: convert to factor.

# 'loyalty_years' is a character.
check_categories(clean_data_old$loyalty_years, c('0-1', '1-3', '3-5', '5-10', 
                                                 '10+')) 
# Categories are correct as well. To-do: convert to ordinal factor.

# 'joining_month' is a character. This is correct.
check_categories(clean_data_old$joining_month, c("Jan", "Feb", "Mar", "Apr", 
                                                 "May", "Jun", "Jul", "Aug", 
                                                 "Sep", "Oct", "Nov", "Dec")) 
# 1121 rows, so some are incorrect
count_na(clean_data_old$joining_month) 
# 125 rows of NA
# To-do: replace NAs with "Unknown", convert to factor

# 'promotion'	is a character. This is correct.
check_categories(clean_data_old$promotion, c("Yes", "No")) 
# 1121 rows are correct
print_nonmatch(clean_data_old$promotion, c("Yes", "No")) 
# Many are upper-case
count_na(clean_data_old$promotion) 
# To-do: Make title case, convert to factor

# Task 1c. NA removal

clean_data_no_na <- clean_data_old %>%
  mutate(first_month = str_trim(first_month)) %>%
  mutate(first_month = str_replace_all(first_month, "^\\.$", "0")) %>%
  mutate(joining_month = replace_na(joining_month, "Unknown"))

# Task 1d. Data types, range

# Changing data types
clean_data <- clean_data_no_na %>%
  mutate(spend = round(spend, digits = 2),
         first_month = as.numeric(first_month),
         first_month = round(first_month, digits = 2),
         items_in_first_month = round(items_in_first_month, digits = 0),
         items_in_first_month = as.integer(items_in_first_month),
         promotion = str_to_title(promotion),
         region = as.factor(region),
         loyalty_years = factor(clean_data_no_na$loyalty_years, ordered = TRUE, 
                                levels = c('0-1', '1-3', '3-5', '5-10', '10+')),
         joining_month = as.factor(joining_month),
         promotion = as.factor(promotion))

# Task 1e. Verification 

# 'spend':
is.numeric(clean_data$spend)
check_range(clean_data$spend, "greater than or equal to", 0)
count_na(clean_data$spend)
# 'first_month':
is.numeric(clean_data$first_month)
check_range(clean_data$first_month, "greater", 0)
count_na(clean_data$first_month)
# 'items_in_first_month':
is.integer(clean_data$items_in_first_month)
check_range(clean_data$items_in_first_month, "greater than or equal to", 0)
count_na(clean_data$items_in_first_month)
# 'region':
is.factor(clean_data$region)
check_categories(clean_data$region, c("Americas", "Asia/Pacific", "Europe", 
                                      "Middle East/Africa", "Unknown"))
count_na(clean_data$region)
# 'loyalty_years':
is.factor(clean_data$loyalty_years)
print(levels(clean_data$loyalty_years))
check_categories(clean_data$loyalty_years, c('0-1', '1-3', '3-5', '5-10', '10+'))
count_na(clean_data$loyalty_years)
# 'joining_month':
is.factor(clean_data$joining_month)
print(levels(clean_data$joining_month))
check_categories(clean_data$joining_month, c("Jan", "Feb", "Mar", "Apr", "May", 
                                             "Jun", "Jul", "Aug", "Sep", "Oct", 
                                             "Nov", "Dec", "Unknown"))
# 'promotion':
is.factor(clean_data$promotion)
print(levels(clean_data$promotion))
check_categories(clean_data$promotion, c("Yes", "No"))
count_na(clean_data$promotion)

# Use this cell to write your code for Task 2

# Goal: the difference in the average spend by number of years, and variance.
# Targets: loyalty_years, average_spend, var_spend.
spend_by_years <- clean_data %>%
  group_by(loyalty_years) %>%
  mutate(average_spend = round(mean(spend), digits = 2),
         var_spend = round(var(spend), digits = 2)) %>%
  select(loyalty_years, average_spend, var_spend)

# Use this cell to write your code for Task 3

# Package loading, dataset attachment
library(tidyverse)
training_dataset_1 <- read_csv('train.csv')
testing_dataset_1 <- read_csv('test.csv')

# Creation of the simple linear model, comparing number of years to spend
yearSpend_lm <- lm(spend ~ loyalty_years, data = training_dataset_1)

# Prediction using model
base_result <- testing_dataset_1 %>%
  mutate(spend = predict(yearSpend_lm, newdata = testing_dataset_1)) %>%
  select(customer_id, spend)

# Use this cell to write your code for Task 4

# Package loading, dataset attachment
library(randomForest)
training_dataset <- read_csv('train.csv')
testing_dataset <- read_csv('test.csv')

# Examine structure
str(training_dataset)
# Training dataset is 996 rows, 8 columns. Same format as from step 1.
str(testing_dataset)
# Testing dataset is 250 rows, 7 columns. All vars except spend.

# Model training
forest_model_beta <- randomForest(spend ~ first_month + items_in_first_month
                                  + region + loyalty_years + joining_month
                                  + promotion, data = training_dataset, 
                                  ntree = 500, mtry = 2, nodesize = 5, 
                                  importance = TRUE)
varImpPlot(forest_model_beta)
# Remove all variables except for loyalty years:

forest_model_loyalty <- randomForest(spend ~ loyalty_years, 
                                     data = training_dataset, ntree = 150, 
                                     mtry = 1, nodesize = 5, importance = TRUE)
plot(forest_model_loyalty)
# Reduce ntree to about 150, mtry to 1

# Application of model to testing dataset
compare_result <- testing_dataset %>%
  mutate(spend = predict(forest_model_loyalty, newdata = testing_dataset)) %>%
  select(customer_id, spend)
