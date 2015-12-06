<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
		

<title>Search Results</title>
</head>
<body>
<%      
	ArrayList<String> creationDate = new ArrayList<String>();
	String tagString = "";
	String countString = "";
	try {

	    	//Create a connection string
	    	String url = "jdbc:mysql://stax.czqccd0tvajp.us-east-1.rds.amazonaws.com:3306/stax";
	    	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		    Class.forName("com.mysql.jdbc.Driver");
	    
	    	//Create a connection 
		    Connection con = DriverManager.getConnection(url, "Stax", "asdf1234");
	    	//Create a SQL statement
		    Statement stmt = con.createStatement();
	    	//Make a SELECT query for all tags in posts
			String str = "select Posts.Tags from Posts";
	    	//Run the query against the database.
		    ResultSet result = stmt.executeQuery(str);

		    List<String> taglist = new ArrayList<String>();
			HashMap<String, Integer> tagMap = new HashMap<String, Integer>();	

			while(result.next()){
				// get tag ranking
				String tagString1 = result.getString("Tags");
				String[] tagArray = tagString1.split(" ");
				for(String tag : tagArray){
					if(!taglist.contains(tag)) taglist.add(tag);
					Object o = tagMap.get(tag);
					int count = 0;
					if(o != null) count = (Integer)o;
					count++;
					tagMap.put(tag, count);
				}
		    } 
		    
			List<Integer> countlist = new ArrayList<Integer>();
			for(String tag : taglist){
				int count = tagMap.get(tag);
				countlist.add(count);
			} 
			
			List<Integer> sortedcount = new ArrayList<Integer>();
			while(!countlist.isEmpty()){
				int highest = 0;
				for(int i : countlist){
					if(i > highest) highest = i;
				}
				sortedcount.add(highest);
				countlist.remove((Integer)highest);
			
			}
			
			// keep top 5
			if(sortedcount.size() > 6){
				while(sortedcount.size() > 6){
					sortedcount.remove(6);
				}
			}
			sortedcount.remove(0);
			
			List<String> sortedtags = new ArrayList<String>();
			for(int count : sortedcount){
				for(String tag : taglist){
					if(tagMap.get(tag) == count && !sortedtags.contains(tag)){
						sortedtags.add(tag);
						break;
					}
				}
			}
		    
			for(String t : sortedtags){
				if(tagString != "") tagString += ",";
				tagString += t;
			}
			out.print(tagString);
			
			for (int c : sortedcount){
				if(countString != "") countString +=",";
				countString += c;
			}
			out.print(countString);
		    //close the connection. 
		    System.out.println("tag " + tagString);
		    System.out.println("count " + countString);
		    con.close();

	} catch (Exception e) {
        out.print(e.toString());
	}
%>
    
    
	<div id="container" style="width:100%; height:400px;"></div>
    
	
	<div id="container2" style="width:100%; height:400px;"></div>   
    <script>
	$(function () {
		
		
		var tagString = "<%=tagString%>"
		var tagStringSplit = tagString.split(",");
		var countString = "<%=countString%>";
		var countStringSplit = countString.split(",");
		for(var i=0; i<countStringSplit.length; i++) { countStringSplit[i] = +countStringSplit[i]; } 
	
		$('#container2').highcharts({
	        chart: {
	            type: 'bar'
	        },
	        title: {
	            text: 'Top 5 Tags'
	        },
	        xAxis: {
	            //categories: ['Apples', 'Bananas', 'Oranges']
	        	categories: tagStringSplit
	        },
	        yAxis: {
	            title: {
	                text: 'Count'
	            }
	        },
	        series: [{
	            name: 'Number of New Posts per Day',
	            data: countStringSplit
	        }]
	    });
	});
	
	
	
	</script>
</body>
</html>

