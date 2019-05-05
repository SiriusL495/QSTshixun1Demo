package login.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.bean.User;
import login.service.LoginService;
import net.sf.json.JSONArray;

@WebServlet("/main2")
public class Main2Servlet extends HttpServlet{
	
	// 初始化一个service，选择调用哪个数据处理
	LoginService service = new LoginService();

	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		// 判断界面发出的是哪个请求信息
		String username = req.getParameter("AccountName");// ""内是name
		String method = req.getParameter("name");//接收前端传来的判断请求的name，增删改查
		System.out.println("add" + method + "1111" + username);//test
		// 判断是否传参了
		if (method == null || method.isEmpty()) {
			throw new RuntimeException("没有传递判断请求");
		}
		// 执行注册/添加数据操作
		if (method.equals("add")) {
			// 查找是否已存在用户
			addUser(req, res);
		}
		// 执行修改操作
		if (method.equals("change")) {
			changeUser(req, res);
		}
		// 执行删除操作
		if (method.equals("delete")) {
			deleteUser(req, res);
		}
		// 执行查找操作
		if (method.equals("check")) {
			checkUser(req, res);
		}
	}

	// 添加用户信息
	public void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("addUser()...");//test
		//接收前端传回的数据，和前端的data内数据对应，
		String username = request.getParameter("AccountName");// ""内是name
		String password = request.getParameter("AccountPwd");
		String sex = request.getParameter("sex");
		String hobby = request.getParameter("AccountHobby");
		boolean m = service.register_check(username);//调用LoginService的判断是否有用户名重复的函数
		if (m) {//如果用户输入的用户名和数据库中的重复了，就不能执行添加信息的操作
			response.getWriter().print("0");
			return;
		}

		System.out.println("pxy");// test

		// 注册新用户，调用LoginService的添加用户信息函数
		boolean i = service.register(username, password, sex, hobby);
		if (i) {
			// 成功的处理逻辑
			response.getWriter().print("1");
		} else {
			// 失败的处理逻辑
			response.getWriter().print("0");
		}
	}

	// 修改用户信息
	public void changeUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("change()...");
		String id = request.getParameter("AccountId");
		System.out.println("pxyyy" + id);// test
		String name = request.getParameter("AccountName");// ""内是name
		String pwd = request.getParameter("AccountPwd");
		String sex = request.getParameter("AccountSex");
		String hobby = request.getParameter("AccountHobby");
		System.out.println("1" + name + "2" + pwd + "3" + sex + "4" + hobby);
		int ids = Integer.parseInt(id);//强制类型转换
		//此处应该判断修改用户id时是否重复
//					boolean m = service.register_check(productname);
//					if (m) {
//						response.getWriter().print("0");
//						return;
//					}

		System.out.println("pxyyy");// test

		// 更新用户信息
		boolean i = service.changeuser(ids, name, pwd, sex, hobby);
		if (i) {
			// 成功的处理逻辑
			response.getWriter().print("1");
		} else {
			// 失败的处理逻辑
			response.getWriter().print("0");
		}
	}

	public void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("deleteUser()...");
		String[] selectid = request.getParameterValues("userid[]");//前端传回的是用户勾选的id集合，此处接收也要是集合类型
		// int seid=Integer.valueof(selectid);//String转int
		//获取前端传回的需要删除的id集合，for循环一个个调用删除函数删除
		for (int i = 0; i < selectid.length; i++) {
			String m = selectid[i];
			int mm = Integer.parseInt(m);//强制类型转换
			boolean j = service.deleteuser(mm);//调用删除函数，只有删除成功和删除不成功，所以是布尔类型
			if (j) {
				// 成功的处理逻辑
				response.getWriter().print("1");
			} else {
				// 失败的处理逻辑
				response.getWriter().print("0");
			}
		}
	}

	// 查找产品信息
	public void checkUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("checkuser()...");
		String id = request.getParameter("id");
		int ids = Integer.parseInt(id);
		String name = request.getParameter("username");// ""内是name
		System.out.println("pxyyyy" + id + "name=" + name);// test

//					boolean m = service.register_check(productname);
//					if (m) {
//						response.getWriter().print("0");
//						return;
//					}
		if (id != null && id != "")// id有数据时
		{
			if (name == null || name == "")// id有数据，name无数据
			{
				System.out.println("通过ID查找");// test
				// 查找产品信息
				ArrayList<User> userList = service.getuserbyId(ids);
				/* 将list集合装换成json对象 */
				JSONArray data = JSONArray.fromObject(userList);
				// 接下来发送数据
				/* 设置编码，防止出现乱码问题 */
				response.setCharacterEncoding("utf-8");
				request.setCharacterEncoding("utf-8");
				/* 得到输出流 */
				PrintWriter respWritter = response.getWriter();
				/* 将JSON格式的对象toString()后发送 */
				respWritter.append(data.toString());
			} else if (id != null || id != "") {// id有数据，name有数据
				System.out.println("通过idname查找");// test
				// 查找产品信息
				ArrayList<User> userList = service.getuserbyIdName(ids, name);
				/* 将list集合装换成json对象 */
				JSONArray data = JSONArray.fromObject(userList);
				// 接下来发送数据
				/* 设置编码，防止出现乱码问题 */
				response.setCharacterEncoding("utf-8");
				request.setCharacterEncoding("utf-8");
				/* 得到输出流 */
				PrintWriter respWritter = response.getWriter();
				/* 将JSON格式的对象toString()后发送 */
				respWritter.append(data.toString());
			}
		} else if (name != null && name != "") {// id无数据，name有数据时
			System.out.println("通过name查找");// test
			// 查找产品信息
			ArrayList<User> userList = service.getuserbyName(name);
			/* 将list集合装换成json对象 */
			JSONArray data = JSONArray.fromObject(userList);
			// 接下来发送数据
			/* 设置编码，防止出现乱码问题 */
			response.setCharacterEncoding("utf-8");
			request.setCharacterEncoding("utf-8");
			/* 得到输出流 */
			PrintWriter respWritter = response.getWriter();
			/* 将JSON格式的对象toString()后发送 */
			respWritter.append(data.toString());
		}

	}

}
