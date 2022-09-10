# Consumer-Credit-Scoring-Model

using SAS

# Part 1
To build a credit scoring model, it needs a processed dataset. In this paper, the dataset that was already processed for the previous group project will be used. On the top of that, extra two categorical variables (‘home_ownership’ and ‘verification_status’) were added in this dataset to make a model. Then, target variable ‘charged_off’ from the original dataset was changed to ‘flagbinary’ by 0 for being bad and 1 for being good which will be used as a target variable in this paper. Variable ‘sub_grade’ was dropped for this paper because it is already graded by the lending club which might cause biased result. In this paper, only SAS will be used to avoid any contamination in results. 

# 1.	Data exploration
Before going into further steps, firstly, it is significant to look at the number of samples and features of the dataset to have a clear information of dataset being used. The descriptions of variables followed as below:
 
<Table 1: General information of the processed dataset>
Variable name 	Description
VAR1	Account number, unique identifier
flagbinary	Performance flag: 
0-	 Bad
1-	 Good
loan_amnt	The listed amount of the loan applied for by the borrower. 
term	The number of payments on the loan. Values are in months and can be either 36 or 60.
int_rate	Interest rate on the loan. 
home_ownership	Home ownership:
0-	Mortgage
1-	Other
2-	Own
3-	Rent
verification_status	Verification status:
0-	Not Verified
1-	Source Verified
2-	Verified
dti	A ratio calculated using the borrower’s  total  monthly  debt payments on the total debt obligations, excluding mortgage and the requested Lending Club loan, divided by the borrower’s self-reported monthly income. 
earliest_cr_line	The month the borrower’s earliest reported  credit  line  was opened.
avg_cur_bal	Average current balance of all accounts. 
mo_sin_rcnt_tl	Months since most recent account opened. 
mort_Acc	Number of mortgage accounts. 
mths_since_recent_inq	Months since most recent inquiry. 
num_actv_rec_tl	Number of currently active revolving trades. 
num_tl_op_past_12m	Number of accounts opened in past 12 months. 
percent_bc_gt_75	Percentage of all bankcard accounts >75% of limit. 
total_bc_limit	Total bankcard high credit / credit limit. 
log_annual_inc	The natural log of the annual income of the borrower. 
fico_score	The borrower’s FICO at loan origination belongs to. 
<Table2: Description of variables>

<Table 1> illustrates that this dataset contains 141630 observations and 19 variables. In this paper, variable ‘VAR1’ will not be used since it is just an indication of account number. From <Table2>, we can confirm that there are two categorical variables. Next, the distribution of each categorical variable was checked with bar charts as seen from <Graph1>.
  
<Graph 1: Distribution of categorial variables>

# 2.	Creating coarse-classified variables 
# 2.1	 Categorical variables

The association of these variables with the flagbinrary was checked using the cross-table between each categorical variable and the performance flag, ‘flagbinary’. 

  
<Table3: Cross-table between each categorical variable and ‘flagbinary’>

<Table3> suggests that there might need some adjustments in groupings as some categories are very small and they should be grouped with large ones. To do that, creating a new coarse-classified variables is necessary. Firstly variables (‘ho’ and ‘vs’) were created that simply changed the value of each value to numerical as shown at <Table4>.
  
<Table4: cross-table of nummericalised categories between each categorical variable and ‘flagbinary’>

Then, different groupings were tried to see which one is better. Firstly, for ‘ho’, group of 2+3 and 0+1 was tried against 0 and 1+2+3. Then, the outcome would be shown as ‘ho1’ and ‘vs1’ categories derived from ‘ho’ and ‘vs’ variables. For deciding different combinations of grouping, conservative decision was considered which would be to group the worst category and another small one. 
  
<Table5: cross table of ‘ho1’ by ‘flagbinary’ (Left: combination of 0+1 and 2+3, Right: combination of 0, 1+2+3)

As shown from <Table5>, they showed different Chi-Square values for each combination. Here, we will use Chi-Square to decide which one is better grouping. <Table5> shows that the combination of 0+1 and 2+3 is better when it comes to its bigger Chi-Square. Therefore, this grouping will be used for further steps. 
  
<Table6: cross table of ‘ho1’ by ‘flagbinary’ (Left: combination of 2+0 and 1, Right: combination of 2, 1+0)

Likewise, the same step was applied to ‘vs’. <Table6> suggests that the combination of 2 and 1+0 is better for its Chi-Square value of 604.5029. Hence, this grouping will be used for further steps. 

