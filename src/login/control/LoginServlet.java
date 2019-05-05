package login.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.service.LoginService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	//初始化一个service
	//private static final long serialVersionUID=1L;
	LoginService service=new LoginService();
	public void service(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String password_again=request.getParameter("password_again");
				
		System.out.println("username:"+username);
		System.out.println("password:"+password);
		System.out.println("password111:"+password_again);
		
//		if(!(password.equals(password_again))) {
//			response.getWriter().print("2");
//			return;
//		} 
		
		boolean i=service.login(username,password);
		//用户名为111,密码为111
		if(password.equals(password_again)) {
			if(i) {//判断重复输入密码是否正确
				//成功的处理逻辑
				response.getWriter().print("1");
				System.out.println("cg");
			}else {
				response.getWriter().print("0");
				System.out.println("奇奇怪怪");
			}
		}else {
			//失败的处理逻辑
			response.getWriter().print("2");
			System.out.println("密码不正确");
		}
					
	}
}
