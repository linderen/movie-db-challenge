module MoviesHelper
  def movie_thumbnail(movie, big = false)
    style = "width: 200px; height: 296px;"
    src = "movie_thumbnail_small.svg"
    if big
      style = "width: 300px; height: 444px;"
      src = "movie_thumbnail_big.svg"
    end
    if movie.poster.blank?
      image_tag(src, class: "img-thumbnail", style: style)
    else
      image_tag(movie.poster, class: "img-thumbnail", style: style)
    end
  end
end
