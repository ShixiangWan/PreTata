package com.tata.svm;

public class LibSVM {

	/*public static void main(String[] args) throws IOException {
		String path = "C:/ShixiangWan/workspace/preTata/WebRoot/upload/1234567890/";
		String outLibsvm = "predict.libsvm";
		String model = "C:/ShixiangWan/workspace/preTata/WebRoot/model/train.libsvm.model";
		String tmp = new LibSVM().run(path,outLibsvm,model);
		System.out.println(tmp);
	}*/
	
	public String run(String path, String outLibsvm, String model) {
		try {
			String[] testArgs = {path+outLibsvm, model, path+"result.txt"};//directory of test file, model file, result file
			Double accuracy = svm_predict.main(testArgs);
			String acc = String.valueOf(accuracy*100)+"%";
			return acc;
		} catch (Exception e) {
			
		}
		return null;
	}

}
