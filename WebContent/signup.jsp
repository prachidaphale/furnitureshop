<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp"%>
<%

if(request.getParameter("btnsignup")!=null)//Login button clicked
{
	
	String email=request.getParameter("txtemail");
	String mobile=request.getParameter("txtmobile");
	String pass=request.getParameter("txtpass");
	db.executeSql("Insert into signup (EmailID,MobileNo,Password) values(?,?,?)", email, mobile, pass);
	msg="You have successsfully registered with Site";

}
%>
<!--Signup Page Specific Contents-->
<div class="container">
<form method="post" id="form1">
<div class="col-5 offset-3">
<br/>
<br/>
<h2>Signup/Create Account</h2>

<div class="form-group">
Email Address
<input type="text" name="txtemail" id="txtemail" class="form-control" placeholder="Enter Username"/>
</div>
<div class="form-group">
Mobile No
<input type="text" name="txtmobile" id="txtmobile" class="form-control" placeholder="Enter Mobile no"/>
</div>
<div class="form-group">
Password
<input type="password" name="txtpass" id="txtpass" class="form-control" placeholder="Enter Password"/>
</div>
<div class="form-group">
Confirm Password
<input type="password" name="txtcpass" id="txtcpass" class="form-control" placeholder="Enter Password"/>
</div>
<br/>
<input type="submit" name="btnsignup" value="Signup" class="btn btn-primary"/>
</div>
</form>
<%=msg%>
</div>
<%@ include file="footer.jsp"%>
<script>
$(function(){
	$("#form1").validate({
		rules:{
			txtemail:{
				required:true,
				email:true
			},
			txtmobile:{
				required:true,
				pattern:/^\d{10}$/
			},
			txtpass:{
				required:true
	
			},
			txtcpass:{
				required:true,
				equalTo:"#txtpass"
			}
		},
		messages:{
			txtemail:{
				required:"EmailID is required",
				email:"Invalid Email ID"
			},
			txtmobile:{
				required:"Mobile No is required",
				pattern:"Mobile No Allows only 10 digits"
			},
			txtpass:{
				required:"Password is Required"
			},
			txtcpass:{
				required:"Confirm Password is Required",
				equalTo:"Password Mismatch"
			}
		}
	});
});
</script>
