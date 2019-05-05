package login.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import login.Util.JDBCUtil;
import login.bean.User;

public class LoginDao {

	//查找是否有用户密码存在,进行登录
	public boolean queryUserByCondition(User user) {
		boolean flag=false;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		// 定义sql
		String sql = "select * from user where username=? And password=?";
		// 获取数据库连接
		Connection conn = JDBCUtil.getConnection();
		System.out.println("queryUserByCondition1111");
		try {
			// 编译sql
			psmt = conn.prepareStatement(sql);
			// 设置参数
			psmt.setString(1, user.getUsername());
			psmt.setString(2, user.getPassword());
			// 执行sql
			rs = psmt.executeQuery();
			// 获取结果集
			flag = rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 最后要关闭连接
			JDBCUtil.close(conn, psmt, rs);
		}
		return flag;

	}
	
	//查找是否有用户名存在
	public boolean queryUserByName(User user) {
		boolean flag=false;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		// 定义sql
		String sql = "select * from user where username=?";
		// 获取数据库连接
		Connection conn = JDBCUtil.getConnection();
		System.out.println("queryUserByName23231111");
		try {
			// 编译sql
			psmt = conn.prepareStatement(sql);
			// 设置参数
			psmt.setString(1, user.getUsername());
			// 执行sql
			rs = psmt.executeQuery();
			// 获取结果集
			flag = rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 最后要关闭连接
			JDBCUtil.close(conn, psmt, rs);
		}
		return flag;

	}
	
	//注册保存用户信息
	public boolean saveUser(User user) {
		//保存用户数据
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int i=-1;
		// 定义sql
		String sql = "insert into user(username,password,sex,hobby) values(?,?,?,?)";
		// 获取数据库连接
		Connection conn = JDBCUtil.getConnection();
		System.out.println("saveUser1111111");
		try {
			// 编译sql
			psmt = conn.prepareStatement(sql);
			// 设置参数
			psmt.setString(1, user.getUsername());
			psmt.setString(2, user.getPassword());
			psmt.setString(3, user.getSex());
			psmt.setString(4, user.getHobby());
			//User user=new User();
			//执行sql
			i = psmt.executeUpdate();
			//获取结果集
//			while (rs.next()){
//			}//u=new User();				u.setId(rs.getInt("id"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 最后要关闭连接
			JDBCUtil.close(conn, psmt, rs);
		}
		return i>0;

	}

