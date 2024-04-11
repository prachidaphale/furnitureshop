<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>
<%
if(request.getParameter("cid")!=null){
	String cid=request.getParameter("cid");
	String qty=request.getParameter("qty");
	db.executeSql("Update Cart set qty=? where CartId=?", qty,cid);
}
if(request.getParameter("did")!=null){
	String did=request.getParameter("did");	
	db.executeSql("Delete from Cart where CartId=?", did);
}
%>
<div class="col-10 offset-1">
<br/>
<h3>Shopping Cart::</h3>
<a href="checkout.jsp" class="btn btn-primary float-end me-4">Checkout</a>
<br/>
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
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
ResultSet rs=db.getRows("select d.CartId,a.ProductId,a.ProductName,b.CategoryName,c.BrandName,a.Price,d.Qty,a.Unit,a.Price*d.Qty as Total,a.ProductImage,d.EmailId from Product a,Category b,Brand c,Cart d where a.CategoryId=b.CategoryId and a.BrandId=c.BrandId and a.ProductId=d.ProductId");
int i=0;
double total=0;
while(rs.next()){
%>
<tr>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
<td>
<input type="number" id="t<%=i%>" class="form-control" style="width:80px" value="<%=rs.getString(7) %>"/>
</td>
<td><%=rs.getString(8) %></td>
<td><%=rs.getString(9) %></td>
<td>
<img src="/furnitureshop/productimages/<%=rs.getString(10) %>" width="70" height="70" alt="NA"/>
</td>
<td>
<a href="#" onclick="updateQty(<%=rs.getString(1) %>,<%=i%>);" class="btn btn-info">Update</a>
<a href="?did=<%=rs.getString(1) %>" onclick="return confirm('Do you want to delete this record?');"  class="btn btn-danger">Delete</a>
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
<th colspan="6" class="text-center">
Total Amount
</th>
<th>
<%=new DecimalFormat("#,###.##").format(total)%>
</th>
<th colspan="2">

</th>
</tfoot>
</table>
</div>



<%@ include file="../footer.jsp"%>
<script>
function updateQty(cid,txtid){ //2  0
	var qty=$("#t"+txtid).val();  //var qty=$("#t0").val(); //1	
	window.location="/furnitureshop/customer/cart.jsp?cid="+cid+"&qty="+qty;
	
}

</script>