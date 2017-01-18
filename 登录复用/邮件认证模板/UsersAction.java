package com.xinli001.smallming.users.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.xinli001.smallming.users.entity.Users;
import com.xinli001.smallming.users.service.UsersService;



@Controller
@Scope("prototype")
@ParentPackage("json-default")
@Namespace("/")
public class UsersAction extends ActionSupport {
	@Resource
	private UsersService usersService;
	
	private Users users;
	
	
	public Users getUsers() {
		return users;
	}


	public void setUsers(Users users) {
		this.users = users;
	}
	private Long result;
	
	public Long getResult() {
		return result;
	}


	public void setResult(Long result) {
		this.result = result;
	}


	@Action(value="login",results={@Result(type="json",params={"root","result"})})
	public String login(){
		Users user = usersService.selByUsers(users);
		if(user!=null){
			result = 1L;
		}else{
			result = 0L;
		}
		return SUCCESS;
	}
	@Action(value="usersExist",results={@Result(type="json",params={"root","result"})})
	public String usersExist(){
		try {
			result = usersService.selUsersExist(users);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	@Action(value="validateExist",results={@Result(type="json",params={"root","result"})})
	public String validateExist(){
		//不提供全局属性?让Action类结构更清晰.
		boolean index = usersService.selValidate(ServletActionContext.getRequest().getParameter("validateCode"));
		if(index){
			result=1L;
		}else{
			result=0L;
		}
		return SUCCESS;
	}
	@Action(value="showUpdatePwd",results=@Result(location="/updatepwd.jsp"))
	public String showUpdatePwd(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("email", request.getParameter("email"));
		return SUCCESS;
	}
	
	@Action(value="updatePassword",results={@Result(type="redirect",location="/login.jsp"),@Result(name="error",type="redirect",location="/updateError.jsp")})
	public String updatePassword(){
		int index = usersService.updPassword(users);
		if(index>0){
			return SUCCESS;
		}else{
			return ERROR;
		}
	}
}
