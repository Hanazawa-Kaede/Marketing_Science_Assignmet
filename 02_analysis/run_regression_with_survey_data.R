# 予算をアウトカム、旅行頻度、最も重視する項目、次に重視する項目を説明変数としてOLS推定を行う。

lm_model <- estimatr::lm_robust(
  data = df,
  formula = budget ~ frequency_of_travel + pref_cleanness + pref_price + pref_location + pref_review_scores + pref_num_of_reviews,
  se_type = "stata"
)
model_list <- list(
  "OLS_robust" = lm_model
)
modelsummary::modelsummary(
  model_list,
  stars = TRUE,
  output = "kableExtra",
  gof_omit = 'RMSE|R2|AIC|BIC',
  fmt = 2
) |> 
  kableExtra::kable_classic_2()
