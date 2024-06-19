import './style.css';

// 시험문제: 1번. Open Street Map을 사용하기 위해 import 한다.
// 여기가 답 자리. 이 줄을 지우고 답을 적으세요.

// 팝업창을 위해
import OSM from 'ol/source/OSM';
import { Overlay} from 'ol';

import {Map, View} from 'ol';
import TileLayer from 'ol/layer/Tile';

// geoserver에서 WFS 방식으로 가져오기 위해
import {Vector as VectorLayer} from 'ol/layer';
import VectorSource from 'ol/source/Vector';
import { GeoJSON } from 'ol/format';
import { Style } from 'ol/style';
import { Circle } from 'ol/style';
import { Stroke } from 'ol/style';
import { Fill } from 'ol/style';

// view와의 상호작용을 위해 
import { Select,DragBox,defaults } from 'ol/interaction';//드래그박스 추가
import { pointerMove,platformModifierKeyOnly, click } from 'ol/events/condition';//플랫폼수정키온리 추가
import {getWidth} from 'ol/extent';//폭 얻는 추가-어떤기능을 하는지 추가로 적을것


// 테스트 환경과 실제 tomcat 서버에 올렸을 때의 url이 다르니 g_url 변수를 이용한다.
const g_url = "http://172.20.221.167:42888";

/**
 * CQL 필터 만들기. 모든 CQL은 이 함수를 통한다.
 */
function getCQL()
{
  let sCQL = "";

  // 시험문제 2번. 전화번호가 063-247-3251 인 업체를 찾도록 CQL_Filter를 설정한다. (가장 마지막에 푸세요)
  // 여기가 답 자리. 이 줄을 지우고 답을 적으세요.

  return sCQL;
}

// geoserver에서 WFS 방식으로 자료를 받아와 openLayers에서 소스로 사용하도록 한다.
let surl = g_url;

// 시험문제 3번. geoserver에서 WFS 방식으로 자료를 받아오도록 URL을 구성한다.
// 여기가 답 자리. 이 줄을 지우고 답을 적으세요.
surl = surl + "/geoserver/donghae/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=donghae:first_data";
surl = surl + "&outputFormat=application/json";
surl = surl + "&CQL_FILTER=";
surl += getCQL();
const wfsSource = new VectorSource
(
  {
    format: new GeoJSON(),        
    url: encodeURI(surl)
  }
);


// 위에서 wfs로 받아온 벡터 소스를 openLayers의 vector layer에 올린다.
// 더 잘 보이게 스타일도 고친다.
const wfsLayer = new VectorLayer
(
  {
    source: wfsSource, 
    style: new Style
    (
       {
         stroke: new Stroke
         (
           {
             color: 'rgba(255, 140, 0, 0.4)',
             width: 1
           }
         ),

         fill: new Fill
         (
           {
             color: 'rgba(255, 140, 0, 0.2)'
           }
         )
       }
    ) 
  }
);


// osm 레이어를 만든다.
const osmLayer = new TileLayer
(
  {
    source: new OSM()
  }
);


// 마우스가 WFS 점 위로 올라갈 때(hover) 처리
const mouseHoverSelect = new Select
(
  {
    condition: pointerMove,
    style: new Style
    (
      {
        stroke: new Stroke
        (
          {
            color: 'rgba(0, 0, 255, 1.0)',
            width: 2
          }
        ),

        fill: new Fill
        (
          {
            color: 'rgba(0, 0, 255, 0.5)'
          }
        )
      }
   )
  }
);


// 마우스로 점을 클릭하면 흰색 선으로 굵게 표시한다.
const mouseClickSelect = new Select
(
  {
    condition: click,
    style: new Style
    (
      {
        stroke: new Stroke
        (
          {
            color: 'rgba(0, 0, 255, 1.0)',
            width: 3
          }
        ),

        fill: new Fill
        (
          {
            color: 'rgba(0, 0, 255, 0.5)'
          }
        )
      }
   )
  }
);  

// WFS 점을 클릭하면 보여줄 오버레이를 만든다.

// 시험문제 5번. popup을 위한 div를 가져온다. 여기까지 다 맞으면 지도가 나타남.
// 여기가 답 자리. 이 줄을 지우고 답을 적으세요.
const landypop = document.getElementById('landyview');
const overlayLayer  = new Overlay
(
  {
    element: landypop
  }
);

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

