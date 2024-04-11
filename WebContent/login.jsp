<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp"%>
<style>
    body {
        background-image: url('/furnitureshop/images/bk1.jpg');
        background-size: center;
    }
</style>

<%

if(request.getParameter("btnlogin")!=null)//Login button clicked
{
	
	String user=request.getParameter("txtuser");
	String pass=request.getParameter("txtpass");
	//admin email id==>admin@gmail.com
			
	if(user.contains("admin")){//if user string contains admin word then it is admin
		//validate it against adminlogin table
		ResultSet rs=db.getRows("select * from admin where UserName=? and Password=?",user,pass);
		
		if(rs.next())//true //false
		{
			//redirect to admin dashboard
			session.setAttribute("user", user);
			session.setAttribute("pass", pass);
			session.setAttribute("type", "admin");
			response.sendRedirect("/furnitureshop/admin/admin.jsp");
			
		}
		else
		{
			session.setAttribute("user", null);
			session.setAttribute("pass", null);
			session.setAttribute("type", null);
			msg="Invalid UserName/Password...Try again...";	
		}
		
	}else{//otherwise it is customer
		//validate it against signup table
		ResultSet rs=db.getRows("select * from signup where EmailID=? and Password=?",user,pass);
				
		if(rs.next())//true //false
		{
			//redirect to customer dashboard
			session.setAttribute("user", user);
			session.setAttribute("pass", pass);
			session.setAttribute("type", "customer");
			response.sendRedirect("/furnitureshop/customer/customer.jsp");
					
		}
		else
		{
			session.setAttribute("user", null);
			session.setAttribute("pass", null);
			session.setAttribute("type", null);
			msg="Invalid UserName/Password...Try again...";	
		}

		
	}
	
}
%>
<!--Login Page Specific Contents-->
<div class="container">
<form method="post" id="form1">
<div class="col-5 offset-3">
<br/>
<br/>
<h2>Login</h2>

<div class="form-group">
<b>UserName/Email Address</b>
<input type="text" name="txtuser" id="txtuser" class="form-control" placeholder="Enter Username"/>
</div>
<div class="form-group">
<b>Password</b>
<input type="password" name="txtpass" id="txtpass" class="form-control" placeholder="Enter Password"/>
</div>
<br/>
<input type="submit" name="btnlogin" value="login" class="btn btn-primary"/>
</div>
</form>
<%=msg%>
</div>
<%@ include file="footer.jsp"%>
<script>
$(function(){
	$("#form1").validate({
		rules:{
			txtuser:{
				required:true
			},
			txtpass:{
				required:true
			}
		},
		messages:{
			txtuser:{
				required:"UserName is required"
			},
			txtpass:{
				required:"Password is required"
			}
		}
	});
});
</script>
