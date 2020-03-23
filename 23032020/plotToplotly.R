library(dplyr )
dat %>% 
  select(created_at,`PM2.5_CF1_ug/m3`) ->dat
dat$datettime <- as.POSIXct(as.character(dat$created_at),format="%Y-%m-%d %H:%M:%S",tz = "UTC")

esquisse::esquisser(viewer = "browser")

p <- ggplot(dat) +
  aes(x = datettime, y = `PM2.5_CF1_ug/m3`) +
  geom_line(size = 1L, colour = "#0c4c8a") +
  theme_minimal()
library (plotly)
ggplotly(p)
chart_link = api_create(p, filename = "public-graph",username = "anwargalshami", key = "w0DcOBMV5n31M5Y8hPZs")
chart_link
plot_ly()
