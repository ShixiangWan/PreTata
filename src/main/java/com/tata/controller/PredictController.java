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
/*此控制器用于对未知蛋白质的预测*/


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
			//获取upload路径
			String tmpFolder = new Date().getTime()+"";
			String root = this.servletContext.getRealPath("/");
            String path = root + "upload/" + tmpFolder + "/";
			new File(path).mkdirs();
			//获取model路径
			String model = root + "data/train.libsvm.model";

			String fileName = "test.fasta";
			if (!file.isEmpty()) {
				/*上传文件情形*/
				fileName = "test.fasta";
				File file2 = new File(path, fileName); //新建一个文件
				try {
					file.getFileItem().write(file2); //将上传的文件写入新建的文件中
				} catch (Exception e) {
					e.printStackTrace();
				}
				System.out.println("上传成功");
			} else if (paste != null){
					/*粘贴文件情形*/
				BufferedWriter bw=new BufferedWriter(new FileWriter(path+fileName));
				bw.write(paste);
				bw.flush();
				bw.close();
			} else {
					/*出错情形*/
				map.addAttribute("error", "请上传文件或粘贴文件！");
				return new ModelAndView("index");
			}
				/*
				 * path是实验文件路径(如C:/upload)，file是用户上传的实验序列文件(如test.fasta)，
				model是我们准备好的训练模型(如train.libsvm.model)
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

			//后台迭代打印，调试使用
			/*Iterator it = mymap.entrySet().iterator();
			while (it.hasNext())
			{
				Map.Entry pairs = (Map.Entry)it.next();
				System.out.println(pairs.getKey() + " = " + pairs.getValue());
			}*/

			//删除本次实验的所有文件
			new deleteOldTemp().DeleteFolder(path);

			return new ModelAndView("index", "mymap", mymap);
		} catch (Exception e) {
			e.printStackTrace();
		}
			/*出错情形*/
		map.addAttribute("error", "请检查您的输入是否有误！！！");
		return new ModelAndView("index");
	}

	public static void main(String[] args) {
		String path = "C:/ShixiangWan/workspace/preTata/WebRoot/upload/";
		String tmpFolder = new Date().getTime()+"";
		path = path + tmpFolder+"/";
		System.out.println(path);
        new File(path).mkdirs();  //创建此抽象路径指定的目录，包括所有必须但不存在的父目录
	}

}
