@colora: #ffffb2;
@colorb: #fecc5c;
@colorc: #fd8d3c;
@colord: #f03b20;
@colore: #bd0026;

Map {
  background-color: #b8dee6;
}

#countries {
  ::outline {
    line-color: #85c5d3;
    line-width: 2;
    line-join: round;
  }
  polygon-fill: #fff;
}

#botany[zoom >= 4],
#botany-density[zoom >= 4]{
  marker-width: 8;
  marker-line-color: #ccf;
  marker-allow-overlap: true;
}

#botany[zoom >= 4] {
  [collection_sub_department = 'Bryophytes']::overlay {
    marker-fill: #f00;
    marker-width: 8;
    marker-allow-overlap: true;
    marker-line-color: #fcc;
  }
}

#botany-density[zoom >= 4] {
  marker-opacity: 0.01;
}

#botany-year[zoom >= 4] {
  marker-width: 10;
  marker-line-width: 0.8;
  marker-line-color: white;
  marker-fill: #bbb;
  marker-allow-overlap: true;
  [scientific_name_author_year =~ '17.*']::overlay {
    marker-fill: @colorb;
    marker-width: 12;
    marker-allow-overlap: true;
    marker-line-width: 0.8;
    marker-line-color: white;
  }
  [scientific_name_author_year =~ '18.*']::overlay {
    marker-fill: @colorc;
    marker-width: 12;
    marker-allow-overlap: true;
    marker-line-width: 0.8;
    marker-line-color: white;
  }
  [scientific_name_author_year =~ '19.*']::overlay {
    marker-fill: @colord;
    marker-width: 12;
    marker-allow-overlap: true;
    marker-line-width: 0.8;
    marker-line-color: white;
  }
  [scientific_name_author_year =~ '20.*']::overlay {
    marker-fill: @colore;
    marker-width: 12;
    marker-allow-overlap: true;
    marker-line-width: 0.8;
    marker-line-color: white;
  }
}

#gridded[zoom >= 6] {
  marker-width: 8;
  marker-fill: #444;
  marker-allow-overlap: true;
  ::text {
    text-face-name: "DejaVu Sans Book";
    text-size: 15;
    text-name: "[count]";
    text-allow-overlap: true;
    text-dy: 10;
  }
  opacity: 0.8;
}


#grid {
  line-width:1;
  line-color:#168;
}
