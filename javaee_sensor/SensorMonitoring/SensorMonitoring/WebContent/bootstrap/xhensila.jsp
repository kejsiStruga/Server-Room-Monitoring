
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
    
    
    <title>Dashboard</title>

    
    
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="css/local.css" />
    

    <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://sdk.amazonaws.com/js/aws-sdk-2.1.40.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <!-- you need to include the shieldui css and js assets in order for the charts to work -->
    <link rel="stylesheet" type="text/css" href="http://www.shieldui.com/shared/components/latest/css/light-bootstrap/all.min.css" />
    <link id="gridcss" rel="stylesheet" type="text/css" href="http://www.shieldui.com/shared/components/latest/css/dark-bootstrap/all.min.css" />

    <script type="text/javascript" src="http://www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
    <script type="text/javascript" src="http://www.prepbootstrap.com/Content/js/gridData.js"></script>
    
    
    
    <style>
    
    
.btn {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  padding: 10px 16px;
}
  
.btn-lg {
  font-size: 18px;
  line-height: 1.33;
  border-radius: 6px;
}

.btn-primary {
  color: #fff;
  background-color: #428bca;
  border-color: #357ebd;
}

.btn-primary:hover,
.btn-primary:focus,
.btn-primary:active,
.btn-primary.active,
.open .dropdown-toggle.btn-primary {
  color: #fff;
  background-color: #3276b1;
  border-color: #285e8e;
}

/***********************
  RAISED BUTTONS
************************/
.btn-primary.raised {
    box-shadow: 0 3px 0 0 #007299;
}
.btn-primary.raised:active, .btn-primary.raised.active {
    background: #33a6cc;
    box-shadow: none;
    margin-bottom: -3px;
    margin-top: 3px;
}

/***********************
  CUSTON BTN VALUES
************************/

.btn {
    padding: 14px 24px;
    border: 0 none;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
}
.btn:focus, .btn:active:focus, .btn.active:focus {
    outline: 0 none;
}

.btn-primary {
    background: #0099cc;
    color: #ffffff;
}
.btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open > .dropdown-toggle.btn-primary {
    background: #33a6cc;
}
.btn-primary:active, .btn-primary.active {
    background: #007299;
    box-shadow: none;
}
div.panel-body {
   
} 






    </style>
    
</head>

<body>
   <%--  <%
        String email=(String)session.getAttribute("email");
        
        //redirect user to login page if not logged in
        if(email==null){
            response.sendRedirect("index.jsp");
        }
        %>  --%>
    <div id="wrapper">
          <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"> <p> User:  <%=email%> 
            </div>
           
              
              
              <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul id="active" class="nav navbar-nav side-nav">
                    <li class="selected"><a href="#"><i class="fa fa-bullseye"></i> Dashboard</a></li>
                    <li><a href="regjistrimi.html"><i class="fa fa-font"></i> Register a new user</a></li>
                    <li><a href="logout.jsp"><i class="fa fa-font"></i> Logout</a></li>
                    </ul>
                
                
                <ul class="nav navbar-nav navbar-right navbar-user">
                    <li class="dropdown messages-dropdown">
                        <a href="#" class="dropdown-toggle">
                             Today's date is: 
                            <script language="javascript">
                            var today = new Date();
                            document.write(today);
                            </script>
                            
                            
                            </a>
                        
            </div>
        </nav>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1> Server Room Dashboard <small>Statistics and more</small></h1>
                    <div class="alert alert-dismissable alert-warning">
                        <button data-dismiss="alert" class="close" type="button">&times;</button>
                        Welcome to the Server Room  dashboard!  
                        <br />
                       
                    </div>
                </div>
            </div>
           
            
            
            <div class="row">
                <div class="col-md-8">
                    <div class="panel panel-primary"> 
                                
                       
                        
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i> 5 minute feed from home sensors for the past 24 hours </h3>
                             </div>
                        
                        
                        
