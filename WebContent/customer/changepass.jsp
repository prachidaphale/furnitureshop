<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>
<%

if(request.getParameter("btnchange")!=null)//Login button clicked
{
	
	
	String opass=request.getParameter("txtopass");
	String npass=request.getParameter("txtnpass");
	String cpass=request.getParameter("txtcpass");
	//check old password is valid or not
	String user=session.getAttribute("user")+"";  //Convert Object to string
	String pass=session.getAttribute("pass")+"";
	
	if(!opass.equals(pass)){//if not matching with db password
		msg="Please enter valid old password";
	}else
	{
		db.executeSql("Update signup set Password=? where EmailID=?",npass,user);
		msg="Password changed successfully.....";
	}
	
	
}
%>
<!--Login Page Specific Contents-->
<div class="container">
<form method="post" id="form1">
<div class="col-5 offset-3">
<br/>
<br/>
<h2>Change Password</h2>


<div class="form-group">
Old Password
<input type="password" name="txtopass" id="txtopass" class="form-control" placeholder="Enter Old Password"/>
</div>

<div class="form-group">
New Password
<input type="password" name="txtnpass" id="txtnpass" class="form-control" placeholder="Enter New Password"/>
</div>
<div class="form-group">
Confirm New Password
<input type="password" name="txtcpass" id="txtcpass" class="form-control" placeholder="Enter Password"/>
</div>
<br/>
<input type="submit" name="btnchange" value="Submit" class="btn btn-primary"/>
</div>
</form>
<%=msg%>
</div>
<%@ include file="../footer.jsp"%>
<script>
$(function(){
	$("#form1").validate({
		rules:{
			txtopass:{
				required:true
			},
			txtnpass:{
				required:true
			},
			txtcpass:{
				required:true,
				equalTo:"#txtnpass"
			}
		},
		messages:{
			txtopass:{
				required:"Old password is required"
			},
			txtnpass:{
				required:"New Password is required"
			},
			txtcpass:{
				required:"Confirm New Password is required",
				equalTo:"Password Mismatch"
			},
		}
	});
});
</script>
