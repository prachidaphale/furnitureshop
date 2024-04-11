<%@page import="com.util.db.DataAccess" %>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
if(session.getAttribute("user")==null){
	String pid=request.getParameter("pid");
	if(pid==null)
	response.sendRedirect("/furnitureshop/login.jsp");
	else
		response.sendRedirect("/furnitureshop/login.jsp?pid="+pid);
	return;//execute from page
}
DataAccess db=new DataAccess();
if(request.getParameter("pid")!=null){
	String pid=request.getParameter("pid");
	db.executeSql("Insert into Cart (ProductId,Qty,EmailId) values(?,?,?)",pid,1,session.getAttribute("user"));
	response.sendRedirect("/furnitureshop/customer/cart.jsp");
}
%>
<div class="col-17 ">
<br/>
<h3><center>Shopping Cart</center></h3>
<a href="addproduct.jsp" class="btn btn-primary float-end me-4">Add Product</a>
<br/>
<br/>
<table id="table1" class="table table-bordered">
<thead class="table-primary">
<tr>
<th>CartId</th>
<th>ProductId</th>
<th>Product Name</th>
<th>Category Name</th>
<th>Brand Name</th>
<th>Price </th>
<th>Qty</th>
<th>Unit</th>
<th>Image</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
ResultSet rs=db.getRows("select d.CartId,a.ProductId,a.ProductName,b.CategoryName,c.BrandName,a.Price,d.Qty,a.Unit,a.ProductImage,d.EmailId from Product a,Category b,Brand c,Cart d where a.CategoryId=b.CategoryId and a.BrandId=c.BrandId and a.ProductId=d.ProductId");
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
<td><%=rs.getString(7) %></td>
<td><%=rs.getString(8) %></td>
<td>
<img src="/furnitureshop/productimages/<%=rs.getString(9) %>" width="70" height="70" alt="NA"/>
</td>
<td>
<a href="addproduct.jsp?eid=<%=rs.getString(1) %>" class="btn btn-info">Edit</a>
<a href="?did=<%=rs.getString(1) %>" onclick="return confirm('Do you want to delete this record?');" class="btn btn-danger">Delete</a>
</td>
</tr>
<%
}
%>

</tbody>
</table>
</div>

