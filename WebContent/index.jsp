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
								<h1>What're you wondering about?</h1>
							</header>
                            <form height = "1px" method="get" action="search.jsp" enctype=text/plain>
                                <input type="text" name="searchbar" placeholder="java" required>
                                <input type="submit" name="searchbutton" class=search value="Search">
                            </form>
							<a href="#" class="image full"><img src="images/pic07.jpg" alt="" /></a>
						</section>
					</div>
					
				</div>
			</div>
		</div>
		
		<!-- Footer -->
		<div id="featured">
			<div class="container">
				<div class="row">
					<div class="4u">
						<h2>Learn more about our applications</h2>
						<a href="#" class="image full"><img src="images/pic01.jpg" alt="" /></a>
						<p></p>
					</div>
					<div class="4u">
						<h2>Learn more about the developers</h2>
						<a href="#" class="image full"><img src="images/pic02.jpg" alt="" /></a>
						<p></p>
					</div>
					<div class="4u">
						<h2>learn more about the developers</h2>
						<a href="#" class="image full"><img src="images/pic03.jpg" alt="" /></a>
						<p></p>
					</div>
				</div>
			</div>
		</div>


		<!-- Footer -->
		<div id="footer">

				<div class="row">
					<p>Developed by: Nicholas Fong, Jeff Kang</p>
				</div>
	
		</div>

		<!-- Copyright -->
		<div id="copyright">
			<div class="container">
				Design: <a href="http://templated.co">TEMPLATED</a> Images: <a href="http://unsplash.com">Unsplash</a> (<a href="http://unsplash.com/cc0">CC0</a>)
			</div>
		</div>
		
	</body>
</html>