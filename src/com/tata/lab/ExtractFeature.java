package com.tata.lab;
/*
 package com.test.lab;
/*
 * ExtractFeature.java
 * ���Ƕ�ȡfastaԴ�ļ�������sequence����ȡ�����������arff�ļ����࣬����ֻ�������ĳ������arff�ļ���Ҫ����һ������
 */
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ExtractFeature {

	/**
	 * ��ȡfasta�����ļ�
	 * @param filePath ϵͳ���и�Ŀ¼+�û�Ŀ¼
	 * @param fastaFile fasta�ļ�
	 * @throws Exception
	 */
	public ArrayList<String> readFastaFile(String fastaFile, String filePath, String classValue) throws Exception {
		File file = new File(fastaFile);
		if (!file.exists()) {
			throw new Exception("fasta�ļ������ڣ�");
		}
		BufferedReader bReaderFasta = new BufferedReader(new FileReader(file));
		String line, name="";
		//��������������Ϣ
		StringBuffer sBuffer = new StringBuffer();
		//�����ڼ�������
		int count = 0;
		//��������
		Map<String, Integer> seqName = new HashMap<String, Integer>();
		//����������ȡ��������
		ArrayList<String> featureList = new ArrayList<String>();
		while((line = bReaderFasta.readLine())!=null) {
			//��������
			if (line.trim().length() == 0) {
				continue;
			}
			//�������>��˵��������
			if (line.startsWith(">")) {
				//˵���ǵ�һ��
				if (name.equals("")) {
					name = line;
					continue;
				} else {//˵�����ǵ�һ������Ҫ������һ������
					System.out.println("name: "+name);
					seqName.put(name, count);
					Sequence sequence = new Sequence(sBuffer.toString());
					featureList.add(sequence.run()+classValue);
					//�ָ�����
					name = line;
					sBuffer.delete(0, sBuffer.length());
					count++;
				}
			} else {//�Ѳ�ͬ�е�������ӽ���
				sBuffer.append(line);
			}
		}
		seqName.put(name, count);
		Sequence sequence = new Sequence(sBuffer.toString());
		featureList.add(sequence.run()+classValue);
		bReaderFasta.close();
		//��Ҫ�������ļ��ȱ�����
		ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filePath+"name.txt"));
		oos.writeObject(seqName);
		oos.flush();
		oos.close();
		return featureList;
	}
	
	/**
	 * �õ�һ�����Լ���arff�ļ�
	 * @param fastaFile fasta�ļ�·��
	 * @param outputPath ����ļ�·��
	 * @param outputFile ����ļ���
	 * @param classValue ���
	 * @param featureNum ��������
	 * @param classNum ������
	 * @throws Exception
	 */
	public boolean getTestArffFile(String fastaFile, String outputPath, String outputFile, String classValue, int featureNum, int classNum) throws Exception {
		try {
			ArrayList<String> featureList = readFastaFile(fastaFile, outputPath, classValue);
			BufferedWriter bWriterArff = new BufferedWriter(new FileWriter(outputPath+outputFile));
			/*д���ļ�ͷ*/
			bWriterArff.write("@relation " + outputFile + "\n");
			/*д��������*/
			for (int i = 1; i <= featureNum; i++) {
				bWriterArff.write("@attribute feature" + i + " real");
				bWriterArff.newLine();
			}
			/*д�����*/
			bWriterArff.write("@attribute class {0");
			for (int i = 1; i < classNum; i++) {
				bWriterArff.write(","+i);
			}
			bWriterArff.write("}");
			bWriterArff.newLine();
			bWriterArff.write("@data");
			bWriterArff.newLine();
			/*д������*/
			for (String seqdata : featureList) {
				bWriterArff.write(seqdata);
				bWriterArff.newLine();
			}
			bWriterArff.flush();
			bWriterArff.close();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}
	/**
	 * @param args
	 */
	/*public static void main(String[] args) throws Exception {
		ExtractFeature e = new ExtractFeature();
		e.getTestArffFile("pos.fasta", "C:\\ShixiangWan\\workspace\\MRMD\\upload\\", "_pos", "1", 188, 2);
		e.getTestArffFile("neg.fasta", "C:\\ShixiangWan\\workspace\\MRMD\\upload\\", "_neg", "0", 188, 2);
	}*/

}