<div class="panel-body" >  
   
    
    
    <!-- KODI I GRAFIKUUUUUUUUUUT--> 
    <div class="container"  style="width:800px;">
    <br />
    <div class="row">
        <div class="col-md-6">
            <canvas id="temperaturegraph" class="inner cover" width="500" height="320"></canvas>
            <br />
           
            
            <div class="panel panel-default">
                <div class="panel-body">
                    
                    
                    
                    
                    <div class="row">
                        
                        
                        <div class="col-sm-3 text-right">
                            <span class="label label-danger">High</span>&nbsp;
                        </div>
                        
                        <div class="col-sm-9">
                            <span id="t-high" class="text-muted">(n/a)</span>
                        </div>
                        
                        
                   </div>
                    
                    
                    
                    <div class="row">
                        
                        <div class="col-sm-3 text-right">
                            <span class="label label-success">Low</span>&nbsp;
                        </div>
                       
                        
                        <div class="col-sm-9">
                            <span id="t-low" class="text-muted">(n/a)</span>
                        </div>
                   
                    
                    </div>
                
                
                
                
                
                </div>
            </div>
        </div>
       
            
            
            <div class="col-md-6">
            <canvas id="humiditygraph" class="inner cover" width="500" height="320"></canvas>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-3 text-right">
                            <span class="label label-danger">High</span>&nbsp;
                        </div>
                        <div class="col-sm-9">
                            <span id="h-high" class="text-muted">(n/a)</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3 text-right">
                            <span class="label label-success">Low</span>&nbsp;
                        </div>
                        <div class="col-sm-9">
                            <span id="h-low" class="text-muted">(n/a)</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
        
        
        
        
        
        
        <div class="row">
        <div class="col-md-12">
            <p class="text-center">5 minute feed from home sensors for the past 24 hours.</p>
        </div>
    </div>

        
        
        
</div> <!-- /container -->


