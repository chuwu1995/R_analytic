## A reference file for using ggplot2 in R ----
##
## *Your name here*
## 2 Oct 2017

## How is Speed distributed by Generation and Legendary status? ----
## Describe how the Speed of Pokemon varies by Generation and Legendary status.

library(data.table)
library(ggplot2)

# Data ----
pokemon <- fread("data/pokemon.csv")

# `Generation` needs to be categorical for ggplot to use it properly
# pokemon[, generation := factor(generation)] # often better to keep the base table unchanged

# Plots ----
# A boxplot is a suitable visual summary
plot_box <- ggplot(pokemon, aes(factor(generation), speed, fill = legendary)) +
  geom_boxplot()

# Write ----
# pdf(file = "hw1_plot.pdf", width = 6, height = 4)
# plot_box
# dev.off()

plot_box


# More involved plotting
plot_box_pretty <- ggplot(pokemon, aes(x = factor(generation),
                                       y = speed,
                                       fill = legendary,
                                       colour = legendary)) +
  geom_boxplot() +
  scale_fill_manual(values = c("lightgrey", "darkblue")) +
  scale_colour_manual(values = c("black", "red")) +
  labs(title = "Relationship between Speed, Generation and Legendary status",
       subtitle = "Pokemon data for HW1",
       x = "Generation (1 - 6)",
       y = "Speed") +
  theme_bw()

plot_box_pretty

#Violins
ggplot(pokemon, aes(x = factor(generation),
                    y = speed,
                    fill = legendary,
                    colour = legendary)) +
  geom_violin() +
  scale_fill_manual(values = c("lightgrey", "darkblue")) +
  scale_colour_manual(values = c("black", "red")) +
  labs(title = "Violin plots are more fine-grained",
       subtitle = "geom_violin()",
       x = "Generation (1 - 6)",
       y = "Speed") +
  theme_bw()


# Facets
pokemon_plot_data <-
  pokemon[, list(speed,
                 generation = paste("Gen", generation),
                 legendary = ifelse(legendary, "Legend", "Normal")
                 )]

ggplot(pokemon_plot_data, aes(x = speed)) +
  geom_histogram(bins = 15) +
  facet_grid(legendary ~ generation) +
  labs(x = "Generation (1 - 6)",
       y = "Speed") +
  theme_bw()



