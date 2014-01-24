Map {
  background-color: desaturate(#b8dee6, 100%);
}

#countries {
  ::outline {
    line-color: desaturate(#85c5d3, 100%);
    line-width: 2;
    line-join: round;
  }
  polygon-fill: #fff;
}

@size: 20;

#botany[zoom >= 4] {
  marker-file: url('symbols/marker.svg');
  marker-allow-overlap: true;
  marker-opacity: 0.2;
  marker-width: @size;
  marker-height: @size;
  marker-clip: false;
  image-filters: colorize-alpha(blue, cyan, green, yellow , orange, red);
  opacity: 0.8;
  [zoom >= 7] {
    marker-width: @size * 2;
    marker-height: @size * 2;
  }
}
