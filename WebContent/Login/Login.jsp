<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录界面</title>
<style type="text/css">
	#table{
		margin:0 auto;
		border-spacing: 10px;
	}
</style>
<script src="../js/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
	function login() {
		var b=check();
		if(b){
			var username=$("#username").val();
			var password=$("#password").val();
			var password_again=$("#password_again").val();
			
			$.ajax({
				url:"../login",
				type:"get",
				data:{
					username:username,
					password:password,
					password_again:password_again
				},
				success:function(data){
					if(data=="1"){
						//成功的处理逻辑
						window.location.href = "Home.jsp";
					}
					if (data == "0") {
						//失败的处理
						alert("用户名或者密码错误");
						document.getElementById("back").innerHtml = "用户名或者密码错误";
					}
					if (data == "2") {
						//失败的处理
						alert("请确认两次输入的密码一致");
						document.getElementById("back").innerHtml = "两次输入密码不一致";
					}
				}
			});
			//ajax请求
			/* var xmlHttp = new XMLHttpRequest();
			var username = document.getElementById("username").value;
			eeee
			var password_again = document.getElementById("password_again").value;
			//ajax回调事件
			xmlHttp.onreadystatechange=function (){
				if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
					var data = xmlHttp.responseText;
					// 1代表成功 0代表是失败
					if (data == "1") {
						//成功的处理逻辑
						window.location.href = "Helloworld.jsp";
					}
					if (data == "0") {
						//失败的处理
						alert("用户名或者密码错误");
						document.getElementById("back").innerHtml = "用户名或者密码错误";
					}
					if (data == "2") {
						//失败的处理
						alert("请确认两次输入的密码一致");
						document.getElementById("back").innerHtml = "两次输入密码不一致";
					}
				}
			}
			xmlHttp.open("get","../login?username="+username+"&password="+password+"&password_again="+password_again,true);
			xmlHttp.send(); */
		}
	}

	//用户名、密码是否为空
	function check() {
		var username=$("#username").val();
		var password=$("#password").val();
		var password_again=$("#password_again").val();
		if(username==""){
			$("#username").focus();
			//$("#username").css("border","2px solid red");
			alert("用户名不能为空！");
			return false;
		}
		
		if(password==""){
			$("#password").focus();
			//$("#password").css("border","2px solid red");
			//$("#username").css("border","");
			alert("密码不能为空！");
			return false;
		}
		
		if(password_again==""){
			$("#password_again").focus();
			alert("确认密码不能为空！");
			return false;
		}
		
		return true;

		/* var username = document.getElementById("username").value;
		var password = document.getElementById("password").value;
		var password_again = document.getElementById("password_again").value;
		if (username == "") {
			document.getElementById("username").focus();
			//document.getElementById("useranme").style.border = "2px solid red";
			alert("用户名不能为空！");
			return false;
		}

		if (password == "") {
			document.getElementById("password").focus();
			//document.getElementById("password").style.border = "2px solid red";
			//document.getElementById("username").style.border = "";
			alert("密码不能为空！");
			return false;
		}
		
		if (password_again == "") {
			document.getElementById("password_again").focus();
			//document.getElementById("password_again").style.border = "2px solid red";
			//document.getElementById("username").style.border = "";
			alert("确认密码不能为空！");
			return false;
		}

		return true; */
	}
	
	function register(){
		window.location.href = "Register.jsp";
	}
</script>
</head>

<body>
	<div id="lo">
		<table id="table">
			<tr>
				<caption>
					<font size="5" color="#F8272A">登录系统</font>
				</caption>
			</tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr>
				<td><font size="3">用户名:</font></td>
				<td><input id="username" name="username" type="text"
					autofocus placeholder="请输入用户名" /></td>
			</tr>
			<tr>
				<td><font size="3">设置密码:</font></td>
				<td><input id="password" name="password" type="password"
					maxlength="20" placeholder="请输入密码" /></td>
			</tr>
			<tr>
				<td></td>
				<td><font size="2" color="#BCBCBC">6-20个字符，由字母、数字<br />和符号的两种以上结合</font></td>
			</tr>
			<tr>
				<td><font size="3">确认密码:</font></td>
				<td><input id="password_again" name="password" type="password" placeholder="请再次输入密码" /></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" onclick="login()" value="登录" />
					<input type="button" onclick="register()" value="注册" />
					<!-- <button type="submit" value="提交按钮">提交</button> -->
					<!-- <button type="reset" value="重置按钮">重置</button> -->
				</td>
			</tr>
		</table>
		<font id="back" color="red"></font>
	</div>
</body>
</html>