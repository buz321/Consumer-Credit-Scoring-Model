# Consumer-Credit-Scoring-Model

using SAS

# Part 1
To build a credit scoring model, it needs a processed dataset. In this paper, the dataset that was already processed for the previous group project will be used. On the top of that, extra two categorical variables (‘home_ownership’ and ‘verification_status’) were added in this dataset to make a model. Then, target variable ‘charged_off’ from the original dataset was changed to ‘flagbinary’ by 0 for being bad and 1 for being good which will be used as a target variable in this paper. Variable ‘sub_grade’ was dropped for this paper because it is already graded by the lending club which might cause biased result. In this paper, only SAS will be used to avoid any contamination in results. 

# 1.	Data exploration
Before going into further steps, firstly, it is significant to look at the number of samples and features of the dataset to have a clear information of dataset being used. The descriptions of variables followed as below:
 
 <img width="270" alt="image" src="https://user-images.githubusercontent.com/107760647/189462566-01ee77bb-9fce-4c30-bd1f-ec07886ea2fa.png">

<Table 1: General information of the processed dataset>

![image](https://user-images.githubusercontent.com/107760647/189462581-997bfb73-b53e-4745-ba9c-c2bde3ad411b.png)

<Table2: Description of variables>

<Table 1> illustrates that this dataset contains 141630 observations and 19 variables. In this paper, variable ‘VAR1’ will not be used since it is just an indication of account number. From <Table2>, we can confirm that there are two categorical variables. Next, the distribution of each categorical variable was checked with bar charts as seen from <Graph1>.
  
<img width="224" alt="image" src="https://user-images.githubusercontent.com/107760647/189462603-650b7a04-7546-45a7-9cfb-f609beb6b856.png">
<img width="220" alt="image" src="https://user-images.githubusercontent.com/107760647/189462606-24f790e5-6e72-4d62-b8da-78cbbbde14dc.png">
<Graph 1: Distribution of categorial variables>

# 2.	Creating coarse-classified variables 
# 2.1	 Categorical variables

The association of these variables with the flagbinrary was checked using the cross-table between each categorical variable and the performance flag, ‘flagbinary’. 

 
<img width="194" alt="image" src="https://user-images.githubusercontent.com/107760647/189462614-9ec2662c-fe74-4660-9f41-a63105da4002.png">
<img width="198" alt="image" src="https://user-images.githubusercontent.com/107760647/189462615-0ca329c7-1d3f-465d-a4e5-637c12cc37cb.png">
<Table3: Cross-table between each categorical variable and ‘flagbinary’>

<Table3> suggests that there might need some adjustments in groupings as some categories are very small and they should be grouped with large ones. To do that, creating a new coarse-classified variables is necessary. Firstly variables (‘ho’ and ‘vs’) were created that simply changed the value of each value to numerical as shown at <Table4>.

<img width="206" alt="image" src="https://user-images.githubusercontent.com/107760647/189462622-006aedcf-6f7b-4b0d-a385-293ad672b014.png">
<img width="196" alt="image" src="https://user-images.githubusercontent.com/107760647/189462623-4b50423a-6c19-466e-8704-e189254aff4d.png">
<Table4: cross-table of nummericalised categories between each categorical variable and ‘flagbinary’>

Then, different groupings were tried to see which one is better. Firstly, for ‘ho’, group of 2+3 and 0+1 was tried against 0 and 1+2+3. Then, the outcome would be shown as ‘ho1’ and ‘vs1’ categories derived from ‘ho’ and ‘vs’ variables. For deciding different combinations of grouping, conservative decision was considered which would be to group the worst category and another small one. 
 
<img width="189" alt="image" src="https://user-images.githubusercontent.com/107760647/189462639-4b595493-f036-48d4-a050-919c911fc442.png">
<img width="207" alt="image" src="https://user-images.githubusercontent.com/107760647/189462641-a82811a5-1ef1-4efb-90e9-341690b07601.png">
<Table5: cross table of ‘ho1’ by ‘flagbinary’ (Left: combination of 0+1 and 2+3, Right: combination of 0, 1+2+3)

As shown from <Table5>, they showed different Chi-Square values for each combination. Here, we will use Chi-Square to decide which one is better grouping. <Table5> shows that the combination of 0+1 and 2+3 is better when it comes to its bigger Chi-Square. Therefore, this grouping will be used for further steps. 
 
<img width="196" alt="image" src="https://user-images.githubusercontent.com/107760647/189462651-0bbdb7a8-08a1-4e53-9855-5bb78a3846e5.png">
<img width="351" alt="image" src="https://user-images.githubusercontent.com/107760647/189462660-984b4ba3-89aa-448e-abce-360d2b0ef638.png">
<Table6: cross table of ‘ho1’ by ‘flagbinary’ (Left: combination of 2+0 and 1, Right: combination of 2, 1+0)

Likewise, the same step was applied to ‘vs’. <Table6> suggests that the combination of 2 and 1+0 is better for its Chi-Square value of 604.5029. Hence, this grouping will be used for further steps. 

# 2.2	 Numerical variables 
It is important to look at how variables are distributed for numerical variables for any potential of discriminant analysis. For instance, variable ‘int_rate’ is normally distributed according to <Graph 2>. Likewise, other variables were checked, and they were assumed to be normally distributed. 
 
<img width="141" alt="image" src="https://user-images.githubusercontent.com/107760647/189462664-4e8b9dde-58bd-41de-82a0-90767e64fffb.png">
<Graph2: distribution of ‘int_rate’>

Next, numerical variables were split into final classes to be ready to make a coarse-classification for 10 groups of approximate size as shown at <Table7>. 

<img width="141" alt="image" src="https://user-images.githubusercontent.com/107760647/189462683-0ab55b53-40d0-4325-9adf-b2cd6ae858e6.png">
<Table7: ranks for variable ‘loan_amnt’>

For the next step, new variable was created for showing the rank of the variable used. For instance, for variable ‘loan_amnt’, it is ‘loanbinned’. Then, cross-tabulation table for ‘loanbinned’ and ‘flagbinary’ was made to check the certain trend within the values of ranks. For example, in <Table8>, the overall trend is decreasing towards 9. However, some of ranks do not follow the trend. Therefore, they need to be merged to make the trend consistent. Here, we can merge 0+1 and 5+6 because 1 increased from 0 and 7 increased from 6. One can claim that it is general rule to merge 6 and 7 together. However, if 6 and 7 merged, it will still give the wrong trend. Therefore, the perfect grouping combination which is 5+6 was decided. 

	<img width="210" alt="image" src="https://user-images.githubusercontent.com/107760647/189462687-331b4a6e-4f8c-46b3-b385-ff80fa64a427.png">
<Table8: cross-tabulation frequency table for ‘loanbinned’ and the ‘flagbinary’>
	
 <img width="189" alt="image" src="https://user-images.githubusercontent.com/107760647/189462691-8abb3b40-fe36-4671-aae4-2dd4edc6e1d9.png">
<Table9: cross-tabulation frequency table for ‘loanbinned’ and the ‘flagbinary’ after merged with different ranks>

The output from the previous step is shown at <Table9>. We can confirm that the trend is decreasing, and we can proceed to the step. This method was implemented to other numerical variables to make coarse-classification. Then, each group from 1 to 9 will be converted into a dummy variable for each numerical variable to run the logistic regression as show in <Table10>. 

<img width="175" alt="image" src="https://user-images.githubusercontent.com/107760647/189462696-835f5470-e261-4a92-b226-e6ce540c54b4.png">
<Table10: Dummy variable for ‘loan_amnt’>

# 3.	Logistic Regression (using dummy variables)
The data was split into 0.7:0.3 ratio. Then, it will run logistic regression on training data, and check the performance on the test data. 
 
<img width="188" alt="image" src="https://user-images.githubusercontent.com/107760647/189462700-d86b6b74-da7a-4600-b416-2f0c7f641c36.png">
<Table11: General information of the model>
<Table 11> shows the observations used (training data). Besides, it shows the number of ‘0’ and ‘1’ of ‘flagbinary’ in the model. 
 
<img width="246" alt="image" src="https://user-images.githubusercontent.com/107760647/189462704-2a5ff3e2-3e95-4949-865b-a4995c33c399.png">
<Table12: model fit as compared to a baseline “null” model>
Here, it will only discuss that can explain some factors of the model. From <Table12>, Wald Chi-square and Pr>ChiSq indicate chi-square statistics and its significance level. Here, Pr>ChiSq illustrates the probability of securing this value of chi-square if independent variables have no impact on dependent variables. This is also an indication of p-value. Depending on the significance level (generally 95% or 99%), if p-value is less than 0.05 or 0.01, it means the model is statistically significant. For this model, it is found out to be statistically significant for any significance level, because its p-value is less than .0001. DF conveys the number of degrees of freedom of the model. For this model, there are 63 predictors (dummy) used for this model. 

	<img width="206" alt="image" src="https://user-images.githubusercontent.com/107760647/189462708-4e205b74-71ac-430b-8f10-8a3f6aac267a.png">
<Table13: ROC curve for comparison (ROC1 = no discrimination line (0.5))>

<Table13> shows that the model’s AUC is about 0.6526. This can mean the model’s accuracy may be low for its value of AUC close to its no discrimination line which is ROC1 in this table. AUC is generally better when it is close to 1. Bowers and Zhou (2019) asserted that AUC below 0.75 indicates low accuracy, and vice versa. Hence, this model is very weak in predicting considering its low AUC value. 

4.	Setting a cut-off point 
To calculate the Kolmogorov-Smirnov (KS) statistic, this paper adopted Excel to calculate it. To do that, firstly, the outcome from previous step (logistic regression) was extracted from SAS as an excel file. Here, the counts of observed Good and Bad explaining each level of predicted probability were made into two columns with p_1 (probability of being good). In this process, the missing values were replaced as 0. The outcome of first 10 rows follows as <Table14>.
 
<img width="285" alt="image" src="https://user-images.githubusercontent.com/107760647/189462714-b30f3a75-1524-424a-be00-44d77bdd9215.png">	
<Table14: outcome of P_1, Bad, and Good for first 10 rows>
Then, for each column, Cumulative number of Bads (Bads at and below the Score), number of Goods (Goods at and below the Score), Cumulative proportion of Bads from all Bads , Cumulative proportion of Goods from all Goods, Absolute difference between Cumulative proportions of Bads and Goods were calculated based on the <Table14>. Then, the column of Absolute difference between Cumulative proportions of Bads and Goods was selected and used to compute the Kolmogorov-Smirnov (KS) statistic using an excel function =MAX(). 

The KS statistic for this model is 0.21753688. Using this KS statistic, the cut-off point was set to 0.8411 which is the point to split between reject or accept customers (Thomas et al 2017). This cut-off setting gives acceptance rate of 53.91%, and cumulated bad rate of 10.62. 













# Part 2
Different settings of cut-off will be discussed to have an insight of finding the optimal cut-off value for this model. In addition, classification decision tree model was adopted to compare the accuracy level to see if there are any potential improvements for predicting the target. 

# 1.	Analysis to find an optimal cut-off point using an error rate
 

<Graph3: Trend line of error rate>


![image](https://user-images.githubusercontent.com/107760647/189462764-0af7828e-9929-4e09-b22c-61f5471cfab5.png)
<Table15: different cut-off settings and changes based on the original cut-off point> 
To compare different rates, different cut-off settings was tried. Error rate used here was computed as ‘Error rate = (b+c)/(a+b+c+d)’ based on <Table 16> in the Appendix. As shown from <Table15>, error rate is positively related to cut-off level. For example, cut-off 0.7588 shows the smallest error rate out of different cut-off settings, even smaller than the original cut-off setting. To check the trend of the whole samples, graph was plotted for error rates. <Graph3> shows the increasing trend when the probability of good (p_1) is increasing for whole samples (p_1 is sorted ascending). Therefore, this dataset shows the positive correlation between cut-off and error rate where high cut-off means high error-rates, and vice versa. 
From these results, one can infer smaller cut-off point may be a good point as it shows the smaller error rate. However, it is not reasonable to trust this hypothesis because it would not be a logical decision. For instance, if we were to put the smallest cut-off point (0.49%) just because it has the smallest error rate, it means we are only accepting 0.51 % and rejecting the rest which generally do not make any sense when it comes to the real-industry point of view. In addition, one can claim that different settings of cut-off may not be efficient in this model since its performance level is already low. Hence, it might not be reliable in the first place. 

To find the optimal cut-off point, having some extra information such as pricing or the acceptance risk level of the lender may be helpful. However, ultimately, there is no universal optimal cut-off point in credit scoring which also means it can always change. Abdou and Pointon (2011) discussed that cut-off points can vary depending on its environment or even the credit decision makers’ attitude to risks. For example, if they are risk-averse, they might put the cut-off point where they do not have to take any risks such as only accepting those a few have very good scores. On the other hand, if some banks do not mind taking risks and take many clients as they want, the cut-off point would be very low compared to those who are risk-averse. In addition, when there is an unbalance in classes, it is more challenging to set an optimal cut-off point as there is a high chance that the conventional methods would provide biased result as they tend to favour the majority class (Calabrese, 2014). Applying it to this model, an optimal point cannot be decided with the limited information of this data and background details of its purpose of using and characteristics of whoever make decisions with it.

# 2.	Comparison between Logistic Regression and Classification Decision Tree
Classification decision tree was implemented to compare the accuracy and efficiency with the original model. To avoid any contamination in results, SAS was used. To train the data, split of 0.7:0.3 was used (validation = 0.3). The results are as followed:

<img width="310" alt="image" src="https://user-images.githubusercontent.com/107760647/189462779-519b8d7a-9cdf-4ddc-8d5c-1dfdf149d6ed.png">
<Graph4: AUC for the classification decision tree>
The result shows that the original logistic regression is slightly better than the classification decision tree model (0.65>0.59) when compared their AUC level for the dataset used in this paper. In addition, looking at gini coefficient, decision tree model’s gini value is lower than the original model (0.3052>0.2661). Therefore, we can conclude that the decision tree model is worse than the original model when it comes to AUC and gini value. In fact, both of models are relatively weak when it comes to predicting the target variable for their AUC values less than 0.75.  
However, it is worth noting that classification decision tree model provides visual advantage with splits so that people can easily understand. As shown from <Graph5> and <Graph6>, they show how the target was predicted depending on each variable in the dataset. This visual advantage may be colossal for its purpose of use. For instance, if clients or customers want to have a clear view of how the decision was made, it is much easier to interpret and explain for them, even for non-experts. Therefore, it is very challenging to say which one is better only depending on its AUC level due to other advantageous factors of different models. Hence, though the classification decision tree model showed less accuracy level, it might be better off when it comes to explanation and interpretation pf result. In fact, some people think decision tree models are better off when it performs similar level to a comparing model. Rudd and Priestley (2017) asserted that decision tree models are better than logistic regression if their performance levels are similar. The reasons are as followed: 1. Decision trees are less sensitive to missing data and outliers 2. The data does not need to be normalised and not need an assumption of linearity 3. Decision tree’s graphical output is more advantageous than logistic regression that leads to better explanation and interpretation of decisions made depending on the splits. 
 
<img width="345" alt="image" src="https://user-images.githubusercontent.com/107760647/189462785-92cdad41-933c-42b1-8513-5de5d2ecd2d1.png">
<Graph5: Classification decision tree splits>

<img width="334" alt="image" src="https://user-images.githubusercontent.com/107760647/189462793-16e201fe-3d17-4def-bcb6-9ef094c0fb3d.png">
<Graph6: Subtree of classification decision tree at Node=0>

