<script src="/furnitureshop/js/sweetalert.min.js"></script>
<script src="/furnitureshop/js/jquery-3.6.0.js"></script>
<script src="/furnitureshop/js/DataTables/datatables.js"></script>
<script src="/furnitureshop/js/bootstrap.js"></script>
<script src="/furnitureshop/js/jquery.validate.js"></script>
<script src="/furnitureshop/js/additional-methods.js"></script>
<%
if(!msg.equals(""))
{
%>
<script >
swal("Classic Furniture","<%=msg%>","error");
</script>
<% 
}
%>
</body>
</html>