# 2.2	 Numerical variables 
It is important to look at how variables are distributed for numerical variables for any potential of discriminant analysis. For instance, variable ‘int_rate’ is normally distributed according to <Graph 2>. Likewise, other variables were checked, and they were assumed to be normally distributed. 
 
<Graph2: distribution of ‘int_rate’>

Next, numerical variables were split into final classes to be ready to make a coarse-classification for 10 groups of approximate size as shown at <Table7>. 
 
<Table7: ranks for variable ‘loan_amnt’>

For the next step, new variable was created for showing the rank of the variable used. For instance, for variable ‘loan_amnt’, it is ‘loanbinned’. Then, cross-tabulation table for ‘loanbinned’ and ‘flagbinary’ was made to check the certain trend within the values of ranks. For example, in <Table8>, the overall trend is decreasing towards 9. However, some of ranks do not follow the trend. Therefore, they need to be merged to make the trend consistent. Here, we can merge 0+1 and 5+6 because 1 increased from 0 and 7 increased from 6. One can claim that it is general rule to merge 6 and 7 together. However, if 6 and 7 merged, it will still give the wrong trend. Therefore, the perfect grouping combination which is 5+6 was decided. 
 
<Table8: cross-tabulation frequency table for ‘loanbinned’ and the ‘flagbinary’>

 
<Table9: cross-tabulation frequency table for ‘loanbinned’ and the ‘flagbinary’ after merged with different ranks>

The output from the previous step is shown at <Table9>. We can confirm that the trend is decreasing, and we can proceed to the step. This method was implemented to other numerical variables to make coarse-classification. Then, each group from 1 to 9 will be converted into a dummy variable for each numerical variable to run the logistic regression as show in <Table10>. 
 
<Table10: Dummy variable for ‘loan_amnt’>

# 3.	Logistic Regression (using dummy variables)
The data was split into 0.7:0.3 ratio. Then, it will run logistic regression on training data, and check the performance on the test data. 
 
<Table11: General information of the model>
<Table 11> shows the observations used (training data). Besides, it shows the number of ‘0’ and ‘1’ of ‘flagbinary’ in the model. 
 
<Table12: model fit as compared to a baseline “null” model>
Here, it will only discuss that can explain some factors of the model. From <Table12>, Wald Chi-square and Pr>ChiSq indicate chi-square statistics and its significance level. Here, Pr>ChiSq illustrates the probability of securing this value of chi-square if independent variables have no impact on dependent variables. This is also an indication of p-value. Depending on the significance level (generally 95% or 99%), if p-value is less than 0.05 or 0.01, it means the model is statistically significant. For this model, it is found out to be statistically significant for any significance level, because its p-value is less than .0001. DF conveys the number of degrees of freedom of the model. For this model, there are 63 predictors (dummy) used for this model. 







 
<Table13: ROC curve for comparison (ROC1 = no discrimination line (0.5))>

<Table13> shows that the model’s AUC is about 0.6526. This can mean the model’s accuracy may be low for its value of AUC close to its no discrimination line which is ROC1 in this table. AUC is generally better when it is close to 1. Bowers and Zhou (2019) asserted that AUC below 0.75 indicates low accuracy, and vice versa. Hence, this model is very weak in predicting considering its low AUC value. 

4.	Setting a cut-off point 
To calculate the Kolmogorov-Smirnov (KS) statistic, this paper adopted Excel to calculate it. To do that, firstly, the outcome from previous step (logistic regression) was extracted from SAS as an excel file. Here, the counts of observed Good and Bad explaining each level of predicted probability were made into two columns with p_1 (probability of being good). In this process, the missing values were replaced as 0. The outcome of first 10 rows follows as <Table14>.
 
<Table14: outcome of P_1, Bad, and Good for first 10 rows>
Then, for each column, Cumulative number of Bads (Bads at and below the Score), number of Goods (Goods at and below the Score), Cumulative proportion of Bads from all Bads , Cumulative proportion of Goods from all Goods, Absolute difference between Cumulative proportions of Bads and Goods were calculated based on the <Table14>. Then, the column of Absolute difference between Cumulative proportions of Bads and Goods was selected and used to compute the Kolmogorov-Smirnov (KS) statistic using an excel function =MAX(). 

The KS statistic for this model is 0.21753688. Using this KS statistic, the cut-off point was set to 0.8411 which is the point to split between reject or accept customers (Thomas et al 2017). This cut-off setting gives acceptance rate of 53.91%, and cumulated bad rate of 10.62. 













# Part 2
Different settings of cut-off will be discussed to have an insight of finding the optimal cut-off value for this model. In addition, classification decision tree model was adopted to compare the accuracy level to see if there are any potential improvements for predicting the target. 

