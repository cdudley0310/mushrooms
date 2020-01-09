# Mushroom Edibility

This repository contains the analysis I performed on the [Mushroom Classification Kaggle dataset](https://www.kaggle.com/uciml/mushroom-classification). The goal of the associated Kaggle competition was to build a model which could determine if a particular mushroom was edible or poisonous using a variety of morphological mushroom characteristics. I enjoy learning about poisonous plants and fungi and so this dataset was particularly interesting for me.

My personal goal with this dataset was to get a feel for the [Reticulate package](https://rstudio.github.io/reticulate/) in R, especially when used with R Markdown. Reticulate is a package which allows Python and R to interact in R and is a great way for me to improve my skills using Python while keeping all of my analysis organized and in the same file.

Along the way, I decided to make a simple Shiny app using this dataset which, as of this moment, only creates an interactive bar graphs and a related summary table of characteristics and counts based on the selected characteristic. 

This is very much a work in progress and I intend to flesh out both the Python analysis and the Shiny app.

# Important Files in this Repository

* `mushrooms.Rproj` –– the project environment for this analysis
* `mushrooms.rmd` –– R Markdown file containing the Python/R data management and analysis
* `Mushrooms/app.R` –– Shiny app
* `mushrooms.csv` –– data retrieved from [Kaggle](https://www.kaggle.com/uciml/mushroom-classification)
