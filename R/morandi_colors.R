morandi_colors <- list(
  color1 = c("#eee5f8"), color2 = c("#7a7281"), color3 = c("#f8ebd8"),
  color4 = c("#c1cbd7"), color5 = c("#8696a7"), color6 = c("#dfd7d7"),
  color7 = c("#e0e6e2"), color8 = c("#899f92"), color9 = c("#e0ebdb"),
  color10 = c("#c2d1be"), color11 = c("#c9c0d3"), color12 = c("#a6a6a8"),
  color13 = c("#dadad8"), color14 = c("#afb0b2"), color15 = c("#9ca8b8"),
  color16 = c("#656565"), color17 = c("#e5eaef"), color18 = c("#ebf5f0"),
  color19 = c("#abb7bd"), color20 = c("#b4c9c8"), color21 = c("#c7b8a1"),
  color22 = c("#cac3bb"), color23 = c("#a29988"), color24 = c("#939391"),
  color25 = c("#ececea"), color26 = c("#d8caaf"), color27 = c("#eee4e2"),
  color28 = c("#ebdad3"), color29 = c("#fee2d1"), color30 = c("#df9f97"),
  color31 = c("#faead3"), color32 = c("#f0ebe5"), color33 = c("#b7b1a5"),
  color34 = c("#bfbfbf"), color35 = c("#fffaf4"), color36 = c("#c5b8a5"),
  color37 = c("#f0e3af"), color38 = c("#fde8b6"), color39 = c("#e8e98b"),
  color40 = c("#edda95"), color41 = c("#ead0d1"), color42 = c("#6b5152"),
  color43 = c("#d3d4cc"), color44 = c("#e0e5df"), color45 = c("#96a48b"),
  color46 = c("#fdf9ee"), color47 = c("#e2e2e0"), color48 = c("#d0cfca"),
  color49 = c("#626461"), color50 = c("#424242"), color51 = c("#a27e7e"),
  color52 = c("#965454"), color53 = c("#e0cdcf"), color54 = c("#b5c4b1"),
  color55 = c("#7b8b6f"), color56 = c("#f0ebe5"), color57 = c("#20233c"),
  color58 = c("#264b75"), color59 = c("#2c2e41"), color60 = c("#384277")
)

#' Show all the morandi colors
#' @param x x
#' @export
#' @importFrom graphics pie title
#' @examples morandi_show()

morandi_show <- function(x) {
  pal <- as.character(morandi_colors)

  par(mar = rep(0, 4))
  x = pie(rep(1, length(pal)), col = pal)
  x
  title(main = "All the Morandi Colors", cex.main = 1, line = -1)
  print("Showing all the morandi colors")
}


#' DIY your own morandi palette
#'
#' @param my_colors a numeric vector
#' @param n number of colors
#' @param type "discrete" or "continuous"
#'
#' @return a color vector
#' @export
#'
#' @examples
#' x <- c(3, 6, 9, 18, 56)
#' my_diy_colors <- morandi_diy(my_colors = x, type = c("discrete"))
morandi_diy <- function(my_colors, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  if (length(my_colors) > 60)
    stop("Exceeded the total number of colors")
  if (length(my_colors) <= 0)
    stop("Must select at least one color")

  palette = c()

  for (i in 1:length(my_colors)) {
    palette[[i]] <- morandi_colors[[my_colors[[i]]]]
  }

  if (is.null(palette))
    stop("Palette not available.")

  if (missing(n)) {
    n <- length(palette)
  }

  if (type == "discrete" && n > length(palette)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(palette)(n),
                discrete = palette[1:n]
  )
  structure(out, class = "palette")
}
