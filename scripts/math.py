import pandas as pd
import numpy as np
from scipy.stats import chi2_contingency, spearmanr, kruskal, f_oneway
from statsmodels.miscmodels.ordinal_model import OrderedModel
import statsmodels.api as sm

a_df = pd.read_csv('a.csv')
b_df = pd.read_csv('b.csv')

# 1. Chi-Square Test (RQ1): Association between Genre, Nationality, and Bechdel Score
def chi_square_test(data):
    contingency_table = pd.crosstab([data['country'], data['genre']], data['rating'])
    chi2, p, dof, expected = chi2_contingency(contingency_table)
    print(f"Chi-Square Test:\nChi2: {chi2}, p-value: {p}\n")

# 2. Cramér's V for Strength of Association after Chi-Square
def cramers_v(chi2, contingency_table):
    n = contingency_table.sum().sum()
    min_dim = min(contingency_table.shape) - 1
    v = np.sqrt(chi2 / (n * min_dim))
    print(f"Cramér's V: {v}\n")

# 3. Ordinal Logistic Regression (RQ2): Effect of Decade on Bechdel Score
def ordinal_logistic_regression(data):
    model = OrderedModel(data['rating'], data[['decade']], distr='logit')
    result = model.fit()
    print("Ordinal Logistic Regression:\n", result.summary(), "\n")

# 4. Kruskal-Wallis Test: Comparing Bechdel Scores Across Genres or Countries
def kruskal_wallis_test(data):
    groups = data.groupby('genre')['rating'].apply(list)
    stat, p = kruskal(*groups)
    print(f"Kruskal-Wallis Test:\nStatistic: {stat}, p-value: {p}\n")

# 5. Spearman’s Rank Correlation (RQ2): Correlation Between Decade and Bechdel Score
def spearman_correlation(data):
    corr, p = spearmanr(data['decade'], data['rating'])
    print(f"Spearman’s Rank Correlation:\nCorrelation: {corr}, p-value: {p}\n")

# 6. ANOVA: Comparing Bechdel Scores Across Decades (RQ1 or RQ2)
def anova_test(data):
    groups = data.groupby('decade')['rating'].apply(list)
    stat, p = f_oneway(*groups)
    print(f"ANOVA Test:\nStatistic: {stat}, p-value: {p}\n")

# 7. Post-hoc Tukey HSD: Detailed Pairwise Comparison after ANOVA
def tukey_posthoc(data):
    import statsmodels.stats.multicomp as mc
    tukey = mc.MultiComparison(data['rating'], data['decade'])
    result = tukey.tukeyhsd()
    print(f"Tukey HSD Post-hoc Test:\n{result}\n")

# Functions to handle the second dataset (b.csv)
# Using Kruskal-Wallis for comparing Bechdel Test distributions across nationalities (BR, USA, Others)
def kruskal_b(data):
    br_scores = data[data['country'] == 'BR'][['p0', 'p1', 'p2', 'pPassed']].values.flatten()
    usa_scores = data[data['country'] == 'EUA'][['p0', 'p1', 'p2', 'pPassed']].values.flatten()
    others_scores = data[data['country'] == 'Outros'][['p0', 'p1', 'p2', 'pPassed']].values.flatten()
    stat, p = kruskal(br_scores, usa_scores, others_scores)
    print(f"Kruskal-Wallis on Nationalities:\nStatistic: {stat}, p-value: {p}\n")

print("\n--- Test Results ---\n")
chi_square_test(a_df)
ordinal_logistic_regression(a_df)
kruskal_wallis_test(a_df)
spearman_correlation(a_df)
anova_test(a_df)
tukey_posthoc(a_df)
kruskal_b(b_df)
