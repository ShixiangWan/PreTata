package com.tata.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;
import java.io.File;

@Controller
public class DownloadController implements ServletContextAware {
    private ServletContext servletContext;

    @Autowired
    public void setServletContext(ServletContext context) {
        this.servletContext  = context;
    }

    @RequestMapping(value="download")
    public ResponseEntity<byte[]> DownloadExample(String type){
        try {
            String fileName = "";
            if (type.equals("type1")) fileName = "uniprot-TATA-Binding-Protein.fasta";
            if (type.equals("type2")) fileName = "188D-and-ProPred-featuresets.zip";
            if (type.equals("type3")) fileName = "train.libsvm.model";
            /*bytes file*/
            String pathName = this.servletContext.getRealPath("/")+"data/"+fileName;
            byte[] bytes = FileUtils.readFileToByteArray(new File(pathName));
            /*http wrap*/
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment",
                    new String(fileName.getBytes("gb2312"),"iso-8859-1"));
            return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
        } catch (Exception ignored) {
            return null;
        }
    }
}
