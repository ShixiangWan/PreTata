package com.tata.lab;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import com.tata.svm.LibSVM;
import com.tata.utils.arffToLibsvm;
import com.tata.utils.checkSequence;
import com.tata.utils.handleResults;

public class testRF {
	
	@SuppressWarnings("rawtypes")
	public static void main(String[] args) {
		//设置路径和蛋白质文件
		String path = "C:/ShixiangWan/workspace/preTata/WebRoot/upload/1234567890/";
		String file = "test.fasta";
		String model = "C:/ShixiangWan/workspace/preTata/WebRoot/model/train.libsvm.model";
		LinkedHashMap f = new testRF().run(path, file, model);
		if (f!=null) {
		   Iterator it = f.entrySet().iterator();
		   while (it.hasNext())
		   {    
			   Map.Entry pairs = (Map.Entry)it.next();    
			   System.out.println(pairs.getKey() + " = " + pairs.getValue());    
		   }
		}
		System.out.println("OK");
	}
	
	/*
	 * path是实验文件路径，file是用户上传的实验序列文件，
	posOut是提取特征序列后的arff文件名称，train是我们准备好的train.arff文件，
	model是我们准备好的训练模型，dimen是用户的类标数目
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public LinkedHashMap run(String path, String file, String model) {
		try {
			/*检查序列的正确性*/
			String errorMessage = "";  //记录错误信息
			boolean isAllRight = true;  //标记整个过程是否会有错误
			int testError = new checkSequence().checkIsRight(path+file);
			if (testError != 0) {
				isAllRight = false;
				if (testError == -1) {
					errorMessage = "The data is Empty, please input the test data.";
				} else {
					errorMessage = "The "+testError+"th protein sequence contains incorrect sequences or the " +
							"format of this sequence is wrong, please check it.";
				}
				LinkedHashMap error = new LinkedHashMap<>();
				error.put("error", errorMessage);
				return error;
			}
			System.out.println("序列正确，开始提取特征");
			/*提取特征，预测分类*/
			if (isAllRight) {
				/*提取特征*/
				int dimen = 2;
				String outArff = "_test.arff";
				ExtractFeature feature = new ExtractFeature();
				boolean e1 = feature.getTestArffFile(path+file, path, outArff, "1", 188, dimen);
				if (!e1) return null;
				System.out.println("188D特征提取完成");
				
				/*将arff格式转换成libsvm格式*/
				String outLibsvm = new arffToLibsvm().run(path, outArff);
				if (outLibsvm == null) return null;
				System.out.println("libsvm格式转换完成");
				
				/*调用libsvm算法预测分类*/
				String accuracy = new LibSVM().run(path,outLibsvm,model);
				//System.out.println(accuracy);
				if (accuracy == null) return null;
				System.out.println("预测成功，开始提取信息");
				
				/*读取结果存入LinkedHashMap*/
				LinkedHashMap mymap = new handleResults().run(path, file, "result.txt");
				if (mymap == null) return null;
				mymap.put("accuracy", accuracy);
				
				return mymap;
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
}
