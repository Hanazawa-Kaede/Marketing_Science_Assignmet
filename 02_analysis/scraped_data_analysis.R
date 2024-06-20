# 記述統計
modelsummary::datasummary_skim(df_scraped)

model_list <- list(
  "OLS_robust" = estimatr::lm_robust(prices ~ トータルスコア + `施設・設備` + 清潔さ + 快適さ + ロケーション + 口コミ件数, data = df_scraped),
  "Fixed Effects Model" = fixest::feols(prices ~ トータルスコア + `施設・設備` + 清潔さ + 快適さ + ロケーション + 口コミ件数 | 物件名, data = df_scraped)
  )

modelsummary::modelsummary(
  model_list,
  stars = TRUE,
  output = "kableExtra",
  gof_omit = 'RMSE|R2|AIC|BIC',
  fmt = 2
) |> 
  kableExtra::kable_classic_2()
