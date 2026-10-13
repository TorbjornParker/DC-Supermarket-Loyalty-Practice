# DataCamp Practice Exam | Modeling Supermarket Customer Loyalty
Contains files used for the practice exam for my DataCamp Data Scientist Associate in R certification.
DataCamp is a paid online learning platform offering courses and certifications in programming and statistics.

The project consisted of 4 Tasks, all of which needed to be passed and were graded by an auto-grader. The overall goal of the project was to create a model to predict the amount fictional customers would spend at a fictional supermarket chain.

NOTE TO R USERS OF DATACAMP: For some reason, this Practice Exam was unable to pass the auto-grader when the auto-grader's language was set to R. Python code producing identical output, tested with identical(), did work. I suspect the issue has to do with the auto-grader. Similar code did pass the actual practical exam, however.

The tasks of the practice exam:
  1. Clean all columns of data based on a list of specifications for each variable.
  2. Create new variables calculating the average spending and spending variance of customers, grouped by number of years in a loyalty program.
  3. Train a baseline model to predict the average annual spending per customer, test it on a testing dataset.
  4. Train a comparison model to predict the average annual spending per customer, test it on a testing dataset.

This project was written in R. The final code for the project was written by me in DataCamp's DataLab Notebook interface, using the tidyverse and randomForest packages. Helper functions for data cleaning were written by me using RStudio Ver. 2025.09.2+418. Conversion from Jupyter Notebook to R Markdown was done using R's jsonlite package.

To run this code for yourself:
  1. Download either the R Markdown or the R script file, as well as `loyalty.csv`, `test.csv`, and `train.csv` files in this repo.
  2. Run the R Markdown or R script file in RStudio or another R IDE. The filepath for loading files is already set to "Downloads."
  3. You may need to install the "tidyverse" and "randomForest" following packages before use, if you have not done so previously. To do this, open R and run: `install.packages("tidyverse")` and `install.packages("randomForest")`.

For further inquiries, contact me on LinkedIn at https://www.linkedin.com/in/torben-parker/, or on GitHub.

Citations:

Liaw A, Wiener M (2002). “Classification and Regression by randomForest.” _R News_, *2*(3), #18-22. <https://CRAN.R-project.org/doc/Rnews/>.

Ooms J (2014). “The jsonlite Package: A Practical and Consistent Mapping Between JSON Data and R Objects.” _arXiv:1403.2805 [stat.CO]_. <https://arxiv.org/abs/1403.2805>.

R Core Team (2025). _R: A Language and Environment for Statistical Computing_. R Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.

Wickham H, Averick M, Bryan J, Chang W, McGowan LD, François R, Grolemund G, Hayes A, Henry L, Hester J, Kuhn M, Pedersen TL, Miller E, Bache SM, Müller K, Ooms J, Robinson D, Seidel DP, Spinu V, Takahashi K, Vaughan D, Wilke C, Woo K, Yutani H (2019). “Welcome to the tidyverse.” _Journal of Open Source Software_, *4*(43), 1686. doi:10.21105/joss.01686 <https://doi.org/10.21105/joss.01686>.
