<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp"%>
<%
if(request.getParameter("btnsubmit")!=null) 
{
	String email=request.getParameter("txtemail");
	String feedback=request.getParameter("txtfeedback");
	Date dt = new Date(); //Current date and time
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String fdate=sdf.format(dt);
	
	db.executeSql("Insert into Feedback (FeedbackDateTime,EmailID,FeedbackText) values(?,?,?)", fdate,email,feedback);
	msg="Thanks for your feedback!";
}

%>
<!-- Feedback Page Specific Contents -->
<div class="container">
<form method="post" id="form1">
<div class="col-5 offset-3">
<br/>
<br/>
<h4>Please provide your valuable feedback::</h4>
<div class="form-group">
Email ID
<input type="text" name="txtemail" id="txtemail" class="form-control" placeholder="Enter Username"/>
</div>
<div class="form-group">
Feedback
<textarea name="txtfeedback" class="form-control" rows="10"></textarea>
</div>
<br/>
<input type="submit" name="btnsubmit" value="Submit" class="btn btn-primary"/>
</div>
</form>
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
			txtfeedback:{
				required:true
			}
		},
		messages:{
			txtemail:{
				required:"EmailID is required",
				email:"Invalid Email ID"
			},
			txtfeedback:{
				required:"Feedback is required"
			}
		}
		
	}); 
 });
 
 </script>
 