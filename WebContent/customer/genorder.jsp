<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.util.db.DataAccess"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
//Generate Order
String data=session.getAttribute("data").toString();
String user=session.getAttribute("user").toString();
DataAccess db=new DataAccess();
ResultSet rs=db.getRows("select sum(b.Price*a.Qty) from Cart a, Product b where a.EmailID=? and a.ProductId=b.ProductId",user);
double total=0;
if(rs.next()){
total=rs.getDouble(1);	
}

Date dt = new Date(); //Current date and time
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String odate=sdf.format(dt);

int ordid=db.executeSqlId("Insert into Orders (OrderDate,EmailID,PayDetails,TotalAmt) values(?,?,?,?)", odate,user,data,total);

//Insert Orderdetails
db.executeSql("Insert into OrderDetails select "+ordid+",ProductId,Qty from Cart where EmailID=?",user);

db.executeSql("delete from cart where EmailID=?", user);
response.sendRedirect("/furnitureshop/customer/orderinfo.jsp?oid="+ordid);
%>