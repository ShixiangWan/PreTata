package com.tata.svm;

public class LibSVM {

	public static void main(String[] args) {
		String path = "C:\\workspace_intell\\PreTATA\\out\\artifacts\\PreTATA_Web_exploded\\upload/1495701564903/";
		String outLibsvm = "out.libsvm";
		String model = "C:\\workspace_intell\\PreTATA\\out\\artifacts\\PreTATA_Web_exploded\\data/train.libsvm.model";
		String tmp = new LibSVM().run(path,outLibsvm,model);
		System.out.println(tmp);
	}
	
	public String run(String path, String outLibsvm, String model) {
		try {
			String[] testArgs = {path+outLibsvm, model, path+"result.txt"};//directory of test file, model file, result file
			Double accuracy = svm_predict.main(testArgs);
			String acc = String.valueOf(accuracy*100)+"%";
			return acc;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

}
