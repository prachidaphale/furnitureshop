<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>
<%
if (request.getParameter("did")!=null){
	db.executeSql("delete from Product where ProductId=?", request.getParameter("did"));
}
if (request.getParameter("eid")!=null){
	session.setAttribute("eid", request.getParameter("eid"));
	response.sendRedirect("editproduct.jsp");//Redirect to/go to given page
}
%>
<div class="col-17 ">
<br/>
<h3><center>Product List </center></h3>
<a href="addproduct.jsp" class="btn btn-primary float-end me-4">Add Product</a>
<br/>
<br/>
<table id="table1" class="table table-bordered">
<thead class="table-primary">
<tr>
<th>Product Id</th>
<th>Product Name</th>
<th>Category Id</th>
<th>Category Name</th>
<th>Brand Id </th>
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
ResultSet rs=db.getRows("select a.ProductId,a.ProductName,a.CategoryId,b.CategoryName,a.BrandId,c.BrandName,a.Price,a.Qty,a.Unit,a.ProductImage from Product a,Category b,Brand c where a.CategoryId=b.CategoryId and a.BrandId=c.BrandId");
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
<td><%=rs.getString(9) %></td>
<td>
<img src="/furnitureshop/productimages/<%=rs.getString(10) %>" width="70" height="70" alt="NA"/>
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
<%@ include file="../footer.jsp"%>
<script>
$(function(){
$("#table1").DataTable();//apply database library on table whose id is table1
});
</script>