package com.tata.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tata.lab.testRF;
import com.tata.utils.deleteOldTemp;
/*�˿��������ڶ�δ֪�����ʵ�Ԥ��*/


@Controller
public class PredictController implements ServletContextAware{
		private ServletContext servletContext;
		@Autowired
		public void setServletContext(ServletContext context) {
			this.servletContext  = context;
		}
		@SuppressWarnings("rawtypes")
		@RequestMapping(value="predict", method = RequestMethod.POST)
		public ModelAndView handleUploadData(String name,@RequestParam("file") CommonsMultipartFile file,
				@RequestParam("paste")String paste, Model map){
			try {
				//��ȡupload·��,ĩβ�зָ���������
				String tmpFolder = new Date().getTime()+"";
				String path = this.servletContext.getRealPath("/upload/"+tmpFolder+"/");
				path = path+"/"; //��������������е�jetty�������������䣡
				File fileFolder = new File(path);
				fileFolder.mkdirs();
				//��ȡmodel·��,ĩβ�зָ���������
				String model = this.servletContext.getRealPath("/model/");
				model = model+"/"; //��������������е�jetty�������������䣡
				model = model + "train.libsvm.model";
				
				String fileName = "test.fasta";
				if (!file.isEmpty()) {
					   /*�ϴ��ļ�����*/
					   fileName = "test.fasta";
					   File file2 = new File(path, fileName); //�½�һ���ļ�
					   try {
						    file.getFileItem().write(file2); //���ϴ����ļ�д���½����ļ���
					   } catch (Exception e) {
						    e.printStackTrace();
					   }
					   System.out.println("�ϴ��ɹ�");
			    } else if (paste != null){
					/*ճ���ļ�����*/
					BufferedWriter bw=new BufferedWriter(new FileWriter(path+fileName));
					bw.write(paste);
					bw.flush();
					bw.close();
				} else {
					/*��������*/
					map.addAttribute("error", "���ϴ��ļ���ճ���ļ���");
					return new ModelAndView("predict");
				}
				/*
				 * path��ʵ���ļ�·��(��C:/upload)��file���û��ϴ���ʵ�������ļ�(��test.fasta)��
				model������׼���õ�ѵ��ģ��(��train.libsvm.model)
				*/
				LinkedHashMap mymap = new testRF().run(path, fileName, model);
				map.addAttribute("accuracy", mymap.get("accuracy"));
				map.addAttribute("pos", mymap.get("pos"));
				map.addAttribute("neg", mymap.get("neg"));
				map.addAttribute("all", mymap.get("all"));
				mymap.remove("accuracy");
				mymap.remove("pos");
				mymap.remove("neg");
				mymap.remove("all");
				
			    //��̨������ӡ������ʹ��
			    if (mymap!=null) {
			    	Iterator it = mymap.entrySet().iterator();
				    while (it.hasNext())
				    {
					    Map.Entry pairs = (Map.Entry)it.next();    
					    System.out.println(pairs.getKey() + " = " + pairs.getValue());    
				    }
			    }
			    //ɾ������ʵ��������ļ�
			    new deleteOldTemp().DeleteFolder(path);
			    
			    return new ModelAndView("predict", "mymap", mymap);
			} catch (Exception e) {
				e.printStackTrace();
			}
			/*��������*/
			map.addAttribute("error", "�������������Ƿ����󣡣���");
			return new ModelAndView("predict");
		}
		
		public static void main(String[] args) {
			String path = "C:/ShixiangWan/workspace/preTata/WebRoot/upload/";
			String tmpFolder = new Date().getTime()+"";
			path = path + tmpFolder+"/";
			System.out.println(path);
			File file = new File(path);
			file.mkdirs();  //�����˳���·��ָ����Ŀ¼���������б��뵫�����ڵĸ�Ŀ¼
		}
		
}
