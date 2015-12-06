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

			List taglist = new ArrayList<String>();
			HashMap tagMap = new HashMap<String, Integer>();

			while(result.next()){
				String tagString = result.getString("Tags");
				String[] tags = tagString.split(" ");
				for(String tag : tags){
					if(!taglist.contains(tag)) taglist.add(tag);
					int count = tagMap.get(tag);
					if(count == null) count = 1;
					else count++;
					tagMap.put(tag, count);
				}
			}
			
			List countlist = new ArrayList<Integer>();
			for(String tag : taglist){
				int count = tagMap.get(tag);
				countlist.add(count);
			} 
			
			List sortedcount = new ArrayList<Integer>();
			while(!countlist.isEmpty()){
				int highest = 0;
				for(int i : countlist){
					if(i > highest) highest = i;
				}
				sortedcount.add(highest);
				countlist.remove(highest);
			}
			
			// keep top 5
			if(sortedcount.size() > 5){
				for(i = 4; i<sortedcount.size();i++){
					sortedcount.remove(i);
				}
			}
			
			List<String> sortedtags = new ArrayList<String>();
			for(int count : sortedcount){
				for(String tag : taglist){
					if(tagMap.get(tag) == count){
						sortedtags.add(tag);
						break;
					}
				}
			}
		    
			String tagString = "";
			for(String s : sortedtags){
				if(tagString != "") tagString += ",";
				tagString += s;
			}
			
			String countString = ""; 
			for (int s : sortedcount){
				if(countString != "") countString +=",";
				countString += s;
			}
			
		    //close the connection.
		    con.close();

	} catch (Exception e) {
        out.print(e.toString());
	}
%>
    
    
	<div id="container" style="width:100%; height:400px;"></div>
    
    <script>
	$(function () {
		
		query = "date";
		var test = [2,3,5,6,10,20];
		var dateArray = ["07/31/2008", "08/1/2008", "08/2/2008", "08/3/2008", "08/4/2008", "08/5/2008"];
		var languages = ["Java", "Python", "C++", "Ruby", "Node"];
			
		var dc1 = "<%=dateChart%>";
		var test1 = <%=test22%>;
		
		$('#container').highcharts({
	        chart: {
	            type: 'line'
	        },
	        title: {
	            text: 'Results'
	        },
	        xAxis: {
	            //categories: ['Apples', 'Bananas', 'Oranges']
	        	categories: dateArray
	        },
	        yAxis: {
	            title: {
	                text: 'Count' + query
	            }
	        },
	        series: [{
	            name: 'Query', 
	            data: test1
	        }, {
	            name: 'John',
	            data: [0,0,0,0,0,0]
	        }]
	    });
	});
	
	</script>
</body>
</html>

