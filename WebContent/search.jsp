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
    String word = "testing string";
	
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
		    String entity = request.getParameter("searchbar");
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
		       out.print("</td>");
				out.print("</tr>");
		      
		    } 
		    out.print("</table>");
		    out.print(creationDate);	
		   	creationDateArr = creationDate.toArray(new String[creationDate.size()]);
		    
		    //close the connection.
		    con.close();

	} catch (Exception e) {
        out.print(e.toString());
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
	
	
	
</body>
</html>