<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp"%>
<% 
String sql="select a.ProductId,a.ProductName,a.CategoryId,b.CategoryName,a.BrandId,c.BrandName,a.Price,a.Qty,a.Unit,a.ProductImage from Product a,Category b,Brand c where a.CategoryId=b.CategoryId and a.BrandId=c.BrandId ";//default product list
if(request.getParameter("cid")!=null){
	sql=sql+" and a.CategoryId="+ request.getParameter("cid");
}
if(request.getParameter("bid")!=null){
	sql=sql+" and a.BrandId="+ request.getParameter("bid");
}
if(request.getParameter("q")!=null){
	sql=sql+" and a.ProductName like '%"+ request.getParameter("q")+"%'";
}
%>
<!--Product Page Specific Contents-->
<div class="row">
<div class="col-3">
<div class="list-group">
	<a href="#" class="list-group-item list-group-item-action active">Categories</a>
	<%
	ResultSet rs=db.getRows("select * from Category");
	while(rs.next()){
		%>
		<a href="?cid=<%=rs.getString(1)%>" class="list-group-item list-group-item-action"><%=rs.getString(2)%></a>
		<%
		}
	%>
</div>
<hr/>
<div class="list-group">
  <a href="#" class="list-group-item list-group-item-action active">Brands</a>
  	<%
  	rs=db.getRows("select * from Brand");
	while(rs.next()){
		%>
		<a href="?bid=<%=rs.getString(1)%>" class="list-group-item list-group-item-action"><%=rs.getString(2)%></a>
		<%
		}
	%> 
</div>
</div>
<div class="col-8">
<div class="row row-cols-3 g-4">
<%
ResultSet rs2=db.getRows(sql);
while(rs2.next()){
%>
<div class="col">
<div class="card h-100">  <!-- mb-3 -->
  <h6 class="card-header"><%=rs2.getString(2) %></h6>
  <div class="card-body">
    <h6 class="card-title"><%=rs2.getString(4) %></h6>
    <h6 class="card-subtitle text-muted"><%=rs2.getString(6)%></h6>
  </div>
  <img class="card-image-top" src="/furnitureshop/productimages/<%=rs2.getString(10)%>" width="100%" height="200" alt="NA"/>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">Price: <%=rs2.getString(7) %></li>
    <li class="list-group-item">Available Qty:<%=rs2.getString(8)%></li>
    <li class="list-group-item">Unit:<%=rs2.getString(9)%></li>
  </ul>
  <div class="card-body">
    <a href="/furnitureshop/customer/addToCart.jsp?pid=<%=rs2.getString(1) %>" class="btn btn-success btn-sm">Add to Cart</a>
    <a href="#" class="btn btn-info btn-sm">More Details</a>
  </div>
</div>
</div>
<%
}
%>
</div>
</div>
</div>
<%@ include file="footer.jsp"%>