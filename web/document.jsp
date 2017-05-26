<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE>
<html>
    <head>
        <base href="<%=basePath%>">
        <link rel="shortcut icon" href="icon.ico" type="image/x-icon" />
        <title>PreTATA</title>
	    <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <style type="text/css">
	        body {
	                padding-top: 80px;
                    /*background: url(img/background2.jpg) repeat;*/
                    /*background-attachment: fixed;*/
                    /*min-height: 1000px;*/
	            }
        </style>
        <script type="text/javascript">
            function note() {
                $("#note").html("Please wait a moment. Submitting data ... ");
            }
        </script>
  </head>
  
  <body>
  		<!-- 导航栏 -->
    	<jsp:include page="header.jsp" />
    	
    	<div class="container">
    		<div class="well">

                <h3>About PreTATA</h3>
                <p>It is necessary and essential to discovery protein function from the novel primary sequences. Wet lab experimental procedures are not only time-consuming, but also costly, so predicting protein structure and function reliably based only on amino acid sequence has significant value.TATA-binding protein (TBP) is a kind of DNA binding protein, which plays a key role in the transcrip-tion regulation. Our study proposed an automatic approach for identifying TATA-binding proteins effi-ciently, accurately, and conveniently. This method would guide for the special protein identificationwith computational intelligence strategies.</p>

                <h3>Original Source</h3>
                <p>The raw TBP dataset is downloaded from the Uniport database (http://www.uniprot.org). The dataset contains 964 TBP protein sequences. We clustered the raw dataset using CD-HIT before each analysis, because of extensive redundancy in the raw data (including many repeat sequences). We found 559 positive instances and 8,465 negative instances at a clustering threshold value of 90%. Then 559 negative control sequences were selected by random sampling from the 8,465 sequence negative instances. (<a href="download.do?type=type1">download source</a>)</p>

                <h3>Feature Dataset</h3>
                <p>Based on the original source above, we extracted a novel 188D and PriPred feature dataset (<a href="download.do?type=type2">download</a>) used for a series of machine learning experiments. This dataset can be dealt with <a target="_blank" href="http://www.cs.waikato.ac.nz/ml/weka/">WEKA</a> directly.</p>
                <p>For the convenience of scientific community, we offer trained model file for predicting TATA-binding directly. (<a href="download.do?type=type3">download</a>)</p>
                <p>If you have any question, please feel free to send us your doubt. (Email: shixiangwan@gmail.com)</p>

                <h3>Citation</h3>
                <p style="color: red;">Zou Quan, Shixiang Wan, Ying Ju, Jijun Tang, and Xiangxiang Zeng. "Pretata: predicting TATA binding proteins with novel features and dimensionality reduction strategy." BMC Systems Biology, 10.4 (2016): 401.</p>

			</div>
            <!-- 底部栏 -->
            <p style="text-align:center;" class="text-muted">Bioinformatics Laboratory - Tianjin University @ <a target="_blank" href="http://lab.malab.cn/~shixiang/">Shixiang Wan</a></p>
        </div>
  </body>
</html>
