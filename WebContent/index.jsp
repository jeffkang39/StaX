<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<!DOCTYPE HTML>
<!--
	Iridium by TEMPLATED
    templated.co @templatedco
    Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head>
		<title>StaX</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link href='http://fonts.googleapis.com/css?family=Arimo:400,700' rel='stylesheet' type='text/css'>
		<!--[if lte IE 8]><script src="js/html5shiv.js"></script><![endif]-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-panels.min.js"></script>
		<script src="js/init.js"></script>
		<noscript>
			<link rel="stylesheet" href="css/skel-noscript.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-desktop.css" />
		</noscript>
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
		<!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
	</head>
	<body class="homepage">
	

		<!-- Header -->
		<div id="header">
			<div class="container"> 
				
				<!-- Logo -->
				<div id="logo">
					<h1><a href="#">StaX</a></h1>
					<span>Stack Overflow</span>
				</div>
			</div>
		</div>

		<!-- Main -->
		<div id="main">
			<div class="container">
				<div class="row"> 
					
					<!-- Content -->
					<div id="content" class="8u skel-cell-important">
						<section>
							<header>
								<h2>Welcome to StaX! </h2>            
							</header>
                            <h1>What are you wondering about?</h1>
                            <form height = "1px" method="get" action="search.jsp" enctype=text/plain>
                                <input type="text" name="searchbar" placeholder="java" required>
                                <input type="submit" name="searchbutton" class=search value="Search">
                            </form>
                            Enter a query above, and we'll display the top viewed question regarding the topic, the trend for number of posts in the topic, and which tags are commonly paired with this query!
                            <header>
                                <br>
                            	<a href="ranking.jsp">
                                    <h2>Tag Rankings</h2>
                                </a>
                                <br>
                                Wondering what's trending? We'll show you the top five tags on Stack Overflow so you can know what you <em>should</em> know.
                            </header>
                            
						</section>
					</div>
					
				</div>
			</div>
		</div>
		<div id="footer">

				<div class="row">
					<p> Nicholas Fong, Jeffrey Kang</p>
				</div>
	
		</div>
	</body>
</html>