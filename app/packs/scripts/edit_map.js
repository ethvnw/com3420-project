/**
 * Adds drawing functionality to base map
 */

import "leaflet-draw";
import {
  map,
  fairways,
  greens,
  roughs,
  bunkers,
  water,
  rocks,
  trees,
  tees,
} from "./load_map.js";
import { FeatureGroup } from "leaflet";

var drawOptions = {
  position: "topleft",
  draw: {
    polyline: false,
    polygon: {
      allowIntersection: false,
    },
    circle: false,
    rectangle: false,
    marker: false,
    circlemarker: false,
  },
  edit: {
    featureGroup: fairways,
    remove: true,
  },
};

var drawControl = new L.Control.Draw(drawOptions);
/**
 * Reinitalises the draw control with the new featuregroup
 * @param {FeatureGroup} type the featuregroup to be edited
 * @returns {void}
 */
function initialiseDrawControl(type) {
  drawOptions.edit.featureGroup = type;
  map.removeControl(drawControl);

  drawControl = new L.Control.Draw(drawOptions);
  map.addControl(drawControl);
}
initialiseDrawControl(fairways);

var shapeType = document.getElementById("shape-type");
/**
 * Changes the featuregroup to be edited based on the dropdown menu
 * @returns {void}
 * @listens shapeType.onchange
 */
shapeType.onchange = function () {
  switch (shapeType.value) {
    case "fairway":
      initialiseDrawControl(fairways);
      break;
    case "green":
      initialiseDrawControl(greens);
      break;
    case "rough":
      initialiseDrawControl(roughs);
      break;
    case "rock":
      initialiseDrawControl(rocks);
      break;
    case "bunker":
      initialiseDrawControl(bunkers);
      break;
    case "water":
      initialiseDrawControl(water);
      break;
    case "tree":
      initialiseDrawControl(trees);
      break;
    case "tee":
      initialiseDrawControl(tees);
  }
};

/**
 * Adds the drawn shape to the correct featuregroup
 * @param {Event} e the shape that triggered the function
 * @returns {void}
 * @listens draw:created
 */
map.on("draw:created", function (e) {
  var layer = e.layer;

  switch (shapeType.value) {
    case "fairway":
      fairways.addLayer(layer);
      break;
    case "green":
      greens.addLayer(layer);
      break;
    case "rough":
      roughs.addLayer(layer);
      break;
    case "rock":
      rocks.addLayer(layer);
      break;
    case "bunker":
      bunkers.addLayer(layer);
      break;
    case "water":
      water.addLayer(layer);
      break;
    case "tree":
      trees.addLayer(layer);
      break;
    case "tee":
      tees.addLayer(layer);
  }
});
