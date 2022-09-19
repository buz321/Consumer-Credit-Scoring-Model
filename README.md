# Consumer-Credit-Scoring-Model (SAS)

Consumer Credit Scoring model using data from Lending Club Card (https://www.kaggle.com/datasets/wordsforthewise/lending-club/code)

# Logistic Regression
The data was split into 0.7:0.3 ratio. Then, it will run logistic regression on training data, and check the performance on the test data. 
 
 <img width="188" alt="image" src="https://user-images.githubusercontent.com/107760647/191000003-273a6337-551c-4eaf-919f-459100453c6c.png">
<Table11: General information of the model>
<Table 11> shows the observations used (training data). Besides, it shows the number of ‘0’ and ‘1’ of ‘flagbinary’ in the model. 

<img width="246" alt="image" src="https://user-images.githubusercontent.com/107760647/190999976-c6108aed-b5e5-4eea-b769-253aa2b59281.png">
<Table12: model fit as compared to a baseline “null” model>
Here, it will only discuss that can explain some factors of the model. From <Table12>, Wald Chi-square and Pr>ChiSq indicate chi-square statistics and its significance level. Here, Pr>ChiSq illustrates the probability of securing this value of chi-square if independent variables have no impact on dependent variables. This is also an indication of p-value. Depending on the significance level (generally 95% or 99%), if p-value is less than 0.05 or 0.01, it means the model is statistically significant. For this model, it is found out to be statistically significant for any significance level, because its p-value is less than .0001. DF conveys the number of degrees of freedom of the model. For this model, there are 63 predictors (dummy) used for this model. 


 <img width="206" alt="image" src="https://user-images.githubusercontent.com/107760647/190999946-8df4390b-d710-4e11-97b4-d7ab461ef1c2.png">
<Table13: ROC curve for comparison (ROC1 = no discrimination line (0.5))>

<Table13> shows that the model’s AUC is about 0.6526. This can mean the model’s accuracy may be low for its value of AUC close to its no discrimination line which is ROC1 in this table. AUC is generally better when it is close to 1. Bowers and Zhou (2019) asserted that AUC below 0.75 indicates low accuracy, and vice versa. Hence, this model is very weak in predicting considering its low AUC value. 

# Cut-off point
To calculate the Kolmogorov-Smirnov (KS) statistic, this paper adopted Excel to calculate it. To do that, firstly, the outcome from previous step (logistic regression) was extracted from SAS as an excel file. Here, the counts of observed Good and Bad explaining each level of predicted probability were made into two columns with p_1 (probability of being good). In this process, the missing values were replaced as 0. The outcome of first 10 rows follows as <Table14>.

<img width="285" alt="image" src="https://user-images.githubusercontent.com/107760647/191000126-d61e084d-82bd-4bcd-82ab-9b217c6b8955.png">
<Table14: outcome of P_1, Bad, and Good for first 10 rows>
Then, for each column, Cumulative number of Bads (Bads at and below the Score), number of Goods (Goods at and below the Score), Cumulative proportion of Bads from all Bads , Cumulative proportion of Goods from all Goods, Absolute difference between Cumulative proportions of Bads and Goods were calculated based on the <Table14>. Then, the column of Absolute difference between Cumulative proportions of Bads and Goods was selected and used to compute the Kolmogorov-Smirnov (KS) statistic using an excel function =MAX(). 

The KS statistic for this model is 0.21753688. Using this KS statistic, the cut-off point was set to 0.8411 which is the point to split between reject or accept customers (Thomas et al 2017). This cut-off setting gives acceptance rate of 53.91%, and cumulated bad rate of 10.62. 


