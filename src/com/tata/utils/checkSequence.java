package com.tata.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;

public class checkSequence {
	public static void main(String[] args) {
		try {
			int a = new checkSequence().checkIsRight("/home/shixiang/workspace/preTata/WebRoot/upload/test.fasta");
			System.out.println(a);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * �������������Ƿ�Ϸ����������Ϣ�����֣�һ����û�����ݵģ�һ����������߰��� �д��������
	 * -1����û�����ݣ�0�������������Ĵ��������ǵڼ���������
	 * @param filePath ����ĵ����������ļ�
	 * @return
	 * @throws Exception
	 */
	public int checkIsRight(String filePath) throws Exception {
		//����ǵڼ�������������
		int countNumber = 1;
		//�ȼ���Ƿ�������
		File file = new File(filePath);
		if (file.length() == 0 || !file.exists()) {
			return -1;
		}
		//����ǲ��ǵ��������а������Ϸ�����
		BufferedReader bReader = new BufferedReader(new FileReader(file));
		String line = bReader.readLine();
		String seqLine = "";
		//�жϵ�һ�������Ƿ�������
		if (!line.trim().startsWith(">")) {
			bReader.close();
			return countNumber;
		}
		while((line = bReader.readLine())!=null) {
			if (line == null || line.trim().length() == 0) {
				continue;
			}
			if (line.trim().startsWith(">")) {//������һ����Ϣ
				//�ж��Ƿ񳬳����߳���
				if (seqLine.length() < 10 || seqLine.length() > 10000) {
					bReader.close();
					return countNumber;
				}
				//�鿴�Ƿ�����Ƿ�����
				if (containBad(seqLine)) {
					bReader.close();
					return countNumber;
				}
				//��ʼ��һ��
				countNumber++;
				seqLine = "";
			} else {
				seqLine += line.trim();
			}
		}
		//�������һ��
		if (seqLine.length() < 10 || seqLine.length() > 10000) {
			bReader.close();
			return countNumber;
		}
		//�鿴�Ƿ�����Ƿ�����
		if (containBad(seqLine)) {
			bReader.close();
			return countNumber;
		}
		bReader.close();
		return 0;
	}
	
	//����ĵ����ʵĺ���������
	private ArrayList<String> baseList;
	public checkSequence() throws Exception {
		baseList = new ArrayList<String>();
		baseList.add("A");baseList.add("C");baseList.add("D");
		baseList.add("E");baseList.add("F");baseList.add("G");
		baseList.add("H");baseList.add("I");baseList.add("K");
		baseList.add("L");baseList.add("M");baseList.add("N");
		baseList.add("P");baseList.add("Q");baseList.add("R");
		baseList.add("S");baseList.add("T");baseList.add("V");
		baseList.add("W");baseList.add("Y");baseList.add(" ");
	}
	/**
	 * ����Ƿ��зǷ�����
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	private boolean containBad(String seq) throws Exception {
		for (int i = 0; i < seq.length(); i++) {
			if (!baseList.contains(String.valueOf(seq.charAt(i)))) {
				return true;
			}
		}
		return false;
	}

}
