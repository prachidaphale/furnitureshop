<%@page import="javazoom.upload.MultipartFormDataRequest" %>
<%@page import="javazoom.upload.UploadBean"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.UploadFile"%>     
<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%> 
<%
String path=request.getRealPath("/productimages/");
//D:\FinalProject\furnitureshop\WebContent\productimages/
UploadBean upBean=new UploadBean();
upBean.setFolderstore(path); //Store uploaded files in this directory/folder
String prodid="",prodname="",catid="",brandid="",price="",qty="",unit="",btntext="Save";
String fname="";
String title="Add Product";
if(MultipartFormDataRequest.isMultipartFormData(request)){
	MultipartFormDataRequest mrequest=new MultipartFormDataRequest(request);
	//request (MP) ===> Wrapper ====> MultipartFormDataRequest
	prodid=mrequest.getParameter("txtprodid");
	prodname=mrequest.getParameter("txtprodname");
	catid=mrequest.getParameter("txtcatid");
	brandid=mrequest.getParameter("txtbrandid");
	price=mrequest.getParameter("txtprice");
	qty=mrequest.getParameter("txtqty");
	unit=mrequest.getParameter("txtunit");
	catid=mrequest.getParameter("txtcatid");
	Hashtable ht=mrequest.getFiles();//HashTable - collection of key/valie paris
	if(ht!=null && ht.size()>0){
		UploadFile uf= (UploadFile)ht.get("txtimage");//Return type==>Object
		if(uf!=null && uf.getFileName()!=null && !uf.getFileName().equals("")){
			fname=uf.getFileName();
			//Upload/Save file to server
			upBean.store(mrequest, "txtimage");
		}
    }
	if(mrequest.getParameter("btnsave").equals("Save")){
		db.executeSql("Insert into Product (ProductName,CategoryId,BrandId,Price,Qty,Unit,ProductImage) values(?,?,?,?,?,?,?)", prodname,catid,brandid,price,qty,unit,fname);
	    msg="Product information is saved successfully.....";
	}else{
		db.executeSql("Update Product set ProductName=?,CategoryId=?,BrandId=?,Price=?,Qty=?,Unit=?,ProductImage=? where ProductId=?", prodname,catid,brandid,price,qty,unit,fname,prodid);
	    msg="Product information is updated successfully.....";
	}
}else{
	if(request.getParameter("eid")!=null){
		ResultSet rs=db.getRows("select * from product where ProductId=?",request.getParameter("eid"));
		if(rs.next()){
			prodid=rs.getString(1);
			prodname=rs.getString(2);
			catid=rs.getString(3);
			brandid=rs.getString(4);
			price=rs.getString(5);
			qty=rs.getString(6);
			unit=rs.getString(7);
			fname=rs.getString(8);
			title="Edit Product";
			btntext="Update";
		}
	}
}

%>
<div class="col-7 offset-2">
<br/>
<h3><%=title%></h3>
<form method="post" id="form1" enctype="multipart/form-data">
<input type="hidden" name="txtprodid" value="<%= prodid%>"/>
<div class="form-group">
<b>Product Name</b>
<input name="txtprodname" id="txtprodname" class="form-control" placeholder="Product Name" value="<%=prodname%>" autofocus/>
</div>
<div class="form-group">
<b>Product Category</b>
<select name="txtcatid" id="txtcatid" class="form-select">
<option value="">--Select Product Category--</option>
<% 
ResultSet rs=db.getRows("select *from category");
while(rs.next()){
%>
<option value="<%=rs.getString(1)%>"<%=catid.equals(rs.getString(1))?"selected":"" %>><%=rs.getString(2)%></option>
<%
}
%>
</select>
</div>
<div class="form-group">
<b>Product Brand</b>
<select name="txtbrandid" id="txtbrandid" class="form-select">
<option value="">--Select Product Category--</option>
<% 
 rs=db.getRows("select *from brand");
while(rs.next()){
%>
<option value="<%=rs.getString(1)%>" <%=brandid.equals(rs.getString(1))?"selected":"" %>><%=rs.getString(2)%></option>
<%
}
%>
</select>
</div>
<div class="form-group">
<b>Price</b>
<input name="txtprice" id="txtprice" class="form-control" placeholder="Product Price" value="<%=price%>"/>
</div>
<div class="form-group">
<b>Quantity</b>
<input name="txtqty" id="txtqty" class="form-control" placeholder="Product Qty" value="<%=qty%>"/>
</div>
<div class="form-group">
<b>Unit</b>
<select name="txtunit" id="txtunit" class="form-select">
<option value="">--Select Product Unit--</option>
<option value="Pcs"<%=unit.equals("Pcs")?"selected":"" %>>Pcs</option>
<option value="Bottles"<%=unit.equals("Bottles")?"selected":"" %>>Bottles</option>
<option value="Boxes"<%=unit.equals("Boxes")?"selected":"" %>>Boxes</option>
</select>
</div>
<div class="form-group">
<b>Browse Product Image</b>
<input type="file" name="txtimage" id="txtimage" class="form-control"/>
<img  src="/furnitureshop/productimages/<%=fname%>" width="70" height="70"alt="NA"/>
</div>
<br/>
<input type="submit" name="btnsave" value="<%=btntext%>" class="btn btn-primary"/>
<a href="addproduct.jsp" class="btn btn-secondary">Clear</a>
<a href="productlist.jsp" class="btn btn-info">Product List</a>
</form>
<br/>
<br/>
</div>
<%@ include file="../footer.jsp"%>
<script>
$(function(){
	$("#form1").validate({
		rules:{
			txtprodname:{
				required:true
			},
			txtcatid:{
				required:true
			},
			txtbrandid:{
				required:true
			},
			txtprice:{
				required:true,
				number:true//12,  12.34
			},
			txtqty:{
				required:true,
				digits:true
			},
			txtunit:{
				required:true
			},
			txtimage:{
				required:true
			}
		},
		messages:{
			txtprodname:{
				required:"Product Name required"
			},
			txtcatid:{
				required:"Please select category"
			},
			txtbrandid:{
				required:"Please select brand"
			},
			txtprice:{
				required:"Product price required",
				number:"Product price should be numeric"
			},
			txtqty:{
				required:"Product Qty required",
				digits:"Product Qty should be integer"
			},
			txtunit:{
				required:"Product units required"
			},
			txtimage:{
				required:"Product Image is required"
			}
		}
	});
});
</script>



