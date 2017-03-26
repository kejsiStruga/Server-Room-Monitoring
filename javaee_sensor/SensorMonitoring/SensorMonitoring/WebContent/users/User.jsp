<%@ page import="com.administration.model.*" %> 
<%@ include file="/includes/header.html" %>
<script src="js/main.js"></script>
<link href="/css/user.css" rel="stylesheet">
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
		response.sendRedirect("/SensorMonitoring/login/index.jsp");
	}catch(Exception e) {
		out.print("error");
	}
} else {%>
		<%-- <%out.print(request.getServletPath()); %>
 --%>
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
						<a href="/SensorMonitoring/Profile.jsp">

							<span><i class="fa fa-user"></i></span>
							<span>Profile</span>
						</a>
					</li>
					<li >
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
				Profile
			</div>				
 			 <div class="form-group">
 		<!-- 	 action="UserController" method="POST" name="frmEditUser" -->
				 <form  class="show-user" id="form" style=" width: 500px;margin-left: 360px;" >
				     <% User user = (User)request.getAttribute("user"); %>    	
				        User ID : <input class="form-control" type="text" readonly="readonly" name="id" id="id"
				            value=" <%=user.getId() %> " /><br /> 
				        First Name : <input
				            type="text" class="form-control" name="firstName" id="firstName"
				            value=" <%=user.getFname() %> " /><br /> 
				        Last Name : <input
				            type="text" class="form-control" name="lastName" id="lastName"
				            value="<%=user.getLname() %>" /><br />            
				        Email : <input class="form-control" type="text" name="email" id="email"
				            value="<%=user.getEmail() %>" /><br /> 				           
				        Password: <input type="password" name="password" id="password" class="form-control" /><br />
				        Confirm Password: <input type="password" name="password_confirmation" id="password_confirmation" class="form-control" /><br />
				        <input id="submit" class="form-control btn btn-success" value="Submit" />            
               </form>
            </div>
          </div>
	</body>
<%
}
%>
<script>
	$(document).ready(function(){
		$('#submit').on('click',function()
		    {
	    	  var id = $('#id').val(); 
		      var fname=$('#firstName').val();
		      var lname = $('#lastName').val();
		      var email = $('#email').val();
		      var password = $('#password').val();
		      var password_conf = $('#password_confirmation').val();
		    
		        if(fname==''||lname=='' || email=='' || password=='' || password_conf=='')
		        { 

				 sweetAlert("All the fields are required", "Please try again !", "warning");
		         return false;
		        
		        }else if(password.length<4 )
		        {
		          sweetAlert("Password must be ate least 6 characters", "Please try again !", "warning");
		          return false;
		        }
		        else if(password!=password_conf)
		        {
		        	  sweetAlert("Your passwords must macth", "Please try again !", "warning");
			          return false;
		        }
		        else{  
			      $('#form').submit();
				      $.ajax({
				          type: "POST", 
				          url: "UserController", 					         
				          data:  {id: id, fname: fname, lname: lname, email: email, password: password},
					      success: function (result) {
								 sweetAlert("Profile updated successfully", "", "success");
					      },
					      error: function(err) {
							console.log(err);
						 }      
				      });
			    }
		    });
   });
</script>
</html>