	//获取数据库中所有数据
	public ArrayList<User> getUserList() {
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ArrayList<User> userList = new ArrayList<User>();
		// 获取数据库连接
		Connection conn = JDBCUtil.getConnection();
		String sql = "select * from user";
		try {
			// 编译sql
			psmt = conn.prepareStatement(sql);
			// 执行sql
			rs = psmt.executeQuery();// executeUpdate()
			// 获取结果集
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setSex(rs.getString("sex"));
				user.setHobby(rs.getString("hobby"));
				userList.add(user);
			} // u=new User(); u.setId(rs.getInt("id"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 最后要关闭连接
			JDBCUtil.close(conn, psmt, null);
		}
		// System.out.println(user.username);
		return userList;
	}

	//删除数据库中用户信息
		public boolean deleteUserById(int selectId) {
			PreparedStatement psmt = null;
			int i = -1;
			// 定义 ？：占位符
			// 数据库连接
			Connection conn = JDBCUtil.getConnection();
			String sql = "delete from user where id=?";
			try {
				// 编译sql
				psmt = conn.prepareStatement(sql);
				// 设置参数
				psmt.setInt(1, selectId);
				// 执行sql
				i = psmt.executeUpdate();
				// 获取结果集
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 最后要关闭连接
				JDBCUtil.close(conn, psmt, null);
			}
			return i > 0;
		}
	
	//修改用户信息
		public boolean updateUser(User u) {
			PreparedStatement psmt = null;
			int i = -1;
			// 定义 ？：占位符
			// 数据库连接
			Connection conn = JDBCUtil.getConnection();
			String sql = "update user set username = ?,password = ?,sex=?,hobby=? where id = ?";
			try {
				// 编译sql
				psmt = conn.prepareStatement(sql);
				// 设置参数
				psmt.setString(1, u.getUsername());
				psmt.setString(2, u.getPassword());
				// String rr=user.getRole()==1?"管理员":"普通员工";
				psmt.setString(3, u.getSex());
				psmt.setString(4, u.getHobby());
				psmt.setInt(5, u.getId());
				// 执行sql
				i = psmt.executeUpdate();
				// 获取结果集
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 最后要关闭连接
				JDBCUtil.close(conn, psmt, null);
			}
			return i > 0;
		}
	
	// 查找用户信息
	// 模糊查询数据库数据——产品ID
	public ArrayList<User> getUserListByID(int val) {
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ArrayList<User> userList = new ArrayList<User>();
		// 获取数据库连接
		Connection conn = JDBCUtil.getConnection();
		String sql = "select * from user where id like ?";
		try {
			// 编译sql
			psmt = conn.prepareStatement(sql);
			// 设置参数值
			psmt.setString(1, "%" + val + "%");
			// 执行sql
			rs = psmt.executeQuery();// executeUpdate()
			// 获取结果集
			while (rs.next()) {
				User pr = new User();
				pr.setId(rs.getInt("id"));
				pr.setUsername(rs.getString("username"));
				pr.setPassword(rs.getString("password"));
				pr.setSex(rs.getString("sex"));
				pr.setHobby(rs.getString("hobby"));
				userList.add(pr);
			} // u=new User(); u.setId(rs.getInt("id"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 最后要关闭连接
			JDBCUtil.close(conn, psmt, null);
		}
		return userList;
	}

	// 模糊查询数据库数据——产品名称
	public ArrayList<User> getProductListByName(String val) {
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ArrayList<User> userList = new ArrayList<User>();
		// 获取数据库连接
		Connection conn = JDBCUtil.getConnection();
		String sql = "select * from user where username like ?";
		try {
			// 编译sql
			psmt = conn.prepareStatement(sql);
			// 设置参数值
			psmt.setString(1, "%" + val + "%");
			// 执行sql
			rs = psmt.executeQuery();// executeUpdate()
			// 获取结果集
			while (rs.next()) {
				User pr = new User();
				pr.setId(rs.getInt("id"));
				pr.setUsername(rs.getString("username"));
				pr.setPassword(rs.getString("password"));
				pr.setSex(rs.getString("sex"));
				pr.setHobby(rs.getString("hobby"));
				userList.add(pr);
			} // u=new User(); u.setId(rs.getInt("id"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 最后要关闭连接
			JDBCUtil.close(conn, psmt, null);
		}
		// System.out.println(user.username);
		return userList;
	}

	// 模糊查询数据库数据——产品ID和名称
	public ArrayList<User> getProductListByIDName(int val, String val2) {
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ArrayList<User> userList = new ArrayList<User>();
		// 获取数据库连接
		Connection conn = JDBCUtil.getConnection();
		String sql = "select * from user where id like ? and username like ?";
		try {
			// 编译sql
			psmt = conn.prepareStatement(sql);
			// 设置参数值
			psmt.setString(1, "%" + val + "%");
			psmt.setString(2, "%" + val2 + "%");
			// 执行sql
			rs = psmt.executeQuery();// executeUpdate()
			// 获取结果集
			while (rs.next()) {
				User pr = new User();
				pr.setId(rs.getInt("id"));
				pr.setUsername(rs.getString("username"));
				pr.setPassword(rs.getString("password"));
				pr.setSex(rs.getString("sex"));
				pr.setHobby(rs.getString("hobby"));
				userList.add(pr);
			} // u=new User(); u.setId(rs.getInt("id"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 最后要关闭连接
			JDBCUtil.close(conn, psmt, null);
		}
		// System.out.println(user.username);
		return userList;
	}
}
