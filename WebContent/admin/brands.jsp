<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>
<%
String brandid="",brandname="",btntext="Save";

if(request.getParameter("btnsave")!=null)
{
if(request.getParameter("btnsave").equals("Save")){
	brandname=request.getParameter("txtbrand");
	db.executeSql("Insert into brand (BrandName) values(?)", brandname);
	msg="Brand is saved successfully...";
}else{
	brandid=request.getParameter("txtbrandid");
	brandname=request.getParameter("txtbrand");
	db.executeSql("Update brand set BrandName=? where BrandId=?", brandname,brandid);
	msg="Brand is updated successfully...";	
}
}else{
	if(request.getParameter("eid")!=null)
	{
		brandid=request.getParameter("eid");
		ResultSet rs=db.getRows("select * from brand where BrandId=?", brandid);
		if(rs.next())
		{
	
			brandname=rs.getString(2);
			btntext="Update";
		}
	}
	else if(request.getParameter("did")!=null)
	{
		 brandid=request.getParameter("did");
		db.executeSql("Delete from brand Where BrandId=?", brandid);
		msg="Brand is Deleted Successfully..";
	}
}
%>
<div class="col-5 offset-2">
<br/>
<h3>Manage Product Brands/Companies::</h3>
<form method="post" id="form1">
<input type="hidden" name="txtbrandid" value="<%= brandid%>"/>
<div class="form-group">
 <b>Brand Name</b>
<input name="txtbrand" class="form-control" placeholder="Brand Name" value="<%= brandname%>"/>
</div>
<br/>
<input type="submit" name="btnsave" value="<%=btntext%>" class="btn btn-primary"/>
<a href="brands.jsp" class="btn btn-secondary">Clear</a>
</form>
<br/>
<br/>
<table id="table1" class="table table-bordered">
<thead class="table-primary">
<tr>
<th>Brand Id</th>
<th>Brand Name</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
ResultSet rs=db.getRows("select * from brand");
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td>
<a href="?eid=<%=rs.getString(1) %>" class="btn btn-info">Edit</a>
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