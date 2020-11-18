morandi_palettes <- list(
  Two_Variables1 = c("#eee5f8", "#20233c"),
  Two_Variables2 = c("#edda95", "#264b75"),
  Three_Variables1 = c("#df9f97", "#626461", "#384277"),
  Three_Variables2 = c("#899f92", "#d8caaf", "#a27e7e"),
  WildDream = c("#4B5556", "#5F7880", "#CAA78D", "#CCA085", "#D3D5D4"),
  SweetDream = c("#B8926A", "#D2BFA6", "#A39886", "#D7C0AE", "#D0C0A6"),
  MistyForest = c("#2c2e41", "#626461", "#656565", "#abb7bd",
                  "#df9f97", "#c2d1be", "#ebdad3"),
  Melancholy = c("#20233c", "#264b75", "#8696a7", "#c9c0d3",
                 "#c1cbd7", "#eee5f8", "#ebf5f0"),
  Unicorn = c("#edda95", "#c5b8a5", "#b4c9c8", "#faead3",
             "#8696a7", "#dadad8", "#a27e7e"),
  Cava = c("#6D1919", "#986C62", "#F0E7DA", "#D4C8BE", "#F5F6F2")
)

#' Morandi Color Palette for R Plot
#' Morandi colors refer to a muted and pale color palette,
#' which is not bright as if covered with a layer of gray tone.
#' Morandi colors has rich connotation without a tendency to show off,
#' releasing the soothing elegance.
#'
#' @param name Palette name for plotting two variables:
#'   \code{Two_Variables1}, \code{Two_Variables2},
#'   three variables: \code{Three_Variables1}, \code{Three_Variables2}
#'   multivariables: \code{WildDream}, \code{SweetDream}, \code{MistyForest},
#'   \code{Melancholy}, \code{Aurora}, \code{Cava}.
#' @param n number of colors.
#' @param type "Continuous" or "discrete".
#'
#' @return A vector of colors
#' @export
#' @keywords colors
#' @examples
#' morandi("Two_Variables2")
#' morandi("Three_Variables2")
#' morandi("Cava")
#' morandi("Unicorn")
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' palette <- morandi(100, name = "Melancholy", type = "continuous")
#' image(volcano, col = palette)
morandi <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- morandi_palettes[[name]]
  if (is.null(pal))
    stop("Palette not available.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 2)
}
