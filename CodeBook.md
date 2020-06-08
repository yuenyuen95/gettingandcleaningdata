#### Explaining the data

This project uses 8 data files; features.txt, activity_labels.txt, X_train.txt, X_test.txt, y_train.txt, y_test.txt, subject_train.txt, subject_test.txt, that can be found inside the downloaded dataset, the UCI HAR Dataset

features.txt contains the variable names that correspond with each column of the set data, X_train.txt & X_test.txt

activity_labels.txt contains descriptive names of each Activity label and their respective codes which matches the codes on the label data, y_train.txt & y_test.txt

subject_train.txt and subject_test.txt contain the subject identifiers 

#### Workflow

1. Load the {dpylr} package

2. Download the UCI HAR Dataset 

3. Read each of the required data files as data frames using the read.table() function and assign them names

4. Within the read.table() function, assign column names using the col.name argument. For the set data x_train and x_test, reference the column names from the Functions column of 'features'.

5.Merge the training and test sets using rbind() function: 

        'set' is created by merging x_train & x_test
        'label' is created by merging y_train & y_test 
        'subject' is created by merging subject_train & subjct_test

Note: Do not column bind them together yet

6. Use the grep() function to select just the items with the word "mean" or "std" in it from 'features' and store the result in 'selected_col'

7. Subset the selected columns from 'set' and store the results in 'set' again

8. In 'label', replace the codes in the Code column with its respective descriptive activity in 'activity_labels' and rename the column name Activity.

9. Retrieve the correct names of the selected columns from 'features' and rename the column names using the gsub() function to make the variable names easier to understand

        replaced -mean() with Mean
        replaced -std() with Std
        removed all stray () and - 

10. Assign the new column names to 'set'

11. Merge 'subject', 'label' and 'set' using the cbind() function to create one dataset  

12. Convert the variables Activity and Subject into a factor

        Activity: Factor w/ 6 levels
        Subject: Factor w/ 30 levels

13. Group the merged dataset 'merged_data' by Subject and Activity, and summarize the data by taking the mean of each variable for each subject and activity.

14. Export the final data as a txt file 
        
        'final.txt'