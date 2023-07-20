<%@ page import="java.sql.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.util.*" %>

 <html>
<head>
<title>Enquirey app</title>
<style>
*{font-size:40px;}
textarea{resize:None;}
</style>
</head>
<body>
<center>
<h1>Fill the Form</h1>
<form >  
<input  type="text" name="na" placeholder="enter name" required/>
<br/><br/>
<input type="number"  name="ph" placeholder="enter phone" required/>
<br/><br/>
<textarea name="qu" placeholder ="enter query" rows=5></textarea>
<br/><br/>
<input type="submit"  name="btn"/>
</form>
<%
  if(request.getParameter("btn")!=null)
   {
    String name=request.getParameter("na");
    long phone=Long.parseLong(request.getParameter("ph"));
     String query=request.getParameter("qu");
    try
  {
	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
 	String url="jdbc:mysql://localhost:3306/kit1oct22";
	String un="root";
	String pw="abc123";
	Connection con=DriverManager.getConnection(url,un,pw);
	String sql="insert into student(name,phone,query) values(?,?,?)";
	PreparedStatement pst=con.prepareStatement(sql);
	pst.setString(1,name);	
        pst.setLong(2,phone);	
	pst.setString(3,query);	
	pst.executeUpdate();
	out.println("we will get back to you in 2 hours");

	//MAIL KAHAN SE JAYEGA 
	Properties p=System.getProperties();	
	p.put("mail.smtp.host","smtp.gmail.com");
	p.put("mail.smtp.port",587);
	p.put("mail.smtp.auth",true);
	p.put("mail.smtp.starttls.enable",true);

	// apka username and password ka authentication
	Session ms =Session.getInstance(p,new Authenticator(){
	public PasswordAuthentication getPasswordAuthentication(){
	  String un="kunal.tester.2sep22@gmail.com";
	  String pw="refnaczvbgjjbpyq";
	  return new PasswordAuthentication(un,pw);
		}
	    });
	try
	{
	//MAIL ko DRAFT karke bhejo
	  MimeMessage msg=new MimeMessage(ms);	
	String subject="enquiry from"+name;
	  msg.setSubject(subject);
	String txt="name="+name+"phone="+phone+"query="+query;
	  msg.setText(txt);
	  msg.setFrom(new InternetAddress("kunal.tester2sep22@gmail.com"));
	  msg.addRecipient(Message.RecipientType.TO,new InternetAddress("prathmeshaug6@gmail.com"));
	  Transport.send(msg);
	}
	catch(Exception e)
	  {
		out.println("issues-->"+e);	
	   }	
	con.close();
          }
	catch(SQLException e)
	  {
		out.println("issues"+e);	
	   }
	}	

%>

</center>
</body>
</html>