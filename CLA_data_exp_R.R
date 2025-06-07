rm(list=ls())
# NOTE: Script pour le cours intensif ACL 2025

# L'exploration de données avec R

# NOTE: Importer nos extensions
library(tidyverse)

# NOTE: Importer + examiner les données
my_data <- read_csv("phonetique.csv") # fichier csv normal
load("phonetique.RData") # fichier RData

my_data <- my_data |>
  mutate(ID = as_factor(ID))

my_data <- my_data |> 
  mutate(across(where(is_character), as_factor))

my_data <- my_data |> 
  mutate(Gain = Post - Pre)

my_data

my_data |> glimpse()
glimpse(my_data)

my_data <- my_data |> 
  rename("Competence" = 3,
         "Learning" = Gain)

my_data
names(my_data)

# NOTE: Résumer + explorer les données
# mutate()
# clean_names() from the janitor package
# glimpse(), summary()
# rename()
# mutate()
# filter() et select()

over_4 <- my_data |> 
  filter(Learning > 4,
         Competence != "Int") |> 
  select(-c(Pre, Post, Hours))

over_4

my_summary <- my_data |> 
  summarize(Mean = mean(Learning),
            SD = sd(Learning),
            .by = c(L1, Condition))


# NOTE: Visualiser les données avec ggplot2
ggplot(data = my_data, 
       aes(x = Condition, y = Learning)) + 
  geom_boxplot(fill = "gray") +
  stat_summary() +
  labs(x = "Study condition",
       y = "Post - Pre")
  # theme_classic()
