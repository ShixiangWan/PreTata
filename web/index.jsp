<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>"><link rel="shortcut icon" href="icon.ico" type="image/x-icon" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>PreTATA</title>
    <!-- bootstrap -->
    <%--<link href="css/bootstrap-theme.min.css" rel="stylesheet">--%>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- jPages -->
    <link href="css/jPages.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <script src="js/jPages.min.js"></script>
    
    <style type="text/css">
      body {
              padding-top: 80px;
            }
      .result {
      	color: blue;
      }
      .warn {
      	color: red;
      }
    </style>
	<script type="text/javascript">
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

        function paste() {
            $("#paste").html(">sp|P20226|TP_HMAN TATA--inding prtein S=Hm sapiens GN=TP PE=1 SV=2\nMDQNNSLPPYAQGLASPQGAMTPGIPIFSPMMPYGTGLTPQPIQNTNSLSILEEQQRQQQ\nNIVSTVNLGCKLDLKTIALRARNAEYNPKRFAAVIMRIREPRTTALIFSSGKMVCTGAKS\nEEQSRLAARKYARVVQKLGFPAKFLDFKIQNMVGSCDVKFPIRLEGLVLTHQQFSSYEPE\nLFPGLIYRMIKPRIVLLIFVSGKVVLTGAKVRAEIYEAFENIYPILKGFRKTT\n>sp|P13393|TP_YEAST TATA--inding prtein S=Saccharmyces cerevisiae (strain ATCC 204508 / S288c) GN=SPT15 PE=1 SV=3\nMADEERLKEFKEANKIVFDPNTRQVWENQNRDGTKPATTFQSEEDIKRAAPESEKDTSAT\nSGIVPTLQNIVATVTLGCRLDLKTVALHARNAEYNPKRFAAVIMRIREPKTTALIFASGK\nMVVTGAKSEDDSKLASRKYARIIQKIGFAAKFTDFKIQNIVGSCDVKFPIRLEGLAFSHG\nTFSSYEPELFPGLIYRMVKPKIVLLIFVSGKIVLTGAKQREEIYQAFEAIYPVLSEFRKM\n>sp|P32333|MT1_YEAST TATA-inding prtein-assciated factr MT1 S=Saccharmyces cerevisiae (strain ATCC 204508 / S288c) GN=MT1 PE=1 SV=1\nMTSRVSRLDRQVILIETGSTQVVRNMAADQMGDLAKQHPEDILSLLSRVYPFLLVKKWET\nRVTAARAVGGIVAHAPSWDPNESDLVGGTNEGSPLDNAQVKLEHEMKIKLEEATQNNQLN\nLLQEDHHLSSLSDWKLNEILKSGKVLLASSMNDYNVLGKADDNIRKQAKTDDIKQETSML\nNASDKANENKSNANKKSARMLAMARRKKKMSAKNTPKHPVDITESSVSKTLLNGKNMTNS\nAASLATSPTSNQLNPKLEITEQADESKLMIESTVRPLLEQHEIVAGLVWQFQGIYELLLD\nNLMSENWEIRHGAALGLRELVKKHAYGVSRVKGNTREENNLRNSRSLEDLASRLLTVFAL\nDRFGDYVYDTVVAPVRESVAQTLAALLIHLDSTLSIKIFNCLEQLVLQDPLQTGLPNKIW\nEATHGGLLGIRYFVSIKTNFLFAHGLLENVVRIVLYGLNQSDDDVQSVAASILTPITSEF\nVKLNNSTIEILVTTIWSLLARLDDDISSSVGSIMDLLAKLCDHQEVLDILKNKALEHPSE\nWSFKSLVPKLYPFLRHSISSVRRAVLNLLIAFLSIKDDSTKNWLNGKVFRLVFQNILLEQ\nNPELLQLSFDVYVALLEHYKVKHTEKTLDHVFSKHLQPILHLLNTPVGEKGKNYAMESQY\nILKPSQHYQLHPEKKRSISETTTDSDIPIPKNNEHINIDAPMIAGDITLLGLDVILNTRI\nMGAKAFALTLSMFQDSTLQSFFTNVLVRCLELPFSTPRMLAGIIVSQFCSSWLQKHPEGE\nKLPSFVSEIFSPVMNKQLLNRDEFPVFRELVPSLKALRTQCQSLLATFVDVGMLPQYKLP\nNVAIVVQGETEAGPHAFGVETAEKVYGEYYDKMFKSMNNSYKLLAKKPLEDSKHRVLMAI\nNSAKESAKLRTGSILANYASSILLFDGLPLKLNPIIRSLMDSVKEERNEKLQTMAGESVV\nHLIQQLLENNKVNVSGKIVKNLCGFLCVDTSEVPDFSVNAEYKEKILTLIKESNSIAAQD\nDINLAKMSEEAQLKRKGGLITLKILFEVLGPSILQKLPQLRSILFDSLSDHENEEASKVD\nNEQGQKIVDSFGVLRALFPFMSDSLRSSEVFTRFPVLLTFLRSNLSVFRYSAARTFADLA\nKISSVEVMAYTIREILPLMNSAGSLSDRQGSTELIYHLSLSMETDVLPYVIFLIVPLLGR\nMSDSNEDVRNLATTTFASIIKLVPLEAGIADPKGLPEELVASRERERDFIQQMMDPSKAK\nPFKLPIAIKATLRKYQQDGVNWLAFLNKYHLHGILCDDMGLGKTLQTICIIASDQYLRKE\nDYEKTRSVESRALPSLIICPPSLTGHWENEFDQYAPFLKVVVYAGGPTVRLTLRPQLSDA\nDIIVTSYDVARNDLAVLNKTEYNYCVLDEGHIIKNSQSKLAKAVKEITANHRLILTGTPI\nQNNVLELWSLFDFLMPGFLGTEKMFQERFAKPIAASRNSKTSSKEQEAGVLALEALHKQV\nLPFMLRRLKEDVLSDLPPKIIQDYYCELGDLQKQLYMDFTKKQKNVVEKDIENSEIADGK\nQHIFQALQYMRKLCNHPALVLSPNHPQLAQVQDYLKQTGLDLHDIINAPKLSALRTLLFE\nCGIGEEDIDKKASQDQNFPIQNVISQHRALIFCQLKDMLDMVENDLFKKYMPSVTYMRLD\nGSIDPRDRQKVVRKFNEDPSIDCLLLTTKVGGLGLNLTGADTVIFVEHDWNPMNDLQAMD\nRAHRIGQKKVVNVYRIITKGTLEEKIMGLQKFKMNIASTVVNQQNSGLASMDTHQLLDLF\nDPDNVTSQDNEEKNNGDSQAAKGMEDIANETGLTGKAKEALGELKELWDPSQYEEEYNLD\nTFIKTLR\n>sp|Q01658|NC2_HMAN Prtein Dr1 S=Hm sapiens GN=DR1 PE=1 SV=1\nMASSSGNDDDLTIPRAAINKMIKETLPNVRVANDARELVVNCCTEFIHLISSEANEICNK\nSEKKTISPEHVIQALESLGFGSYISEVKEVLQECKTVALKRRKASSRLENLGIPEEELLR\nQQQELFAKARQQQAELAQQEWLQMQQAAQQAQLAAASASASNQAGSSQDEEDDDDI\n>sp|P28147|TP1_ARATH TATA--inding prtein 1 S=Araidpsis thaliana GN=TP1 PE=1 SV=1\nMTDQGLEGSNPVDLSKHPSGIVPTLQNIVSTVNLDCKLDLKAIALQARNAEYNPKRFAAV\nIMRIREPKTTALIFASGKMVCTGAKSEDFSKMAARKYARIVQKLGFPAKFKDFKIQNIVG\nSCDVKFPIRLEGLAYSHAAFSSYEPELFPGLIYRMKVPKIVLLIFVSGKIVITGAKMRDE\nTYKAFENIYPVLSEFRKIQQ\n>sp|P20227|TP_DRME TATA--inding prtein S=Drsphila melangaster GN=Tp PE=1 SV=1\nMDQMLSPNFSIPSIGTPLHQMEADQQIVANPVYHPPAVSQPDSLMPAPGSSSVQHQQQQQ\nQSDASGGSGLFGHEPSLPLAHKQMQSYQPSASYQQQQQQQQLQSQAPGGGGSTPQSMMQP\nQTPQSMMAHMMPMSERSVGGSGAGGGGDALSNIHQTMGPSTPMTPATPGSADPGIVPQLQ\nNIVSTVNLCCKLDLKKIALHARNAEYNPKRFAAVIMRIREPRTTALIFSSGKMVCTGAKS\nEDDSRLAARKYARIIQKLGFPAKFLDFKIQNMVGSCDVKFPIRLEGLVLTHCNFSSYEPE\nLFPGLIYRMVRPRIVLLIFVSGKVVLTGAKVRQEIYDAFDKIFPILKKFKKQS\n>sp|Q7SL3|TP_DANRE TATA--inding prtein S=Dani reri GN=tp PE=1 SV=1\nMEQNNSLPPFAQGLASPQGAMTPGLPIFSPMMPYGTGLTPQPVQNSNSLSLLEEQQRQQQ\nQQQAASQQQGGMVGGSGQTPQLYHSTQAVSTTTALPGNTPLYTTPLTPMTPITPATPASE\nSSGIVPQLQNIVSTVNLGCKLDLKTIALRARNAEYNPKRFAAVIMRIREPRTTALIFSSG\nKMVCTGAKSEEQSRLAARKYARVVQKLGFPAKFLDFKIQNMVGSCDVKFPIRLEGLVLTH\nQQFSSYEPELFPGLIYRMIKPRIVLLIFVSGKVVLTGAKVRGEIYEAFENIYPILKGFRK\nTS\n>sp|Q6P926|SPA24_MSE Spermatgenesis-assciated prtein 24 S=Ms mscls GN=Spata24 PE=1 SV=1\nMATPLGWSQGGSGSVCLAFDQLRDVIESQEELIHQLRNVMVLQDENFVSKEEFHEIEKKL\nVEEKAAHAKTKALLAKEEEKLQFALGEVEVLSKQLEKEKMAFEKALSSVKSRVLQESSKK\nDQLITKCNEIESHIIKQEDILNGKENEIKELQQVISQQKQNFRNHISDFRIQKQQETYMA\nQVLDQKRKKATGMRRARSRQCSREK\n>sp|43133|TP_CANAL TATA--inding prtein S=Candida alicans (strain SC5314 / ATCC MYA-2876) GN=TP1 PE=2 SV=1\nMDLKLPPTNPTNPQQAKTFMKSIEEDEKNKAEDLDIIKKEDIDEPKQEDTTDGNGGGGIG\nIVPTLQNIVATVNLDCRLDLKTIALHARNAEYNPKRFAAVIMRIRDPKTTALIFASGKMV\nVTGAKSEDDSKLASRKYARIIQKLGFNAKFCDFKIQNIVGSTDVKFAIRLEGLAFAHGTF\nSSYEPELFPGLIYRMVKPKIVLLIFVSGKIVLTGAKKREEIYDAFESIYPVLNEFRKN\n>sp|P52653|TP1_ENTHI TATA--inding prtein 1 S=Entamea histlytica GN=TP PE=3 SV=2\nMSTPGDFSLSPFILGGAVDPRSMSQLGNICHADYMSTSTESQERSLNNPNDTHPEIVNVV\nSTFQLGVKLELRKIVQKARNAEYNPKRFAGAIMRISSPKSTALIFQTGKIVCTGTRSIEE\nSKIASKKYAKIIKKIGYPIHYSNFNVQNIVGSCDVKFQIALRTLVDSYLAFCQYEPEVFP\nGLVYRMASPKVTLLVFSTGKVVLTGAKDEESLNLAYKNIYPILLANRKEDISNQ");
        }
	</script>
  </head>

  <body>

	<!-- 引入导航栏 -->
    <jsp:include page="header.jsp" />

    <div class="container">

        <div style="font-size:37px; padding: 0;">PreTATA: A web server for predicting TATA-binding protein</div>

        <div class="col-md-8">
            <h4 class="text-muted"></h4>
            <form class="form-horizontal" action="predict.do" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <%--粘贴和上传组件--%>
                    <textarea name="paste" id="paste" class="form-control" rows="3" onfocus="check2(this)" style="height:150px;"></textarea>
                    <span class="help-block">Paste fasta sequences, <strong>OR UPLOAD YOUR FILE BELOW (maximum 20MB)</strong>
                            <input name="file" type="file" id="predictInputFile" onchange="check(this)">
                            </span>
                    Example: <a onclick="paste()"><strong>Paste instances (10 unknown protein sequences)</strong></a>
                    <p style="margin: 10px 0 0 0;"></p>
                    <button type="submit" onclick="note()" class="btn btn-primary" style="width: 300px;">Predict</button>
                    <strong><span id="count" style="color: green;">${requestScope.error}</span></strong>
                </div>
            </form>
        </div>
        <div class="col-md-4">
            <img src="img/home.jpg" style="width:280px;"/>
        </div>

        <h1 style="height: 290px;"></h1>
        <c:if test="${empty requestScope.mymap}">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                    <h4 class="panel-title">About PreTATA</h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        PreTATA is a web server that helps bioinformatics researchers make experiments about protein class predicting,
                        especially tata-binding. TATA-Predict combines the feature extracting method of 188D and the Libsvm of
                        Chih-Jen Lin, and have a great performances in our experiments! Last but not least, the TATA-Predict v0.1 is young, we will appreciate it if you fork it at
                        github or propose BUG to us. Thank you.
                        <div class="text-right">10th Nov, 2015<br>Shixiang Wan</div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty requestScope.mymap}">
            <div class="panel panel-primary">
                <div class="panel-body">
                    <p>Forecast: <span class="result">${requestScope.accuracy}</span> sequences of your source is/are TATA-binding.</p>
                    <p>From all of your data, there are <span class="result">${requestScope.pos}</span> positive instances,
                    <span class="result">${requestScope.neg}</span> negative inatances, and
                    <span class="result">${requestScope.all}</span> instances in all.</p>
                    <table class="table table-condensed table-bordered">
                        <thead>
                            <tr>
                              <td class="active col-md-1">ID</td>
                              <td class="active col-md-10">Sequence Name</td>
                              <td class="active col-md-1">Predict</td>
                            </tr>
                        </thead>
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
                </div><!-- /panel-body -->
            </div>
        </c:if>

    <!-- 底部栏 -->
    <p style="text-align:center;" class="text-muted">Bioinformatics Laboratory - Tianjin University @ <a target="_blank" href="http://lab.malab.cn/~shixiang/">Shixiang Wan</a></p>

    </div> <!-- /container -->

  </body>
</html>