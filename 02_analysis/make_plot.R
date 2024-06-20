# プロットを作成する関数
make_plot <- function(df, x, y, title) {
  if(x == "frequency_of_travel"){
    # 相関係数の計算
    correlation <- cor(df[[x]], df[[y]], use = "complete.obs")
    
    # Notesテキストの作成
    note_text <- paste("Notes:\n",
                       "Correlation (", x, " vs ", y, "): ", round(correlation, 2), sep = "")
  }
  
  # プロットの作成
  p <- ggplot(df, aes(x = !!sym(x), y = !!sym(y))) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(x = x, y = y, title = title) +
    theme_minimal(base_family = "HiraKakuProN-W3") 
  
  if(x == "frequency_of_travel"){
    p <- p + 
      geom_density_2d_filled() +
      annotate("text", x = Inf, y = Inf, label = note_text, hjust = 1.1, vjust = -1.1, size = 4, color = "blue")
  }
  
  return(p)
}

# プロットを作成
most_pref_and_budget <- make_plot(df, "most_pref", "budget", "Budget vs Most Preferred Attribute")
second_pref_and_budget <- make_plot(df, "second_pref", "budget", "Budget vs Second Preferred Attribute")

# 2つのプロットを横に並べて表示
gridExtra::grid.arrange(most_pref_and_budget, second_pref_and_budget, ncol = 2)

# 予算と旅行頻度のプロットを作成
make_plot(df, "frequency_of_travel", "budget", "Budget vs Frequency of Travel")


