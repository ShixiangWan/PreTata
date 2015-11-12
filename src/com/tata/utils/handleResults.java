package com.tata.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

public class handleResults {
	
	@SuppressWarnings("rawtypes")
	public static void main(String[] args) {
		String path = "C:/ShixiangWan/workspace/preTata/WebRoot/upload/";
		String file = "test.fasta";
		LinkedHashMap f = new handleResults().run(path, file, "result.txt");
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
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public LinkedHashMap run(String path, String file, String resultTxt) {
		try {
			BufferedReader br1 = new BufferedReader(new FileReader(path+file));
			BufferedReader br2 = new BufferedReader(new FileReader(path+resultTxt));
			LinkedHashMap myMap = new LinkedHashMap<>();
			
			String br1_line;
			String br2_line;
			int pos=0;
			int neg=0;
			int all=0;
			while(br1.ready() && br2.ready()) {
				br1_line = br1.readLine();
				if (br1_line.substring(0,1).equals(">")) {
					br2_line = br2.readLine();
					br2_line = br2_line.substring(0, br2_line.indexOf("."));
					if (Integer.parseInt(br2_line) == 1) {
						pos++;
					} else {
						neg++;
					}
					myMap.put(br1_line, br2_line);
				}
			}
			myMap.put("pos", pos);
			myMap.put("neg", neg);
			myMap.put("all", pos+neg);
			
			br1.close();
			br2.close();
			return myMap;
		} catch (Exception e) {
			
		}
		return null;
	}
}