# 1.	Analysis to find an optimal cut-off point using an error rate
 
<Graph3: Trend line of error rate>
	Cut-off 
0.7588	Cut-off
0.8675	Cut-off
0.9264
Acceptance rate	83.50%	40.00%	10.33%
Cum bad rate	13.89%	9.26%	5.62%
Change in accepted numbers of bad	8711	-2865	-7289
Change in accepted numbers of good	36031	-16833	-54439
Change in acceptance rate:	31.59	-13.91	-43.58
Error rate 	0.222015	0.513535	0.747822
<Table15: different cut-off settings and changes based on the original cut-off point> 
To compare different rates, different cut-off settings was tried. Error rate used here was computed as ‘Error rate = (b+c)/(a+b+c+d)’ based on <Table 16> in the Appendix. As shown from <Table15>, error rate is positively related to cut-off level. For example, cut-off 0.7588 shows the smallest error rate out of different cut-off settings, even smaller than the original cut-off setting. To check the trend of the whole samples, graph was plotted for error rates. <Graph3> shows the increasing trend when the probability of good (p_1) is increasing for whole samples (p_1 is sorted ascending). Therefore, this dataset shows the positive correlation between cut-off and error rate where high cut-off means high error-rates, and vice versa. 
From these results, one can infer smaller cut-off point may be a good point as it shows the smaller error rate. However, it is not reasonable to trust this hypothesis because it would not be a logical decision. For instance, if we were to put the smallest cut-off point (0.49%) just because it has the smallest error rate, it means we are only accepting 0.51 % and rejecting the rest which generally do not make any sense when it comes to the real-industry point of view. In addition, one can claim that different settings of cut-off may not be efficient in this model since its performance level is already low. Hence, it might not be reliable in the first place. 

To find the optimal cut-off point, having some extra information such as pricing or the acceptance risk level of the lender may be helpful. However, ultimately, there is no universal optimal cut-off point in credit scoring which also means it can always change. Abdou and Pointon (2011) discussed that cut-off points can vary depending on its environment or even the credit decision makers’ attitude to risks. For example, if they are risk-averse, they might put the cut-off point where they do not have to take any risks such as only accepting those a few have very good scores. On the other hand, if some banks do not mind taking risks and take many clients as they want, the cut-off point would be very low compared to those who are risk-averse. In addition, when there is an unbalance in classes, it is more challenging to set an optimal cut-off point as there is a high chance that the conventional methods would provide biased result as they tend to favour the majority class (Calabrese, 2014). Applying it to this model, an optimal point cannot be decided with the limited information of this data and background details of its purpose of using and characteristics of whoever make decisions with it.

# 2.	Comparison between Logistic Regression and Classification Decision Tree
Classification decision tree was implemented to compare the accuracy and efficiency with the original model. To avoid any contamination in results, SAS was used. To train the data, split of 0.7:0.3 was used (validation = 0.3). The results are as followed:
 
<Graph4: AUC for the classification decision tree>
The result shows that the original logistic regression is slightly better than the classification decision tree model (0.65>0.59) when compared their AUC level for the dataset used in this paper. In addition, looking at gini coefficient, decision tree model’s gini value is lower than the original model (0.3052>0.2661). Therefore, we can conclude that the decision tree model is worse than the original model when it comes to AUC and gini value. In fact, both of models are relatively weak when it comes to predicting the target variable for their AUC values less than 0.75.  
However, it is worth noting that classification decision tree model provides visual advantage with splits so that people can easily understand. As shown from <Graph5> and <Graph6>, they show how the target was predicted depending on each variable in the dataset. This visual advantage may be colossal for its purpose of use. For instance, if clients or customers want to have a clear view of how the decision was made, it is much easier to interpret and explain for them, even for non-experts. Therefore, it is very challenging to say which one is better only depending on its AUC level due to other advantageous factors of different models. Hence, though the classification decision tree model showed less accuracy level, it might be better off when it comes to explanation and interpretation pf result. In fact, some people think decision tree models are better off when it performs similar level to a comparing model. Rudd and Priestley (2017) asserted that decision tree models are better than logistic regression if their performance levels are similar. The reasons are as followed: 1. Decision trees are less sensitive to missing data and outliers 2. The data does not need to be normalised and not need an assumption of linearity 3. Decision tree’s graphical output is more advantageous than logistic regression that leads to better explanation and interpretation of decisions made depending on the splits. 
 
<Graph5: Classification decision tree splits>
 
<Graph6: Subtree of classification decision tree at Node=0>
![image](https://user-images.githubusercontent.com/107760647/189462507-54a5a4fd-a434-40cb-8abf-643a5064c70f.png)
