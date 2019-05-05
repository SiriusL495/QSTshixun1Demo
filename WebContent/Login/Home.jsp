<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 1、JQuery的js包 -->
<script type="text/javascript" src="../js/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../easyui/easyui/1.3.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyui/easyui/1.3.4/themes/icon.css">
<script type="text/javascript" src="../easyui/easyui/1.3.4/jquery.min.js"></script>
<script type="text/javascript" src="../easyui/easyui/1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript" >
$(function (){
	//创建datagrid
	$("#show_table").datagrid({//在table表格元素中加载数据网格
		url:'../main',//对应的是servlet最上面的@WebServlet，此处是打开网页时直接加载数据到数据网格中
		columns:[[//数据网格（datagrid）的列（column）的配置对象，field和servlet传回的JSON数据集合中的字段名要一致
			{field:'ck',checkbox:true,width:50},
			{field:'id',title:'id',width:50},
			{field:'username',title:'用户名',width:100},
			{field:'password',title:'密码',width:100},
			{field:'sex',title:'性别',width:100},
			{field:'hobby',title:'爱好',width:100}
		]],
		loadFilter:pagerFilter,//分页过滤器（具体代码在下面的分页过滤器中）
		fitColumns:true,//列自适应宽度，不能和冻结列同时设置为true
        striped:true,//斑马线效果
        idField:'id',//主键列
        striped:true,//是否奇偶行不同效果
        rownumbers:true,//显示行号
        singleSelect:false,//是否单选
        pagination:true,//显示分页栏
        pageList:[10,20,50,100],//每页行数选择列表
        pageSize:10,//初始每页行数
        remoteSort:true,//是否服务器端排序，设成false，才能客户端排序
        //sortName:'id',//设置排序列
        //sortOrder:'desc',//排序方式
        
        toolbar:[{//数据网格（datagrid）面板的头部工具栏
        	text: 'ID：<input class="easyui-textbox" id="sid_s" name="sid_s"> 用户名：<input class="easyui-textbox" id="sname_s" name="sname_s">' 
        	//用jQuery在数据网格的头部工具栏创建一个搜索框，分别是按照ID和按照用户名进行搜索
        }, {
        	iconCls:'icon-search',//头部工具栏的图标选择，图标库在easyui文件夹中
        	text:"查询",//按钮的名字
        	handler:function(){//点击按钮时的处理数据功能
        		var check_id=$("input[name=sid_s]").val();//获取用户输入的ID搜索值
        		var check_name=$("input[name=sname_s]").val();//获取用户输入的name搜索值
        		alert("id="+check_id+",name="+check_name);//test
        		//ajax请求
        		$.ajax({
					url:'../main2?name=check',//ajax请求的url请求地址，对应的是servlet中@WebServlet("/main2")，问号后的name=check是传参
							//name=check传参到servlet中，判断用户的请求是查找数据，调用相应的函数实现功能
					type:'get',//ajax请求数据的方式，两种：一种是get，适合数据少，调试时传值可见，一种是post，适合大数据，但是传值不可见，不便调试，比较安全
					dataType: 'json',//设置数据接收的格式为JSON，因为要将查找到的数据显示在datagrid数据网格中，而在servlet中查找到的数据是转换为JSON格式的
					data:{//需要传到servlet中进行判断的数据，name=check应该也可以放在里面，我没试过
						//这里的格式采用键值对的形式，id相当于key，要将key对应的value值check_id传值到servlet中
						id:check_id,//key:value
						username:check_name
					},
					success:function(json){//json为servlet传回的数据集合（大概是这个意思）
						if(json){//如果查找到数据了，就执行
							$.messager.alert('信息提示','查找成功！','info');
							$("#show_table").datagrid('loadData',json); //用查找到的数据代替原始数据刷新数据表格
						}
						else//如果未查找到数据
						{
							$.messager.alert('信息提示','查找失败！','info');
						}
					}	
				});
            }
        },{
        	iconCls:'icon-search',
        	text:"显示全部",
        	handler:function(){
        		$("#show_table").datagrid('reload');
        		$("input[name=sid_s]").val("");//清空头部工具栏的id搜索框内容
        		$("input[name=sname_s]").val("");//清空头部工具栏的name搜索框内容
        	}
        },{
        	iconCls:'icon-add',
        	text:"新增",
        	handler:function(){
        		//弹出一个对话框进行增加
        		$("#ftitle").find('p').text("添加用户信息");//动态修改弹出框中的表单标题名
        		$("#dlg-buttons").find('a').attr("onclick","saveuser();");//动态设置确认按钮的onclick方法
        		$("#show_table").datagrid("clearSelections");//清空用户所选项
        		$("#dlg").dialog("open").dialog('setTitle', 'New User');//打开弹出框添加用户信息，同时设置弹出框的title
        		$("#fid").hide();//隐藏输入id框，因为id是自动增长，在添加数据的时候不需要填写id
        		//设置弹出框表单初始状态都为空
        		$(" input[ name='AccountName'] ").val("");//清空用户名输入框内容
                $(" input[ name='AccountPwd'] ").val("");//清空密码输入框内容
                $("input[name=sex]:eq(0)").attr("checked",'checked');//设置性别默认选项为男
                $(" input[ name='AccountHobby'] ").val("");//清空爱好输入框内容
                document.getElementById("hidtype").value="submit";//这个我也不知道干啥的=_=
            }
        },{
        	iconCls:'icon-edit',
        	text:"修改",
        	handler:function(){
        		//与添加使用的是同一个弹出框，区别在于修改需要传默认参数
        		var items = $('#show_table').datagrid('getSelections');//获取用户勾选的选项集合，items是个数据集合
        		var ids=[];//用于存储获取的已勾选的用户的id
        		var names=[];//用于存储获取的已勾选的用户的用户名
        		var pwds=[];//用于存储获取的已勾选的用户的密码
        		var sexs=[];//用于存储获取的已勾选的用户的性别
        		var hobbys=[];//用于存储获取的已勾选的用户的爱好
        		for(var i=0; i<items.length; i++){//如果勾选了多个选项，遍历获取各个属性值并存储到对应的数组中
        			ids.push(items[i].id);
        			names.push(items[i].username);
        			pwds.push(items[i].password);
        			sexs.push(items[i].sex);
        			hobbys.push(items[i].hobby);
        		}
        		//因为要判断是否选择多个选项，所以选择getSelections，如果获取的集合长度大于1就是多选，小于1就是未选择，都要出现相应的提示
        		alert("items.length="+items.length+"+items.ids="+ids);//test
        		if(items.length>1){//如果选中多行
        			$.messager.show({title:'提示',msg:'只能选中一条记录进行修改'});
        			$("#show_table").datagrid("clearSelections");//清空所有所选项
        			return;
        		}
        		if(items.length<=0){//如果未选中任何行
        			$.messager.show({title:'提示',msg:'请至少选中一条记录进行修改'});
        		}
        		else{//经过上述判断，此时用户肯定只选择了一项纪录进行修改
        			alert("item.Id"+ids[0]);//test
        			$(" input[ name='AccountId'] ").val(ids[0]);//获取用户勾选的用户的id
        			$(" input[ name='AccountName'] ").val(names[0]);//获取用户勾选的用户的用户名
                    $(" input[ name='AccountPwd'] ").val(pwds[0]);//获取用户勾选的用户的密码
                    $('input[name="sex"]:checked').val(sexs[0]);//获取用户选择的用户的性别
                    $(" input[ name='AccountHobby'] ").val(hobbys[0]);//获取用户选择的用户的爱好
                    $("#fmtitle").find('p').text("修改用户信息");//动态修改弹出框的表单标题
                    $("#dlg-buttons").find('a').attr("onclick","changeuser();");//动态设置弹出框确认按钮的onclick方法
                    $("#dlg").dialog("open").dialog('setTitle', 'Change User');//设置标题栏
                    document.getElementById("hidtype").value="submit";
        		}
            }
        },{
        	iconCls:'icon-remove',
        	text:"删除",
        	handler:function(){
        		var items = $('#show_table').datagrid('getSelections');
        		if(items.length>0)
                {
        			$.messager.confirm('信息提示','确定要删除该产品信息？', function(result){
            			if(result){
            				var ids = [];
            				$(items).each(function(){
            					ids.push(this.id);//将当前选中要删除的id都装在ids的数组中
            				});
            				alert(ids);
            				$.ajax({
            					url:'../main2?name=delete&userid='+ids,
            					data:{
            						userid:ids
            					},
            					success:function(data){
            						if(data){
            							$.messager.alert('信息提示','删除成功！','info');
            							ids=[];//清空id的数组
            							$("#show_table").datagrid('reload'); //刷新数据表格
            						}
            						else
            						{
            							$.messager.alert('信息提示','删除失败！','info');
            						}
            					}	
            				});
            			}	
            		});
                }
        		else
                {
                    $.messager.show({title:'提示',msg:'请至少选中一条记录'});
                }
            }
        }],
	});
	
})


