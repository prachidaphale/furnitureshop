<%@page import="com.util.db.DataAccess"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 DataAccess db=new DataAccess();
 String msg="",search=""; 
 if(request.getParameter("btnsearch")!=null){
	 search=request.getParameter("txtsearch");
	 session.setAttribute("search", search);
	 response.sendRedirect("/furnitureshop/products.jsp?q="+search);
 }
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Furniture Shop</title>
<link href="/furnitureshop/css/bootstrap.css" rel="stylesheet"/>
<link href="/furnitureshop/js/DataTables/datatables.css" rel="stylesheet"/>
<style>
label.error{
color:red;
font-weight:bold;
}
<%-- CSS for home page background --%>
<% if (request.getRequestURI().endsWith("/index.jsp")) { %>
body {
    background-image: url('/furnitureshop/images/bk1.jpg'); 
    background-size: center; 
   
}
<% } %>
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
<%-- Body content for your home page --%>
<% if (request.getRequestURI().endsWith("/index.jsp")) { %>
    <div class="home-page-content">
        <!-- Content specific to the home page -->
    </div>
<% } else { %>
    <div class="other-page-content">
        <!-- Content for other pages -->
    </div>
<% } %>
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">Classic Furniture</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
      <%	
      	if(session.getAttribute("user")==null)//if No login
      	{ 		
      %>
        <li class="nav-item">
          <a class="nav-link active" href="/furnitureshop/index.jsp">Home
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/categories.jsp">Categories</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/brands.jsp">Brands</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/products.jsp">Products</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/about.jsp">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/contact.jsp">Contact</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/feedback.jsp">Feedback</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/login.jsp">Login</a>
        </li>
       <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/signup.jsp">Create Account</a>
        </li>
        <%
        }else if (session.getAttribute("user")!=null && session.getAttribute("type").equals("admin")) 
        {
        %>
        <li class="nav-item">
          <a class="nav-link active" href="/furnitureshop/admin/admin.jsp">Admin
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/categories.jsp">Categories</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/brands.jsp">Brands</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/productlist.jsp">Products</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/customerList.jsp">Customer List</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/orderhistory.jsp">Orders</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/feedbacks.jsp">Feedbacks</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/reportlist.jsp">Reports</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/changepass.jsp">Change Password</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">User:<%=session.getAttribute("user")%></a>
        </li>
       <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/admin/logout.jsp">Logout</a>
        </li>
        <%
        }else if (session.getAttribute("user")!=null && session.getAttribute("type").equals("customer")) 
        {
		%>
		<li class="nav-item">
          <a class="nav-link active" href="/furnitureshop/customer/customer.jsp">Customer
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/products.jsp">Products</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/customer/cart.jsp">Cart</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/customer/orderhistory.jsp">Orders</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/customer/changepass.jsp">Change Password</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">User:<%=session.getAttribute("user") %></a>
        </li>
       <li class="nav-item">
          <a class="nav-link" href="/furnitureshop/customer/logout.jsp">Logout</a>
        </li>		
		<%
		}
		%>
      </ul>
      <%
      if(session.getAttribute("user")==null || (session.getAttribute("user")!=null && session.getAttribute("type").equals("customer")))
      {
      %>
      <form class="d-flex" method="post">
        <input class="form-control me-sm-2" type="search" name="txtsearch" placeholder="Search Product" value="<%=session.getAttribute("search")==null?"":session.getAttribute("search")%>"/>
        <button class="btn btn-secondary my-2 my-sm-0" type="submit" name="btnsearch" value="Search">Search</button>
      </form>
      <%
      }
      %>
    </div>
  </div>
</nav>