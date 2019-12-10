library(tidyverse)
library(deldir)
library(viridis)

set.seed(13)

n <- 40000

long <-
    runif(n = n,
          min = -30,
          max = 30)

lat <-
    runif(n = n,
          min = -30,
          max = 30)


df <-
    tibble(lat, long)

df %>%
    ggplot(aes(x = long, y = lat)) +
    geom_point()

voronoi <-
    deldir(df$long, df$lat)

# dirsgs => segmenting lines
# delsgs => connections

net <-
    voronoi$delsgs


### Red print

colors_vec <-
    viridis(n = 20, option = 'B')

set.seed(13)
net$edge_col <-
    sample(letters[1:20], nrow(net), replace = TRUE)


png('pollock_1.png', height = 1000, width = 1000)

ggplot() +
    geom_segment(data = net,
                 aes(x = x1, y = y1, xend = x2, yend = y2, col = edge_col),
                 size = .1) +
    scale_color_manual(values = colors_vec) +
    theme_void() +
    theme(legend.position = 'none') +
    theme(
      plot.background =
        element_rect(
          fill = 'black',
          color = 'black')
    ) +
    ylim(c(-30, 30)) +
    xlim(c(-30, 30))

dev.off()



### Green print

colors_vec <-
  viridis(n = 20, option = 'D')

set.seed(13)
net$edge_col <-
  sample(letters[1:20], nrow(net), replace = TRUE)


png('pollock_2.png', height = 1000, width = 1000)

ggplot() +
  geom_segment(data = net,
               aes(x = x1, y = y1, xend = x2, yend = y2, col = edge_col),
               size = .1) +
  scale_color_manual(values = colors_vec) +
  theme_void() +
  theme(legend.position = 'none') +
  theme(
    plot.background =
      element_rect(
        fill = 'black',
        color = 'black')
  ) +
  ylim(c(-30, 30)) +
  xlim(c(-30, 30))

dev.off()