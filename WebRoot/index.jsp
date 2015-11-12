<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>">
    
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>BDSCyto</title>
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
    <style type="text/css">
      body {
      		
      		  background: url(img/background2.jpg) repeat;
  			  background-attachment: fixed;
              min-height: 700px;
              padding-top: 70px;
            }
      .result {
      	color: blue;
      }
    </style>
  </head>

  <body>

    <jsp:include page="header.jsp" />

    <div class="container">

		
	<div class="jumbotron">
		<h2>TATA-Predict - a web server of classifying tata-binding protein.<br><br></h2>
		
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" style="height:300px;">
		  <div class="panel panel-default">
		    <div class="panel-heading" role="tab" id="headingOne">
		      <h4 class="panel-title">
		        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
		          Introduction
		        </a>
		      </h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
		      <div class="panel-body">
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				TATA-Predict is a web server that helps bioinformatics researchers make experiments about protein class predicting, 
				especially tata-binding. TATA-Predict combines the feature extracting method of 188D and the Libsvm of 
				<mark>Chih-Jen Lin</mark>, and have a great performances in our experiments!
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Last but not least, the <mark>TATA-Predict v0.1</mark> is young, we will appreciate it if you fork it at 
				github or propose <mark>BUG</mark> to us.
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Thank you. Have a nice day.
				<div class="text-right">10th Nov, shixiang</div>
				</div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading" role="tab" id="headingTwo">
		      <h4 class="panel-title">
		        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		          Participator
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
		      <div class="panel-body">
				<div class="media">
				  <div class="media-left">
				    <a href="#">
				      <img class="media-object" src="img/shixiang.jpg" alt="...">
				    </a>
				  </div>
				  <div class="media-body">
			        Author: Shixiang Wan</br>
			      	Email: shixiangwan@gmail.com</br>
			      	Github: https://github.com/ShixiangWan</br>
				  </div>
				</div>
		      </div>
		      <div class="panel-body">
				<div class="media">
				  <div class="media-left">
				    <a href="#">
				      <img class="media-object" src="img/zouquan.jpg" alt="...">
				    </a>
				  </div>
				  <div class="media-body">
			        Supervisor: Zou Quan was born in 1982. He received his Ph.D. degree in Artificial Intelligence and Infor-mation Process from Harbin Institute of Technology in 2009. Now He is an assistant professor and M.S. supervisor at Xiamen University. His research interests include Bioinformatics and data mining.
				  </div>
				</div>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading" role="tab" id="headingThree">
		      <h4 class="panel-title">
		        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		          Update History
		        </a>
		      </h4>
		    </div>
		    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
		      <div class="panel-body">
			  2015-11-10. Update to BDSCyto-min v0.1.<br>
		      </div>
		    </div>
		  </div>
		</div>	 
		
		<nav>
		  <ul class="pager">
		    <li><p><a class="btn btn-primary btn-lg btn-center" href="predict.jsp" role="button">Go lab now!</a></p></li>
		  </ul>
		</nav>
		
		
		
	</div> 
		
		
    <p class="text-center">Copyright DMLab@TJU. All Rights Reserved.</p>    
        

    </div> <!-- /container -->

    
  </body>
</html>