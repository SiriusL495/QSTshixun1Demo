package login.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.service.LoginService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	// 初始化一个service
	// private static final long serialVersionUID=1L;
	LoginService service = new LoginService();

	public void service(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String password_again = request.getParameter("password_again");
		String sex = request.getParameter("sex");
		String hobby = request.getParameter("hobby");

		System.out.println("username:" + username);
		System.out.println("password:" + password);
		System.out.println("password1:" + password_again);

//			if(!(password.equals(password_again))) {
//				response.getWriter().print("2");
//				return;
//			}

		boolean m = service.register_check(username);// 查找是否已存在用户
		if (m) {
			response.getWriter().print("0");
			return;
		}
		System.out.println("pxy");

		boolean i = service.register(username, password, sex, hobby);// 注册新用户
		// 用户名为111,密码为111
		if (i) {
			if (password.equals(password_again)) {// 判断重复输入密码是否正确
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
}
