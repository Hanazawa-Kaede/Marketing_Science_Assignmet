# アンケートデータの記述統計を確認する
df_for_summary_staat <- df |> 
  select(most_pref, second_pref, budget, frequency_of_travel)

table_title <- "最も重視する項目ごとの記述統計"

modelsummary::datasummary_balance(
  ~most_pref,
  df_for_summary_staat,
  title = table_title,
  output = "kableExtra"
  ) |> 
  kableExtra::kable_classic_2()

