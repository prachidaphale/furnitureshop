<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>
<%
if(request.getParameter("oid")!=null){
String oid=request.getParameter("oid");
ResultSet rs=db.getRows("select * from Orders where OrderId=?",oid);
if(rs.next()){
%>
<div class="col-10 offset-1">
<br/>
<h3>Order Information::</h3>
<table id="table1" class="table table-bordered">
<tr>
<td><strong>Order ID</strong></td><td><%=rs.getString(1) %></td>
<td><strong>Order Date</strong></td><td><%=rs.getString(2) %></td>
<td><strong>Ordered By</strong></td><td><%=rs.getString(3) %></td>
<td><strong>Pay Details</strong></td><td><%=rs.getString(4).split(";")[0] %></td>
</tr>
</table>
<br/>
<table id="table1" class="table table-bordered">
<thead class="table-dark">
<tr>
<th>Product Name</th>
<th>Category Name</th>
<th>Brand Name</th>
<th>Price</th>
<th>Qty</th>
<th>Unit</th>
<th>Total</th>
<th>Image</th>
</tr>
</thead>
<tbody>
<%
rs=db.getRows("select d.OrderId,a.ProductId,a.ProductName,b.CategoryName,c.BrandName,a.Price,d.Qty,a.Unit,a.Price*d.Qty as Total,a.ProductImage from Product a,Category b,Brand c,OrderDetails d where d.OrderId=? and a.CategoryId=b.CategoryId and a.BrandId=c.BrandId and a.ProductId=d.ProductId",oid);
int i=0;
double total=0;
while(rs.next()){
%>
<tr>
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
</tr>
<%
total+=rs.getDouble(9);
i++;
}
%>
</tbody>
<tfoot>
<tr class="table-dark">
<th colspan="4" class="text-right">
You will receive order within 3/4 business days from order date.  
</th>
<th colspan="2">
Total Amount
<th>
<%=new DecimalFormat("#,###.##").format(total)%>
</th>
<th colspan="2">
</th>
</tfoot>
</table>
<button class="btn btn-primary" type="button" onclick="window.print();">Print</button>

</div>
<%
}else{
%>
<br/>
<br/>
<div class="alert alert-dismissible alert-warning w-75 offset-1">
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  <h4 class="alert-heading">Warning!</h4>
  <p class="mb-0">Order Id <%=oid%> is not exists. <a href="/furnitureshop/customer/customer.jsp" class="alert-link">Back to Home</a>.</p>
</div>
<%	
}
}else{
%>
<br/>
<br/>
<div class="alert alert-dismissible alert-warning  w-75 offset-1">
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  <h4 class="alert-heading">Warning!</h4>
  <p class="mb-0">Please provide order id. <a href="/furnitureshop/customer/customer.jsp" class="alert-link">Back to Home</a>.</p>
</div>
<%
}
%>
<%@ include file="../footer.jsp"%>