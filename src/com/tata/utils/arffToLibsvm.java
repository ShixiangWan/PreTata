package com.tata.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;

//Only for 188D
public class arffToLibsvm {
	public static void main(String[] args) {
		String path = "C:/ShixiangWan/workspace/preTata/WebRoot/upload/";
		String file = "_test.arff";
		String out = new arffToLibsvm().run(path, file);
		System.out.println(out);
	}
	
	//���������libsvm�ļ���
	public String run(String path, String file) {
		try {
			String outLibsvm = "out.libsvm";
			BufferedReader br = new BufferedReader(new FileReader(path+file));
			BufferedWriter bw = new BufferedWriter(new FileWriter(path+outLibsvm, true));
			
			String tmp;
			while (br.ready()) {
				tmp = br.readLine();
				if (tmp.substring(0,1).equals("@")) {
					continue;
				}
				//д���ǩ������0��1
				bw.write(tmp.substring(tmp.lastIndexOf(",")+1) + " ");
				for (int i=1; i<=188; ++i) {
					//д��СԪ��
					bw.write(i + ":" + tmp.substring(0,tmp.indexOf(",")) + " ");
					tmp = tmp.substring(tmp.indexOf(",")+1);
				}
				bw.write("\n");
			}
			
			br.close();
			bw.close();
			return outLibsvm;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
}
