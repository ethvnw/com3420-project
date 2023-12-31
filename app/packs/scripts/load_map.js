/**
 * Initialises Leaflet map and loads shapes from database onto it
 */

import L from "leaflet";
import "leaflet-draw";
import { OpenStreetMapProvider } from "leaflet-geosearch";

// ================== MAP SETUP ==================

var fairways = new L.FeatureGroup();
var greens = new L.FeatureGroup();
var roughs = new L.FeatureGroup();
var bunkers = new L.FeatureGroup();
var water = new L.FeatureGroup();
var rocks = new L.FeatureGroup();
var trees = new L.FeatureGroup();
var tees = new L.FeatureGroup();

var map = L.map("map", {
  center: [0, 0],
  zoom: 14,
  maxZoom: 21,
  minZoom: 4,
  maxBounds: [
    [-90, -180],
    [90, 180],
  ],
});

L.control.scale({ position: "topright" }).addTo(map);
map.addLayer(fairways);
map.addLayer(greens);
map.addLayer(roughs);
map.addLayer(trees);
map.addLayer(water);
map.addLayer(bunkers);
map.addLayer(rocks);
map.addLayer(tees);

// Sets colour of each feature group
fairways.on("layeradd", function () {
  fairways.setStyle({ color: "rgb(190, 255, 190)" });
});
greens.on("layeradd", function () {
  greens.setStyle({ color: "rgb(0, 255, 0)" });
});
roughs.on("layeradd", function () {
  roughs.setStyle({ color: "rgb(0, 120, 60)" });
});
rocks.on("layeradd", function () {
  rocks.setStyle({ color: "rgb(50, 50, 50)" });
});
bunkers.on("layeradd", function () {
  bunkers.setStyle({ color: "rgb(255, 255, 80)" });
});
water.on("layeradd", function () {
  water.setStyle({ color: "rgb(0, 0, 255)" });
});
trees.on("layeradd", function () {
  trees.setStyle({ color: "rgb(100, 50, 0)" });
});
tees.on("layeradd", function () {
  tees.setStyle({ color: "rgb(255, 255, 255)" });
});

// Only displays satellite layer on hole pages, not user_holes
if (
  !window.location.pathname.includes("userhole") &&
  !window.location.pathname.includes("user_hole")
) {
  const satelliteLayer = L.tileLayer(
    "http://mt0.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}",
    {
      attribution:
        "Imagery &copy;2023 Bluesky, CNES / Airbus, Getmapping plc, Infoterra Ltd & Bluesky, Maxar Technologies, The GeoInformation Group",
      maxZoom: 21,
      noWrap: true,
    }
  );

  map.addLayer(satelliteLayer);
}

// ================== LOADING SHAPES ONTO MAP ==================

// Gets data from hidden inputs, converts to arrays
var xCoords = document.getElementById("xCoordinates").value.split('"');
var yCoords = document.getElementById("yCoordinates").value.split('"');
var terrain = document.getElementById("terrain_type").value.split('"');

xCoords = xCoords.filter((x) => x != "[" && x != "]" && x != ", ");
yCoords = yCoords.filter((x) => x != "[" && x != "]" && x != ", ");
terrain = terrain.filter((x) => x != "[" && x != "]" && x != ", ");

// Creating multi-dimensional arrays
for (var i = 0; i < xCoords.length; i++) {
  xCoords[i] = xCoords[i].split(",");
  yCoords[i] = yCoords[i].split(",");
}

function loadShapes() {
  var bounds = new L.LatLngBounds();

  // Creating the shapes and adding to correct feature group
  for (var shape = 0; shape < xCoords.length; shape++) {
    var latLngs = [];
    for (var point = 0; point < xCoords[shape].length; point++) {
      latLngs.push([xCoords[shape][point], yCoords[shape][point]]);
    }
    var polygon = new L.Polygon(latLngs);

    switch (terrain[shape]) {
      case "fairway":
        fairways.addLayer(polygon);
        break;
      case "green":
        greens.addLayer(polygon);
        break;
      case "rough":
        roughs.addLayer(polygon);
        break;
      case "rock":
        rocks.addLayer(polygon);
        break;
      case "bunker":
        bunkers.addLayer(polygon);
        break;
      case "water":
        water.addLayer(polygon);
        break;
      case "tree":
        trees.addLayer(polygon);
        break;
      case "tee":
        tees.addLayer(polygon);
    }
    bounds.extend(polygon.getBounds());
  }

  return bounds;
}

// If there are no shapes, centre map on course
if (xCoords[0] == "" || xCoords[0] == "[]") {
  var osm = new OpenStreetMapProvider();
  var courseName = document.getElementById("course").value.split(",")[0];
  osm.search({ query: courseName }).then((result) => {
    map.setView([result[0].y, result[0].x], 16);
  });

  // If there are shapes, load them onto map and fit map to bounds
} else {
  var bounds = loadShapes();
  map.fitBounds(bounds);
  // Disables zooming out and panning away from shapes on user hole pages
  if (
    window.location.pathname.includes("userhole") ||
    window.location.pathname.includes("user_hole")
  ) {
    map.setMinZoom(map.getZoom());
    map.setMaxBounds(bounds.pad(1));
  }
}

export { map, fairways, greens, roughs, bunkers, water, rocks, trees, tees };