/**
	* Name 分页过滤器（老师的代码，直接搬）
	*/
	function pagerFilter(data){
		if (typeof data.length == 'number' && typeof data.splice == 'function'){// is array                
			data = {                   
				total: data.length,                   
				rows: data               
			}            
		}        
		var dg = $(this);         
		var opts = dg.datagrid('options');          
		var pager = dg.datagrid('getPager');          
		pager.pagination({                
			onSelectPage:function(pageNum, pageSize){                 
				opts.pageNumber = pageNum;                   
				opts.pageSize = pageSize;                
				pager.pagination('refresh',{pageNumber:pageNum,pageSize:pageSize});                  
				dg.datagrid('loadData',data);                
			}          
		});           
		if (!data.originalRows){               
			data.originalRows = (data.rows);       
		}         
		var start = (opts.pageNumber-1)*parseInt(opts.pageSize);          
		var end = start + parseInt(opts.pageSize);        
		data.rows = (data.originalRows.slice(start, end));         
		return data;       
	}

//保存用户信息方法
function saveuser() {
	var AccountName=$("input[name=AccountName]").val();
	var AccountPwd=$("input[name=AccountPwd]").val();
	var sex=getsex();//获取用户性别方法，调用
	var AccountHobby=$("input[name=AccountHobby]").val();
	
	$("#fm").form("submit", {//提交表单数据到后台进行处理
			url : '../main2?name=add&AccountName='+AccountName+'&AccountPwd='+AccountPwd+'&sex='+sex+'&AccountHobby='+AccountHobby,
			type:'get',//ajax请求数据的方式为get
			data:{
				//name:获取的数值，从后往前赋值
				AccountName:AccountName,
				AccountPwd:AccountPwd,
				sex:sex,
				AccountHobby:AccountHobby
			},
			onsubmit : function() {
				return $(this).form("validate");//同样我也不知道干啥的代码~~~
			},
			success : function(data) {
				if (data == "1") {
					$.messager.alert("提示信息", "操作成功");//提示框
					$("#dlg").dialog("close");//关闭表单填写数据的弹出框
					$("#dg").datagrid("load");//这啥
					$("#show_table").datagrid('reload'); //刷新数据表格
				} else {
					$.messager.alert("提示信息", "操作失败");
				}
			}
		});
	}
	
