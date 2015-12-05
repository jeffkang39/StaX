<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>
<body>
<%      
	List<String> list = new ArrayList<String>();

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
		       out.print("</tr>");
		      
		    } 
		    out.print("</table>");
		    
		    //close the connection.
		    con.close();

	} catch (Exception e) {
        out.print(e.toString());
	}
	
	
%>
    
</body>
</html>