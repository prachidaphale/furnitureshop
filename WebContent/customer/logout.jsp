<%
session.setAttribute("user", null);
session.setAttribute("pass", null);
session.setAttribute("type", null);
response.sendRedirect("/furnitureshop/login.jsp");

%>