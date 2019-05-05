package login.service;


import login.bean.User;
import login.dao.LoginDao;
import net.sf.json.JSONArray;

import java.util.ArrayList;

public class LoginService {

	LoginDao lDao=new LoginDao();//对User表的数据操作
	
	//登录函数
	public boolean login(String username,String password) {
		//1：代表成功 0：代表失败
		System.out.println("12121212121");
		User u=new User();
		u.setUsername(username);
		u.setPassword(password);
		return lDao.queryUserByCondition(u);
	}
	
	//注册函数
	public boolean register(String username,String password,String sex,String hobby) {
		// 1：代表成功 0：代表失败
		System.out.println("hobby"+hobby);
		User u = new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setSex(sex);
		u.setHobby(hobby);
		return lDao.saveUser(u);
	}

	// 查找是否已存在用户名函数
	public boolean register_check(String username) {
		// 1：代表成功 0：代表失败
		User u = new User();
		u.setUsername(username);
		return lDao.queryUserByName(u);
	}
	
	//查找user表中所有数据
	public ArrayList<User> getUserlist() {
		return lDao.getUserList();
	}
	
	//删除user数据
	public boolean deleteuser(int id) {
		return lDao.deleteUserById(id);
	}
	
	//修改user数据
	public boolean changeuser(int id,String username,String password,String sex,String hobby) {
		User u=new User();
		u.setId(id);
		u.setUsername(username);
		u.setPassword(password);
		u.setSex(sex);
		u.setHobby(hobby);
		return lDao.updateUser(u);
	}

	//查找user——按照ID查找
	public ArrayList<User> getuserbyId(int id){
		return lDao.getUserListByID(id);
	}
	
	// 查找user——按照用户名查找
	public ArrayList<User> getuserbyName(String username) {
		return lDao.getProductListByName(username);
	}

	// 查找user——按照ID和用户名查找
	public ArrayList<User> getuserbyIdName(int id, String username) {
		return lDao.getProductListByIDName(id, username);
	}
}