<script>
    $(document).ready(function(){
        AWS.config.region = 'us-west-2'; // Region
        AWS.config.credentials = new AWS.Credentials('', '');
        var dynamodb = new AWS.DynamoDB();
        var datumVal = new Date() - 864000;
        var params = {
            TableName: 'serverRoomSensor',
            KeyConditionExpression: '#key = :key and #timestamp >= :datum',
            ExpressionAttributeNames: {
                "#key": "key",
                "#timestamp": "timestamp"
            },
            ExpressionAttributeValues: {
                ":key": { "S" : "sensordata"},
                ":datum": { "S" : datumVal.toString()}
            }
        };
        /* Create the context for applying the chart to the HTML canvas */
        var tctx = $("#temperaturegraph").get(0).getContext("2d");
        var hctx = $("#humiditygraph").get(0).getContext("2d");
        /* Set the options for our chart */
        var options = {
            responsive: true,
            showLines: true,
            scales: {
                xAxes: [{
                    display: false
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        };
        /* Set the inital data */
        var tinit = {
            labels: [],
            datasets: [
                {
                    label: "Temperature °C",
                    backgroundColor: 'rgba(204,229,255,0.5)',
                    borderColor: 'rgba(153,204,255,0.75)',
                    data: []
                }
            ]
        };
        var hinit = {
            labels: [],
            datasets: [
                {
                    label: "Humidity %",
                    backgroundColor: 'rgba(229,204,255,0.5)',
                    borderColor: 'rgba(204,153,255,0.75)',
                    data: []
                }
            ]
        };
        var temperaturegraph = new Chart.Line(tctx, {data: tinit, options: options});
        var humiditygraph = new Chart.Line(hctx, {data: hinit, options: options});
        $(function() {
            getData();
            $.ajaxSetup({ cache: false });
            setInterval(getData, 3000);
        });
        /* Makes a scan of the DynamoDB table to set a data object for the chart */
        function getData() {
            dynamodb.query(params, function (err, data) {
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
                    for (var i in data['Items']) {
                        // read the values from the dynamodb JSON packet
                        temperatureRead = parseFloat(data['Items'][i]['payload']['M']['temperature']['N']);
                        humidityRead = parseFloat(data['Items'][i]['payload']['M']['humidity']['N']);
                        timeRead = new Date(parseInt(data['Items'][i]['timestamp']['S'],10)).toUTCString().slice(0, -3);
                        //parseInt(Milliseconds,10)new Date(parseInt(Milliseconds,10));
                        console.log(new Date(parseInt(data['Items'][i]['timestamp']['S'],10)).toUTCString().slice(0, -3));
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
                    $('#t-high').text(Number(temperatureHigh).toFixed(2).toString() + '°C at ' + temperatureHighTime);
                    $('#t-low').text(Number(temperatureLow).toFixed(2).toString() + '°C at ' + temperatureLowTime);
                    $('#h-high').text(Number(humidityHigh).toFixed(2).toString() + '% at ' + humidityHighTime);
                    $('#h-low').text(Number(humidityLow).toFixed(2).toString() + '% at ' + humidityLowTime);
                }
            });
        }
    });
</script>
 <!-- KEETU PERFUNDON GRAFIKUUUU -->
                            
                        </div>
                    </div>
                </div>
                
                
              
                
                
                
                
                
               <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i> Traffic Sources One month tracking </h3>
                        </div>
                        <div class="panel-body">
                            <div id="shieldui-grid1"></div>
                        </div>
                    </div>
                </div>
            </div>
                
          
                
                
          <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i> Logins per week</h3>
                        </div>
                        <div class="panel-body">
                            <div id="shieldui-chart2"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-magnet"></i> Server Overview</h3>
                        </div>
                        <div class="panel-body">
                            <ul class="server-stats">
                                <li>
                                    <div class="key pull-right">CPU</div>
                                    <div class="stat">
                                        <div class="info">60% / 37°C / 3.3 Ghz</div>
                                        <div class="progress progress-small">
                                            <div style="width: 70%;" class="progress-bar progress-bar-danger"></div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="key pull-right">Mem</div>
                                    <div class="stat">
                                        <div class="info">29% / 4GB (16 GB)</div>
                                        <div class="progress progress-small">
                                            <div style="width: 29%;" class="progress-bar"></div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="key pull-right">LAN</div>
                                    <div class="stat">
                                        <div class="info">6 Mb/s <i class="fa fa-caret-down"></i>&nbsp; 3 Mb/s <i class="fa fa-caret-up"></i></div>
                                        <div class="progress progress-small">
                                            <div style="width: 48%;" class="progress-bar progress-bar-inverse"></div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
              
              
              
              <div class="col-lg-4">
                    <header>
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a data-toggle="tab" href="#stats">Users</a>
                            </li>
                           
                            
                        </ul>
                    </header>
                    
                    
                    
                    
                    
                    <div class="body tab-content">
                        <div class="tab-pane clearfix active" id="stats">
                         <h5 class="tab-header"><i class="fa fa-calendar-o fa-2x"></i> Last logged-in users</h5>
                            <ul class="news-list">
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Ivan Gorge</a></div>
                                        <div class="position">Software Engineer</div>
                                        <div class="time">Last logged-in: Mar 12, 11:11</div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Roman Novak</a></div>
                                        <div class="position">Product Designer</div>
                                        <div class="time">Last logged-in: Mar 12, 19:02</div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Teras Uotul</a></div>
                                        <div class="position">Chief Officer</div>
                                        <div class="time">Last logged-in: Jun 16, 2:34</div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Deral Ferad</a></div>
                                        <div class="position">Financial Assistant</div>
                                        <div class="time">Last logged-in: Jun 18, 4:20</div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Konrad Polerd</a></div>
                                        <div class="position">Sales Manager</div>
                                        <div class="time">Last logged-in: Jun 18, 5:13</div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-pane" id="report">
                            <h5 class="tab-header"><i class="fa fa-star fa-2x"></i> Popular contacts</h5>
                            <ul class="news-list news-list-no-hover">
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Pol Johnsson</a></div>
                                        <div class="options">
                                            <button class="btn btn-xs btn-success">
                                                <i class="fa fa-phone"></i>
                                                Call
                                            </button>
                                            <button class="btn btn-xs btn-warning">
                                                <i class="fa fa-envelope-o"></i>
                                                Message
                                            </button>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Terry Garel</a></div>
                                        <div class="options">
                                            <button class="btn btn-xs btn-success">
                                                <i class="fa fa-phone"></i>
                                                Call
                                            </button>
                                            <button class="btn btn-xs btn-warning">
                                                <i class="fa fa-envelope-o"></i>
                                                Message
                                            </button>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Eruos Forkal</a></div>
                                        <div class="options">
                                            <button class="btn btn-xs btn-success">
                                                <i class="fa fa-phone"></i>
                                                Call
                                            </button>
                                            <button class="btn btn-xs btn-warning">
                                                <i class="fa fa-envelope-o"></i>
                                                Message
                                            </button>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Remus Reier</a></div>
                                        <div class="options">
                                            <button class="btn btn-xs btn-success">
                                                <i class="fa fa-phone"></i>
                                                Call
                                            </button>
                                            <button class="btn btn-xs btn-warning">
                                                <i class="fa fa-envelope-o"></i>
                                                Message
                                            </button>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Lover Lund</a></div>
                                        <div class="options">
                                            <button class="btn btn-xs btn-success">
                                                <i class="fa fa-phone"></i>
                                                Call
                                            </button>
                                            <button class="btn btn-xs btn-warning">
                                                <i class="fa fa-envelope-o"></i>
                                                Message
                                            </button>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-pane" id="dropdown1">
                            <h5 class="tab-header"><i class="fa fa-comments fa-2x"></i> Top Commenters</h5>
                            <ul class="news-list">
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Edin Garey</a></div>
                                        <div class="comment">
                                            Nemo enim ipsam voluptatem quia voluptas sit aspernatur 
                                            aut odit aut fugit,sed quia
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Firel Lund</a></div>
                                        <div class="comment">
                                            Duis aute irure dolor in reprehenderit in voluptate velit
                                             esse cillum dolore eu fugiat.
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Jessica Desingter</a></div>
                                        <div class="comment">
                                            Excepteur sint occaecat cupidatat non proident, sunt in
                                             culpa qui officia deserunt.
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Novel Forel</a></div>
                                        <div class="comment">
                                            Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque.
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <i class="fa fa-user fa-4x pull-left"></i>
                                    <div class="news-item-info">
                                        <div class="name"><a href="#">Wedol Reier</a></div>
                                        <div class="comment">
                                            Laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis
                                            et quasi.
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /#wrapper -->

    <script type="text/javascript">
        jQuery(function ($) {
            var performance = [12, 43, 34, 22, 12, 33, 4, 17, 22, 34, 54, 67],
                visits = [123, 323, 443, 32],
                traffic = [
                {
                    Source: "Direct", Amount: 323, Change: 53, Percent: 23, Target: 600
                },
                {
                    Source: "Refer", Amount: 345, Change: 34, Percent: 45, Target: 567
                },
                {
                    Source: "Social", Amount: 567, Change: 67, Percent: 23, Target: 456
                },
                {
                    Source: "Search", Amount: 234, Change: 23, Percent: 56, Target: 890
                },
                {
                    Source: "Internal", Amount: 111, Change: 78, Percent: 12, Target: 345
                }];


            $("#shieldui-chart1").shieldChart({
                theme: "dark",

                primaryHeader: {
                    text: "Visitors"
                },
                exportOptions: {
                    image: false,
                    print: false
                },
                dataSeries: [{
                    seriesType: "area",
                    collectionAlias: "Q Data",
                    data: performance
                }]
            });

            $("#shieldui-chart2").shieldChart({
                theme: "dark",
                primaryHeader: {
                    text: "Traffic Per week"
                },
                exportOptions: {
                    image: false,
                    print: false
                },
                dataSeries: [{
                    seriesType: "pie",
                    collectionAlias: "traffic",
                    data: visits
                }]
            });

            $("#shieldui-grid1").shieldGrid({
                dataSource: {
                    data: traffic
                },
                sorting: {
                    multiple: true
                },
                rowHover: false,
                paging: false,
                columns: [
                { field: "Source", width: "170px", title: "Source" },
                { field: "Amount", title: "Amount" },                
                { field: "Percent", title: "Percent", format: "{0} %" },
                { field: "Target", title: "Target" },
                ]
            });            
        });        
    </script>
</body>
</html>
