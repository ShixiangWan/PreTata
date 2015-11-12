package com.tata.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ServletContextAware;

@Controller
public class DownloadController implements ServletContextAware {
	private ServletContext servletContext;
	@Autowired
	public void setServletContext(ServletContext context) {
		this.servletContext  = context;
	}
	@RequestMapping(value="download")
    public ResponseEntity<byte[]> download(){
        try {
        	HttpHeaders headers = new HttpHeaders();  
            String path = this.servletContext.getRealPath("/model/");
            path = path+"/"; //如果部署新浪云中的jetty容器，必须加这句！
            String fileName = "train.libsvm.model";
            String rspName = path + fileName;
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);  
            headers.setContentDispositionFormData("attachment", new String(fileName.getBytes("gb2312"),"iso-8859-1"));  
            File file = new File(rspName);  
            byte[] bytes = FileUtils.readFileToByteArray(file);
            return new ResponseEntity<byte[]>(bytes, headers, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e);
		} 
        return null;
    } 
}