//弹出框中修改用户信息
function changeuser() {
	$("input[name=AccountId]").attr({"readonly":"readonly"});//将input元素设置为readonly,只读
	var AccountId=$("input[name=AccountId]").val();
	var AccountName=$("input[name=AccountName]").val();
	var AccountPwd=$("input[name=AccountPwd]").val();
	var AccountSex=getsex();
	var AccountHobby=$("input[name=AccountHobby]").val();
	alert("id="+AccountId);
	$("#fm").form("submit", {
			url : '../main2?name=change&AccountId='+AccountId+'&AccountName='+AccountName+'&AccountPwd='+AccountPwd+'&AccountSex='+AccountSex+'&AccountHobby='+AccountHobby,
			type:"get",
			data:{
				//name:获取的数值，从后往前赋值
				AccountId:AccountId,
				AccountName:AccountName,  
				AccountPwd:AccountPwd,
				AccountSex:AccountSex,
				AccountHobby:AccountHobby
			},
			onsubmit : function() {
				return $(this).form("validate");
			},
			success : function(data) {
				if (data == "1") {
					$.messager.alert("提示信息", "操作成功");
					$("#dlg").dialog("close");
					$("#show_table").datagrid("clearSelections");//清空所有所选项
					$("#show_table").datagrid('reload'); //刷新数据表格
				} else {
					$.messager.alert("提示信息", "操作失败:产品ID无法修改");
				}
			}
		});
	}
	
function getsex() {//获取性别，（网上的代码，理解就行）
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
</script>
<style type="text/css">
#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}
</style>
</head>
<body>
	<div>
		<table id="show_table" class="easyui-datagrid" title="数据显示">
		</table>
	</div>
	<!-- 弹出dialog -->
	<form id="fm" method="post">
		<div id="dlg" class="easyui-dialog"
			style="width: 400px; height: 300px; padding: 10px 20px;"
			closed="true" buttons="#dlg-buttons">
			<div class="ftitle">添加新用户</div>

			<div class="fitem">
				<label>ID:</label> <input id="AccountId" name="AccountId"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem" id="fid">
				<label>用户名:</label> <input id="AccountName" name="AccountName"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label>密码:</label> <input id="AccountPwd" name="AccountPwd"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label>性别:</label> <input type="radio" name="sex" value="0"
					checked="checked" />男 <input type="radio" name="sex" value="1" />女
				<!-- <input name="AccountSex" class="easyui-validatebox" required="true" />  -->
			</div>
			<div class="fitem">
				<label>爱好:</label> <input name="AccountHobby"
					class="easyui-vlidatebox" required="true" />
			</div>
			<input type="hidden" name="add" id="hidtype" /> <input
				type="hidden" name="ID" id="Nameid" />

		</div>
	</form>
	 	<div id="dlg-buttons"> 
	 	<!-- 此处要设置弹出框中保存和取消按钮的js代码，调用的方法 -->
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveuser()" iconcls="icon-save">保存</a> 
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')"
            iconcls="icon-cancel">取消</a> 
    </div>
    <!-- 弹出dialog代码结束 -->
</body>
</html>