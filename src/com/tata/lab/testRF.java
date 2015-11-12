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
		//����·���͵������ļ�
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
	 * path��ʵ���ļ�·����file���û��ϴ���ʵ�������ļ���
	posOut����ȡ�������к��arff�ļ����ƣ�train������׼���õ�train.arff�ļ���
	model������׼���õ�ѵ��ģ�ͣ�dimen���û��������Ŀ
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public LinkedHashMap run(String path, String file, String model) {
		try {
			/*������е���ȷ��*/
			String errorMessage = "";  //��¼������Ϣ
			boolean isAllRight = true;  //������������Ƿ���д���
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
			System.out.println("������ȷ����ʼ��ȡ����");
			/*��ȡ������Ԥ�����*/
			if (isAllRight) {
				/*��ȡ����*/
				int dimen = 2;
				String outArff = "_test.arff";
				ExtractFeature feature = new ExtractFeature();
				boolean e1 = feature.getTestArffFile(path+file, path, outArff, "1", 188, dimen);
				if (!e1) return null;
				System.out.println("188D������ȡ���");
				
				/*��arff��ʽת����libsvm��ʽ*/
				String outLibsvm = new arffToLibsvm().run(path, outArff);
				if (outLibsvm == null) return null;
				System.out.println("libsvm��ʽת�����");
				
				/*����libsvm�㷨Ԥ�����*/
				String accuracy = new LibSVM().run(path,outLibsvm,model);
				//System.out.println(accuracy);
				if (accuracy == null) return null;
				System.out.println("Ԥ��ɹ�����ʼ��ȡ��Ϣ");
				
				/*��ȡ�������LinkedHashMap*/
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
