import './style.css';
import OSM from 'ol/source/OSM';
import { Overlay } from 'ol';

import { Map, View } from 'ol';
import TileLayer from 'ol/layer/Tile';
import { Vector as VectorLayer } from 'ol/layer';
import VectorSource from 'ol/source/Vector';
import { GeoJSON } from 'ol/format';
import { Style, Stroke, Fill } from 'ol/style';
import { Select, defaults } from 'ol/interaction';
import { pointerMove, click } from 'ol/events/condition';

const g_url = "http://localhost:42888";

function getCQL() {
  let sCQL = "";

  const slant01 = document.getElementById("slant01");
  const slant02 = document.getElementById("slant02");
  const slant03 = document.getElementById("slant03");
  const slant04 = document.getElementById("slant04");

  if ((true == slant01.checked) || (true == slant02.checked) || (true == slant03.checked) || (true == slant04.checked)) 
    sCQL += "(";

  if (true == slant01.checked) {
    sCQL += "slant = '평지' or slant = '저지'"
  }

  if (true == slant02.checked) {
    if (sCQL.charAt(sCQL.length - 1) != '(')
      sCQL += " or "
    sCQL += "slant='완경사'"
  }

  if (true == slant03.checked) {
    if (sCQL.charAt(sCQL.length - 1) != '(')
      sCQL += " or "
    sCQL += "slant='급경사'"
  }

  if (true == slant04.checked) {
    if (sCQL.charAt(sCQL.length - 1) != '(')
      sCQL += " or "
    sCQL += "slant='고지'"
  }

  if ((true == slant01.checked) || (true == slant02.checked) || (true == slant03.checked) || (true == slant04.checked))
    sCQL += ")"

  console.log("filter=" + sCQL)

  return sCQL;
}

function updateWFSSource() {
  let surl = g_url + "/geoserver/donghae/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=donghae:info";
  surl = surl + "&outputFormat=application/json";
  surl = surl + "&CQL_FILTER=" + getCQL();

  wfsSource.setUrl(encodeURI(surl)); // WFS 소스 URL 업데이트
  wfsSource.refresh(); // 새로운 데이터를 불러오기 위해 소스 갱신
}

const wfsSource = new VectorSource({
  format: new GeoJSON(),
  url: ''
});

function getFeatureStyle(feature) {
  const slant = feature.get('slant');
  const slant01 = document.getElementById("slant01").checked;
  const slant02 = document.getElementById("slant02").checked;
  const slant03 = document.getElementById("slant03").checked;
  const slant04 = document.getElementById("slant04").checked;

  let color = 'rgba(145, 145, 145, 0.6)'; // 기본 회색

  if (slant01 && (slant === '평지' || slant === '저지')) {
    color = 'rgba(0, 255, 0, 0.6)'; // 녹색
  } else if (slant02 && slant === '완경사') {
    color = 'rgba(255, 255, 0, 0.6)'; // 노란색
  } else if (slant03 && slant === '급경사') {
    color = 'rgba(255, 165, 0, 0.6)'; // 주황색
  } else if (slant04 && slant === '고지') {
    color = 'rgba(255, 0, 0, 0.6)'; // 빨간색
  }

  return new Style({
    stroke: new Stroke({
      color: 'rgba(255, 255, 255, 0.4)',
      width: 1
    }),
    fill: new Fill({
      color: color
    })
  });
}

const wfsLayer = new VectorLayer({
  source: wfsSource,
  style: function(feature) { return getFeatureStyle(feature); } // 함수로 스타일 설정
});

const osmLayer = new TileLayer({
  source: new OSM()
});

const mouseHoverSelect = new Select({
  condition: pointerMove,
  style: new Style({
    stroke: new Stroke({
      color: 'rgba(0, 0, 255, 1.0)',
      width: 2
    }),
    fill: new Fill({
      color: 'rgba(0, 0, 255, 0.5)'
    })
  })
});

const landypop = document.getElementById('landyview');
const overlayLayer = new Overlay({
  element: landypop
});

const mouseClickSelect = new Select({
  condition: click,
  style: new Style({
    stroke: new Stroke({
      color: 'rgba(0, 0, 255, 1.0)',
      width: 3
    }),
    fill: new Fill({
      color: 'rgba(0, 0, 255, 0.5)'
    })
  })
});

const map = new Map({
  target: 'map',
  layers: [osmLayer, wfsLayer],
  view: new View({
    center: [14367375.61632484, 4509887.790027254],
    zoom: 12
  }),
  interactions: defaults().extend([mouseHoverSelect, mouseClickSelect]),
  overlays: [overlayLayer]
});

map.on('click', (e) => {
  console.log(e);

  overlayLayer.setPosition(undefined);

  map.forEachFeatureAtPixel(e.pixel, (feature, layer) => {
    if (!feature) return;

    let id = feature.get('address');
    let jibun = feature.get('jibun');
    let area = feature.get('area');
    let youngdo = feature.get('youngdo');
    let price = feature.get('price');

    document.getElementById("jspurl").href = "info.jsp?cvsid=" + id;
    document.getElementById("cvs_id").innerHTML = id;
    document.getElementById("cvs_name").innerHTML = jibun;
    document.getElementById("cvs_addr_doro").innerHTML = area;
    document.getElementById("cvs_addr_jibun").innerHTML = youngdo;
    document.getElementById("cvs_tel").innerHTML = price;

    overlayLayer.setPosition(e.coordinate);
  });
});

function refreshMap() {
  wfsSource.refresh(); // WFS 소스 갱신
  wfsLayer.setStyle(function(feature) { return getFeatureStyle(feature); }); // 스타일 재설정
}

document.getElementById('slant01').onchange = function() {
  updateWFSSource();
  refreshMap();
};
document.getElementById('slant02').onchange = function() {
  updateWFSSource();
  refreshMap();
};
document.getElementById('slant03').onchange = function() {
  updateWFSSource();
  refreshMap();
};
document.getElementById('slant04').onchange = function() {
  updateWFSSource();
  refreshMap();
};

updateWFSSource();