// 지도 클릭 이벤트 처리. 만약 WFS에서 어느 한 점을 클릭했으면 오버레이(popup) 처리한다.
map.on('click', (e) =>
{
  console.log(e);

//   // 일단 창을 닫는다. 이렇게 하면 자료가 없는 곳을 찍으면 창이 닫히는 효과가 나온다.
  overlayLayer.setPosition(undefined);

//   // 점찍은 곳의 자료를 찾아낸다. geoserver에서는 WFS를 위해 위치 정보 뿐 아니라 메타데이터도 같이 보내고 있다.
  map.forEachFeatureAtPixel(e.pixel, (feature, layer) =>
  {
//     // 이 point와 같이 넘어온 메타데이터 값을 찾는다.
    
    let id = feature.get('address');
    let jibun = feature.get('jibun');
    let area = feature.get('area');
    let youngdo = feature.get('youngdo');
    let price = feature.get('price');

//     // 오버레이를 위한 div에 값들을 적는다.
    
//     // 시험문제 6번. 오버레이의 맨 위에 표시되는 H3 크기의 제목을 클릭하면 상세 화면으로 이동하도록 설정한다.
//     // 여기가 답 자리. 이 줄을 지우고 답을 적으세요.
    document.getElementById("jspurl").href = "info.jsp?cvsid="+id;
    document.getElementById("cvs_id").innerHTML = id;
    document.getElementById("cvs_name").innerHTML = jibun;
    document.getElementById("cvs_addr_doro").innerHTML = area;
    document.getElementById("cvs_addr_jibun").innerHTML = youngdo;
    document.getElementById("cvs_tel").innerHTML = price;

//     // 오버레이 창을 띄운다.
    overlayLayer.setPosition(e.coordinate);
  })
}
);

const selectedStyle = new Style({
  fill: new Fill({
    color: 'rgba(255, 255, 255, 0.6)',
  }),
  stroke: new Stroke({
    color: 'rgba(255, 255, 255, 0.7)',
    width: 2,
  }),
});

// a normal select interaction to handle click
const select = new Select({
  style: function (feature) {
    const color = feature.get('COLOR_BIO') || '#eeeeee';
    selectedStyle.getFill().setColor(color);
    return selectedStyle;
  },
});
map.addInteraction(select);

const selectedFeatures = select.getFeatures();

// a DragBox interaction used to select features by drawing boxes
const dragBox = new DragBox({
  condition: platformModifierKeyOnly,
});

map.addInteraction(dragBox);

dragBox.on('boxend', function () {
  const boxExtent = dragBox.getGeometry().getExtent();

  // if the extent crosses the antimeridian process each world separately
  const worldExtent = map.getView().getProjection().getExtent();
  const worldWidth = getWidth(worldExtent);
  const startWorld = Math.floor((boxExtent[0] - worldExtent[0]) / worldWidth);
  const endWorld = Math.floor((boxExtent[2] - worldExtent[0]) / worldWidth);

  for (let world = startWorld; world <= endWorld; ++world) {
    const left = Math.max(boxExtent[0] - world * worldWidth, worldExtent[0]);
    const right = Math.min(boxExtent[2] - world * worldWidth, worldExtent[2]);
    const extent = [left, boxExtent[1], right, boxExtent[3]];

    const boxFeatures = wfsSource
      .getFeaturesInExtent(extent)
      .filter(
        (feature) =>
          !selectedFeatures.getArray().includes(feature) &&
          feature.getGeometry().intersectsExtent(extent),
      );

    // features that intersect the box geometry are added to the
    // collection of selected features

    // if the view is not obliquely rotated the box geometry and
    // its extent are equalivalent so intersecting features can
    // be added directly to the collection
    const rotation = map.getView().getRotation();
    const oblique = rotation % (Math.PI / 2) !== 0;

    // when the view is obliquely rotated the box extent will
    // exceed its geometry so both the box and the candidate
    // feature geometries are rotated around a common anchor
    // to confirm that, with the box geometry aligned with its
    // extent, the geometries intersect
    if (oblique) {
      const anchor = [0, 0];
      const geometry = dragBox.getGeometry().clone();
      geometry.translate(-world * worldWidth, 0);
      geometry.rotate(-rotation, anchor);
      const extent = geometry.getExtent();
      boxFeatures.forEach(function (feature) {
        const geometry = feature.getGeometry().clone();
        geometry.rotate(-rotation, anchor);
        if (geometry.intersectsExtent(extent)) {
          selectedFeatures.push(feature);
        }
      });
    } else {
      selectedFeatures.extend(boxFeatures);
    }
  }
});

// clear selection when drawing a new box and when clicking on the map
dragBox.on('boxstart', function () {
  selectedFeatures.clear();
});

const infoBox = document.getElementById('info');

selectedFeatures.on(['add', 'remove'], function () {
  const names = selectedFeatures.getArray().map((feature) => {
    return feature.get('address');
  });
  if (names.length > 0) {
    infoBox.innerHTML = names.join(', ');
  } else {
    infoBox.innerHTML = 'None';
  }
});
