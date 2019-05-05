<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>主界面</title>
<style type="text/css">
	#show_table th,#show_table td{
		border: 1px solid #151515;
		text-align:left;
	}
	#show_table{
		border: 1px solid #151515;
		margin:0 auto;
		border-spacing: 0px;
	}
	body{
		text-align:center;
	}
	#but{
		width:100%;
		margin-top:50px;
		margin-left:0px auto;
		margin-right:0px auto;
	}
	#add_table{
		margin:0 auto;
		text-align:left;
		border-spacing: 10px;
	}
	#table{
		margin-top:20px;
	}
</style>
<!-- 1、JQuery的js包 -->
<script type="text/javascript" src="../js/jquery-1.8.0.min.js"></script>
<!-- 2 css资源 -->
<link rel="stylesheet" type="text/css" href="../easyui/easyui/1.3.4/themes/default/easyui.css"/>
<!-- 3、图标资源 -->
<link rel="stylesheet" type="text/css" href="../easyui/easyui/jquery-easyui-1.4.1/themes/icon.css"/>
<!-- 4、easyui的js包 -->
<script type="text/javascript" src="../easyui/easyui/1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyui/easyui/1.3.4/jquery.min.js"></script>
<script type="text/javascript">
	//显示数据库中所有数据到界面
	function show(){
		$.ajax({
			url:"../main",
			type:"get",
			dataType:'json',
			success:function(data){
				showData(data);
			},
			error:function(XMLHttpRequest,textStatus,errorThrown){
				alert('AJAX连接异常');
			}
		});
	}

	//提取数据库中数据，并生成对应行
	function showData(data){
		var str = "";//定义用于拼接的字符串
		for (var i = 0; i < data.length; i++) {
			//拼接表格的行和列
			str = "<tr><td><input type='checkbox' class='SelectSingle' value='del'/></td><td>"+ data[i].id + "</td><td>" + data[i].username + "</td><td>" + data[i].password + "</td><td>" + data[i].sex +"</td><td>" + data[i].hobby +"</td></tr>";
			//追加到table中
			$("#show_table").append(str);
		}
	}
	
	//增加数据
	function add(){
		var b = check();
		if (b) {
			var username=$("#username").val();
			var password=$("#password").val();
			var password_again=$("#password_again").val();
			var sex=getsex();
				/* $("#sex").val(); */
			var hobby=$("#hobby").val();
			var method = $("input:hidden[name='method']").val();
			System.out.println(method);
			
			$.ajax({
				url:"../main",
				type:"get",
				data:{
					username:username,
					password:password,
					password_again:password_again,
					sex:sex,
					hobby:hobby,
					method:method
				},
				success:function(data){
					// 1代表成功 0代表是失败
					if (data == "1") {
						//成功的处理逻辑
						//此处应该更新页面的数据显示
						/* window.location.href = "Login.jsp"; */
					} else if (data == "0") {
						//失败的处理
						alert("用户名已存在");
						var ur = document.getElementById("user_repeat");
						ur.innerHTML = "用户名已存在";
						document.getElementById("back").innerHtml = "用户名已存在";
					} else if (data == "2") {
						//失败的处理
						alert("请确认两次输入的密码一致");
						document.getElementById("back").innerHtml = "两次输入密码不一致";
					} else {
						alert("奇奇怪怪的错误");
						document.getElementById("back").innerHtml = "用户名已存在";
					}
				}
			});
		}
	}
	
	//对全选复选框进行操作
	$(function(){
		$('#SelectAll').click(function(e){
			$('.SelectSingle').prop('checked',this.checked);
		});
		
		$(".SelectSingle").click(function(){
			if(($(".SelectSingle").length)==($(".SelectSingle:checked").length)){
				$("#SelectAll").prop("checked",true);
			}else{
				$("#SelectAll").prop("checked",false);
			}
		});
	});
	
	//用户名、密码是否为空
	function check() {
		var username=$("#username").val();
		var password=$("#password").val();
		var password_again=$("#password_again").val();
		if(username==""){
			$("#username").focus();
			alert("用户名不能为空！");
			return false;
		}
		
		if(password==""){
			$("#password").focus();
			alert("密码不能为空！");
			return false;
		}
		
		if(password_again==""){
			$("#password_again").focus();
			alert("确认密码不能为空！");
			return false;
		}
		
		return true;
	}
	
	//获取性别
	function getsex() {
		var val = "";
		var radio = document.getElementsByName("sex");
		for (var i = 0; i < radio.length; i++) {
			if (radio[i].checked == true) {
				val = radio[i].value;
				break;
			}
		}
		return val;
	}
	
	window.onload =show();//进入该网页直接加载显示数据库中数据
</script>
</head>
<body>
	<div>
		<form method="post" enctype="multipart/form-data">
			<table id="add_table">
				<tr>
					<td><font size="3">用户名:</font></td>
					<td><input id="username" name="un" type="text" autofocus
						placeholder="请输入用户名" /></td>
				</tr>
				<tr>
					<td><font size="3">设置密码:</font></td>
					<td><input id="password" name="pwd" type="password"
						maxlength="20" placeholder="请输入密码" /></td>
				</tr>
				<tr>
					<td></td>
					<td><font size="2" color="#BCBCBC">6-20个字符，由字母、<br />数字和符号的两种以上结合
					</font></td>
				</tr>
				<tr>
					<td><font size="3">确认密码:</font></td>
					<td><input id="password_again" name="pwd_again" type="password"
						placeholder="请再次输入密码" /></td>
				</tr>
				<tr>
					<td><font size="3">您的性别:</font></td>
					<td><input type="radio" name="sex" value="0" checked="checked" />男
						<input type="radio" name="sex" value="1" />女</td>
				</tr>
				<tr>
					<td><font size="3">兴趣爱好：</font></td>
					<td><textarea id="hobby" rows="4" cols="22" name="hob"
							placeholder="请输入您的兴趣爱好"></textarea></td>
				</tr>
				<tr>
					<td><input type="hidden" id="met" name="method" value="add" /> </td>
					<td>
						<button type="submit" title="增加数据" name="method" onClick="add()" value="add">增加数据</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="but">
		<button type="button" title="删除数据" onClick="deletee()" name="method" value="deletee">删除数据</button>
		<button type="button" title="修改数据" onClick="change()" name="method" value="change">修改数据</button>
		<button type="button" title="查找数据" onClick="check()" name="method" value="check">查找数据</button>
	</div>
	<div id="table">
		<table id="show_table">
			<tr>
				<th style="width:10px;"><input id="SelectAll" type="checkbox" /></th>
				<th>ID</th>
				<th>用户名</th>
				<th>密码</th>
				<th>性别</th>
				<th>爱好</th>
			</tr>
		</table>
	</div>
</body>
</html>