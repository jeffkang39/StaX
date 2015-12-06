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
	List<String> list = new ArrayList<String>();

	String s = null;
	String creationDateArr[] = null;
	ArrayList<String> creationDate = new ArrayList<String>();
	ArrayList<String> tags = new ArrayList<String>();
    String word = "testing string";
    String tagString = "";
    String countString = ""; 
    String entity= "";
	String title ="";
	int views=0;
	String author="";
	String link="";
    
	try {
	    	//Create a connection string
			//String url = "jdbc:mysql://your_VM:3306/your_db";
	    	String url = "jdbc:mysql://stax.czqccd0tvajp.us-east-1.rds.amazonaws.com:3306/stax";
	    	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		    Class.forName("com.mysql.jdbc.Driver");
	    
	    	//Create a connection to your DB
		   // Connection con = DriverManager.getConnection(url, "csuser", "your_pwd");
		    Connection con = DriverManager.getConnection(url, "Stax", "asdf1234");
	    	//Create a SQL statement
		    Statement stmt = con.createStatement();
	    	//Get the selected radio button from the HelloWorld.jsp
		    entity = request.getParameter("searchbar");
	    	//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
			String str = "select * from Posts where Posts.Tags like'%"+entity+"%' or Posts.Title like '%"+entity+"%'";
	    	//Run the query against the database.
		    ResultSet result = stmt.executeQuery(str);
		   
		    //Make an HTML table to show the results in:
		    out.print("<table>");
		    
	    	   //make a row
		       out.print("<tr>");
	    	   //make a column
		       out.print("<td>");
	    	   //print out column header
		       out.print("name");
		       out.print("</td>");
		       //make a column
		       out.print("<td>");
		       //depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected
		    	   out.print("Tags");
		       out.print("</td>");
		       out.print("</tr>");
		    
		       
	        List<String> taglist = new ArrayList<String>();
			HashMap<String, Integer> tagMap = new HashMap<String, Integer>();	
		    //parse out the results
		    
		    while(result.next())
		    {
		       //make a row
		       out.print("<tr>");
		       //make a column
		       out.print("<td>");
		       //Print out current bar or beer name:
		       out.print(result.getString("Title"));
		       out.print("</td>");
		       out.print("<td>");
		       //Print out current bar/beer additional info: Manf or Address
		    	   out.print(result.getString("Tags"));
		       out.print("</td>");
		       out.print("<td>");
		       //Print out current bar/beer additional info: Manf or Address
		    	out.print(result.getString("CreationDate"));
		   		creationDate.add(result.getString("CreationDate"));
		   		tags.add(result.getString("Tags"));
		       out.print("</td>");
				out.print("</tr>");
		      
				
				// get tag ranking
				String tagString1 = result.getString("Tags");
				String[] tagArray = tagString1.split(" ");
				for(String tag : tagArray){
					if(tag.equals(entity)) continue;
					if(!taglist.contains(tag)) taglist.add(tag);
					Object o = tagMap.get(tag);
					int count = 0;
					if(o != null) count = (Integer)o;
					count++;
					tagMap.put(tag, count);
				}
				
				// highest viewed post
				if(Integer.parseInt(result.getString("ViewCount")) > views){
					views = Integer.parseInt(result.getString("ViewCount"));
					link = "http://stackoverflow.com/questions/"+result.getInt("Id");
					title = result.getString("Title");
					author = result.getString("OwnerDisplayName");
				}
				
		    } 
		    out.print("</table>");
		    out.print(creationDate);	
		   	creationDateArr = creationDate.toArray(new String[creationDate.size()]);
		    out.print("<a href=\""+link+"\">"+title+"</a>");

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
			if(sortedcount.size() > 5){
				
				while(sortedcount.size() > 5){
					sortedcount.remove(5);
				}
			}
			
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

		    //close the connection.
		    con.close();

	} catch (Exception e) {
        out.print(e.toString());
        e.printStackTrace();
        System.out.println("CATCH");
	}
	
	int[] dateChart = {0,0,0,0,0,0}; 
	
	for(String date : creationDateArr){
		if(date.substring(8, 10).equals("31")){			
			dateChart[0] = dateChart[0] + 1;
		}
		if(date.substring(8, 10).equals("01")){
			dateChart[1] = dateChart[1] + 1;
		}
		if(date.substring(8, 10).equals("02")){			
			dateChart[2] ++;
		}
		if(date.substring(8, 10).equals("03")){			
			dateChart[3] ++;
		}
		if(date.substring(8, 10).equals("04")){			
			dateChart[4] ++;
		}
		if(date.substring(8, 10).equals("05")){			
			
			dateChart[5] ++;
		}
	
	}

	int test22[] = {1,2,3,4,5,6}; 
	String testString = "TEST STRING";
	
	String dateChartString = "";
	String temp;
	for(int i = 0; i <dateChart.length; i++){
		dateChartString = dateChartString + " " + dateChart[i];
	}
	
	rankTags(tags);
	
%>
    
 <%! 
   public static void rankTags(ArrayList<String> tagsList) {
    
	 List<String> uniqueTokens = new ArrayList<String>();
	 String[] tempList = null; //tempList holds the tokens for the specific tuple.
	 
	 for(int i = 0; i < tagsList.size(); i++){
		
	 	tempList = tagsList.get(i).split(" ");
	 		for(int j = 0; j < tempList.length; j++){
	 			
	 			if(uniqueTokens.contains(tempList[j]) == false){
	 				uniqueTokens.add(tempList[j]);
	 			}
	 		}
	 }
	 
	 //uniqueTokens has all the unique tokens at this point
	 
		 
	 //System.out.println(uniqueTokens);
	 
	 int[] AL = new int[uniqueTokens.size()];
	
	 for(int i = 0; i < AL.length ;i ++){
		 
	 }
	 
	 //all the tags
	
   } 
%>
	<div id="container" style="width:100%; height:400px;"></div>
    
    <script>
	$(function () {
		
		
		var test = [20,3,5,6,10,20];
		var test2 = "<%=dateChartString%>";
		
		var test3 = test2.split(" ");
		
		for(var i=0; i<test3.length; i++) { test3[i] = +test3[i]; } 
		var test4 = test3.slice(1, test3.length)
		
		var ts = "<%=testString%>";
		var dateArray = ["07/31/2008", "08/1/2008", "08/2/2008", "08/3/2008", "08/4/2008", "08/5/2008"];
		var languages = ["Java", "Python", "C++", "Ruby", "Node"];
		
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
	                text: 'Count'
	            }
	        },
	        series: [{
	            name: 'Number of New Posts per Day',
	            data: test4
	        }]
	    });
	});
	
	</script>
	
	<div id="container2" style="width:100%; height:400px;"></div>   
    <script>
	$(function () {
		
		
		var tagString = "<%=tagString%>"
		var tagStringSplit = tagString.split(",");
		var entity = "<%=entity%>";
		var countString = "<%=countString%>";
		var countStringSplit = countString.split(",");
		for(var i=0; i<countStringSplit.length; i++) { countStringSplit[i] = +countStringSplit[i]; } 
	
		$('#container2').highcharts({
	        chart: {
	            type: 'bar'
	        },
	        title: {
	            text: 'Top 5 Tags paired with ' + entity
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