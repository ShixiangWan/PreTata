<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <!-- bootstrap -->
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- jPages -->
    <link href="css/jPages.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <script src="js/jPages.min.js"></script>
    
    <style type="text/css">
      body {
              background: url(img/background2.jpg) repeat;
              background-attachment: fixed;
              min-height: 1000px;
              padding-top: 70px;
            }
      .result {
      	color: blue;
      }
      .warn {
      	color: red;
      }
    </style>
	<script type="text/javascript">
		/* 重置所有表单 */
		function formReset()
		{
			document.getElementById("form").reset();
		}
		/* 检查上传的文件格式 */
	  	function check(thiz){
	  		var value = $(thiz).val();
	  		value = value.substring(value.lastIndexOf(".")+1);
	  		if (value.indexOf("fasta") == -1) {
	  			document.getElementById("form").reset();
	  			alert("Please insure file format (.fasta)!");
	  		}
	  	}
		/* 检查粘贴蛋白质序列个数 */
	  	function check2(thiz){
	  		var value = $(thiz).val();
	  		var count=0;
	  		var max=10000;
	  		while(value.indexOf(">") >=0 )
	  		{
	  			value = value.replace(">","");
	  			count++;
	  		}
	  		if (count>0) $('#count').removeClass().addClass("result").text('Current Instances: '+count);
	  		if (count>=max) {
	  			document.getElementById("form").reset();
	  			alert("Exceed the limit !"+"(<"+max+")");
	  			$('#count').text("Exceed the limit !"+" (<"+max+")");
	  		}
	  	}
    	/* 分页设置 */
    	$(function(){  
    		$("div.holder").jPages({  
    		  containerID : "itemContainer",
    		  previous : "←",
    		  next : "→",
    		  perPage : 10,  //每页的最大显示页数
    		  delay : 50  //动画时延，单位ms
    		});
    	}); 
	</script>
  </head>

  <body>

	<!-- 引入导航栏 -->
    <jsp:include page="header.jsp" />

    <div class="container">

		<div class="panel panel-primary">
		  <div class="panel-heading">
		    <h2 class="panel-title">
		    	<span class="glyphicon glyphicon-hourglass" aria-hidden="true"></span>
		    	<strong>Predict unknown sequence(s): </strong> Upload or paste FASTA (required)
		    </h2>
		  </div>
		  <div class="panel-body">
			<form id="form" action="predict.do"  method="post" enctype="multipart/form-data">
			  	<div class="radio">
				  <label>
				    <input type="radio" name="name" id="optionsRadios1" value="option1" checked>
				    Upload file
				    <input type="file" name="file" onchange="check(this)">
				  </label>
				</div>
				<div class="radio">
				  <label>
				    <input type="radio" name="name" id="optionsRadios2" value="option2">
				    Paste file content
				  </label>
				  <textarea class="form-control" rows="13" name="paste" onchange="check2(this)"></textarea>
				</div>
				<p>*<strong>Note:</strong> the size of your data must be less than 20MB!
					<span class="warn" id="count">${requestScope.error}</span>
				</p>
				<button type="button" onclick="formReset()" class="btn btn-warning btn-center" style="width:200px;">
					Reset
				</button>
				<button type="submit" class="btn btn-success btn-center"  style="width:200px;">
					<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
					Submit experiment
				</button>
			</form>
		  </div>
		</div>
		
		<!-- Records of your experiment -->
		<div class="panel panel-primary">
		
		  <div class="panel-heading">
		    <h2 class="panel-title">
		    	<span class="glyphicon glyphicon-th" aria-hidden="true"></span>
		    	Records of your experiment
	    	</h2>
		  </div>
		  
		  <div class="panel-body">
		  <c:if test="${empty requestScope.mymap}">
			  <p>You have no data here. </p>
			  <p>Now, uploading your data or paste your sequence and getting rusults. </p>
		  </c:if>
		  <c:if test="${not empty requestScope.mymap}">
		  		<p>Your data has a great performance! The accuracy is <span class="result">${requestScope.accuracy}</span>!</p>
		  		<p>From all of your data, there are <span class="result">${requestScope.pos}</span> positive instances, 
		  		<span class="result">${requestScope.neg}</span> negative inatances, and 
		  		<span class="result">${requestScope.all}</span> instances in all.</p>
			  	<table class="table table-condensed table-bordered">
					<tr>
					  <td class="active col-md-1">ID</td>
					  <td class="info col-md-10">Sequence Name</td>
					  <td class="info col-md-1">Predict class</td>
					</tr>
					<tbody id="itemContainer">  <!-- 分页搜索区 -->
					<c:set var="index" value="0" />
			        <c:forEach items="${requestScope.mymap}" var="m">
			        <c:set var="index" value="${index+1}" />
					<tr>
					  <td class="result">${index}</td>
					  <td class="result">${m.key}</td>
					  <td class="result">${m.value}</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
				
				<!-- 分页导航显示区 -->
			  	<div class="holder"></div>
			  
		  </c:if>
		  </div><!-- /panel-body -->
		  
		</div>

    </div> <!-- /container -->

  </body>
</html>