<%@page import="com.administration.controller.*" %>
<%@page import="com.administration.model.*" %>
<%@include file="/includes/dashboard.html" %>
<script src="js/main.js"></script>
<link href="/css/dashboard.css" rel="stylesheet" />
</head>

<body>
<%
//ne menyre qe edhe nese user-i klikon butonin Back ne Browser, cache 
//Cache-Control is a HTTP Header that controls caching between
//the server and client. It is set using the HttpServletResponse like
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session.getAttribute("authenticated")==null ) {
	try{
		response.sendRedirect("/SensorMonitoring");
	}catch(Exception e) {
		out.print("error");
	}
} else {
		%>
                    <div class="header">
                        <div class="logo">
                            <i class="fa fa-tachometer"></i>
                            <span>Server Room</span>
                        </div>
                        <a href="#" class="nav-trigger"><span></span></a>
                    </div>
                    <div class="side-nav">
                        <div class="logo">
                            <i class="fa fa-tachometer"></i>
                            <span>Server Room</span>
                        </div>
                        <nav>
                            <ul>
                                <li>
                                    <%  Crud userElement = new Crud();
						String email = (String)session.getAttribute("email");
						User us = userElement.getIdByEmail(email);
			        %>
                                        <a href="UserController?action=edit&id=<%=String.valueOf(us.id)%>">
						<span><i class="fa fa-user"></i></span>
						<span>Profile</span>
					</a>
                                </li>
                                <li>
                                    <a href="/SensorMonitoring/Dashboard.jsp">
							<span><i class="fa fa-bar-chart"></i></span>
							<span>Dashboard</span>
						</a>
                                </li>
                                <li>
                                    <form method="post" action="/SensorMonitoring/DownloadFile">
                                        <button style="color:white;" type="submit" class="btn btn-link">
								<span><i class="fa fa-download"></i></span>
								<span>Download</span>
							</button>
                                    </form>
                                </li>
                                <li>
                                    <a href="/SensorMonitoring/Logout.jsp">
							<span><i class="fa fa-sign-out"></i></span>
							<span>Logout</span>
						</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <div class="main-content">
                        <div class="title">
                            Analytics
                        </div>
                        <div class="main">
                            <div class="col-md-6">
                                <canvas id="humiditygraph" class="inner cover" width="500" height="320"></canvas>
                                <br />
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="">
                                            <div class="col-sm-3 text-right">
                                                <span class="label label-danger">High</span>&nbsp;
                                            </div>
                                            <div class="col-sm-9">
                                                <span id="h-high" class="text-muted red-high">(n/a)</span>
                                            </div>
                                        </div>
                                        <div class="">
                                            <div class="col-sm-3 text-right">
                                                <span class="label label-success ">Low</span>&nbsp;
                                            </div>
                                            <div class="col-sm-9">
                                                <span id="h-low" class="text-muted  green-low">(n/a)</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <canvas id="temperaturegraph" class="inner cover" width="500" height="320"></canvas>
                                <br />
                                <div class="panel panel-default" style="background:#eef1f7;">
                                    <div class="panel-body">
                                        <div class="">
                                            <div class="col-sm-3 text-right">
                                                <span class="label label-danger">High</span>&nbsp;
                                            </div>
                                            <div class="col-sm-9">
                                                <span id="t-high" class="text-muted red-high">(n/a)</span>
                                            </div>
                                        </div>
                                        <div class="">
                                            <div class="col-sm-3 text-right">
                                                <span class="label label-success ">Low</span>&nbsp;
                                            </div>
                                            <div class="col-sm-9">
                                                <span id="t-low" class="text-muted green-low">(n/a)</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </body>
            <script>
                $(document).ready(function() {
                    // get current URL path and assign 'active' class
                    var pathname = window.location.pathname;
                    AWS.config.region = 'us-west-2'; // Region
                    AWS.config.credentials = new AWS.Credentials('AKIAIXHH7KUMVY7ASKNQ', 'LfiH9Z3hknRTpL5T1JGMelcDZU2wSpSwsYQceYC7');
                    var dynamodb = new AWS.DynamoDB();
                    var params = {
                        TableName: 'serverRoomSensor',
                        KeyConditionExpression: '#key = :key',
                        ExpressionAttributeNames: {
                            "#key": "key"
                        },
                        ExpressionAttributeValues: {
                            ":key": {
                                "S": "sensordata"
                            }
                        },
                        Limit: 10,
                        ScanIndexForward: false
                    };

                    var tctx = $("#temperaturegraph").get(0).getContext("2d");
                    var hctx = $("#humiditygraph").get(0).getContext("2d");

                    var options = {
                        responsive: true,
                        showLines: true,
                        scales: {
                            xAxes: [{
                                display: false
                            }],
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        },
                        showXLabels: 10
                    };
                    /* Set the inital data */
                    var tinit = {
                        labels: [],
                        datasets: [{
                            label: "Temperature °C",
                            backgroundColor: 'rgba(204,229,255,0.5)',
                            borderColor: 'rgba(153,204,255,0.75)',
                            data: []
                        }]
                    };
                    var hinit = {
                        labels: [],
                        datasets: [{
                            label: "Humidity %",
                            backgroundColor: 'rgba(229,204,255,0.5)',
                            borderColor: 'rgba(204,153,255,0.75)',
                            data: []
                        }]
                    };
                    var temperaturegraph = new Chart.Line(tctx, {
                        data: tinit,
                        options: options
                    });
                    var humiditygraph = new Chart.Line(hctx, {
                        data: hinit,
                        options: options
                    });

                    getData();
                    $(function() {
                        getData();
                        $.ajaxSetup({
                            cache: false
                        });
                        setInterval(getData, 3000);
                    });

                    function getData() {
                        dynamodb.query(params, function(err, data) {
                            if (err) {
                                console.log(err);
                                return null;
                            } else {
                                // placeholders for the data arrays
                                var temperatureValues = [];
                                var humidityValues = [];
                                var labelValues = [];
                                // placeholders for the data read
                                var temperatureRead = 0.0;
                                var humidityRead = 0.0;
                                var timeRead = "";
                                // placeholders for the high/low markers
                                var temperatureHigh = -999.0;
                                var humidityHigh = -999.0;
                                var temperatureLow = 999.0;
                                var humidityLow = 999.0;
                                var temperatureHighTime = "";
                                var temperatureLowTime = "";
                                var humidityHighTime = "";
                                var humidityLowTime = "";
                                var timeRead1 = "";
                                var time = "";

                                for (var i in data['Items']) {
                                    // read the values from the dynamodb JSON packet
                                    temperatureRead = parseFloat(data['Items'][i]['payload']['M']['temperature']['N']);
                                    humidityRead = parseFloat(data['Items'][i]['payload']['M']['humidity']['N']);
                                    timeRead = new Date(parseInt(data['Items'][i]['timestamp']['S'], 10)).toString().substring(1, 25);

                                    // check the read values for high/low watermarks
                                    if (temperatureRead < temperatureLow) {
                                        temperatureLow = temperatureRead;
                                        temperatureLowTime = timeRead;
                                    }
                                    if (temperatureRead > temperatureHigh) {
                                        temperatureHigh = temperatureRead;
                                        temperatureHighTime = timeRead;
                                    }
                                    if (humidityRead < humidityLow) {
                                        humidityLow = humidityRead;
                                        humidityLowTime = timeRead;
                                    }
                                    if (humidityRead > humidityHigh) {
                                        humidityHigh = humidityRead;
                                        humidityHighTime = timeRead;
                                    }
                                    // append the read data to the data arrays
                                    temperatureValues.push(temperatureRead);
                                    humidityValues.push(humidityRead);
                                    labelValues.push(timeRead);
                                }
                                // set the chart object data and label arrays
                                temperaturegraph.data.labels = labelValues;
                                temperaturegraph.data.datasets[0].data = temperatureValues;
                                humiditygraph.data.labels = labelValues;
                                humiditygraph.data.datasets[0].data = humidityValues;
                                // redraw the graph canvas
                                temperaturegraph.update();
                                humiditygraph.update();
                                // update the high/low watermark sections
                                $('#t-high').text(Number(temperatureHigh).toFixed(2).toString() + '°C ' + temperatureHighTime);
                                $('#t-low').text(Number(temperatureLow).toFixed(2).toString() + '°C  ' + temperatureLowTime);
                                $('#h-high').text(Number(humidityHigh).toFixed(2).toString() + '%  ' + humidityHighTime);
                                $('#h-low').text(Number(humidityLow).toFixed(2).toString() + '% ' + humidityLowTime);
                            }
                        });
                    }
                });
            </script>
            <%
}
%>
</html>
