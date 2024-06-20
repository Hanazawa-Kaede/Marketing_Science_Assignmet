library(tidyverse)
library(ggplot2)

# Google Formのアンケートデータを読み込み・加工する関数
build_data <- function() {
  # Load the excel data
  df <- readxl::read_excel("01_data/旅行に関するアンケート（回答）.xlsx")
  
  # 列名を変更
  colnames <- c("time_stamp", "frequency_of_travel", "budget", "reserve_website", "most_pref", "second_pref")
  colnames(df) <- colnames
  
  # 予算を数値に変換
  df$budget <- as.numeric(df$budget)
  
  # 最も重視する項目および次に重視する項目をダミー変数化する。
  df <- df |> 
    mutate(
      pref_cleanness = ifelse(most_pref == "清潔さ", 1, 0),
      pref_price = ifelse(most_pref == "価格が安い", 1, 0),
      pref_location = ifelse(most_pref == "立地の良さ", 1, 0),
      pref_review_scores = ifelse(most_pref == "ホテルのレビュースコア", 1, 0),
      pref_num_of_reviews = ifelse(most_pref == "レビューの件数", 1, 0)
    )
  
  return(df)
}

df <- build_data()



# スクレイピングしたデータを読み込む関数
load_scraped_data <- function() {
  # ディレクトリのパスを指定
  directory_path <- "01_data"
  
  # ディレクトリ内の全ての *.xlsx ファイルをリストアップ
  xlsx_files <- list.files(path = directory_path, pattern = "^東京.*\\.xlsx$", full.names = TRUE)
  
  # 各 .xlsx ファイルからデータフレームを読み込み、リストに格納
  data_list <- lapply(xlsx_files, readxl::read_excel)
  
  # リスト内の全てのデータフレームを縦に結合
  combined_data <- bind_rows(data_list)
  
  return(combined_data)
}

df_scraped_raw <- load_scraped_data()

# データクリーニング
df_scraped <- df_scraped_raw |> 
  # 必要な列のみ確保 and 外れ値除去
  filter(
    元の料金 < 1000000
    ) |>
    mutate(
      prices = 元の料金 - 期間限定セール
    ) |> 
  select(
    prices,
    トータルスコア,
    `施設・設備`,
    清潔さ,
    快適さ,
    ロケーション,
    口コミ件数,
    物件名
  )











