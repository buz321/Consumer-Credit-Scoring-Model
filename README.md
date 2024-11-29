# Consumer Credit Scoring Model

Consumer Credit Scoring model using data from Lending Club Card (https://www.kaggle.com/datasets/wordsforthewise/lending-club/code)

## Overview

This project implements a **consumer credit scoring model** using **SAS**, focusing on predicting creditworthiness by analyzing customer features. The model is designed to classify credit risk effectively, leveraging data preprocessing, feature engineering, and logistic regression. It provides financial institutions with a robust framework for credit scoring.

---

## Features

1. **Data Import and Preparation**:
   - Imported raw data from `final_dataset.csv`.
   - Explored data characteristics with frequency tables and descriptive statistics.

2. **Categorical Variable Analysis**:
   - Analyzed key features such as `home_ownership` and `verification_status`.
   - Created coarse-classified variables for simplified groupings.

3. **Numeric Variable Transformation**:
   - Binned numeric variables such as `loan_amnt`, `fico_score`, and `dti`.
   - Derived weights of evidence (WOE) for predictive variables.

4. **Logistic Regression**:
   - Built logistic regression models with dummy variables to predict `flagbinary`.
   - Evaluated performance using ROC curves and R-squared values.

5. **Result Export**:
   - Scored the dataset and exported results to `wow.xlsx` for further analysis.

---

## Workflow

1. **Data Import**:
   - Loaded the dataset from `M:\CRM\final_dataset.csv` using `PROC IMPORT`.

2. **Exploratory Data Analysis (EDA)**:
   - Used `PROC FREQ` to explore categorical features.
   - Visualized numeric variables like `loan_amnt` using histograms.

3. **Feature Engineering**:
   - Coarse classification for both categorical and numeric variables.
   - Binned numeric variables like `fico_score` and `loan_amnt` into groups.

4. **Logistic Regression**:
   - Performed logistic regression using coarse-classified variables.
   - Assessed model performance with ROC curves and statistical metrics.

5. **Export Results**:
   - Exported predictions to `wow.xlsx` for validation and reporting.

---


## Technologies Used

- **Programming Language**: ![SAS](https://img.shields.io/badge/SAS-005DAC?style=for-the-badge)

- **Procedures**:
  - `PROC IMPORT`: For importing datasets.
  - `PROC FREQ`: For frequency analysis and exploring data.
  - `PROC LOGISTIC`: For building and evaluating logistic regression models.
  - `PROC EXPORT`: For exporting scored results.

---

## Results

### Logistic Regression

The data was split into a 70:30 ratio for training and testing. Logistic regression was applied to the training data, and the model’s performance was evaluated using the test data.

![General Information of the Model](https://user-images.githubusercontent.com/107760647/191000003-273a6337-551c-4eaf-919f-459100453c6c.png)  
**Table 1: General Information of the Model**  
This table summarizes the observations used in the training dataset. It also highlights the distribution of the target variable (`flagbinary`), showing the number of instances for each class (`0` and `1`).

![Model Fit Compared to Baseline](https://user-images.githubusercontent.com/107760647/190999976-c6108aed-b5e5-4eea-b769-253aa2b59281.png)  
**Table 2: Model Fit Compared to a Baseline “Null” Model**  
This table includes key metrics for the logistic regression model. The Wald Chi-square and `Pr > ChiSq` indicate the chi-square statistic and its p-value, respectively. The p-value (`Pr > ChiSq`) reflects the probability of obtaining the observed chi-square statistic if the independent variables had no effect on the dependent variable. A p-value less than 0.05 (or 0.01) indicates statistical significance.  

For this model, the p-value is less than 0.0001, confirming the model's statistical significance at any conventional confidence level (e.g., 95% or 99%). The table also shows the degrees of freedom (DF), which for this model corresponds to 63 predictors, all of which are dummy variables.

![ROC Curve](https://user-images.githubusercontent.com/107760647/190999946-8df4390b-d710-4e11-97b4-d7ab461ef1c2.png)  
**Chart 1: ROC Curve and Comparison (ROC1 = No Discrimination Line, 0.5)**  
The Receiver Operating Characteristic (ROC) curve in Table 13 indicates the model's Area Under the Curve (AUC) is approximately 0.6526. Since the AUC is close to the no-discrimination line (ROC1), the model demonstrates relatively weak predictive power.  

Research (e.g., Bowers and Zhou, 2019) suggests that an AUC below 0.75 indicates low accuracy, while an AUC closer to 1 represents better model performance. Based on these benchmarks, this model's accuracy is considered low due to its AUC value.

---

### Cut-Off Point

The Kolmogorov-Smirnov (KS) statistic was calculated using Excel based on the logistic regression output. First, the predicted probabilities (`p_1`, representing the probability of being good) were exported from SAS into Excel. Missing values in the dataset were replaced with zeros.  

Below is a sample of the first 10 rows of the output, showing `p_1`, the observed counts of "Good" and "Bad" cases, respectively:

![Predicted Probabilities Sample](https://user-images.githubusercontent.com/107760647/191000126-d61e084d-82bd-4bcd-82ab-9b217c6b8955.png)  
**Table 3: Sample Output of Predicted Probabilities (`p_1`), Bads, and Goods**  

For each row, the following calculations were performed:
1. **Cumulative number of Bads**: Total Bads at and below each score.
2. **Cumulative number of Goods**: Total Goods at and below each score.
3. **Cumulative Proportion of Bads**: Proportion of Bads at and below each score relative to all Bads.
4. **Cumulative Proportion of Goods**: Proportion of Goods at and below each score relative to all Goods.
5. **Absolute Difference**: The absolute difference between the cumulative proportions of Bads and Goods.

The **Kolmogorov-Smirnov (KS) statistic** was determined by finding the maximum value of the absolute difference column, using the Excel function `=MAX()`. The KS statistic for this model was **0.2175**.

Using the KS statistic, a cut-off point of **0.8411** was established to distinguish between accepted and rejected customers. This cut-off resulted in an **acceptance rate of 53.91%** and a **cumulative bad rate of 10.62%**, providing a basis for customer segmentation (Thomas et al., 2017).

---

## Installation

1. Install SAS on your system.
2. Update file paths in the code to match your local directories.
3. Run the SAS script to replicate the credit scoring process.

---

## Future Enhancements

- Automate variable binning and feature selection for scalability.
- Integrate with machine learning algorithms to enhance predictive performance.
- Expand analysis with additional financial features.

---

## Contributions

Contributions are welcome! Feel free to fork the repository, make improvements, and submit a pull request.

---
