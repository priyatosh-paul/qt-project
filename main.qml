/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Charts module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtCharts 2.0

Rectangle {
  //  width: 500
    //height: 400

    width: 640
    height: 480
    gradient: Gradient {
        GradientStop { position: 0.0; color: "lightblue" }
        GradientStop { position: 1.0; color: "white" }
    }

    //![1]
    ChartView {
        id: chartView
        title: "Graphical View"
    //![1]
        height: parent.height / 4 * 3
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        legend.alignment: Qt.AlignTop
        antialiasing: true

    //![2]
        BarCategoryAxis {
            id: barCategoriesAxis
            titleText: "Date"
        }

//        ValueAxis{
//            id: valueAxisY2
//            min: 0
//            max: 10
//            titleText: "Rainfall [mm]"

//     }

        ValueAxis {
            id: valueAxisX
            // Hide the value axis; it is only used to map the line series to bar categories axis
            visible: false
            min: 0
            max: 5
        }

        ValueAxis{
            id: valueAxisY
            min: 0
            max: 15
            titleText: "Value"
        }

        LineSeries {
            id: maxTempSeries
            axisX: valueAxisX
            axisY: valueAxisY
        //    name: "Max. Value"
        }

        LineSeries {
            id: minTempSeries
            axisX: valueAxisX
            axisY: valueAxisY
         //   name: "Min. Value"
        }

        BarSeries {
            id: myBarSeries
            axisX: barCategoriesAxis
            axisYRight: valueAxisY2
            BarSet {
                id: rainfallSet
             //   label: "Rainfall"
            }
        }
    //![2]
    }

    // A timer to refresh the forecast every 5 minutes
    Timer {
        interval: 300000
        repeat: true
        triggeredOnStart: true
        running: true
        onTriggered: {
            if (1) {
                //![3]
                // Make HTTP GET request and parse the result
                var xhr = new XMLHttpRequest;
                console.log("I am here");
             //   xhr.open("GET",
                         "http://free.worldweatheronline.com/feed/weather.ashx?q=Jyv%c3%a4skyl%c3%a4,Finland&format=json&num_of_days=5&key="
             //            + weatherAppKey);
                xhr.open("GET",
                                         "http://localhost:8086/query?db=mydb&pretty=true&q=SELECT value1 FROM cpu_load_short order by desc limit 100");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == XMLHttpRequest.DONE) {
                        console.log("Got response");
                        var a = JSON.parse(xhr.responseText);
                        parseWeatherData(a);
                    }
                }
                xhr.send();
                //![3]
            } else {
                // No app key for worldweatheronline.com given by the user -> use dummy static data
            //    var responseText = "{ \"data\": { \"current_condition\": [ {\"cloudcover\": \"10\", \"humidity\": \"61\", \"observation_time\": \"06:26 AM\", \"precipMM\": \"0.0\", \"pressure\": \"1022\", \"temp_C\": \"6\", \"temp_F\": \"43\", \"visibility\": \"10\", \"weatherCode\": \"113\",  \"weatherDesc\": [ {\"value\": \"Sunny\" } ],  \"weatherIconUrl\": [ {\"value\": \"http:\/\/www.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0001_sunny.png\" } ], \"winddir16Point\": \"SE\", \"winddirDegree\": \"140\", \"windspeedKmph\": \"7\", \"windspeedMiles\": \"4\" } ],  \"request\": [ {\"query\": \"Jyvaskyla, Finland\", \"type\": \"City\" } ],  \"weather\": [ {\"date\": \"2012-05-09\", \"precipMM\": \"0.4\", \"tempMaxC\": \"14\", \"tempMaxF\": \"57\", \"tempMinC\": \"7\", \"tempMinF\": \"45\", \"weatherCode\": \"116\",  \"weatherDesc\": [ {\"value\": \"Partly Cloudy\" } ],  \"weatherIconUrl\": [ {\"value\": \"http:\/\/www.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0002_sunny_intervals.png\" } ], \"winddir16Point\": \"S\", \"winddirDegree\": \"179\", \"winddirection\": \"S\", \"windspeedKmph\": \"20\", \"windspeedMiles\": \"12\" }, {\"date\": \"2012-05-10\", \"precipMM\": \"2.4\", \"tempMaxC\": \"13\", \"tempMaxF\": \"55\", \"tempMinC\": \"8\", \"tempMinF\": \"46\", \"weatherCode\": \"266\",  \"weatherDesc\": [ {\"value\": \"Light drizzle\" } ],  \"weatherIconUrl\": [ {\"value\": \"http:\/\/www.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0017_cloudy_with_light_rain.png\" } ], \"winddir16Point\": \"SW\", \"winddirDegree\": \"219\", \"winddirection\": \"SW\", \"windspeedKmph\": \"21\", \"windspeedMiles\": \"13\" }, {\"date\": \"2012-05-11\", \"precipMM\": \"11.1\", \"tempMaxC\": \"15\", \"tempMaxF\": \"59\", \"tempMinC\": \"7\", \"tempMinF\": \"44\", \"weatherCode\": \"266\",  \"weatherDesc\": [ {\"value\": \"Light drizzle\" } ],  \"weatherIconUrl\": [ {\"value\": \"http:\/\/www.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0017_cloudy_with_light_rain.png\" } ], \"winddir16Point\": \"SSW\", \"winddirDegree\": \"200\", \"winddirection\": \"SSW\", \"windspeedKmph\": \"20\", \"windspeedMiles\": \"12\" }, {\"date\": \"2012-05-12\", \"precipMM\": \"2.8\", \"tempMaxC\": \"7\", \"tempMaxF\": \"44\", \"tempMinC\": \"2\", \"tempMinF\": \"35\", \"weatherCode\": \"317\",  \"weatherDesc\": [ {\"value\": \"Light sleet\" } ],  \"weatherIconUrl\": [ {\"value\": \"http:\/\/www.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0021_cloudy_with_sleet.png\" } ], \"winddir16Point\": \"NW\", \"winddirDegree\": \"311\", \"winddirection\": \"NW\", \"windspeedKmph\": \"24\", \"windspeedMiles\": \"15\" }, {\"date\": \"2012-05-13\", \"precipMM\": \"0.4\", \"tempMaxC\": \"6\", \"tempMaxF\": \"42\", \"tempMinC\": \"2\", \"tempMinF\": \"35\", \"weatherCode\": \"116\",  \"weatherDesc\": [ {\"value\": \"Partly Cloudy\" } ],  \"weatherIconUrl\": [ {\"value\": \"http:\/\/www.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0002_sunny_intervals.png\" } ], \"winddir16Point\": \"WNW\", \"winddirDegree\": \"281\", \"winddirection\": \"WNW\", \"windspeedKmph\": \"21\", \"windspeedMiles\": \"13\" } ] }}";
              //      var responseText = "{    \"results\": [        {            \"statement_id\": 0,            \"series\": [                {                    \"name\": \"cpu_load_short\",                    \"columns\": [                        \"time\",                        \"value1\"                    ],                    \"values\": [                        [                            \"2019-08-28T08:47:01.172881821Z\",                            184                        ],                        [                            \"2019-08-28T08:47:02.128832481Z\",                            87                        ],                        [                            \"2019-08-28T08:47:02.284822739Z\",                            178                        ],                        [                            \"2019-08-28T08:47:02.412020539Z\",                            116                        ],                        [                            \"2019-08-28T08:47:02.518945064Z\",                            194                        ],                        [                            \"2019-08-28T08:47:02.68030703Z\",                            136                        ],                        [                            \"2019-08-28T08:47:02.873297391Z\",                            187                        ],                        [                            \"2019-08-28T08:47:03.099528265Z\",                            93                        ],                        [                            \"2019-08-28T08:47:03.313947966Z\",                            50                        ],                        [                            \"2019-08-28T08:47:03.448358336Z\",                            22                        ],                        [                            \"2019-08-28T08:47:03.57991059Z\",                            163                        ],                        [                            \"2019-08-28T08:47:03.703936475Z\",                            28                        ],                        [                            \"2019-08-28T08:47:03.812624156Z\",                            91                        ],                        [                            \"2019-08-28T08:47:03.932521985Z\",                            60                        ],                        [                            \"2019-08-28T08:47:04.038688374Z\",                            164                        ],                        [                            \"2019-08-28T08:47:04.14796325Z\",                            127                        ],                        [                            \"2019-08-28T08:47:04.275085589Z\",                            141                        ],                        [                            \"2019-08-28T08:47:04.387856229Z\",                            27                        ],                        [                            \"2019-08-28T08:47:04.496067259Z\",                            173                        ],                        [                            \"2019-08-28T08:47:04.604534569Z\",                            137                        ],                        [                            \"2019-08-28T08:47:04.703052426Z\",                            12                        ],                        [                            \"2019-08-28T08:47:04.81268015Z\",                            169                        ],                        [                            \"2019-08-28T08:47:04.929352961Z\",                            168                        ],                        [                            \"2019-08-28T08:47:05.045054383Z\",                            30                        ],                        [                            \"2019-08-28T08:47:05.184097028Z\",                            183                        ],                        [                            \"2019-08-28T08:47:05.292029514Z\",                            131                        ],                        [                            \"2019-08-28T08:47:05.404268726Z\",                            63                        ],                        [                            \"2019-08-28T08:47:05.515506553Z\",                            124                        ],                        [                            \"2019-08-28T08:47:05.631602261Z\",                            68                        ],                        [                            \"2019-08-28T08:47:05.732165016Z\",                            136                        ],                        [                            \"2019-08-28T08:47:05.836280413Z\",                            130                        ],                        [                            \"2019-08-28T08:47:05.944557741Z\",                            3                        ],                        [                            \"2019-08-28T08:47:06.061363851Z\",                            23                        ],                        [                            \"2019-08-28T08:47:06.193340329Z\",                            59                        ],                        [                            \"2019-08-28T08:47:06.314287343Z\",                            70                        ],                        [                            \"2019-08-28T08:47:06.429875998Z\",                            168                        ],                        [                            \"2019-08-28T08:47:06.570672535Z\",                            194                        ],                        [                            \"2019-08-28T08:47:06.69165362Z\",                            57                        ],                        [                            \"2019-08-28T08:47:06.822121869Z\",                            12                        ],                        [                            \"2019-08-28T08:47:06.937452839Z\",                            43                        ],                        [                            \"2019-08-28T08:47:07.052385896Z\",                            30                        ],                        [                            \"2019-08-28T08:47:07.172521316Z\",                            174                        ],                        [                            \"2019-08-28T08:47:07.317034608Z\",                            22                        ],                        [                            \"2019-08-28T08:47:07.430909781Z\",                            120                        ],                        [                            \"2019-08-28T08:47:07.548291536Z\",                            185                        ],                        [                            \"2019-08-28T08:47:07.662056394Z\",                            138                        ],                        [                            \"2019-08-28T08:47:07.768142303Z\",                            199                        ],                        [                            \"2019-08-28T08:47:07.888578554Z\",                            125                        ],                        [                            \"2019-08-28T08:47:07.994371923Z\",                            116                        ],                        [                            \"2019-08-28T08:47:08.119493153Z\",                            171                        ],                        [                            \"2019-08-28T08:47:08.2275534Z\",                            14                        ],                        [                            \"2019-08-28T08:47:08.344383884Z\",                            127                        ],                        [                            \"2019-08-28T08:47:08.458323899Z\",                            92                        ],                        [                            \"2019-08-28T08:47:08.572385906Z\",                            181                        ],                        [                            \"2019-08-28T08:47:08.685921696Z\",                            157                        ],                        [                            \"2019-08-28T08:47:08.794036632Z\",                            74                        ],                        [                            \"2019-08-28T08:47:08.910738141Z\",                            63                        ],                        [                            \"2019-08-28T08:47:09.029213581Z\",                            171                        ],                        [                            \"2019-08-28T08:47:09.146067125Z\",                            197                        ],                        [                            \"2019-08-28T08:47:09.271575941Z\",                            82                        ],                        [                            \"2019-08-28T08:47:09.397079079Z\",                            106                        ],                        [                            \"2019-08-28T08:47:09.51980937Z\",                            126                        ],                        [                            \"2019-08-28T08:47:09.6290057Z\",                            85                        ],                        [                            \"2019-08-28T08:47:09.744816945Z\",                            128                        ],                        [                            \"2019-08-28T08:47:09.852188343Z\",                            137                        ],                        [                            \"2019-08-28T08:47:09.968960321Z\",                            106                        ],                        [                            \"2019-08-28T08:47:10.08063559Z\",                            47                        ],                        [                            \"2019-08-28T08:47:10.243013791Z\",                            130                        ],                        [                            \"2019-08-28T08:47:10.416722784Z\",                            114                        ],                        [                            \"2019-08-28T08:47:10.531002554Z\",                            58                        ],                        [                            \"2019-08-28T08:47:10.641348977Z\",                            125                        ],                        [                            \"2019-08-28T08:47:10.755527865Z\",                            96                        ],                        [                            \"2019-08-28T08:47:10.889663057Z\",                            183                        ],                        [                            \"2019-08-28T08:47:11.015880536Z\",                            146                        ],                        [                            \"2019-08-28T08:47:11.139514254Z\",                            15                        ],                        [                            \"2019-08-28T08:47:11.245456962Z\",                            168                        ],                        [                            \"2019-08-28T08:47:11.363557437Z\",                            35                        ],                        [                            \"2019-08-28T08:47:11.478727878Z\",                            165                        ],                        [                            \"2019-08-28T08:47:11.597665257Z\",                            44                        ],                        [                            \"2019-08-28T08:47:11.71979797Z\",                            151                        ],                        [                            \"2019-08-28T08:47:11.835947234Z\",                            88                        ],                        [                            \"2019-08-28T08:47:11.936396485Z\",                            9                        ],                        [                            \"2019-08-28T08:47:12.046335804Z\",                            77                        ],                        [                            \"2019-08-28T08:47:12.165854849Z\",                            179                        ],                        [                            \"2019-08-28T08:47:12.281919716Z\",                            189                        ],                        [                            \"2019-08-28T08:47:12.404533503Z\",                            185                        ],                        [                            \"2019-08-28T08:47:12.528693639Z\",                            4                        ],                        [                            \"2019-08-28T08:47:12.636139759Z\",                            52                        ],                        [                            \"2019-08-28T08:47:12.74867404Z\",                            155                        ],                        [                            \"2019-08-28T08:47:12.863953153Z\",                            200                        ],                        [                            \"2019-08-28T08:47:12.981006905Z\",                            133                        ],                        [                            \"2019-08-28T08:47:13.107088492Z\",                            61                        ],                        [                            \"2019-08-28T08:47:13.228585269Z\",                            77                        ],                        [                            \"2019-08-28T08:47:13.340225094Z\",                            169                        ],                        [                            \"2019-08-28T08:47:13.453693059Z\",                            140                        ],                        [                            \"2019-08-28T08:47:13.573325021Z\",                            13                        ],                        [                            \"2019-08-28T08:47:13.688291981Z\",                            27                        ],                        [                            \"2019-08-28T08:47:13.815014429Z\",                            187                        ],                        [                            \"2019-08-28T08:47:13.940123945Z\",                            95                        ],                        [                            \"2019-08-28T08:47:14.054962403Z\",                            140                        ]                    ]                }            ]        }    ]}";
                 var responseText = "{    \"results\": [        {            \"statement_id\": 0,            \"series\": [                {                    \"name\": \"cpu_load_short\",                    \"columns\": [                        \"time\",                        \"value1\"                    ],                    \"values\": [                        [                            \"2019-08-28T08:47:01.172881821Z\",                            184                        ],                        [                            \"2019-08-28T08:47:02.128832481Z\",                            87                        ],                        [                            \"2019-08-28T08:47:02.284822739Z\",                            178                        ],                        [                            \"2019-08-28T08:47:02.412020539Z\",                            116                        ]                                       ]                }            ]        }    ]}";

                var a = JSON.parse(responseText);
                if (a)
                    parseWeatherData(a);
                else
                     console.log("Parse Error");
            }
        }
    }

    Row {
        id: weatherImageRow
        anchors.top: chartView.bottom
        anchors.topMargin: 5
        anchors.bottom: poweredByText.top
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height - chartView.height - anchors.topMargin

        ListModel {
            id: weatherImageModel
        }

        Repeater {
            id: repeater
            model: weatherImageModel
            delegate: Image {
                source: imageSource
                width: weatherImageRow.height
                height: width
                fillMode: Image.PreserveAspectCrop
            }
        }
    }

    Text {
        id: poweredByText
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 25
        height: parent.height / 25
//        text: "Powered by World Weather Online"
    }

   function parseWeatherData(weatherData)
   // function parseWeatherData(results)
    {
        // Clear previous values
        maxTempSeries.clear();
        minTempSeries.clear();
        weatherImageModel.clear();
        console.log("I am at parseWeatherData ");
        //![4]
        // Loop through the parsed JSON
     //   for (var i in weatherData.data.weather) {
        //    var weatherObj = weatherData.data.weather[i];

         //   for (var i = 0; i < 100; i++)
            for (var i in weatherData.results[0].series[0].values){
            //  x += weatherData.results.series.values[i]
           //     var weatherObj =weatherData.results.series.values[i];

//                x += weatherData.results.statement_id.name.columns.values[i]
            //![4]

            //![5]
            // Store temperature values, rainfall and weather icon.
            // The temperature values begin from 0.5 instead of 0.0 to make the start from the
            // middle of the rainfall bars. This makes the temperature lines visually better
            // synchronized with the rainfall bars.
           //var i;
            maxTempSeries.append(Number(i) + 0.5, weatherData.results[0].series[0].values[i][1]);
            minTempSeries.append(Number(i) + 0.5, weatherData.results[0].series[0].values[i][1]);


            //![5]

            // Update scale of the chart
            valueAxisY.max = Math.max(chartView.axisY().max,weatherData.results[0].series[0].values[i][1]);
            valueAxisX.min = 0;
            valueAxisX.max = Number(i) + 1;

            // Set the x-axis labels to the dates of the forecast
            var xLabels = barCategoriesAxis.categories;
            xLabels[Number(i)] = weatherData.results[0].series[0].values[i][0].substring(0, 10);
            barCategoriesAxis.categories = xLabels;
            barCategoriesAxis.visible = true;
            barCategoriesAxis.min = 0;
            barCategoriesAxis.max = xLabels.length - 1;
        }
    }

}
