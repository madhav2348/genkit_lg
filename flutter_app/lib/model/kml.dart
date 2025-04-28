import 'package:lg_ai/model/ai_data_model.dart';

class KML {
  final String heading;
  final String description;
  final List<String> facts;
  final Location location;

  KML({
    required this.heading,
    required this.description,
    required this.facts,
    required this.location,
  });

  String get fileKML {
    return '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>   
   <Style id="trailhead-balloon-template">  
    <BalloonStyle>       
      <text>
        <![CDATA[         
          <h2>$heading</h2>    
          <p>$description</p>            
          <ul>
        <li>${facts[0]}</li>
        <li>${facts[1]}</li>
        <li>${facts[2]}</li>
         </ul>    
        ]]>
      </text>   
      <bgColor>ffffffff</bgColor>  
    </BalloonStyle> 
  </Style>    
  <Placemark>     
    <name>$heading</name>     
    <styleUrl>#trailhead-balloon-template</styleUrl>   
    <Snippet maxLines="0"></Snippet>
    <description></description>
    	<gx:balloonVisibility>1</gx:balloonVisibility>  
   <Point>       
      <coordinates>${location.longitute},${location.latitude}/coordinates>     
    </Point>   
  </Placemark>     
</Document> 
</kml>
''';
  }
}



    // <li>${facts[0]}</li>
    //     <li>${facts[1]}</li>
    //     <li>${facts[2]}</li>
