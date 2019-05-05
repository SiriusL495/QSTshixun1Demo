package login.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.bean.User;
import login.service.LoginService;
import net.sf.json.JSONArray;

@WebServlet("/main")
public class MainServlet extends HttpServlet{
	//初始化一个service
	LoginService service = new LoginService();
	
//	//初始化界面
//	public void init(HttpServletRequest req, HttpServletResponse res) throws ServletException {
//		
//	}
	public void service(HttpServletRequest req, HttpServletResponse res) 
	throws ServletException, IOException {
		
		try {
			ArrayList<User> u=service.getUserlist();
			/*将list集合装换成json对象*/
			JSONArray data = JSONArray.fromObject(u);
			//接下来发送数据
			/*设置编码，防止出现乱码问题*/
			res.setCharacterEncoding("utf-8");
			req.setCharacterEncoding("utf-8");
			/*得到输出流*/
			PrintWriter respWritter = res.getWriter();
			/*将JSON格式的对象toString()后发送*/
			respWritter.append(data.toString());
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//判断界面发出的是哪个请求信息
//		String username = req.getParameter("un");//""内是name
//		String method=req.getParameter("name");
//		System.out.println("name"+method+"1111"+username);
//		//判断是否传参了
//		if(method==null || method.isEmpty()){
//			throw new RuntimeException("没有传递method参数");
//		}
//		//执行注册消息
//		if(method.equals("add")){
//			// 查找是否已存在用户
//			addUser(req,res);
//		}
//		//执行修改操作
//		if(method.equals("change")){
//			changeUser(req,res);
//		}
	}

	public void addUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		System.out.println("addUser()...");
		String username = request.getParameter("un");//""内是name
		String password = request.getParameter("pwd");
		String password_again = request.getParameter("pwd_again");
		String sex = request.getParameter("sex");
		String hobby = request.getParameter("hob");
		boolean m = service.register_check(username);
		if (m) {
			response.getWriter().print("0");
			return;
		}
		
		System.out.println("pxy");//test
		
		// 注册新用户
		boolean i = service.register(username, password, sex, hobby);
		// 用户名为111,密码为111
		if (i) {
			// 判断重复输入密码是否正确
			if (password.equals(password_again)) {
				// 成功的处理逻辑
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}
		} else {
			// 失败的处理逻辑
			response.getWriter().print("0");
		}
	}
	
	public void changeUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		System.out.println("change()...");
	}
}
