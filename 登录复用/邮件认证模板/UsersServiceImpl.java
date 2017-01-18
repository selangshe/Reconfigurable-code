package com.xinli001.smallming.users.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;

import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import com.opensymphony.xwork2.ActionContext;
import com.xinli001.smallming.commons.util.SpringMailUtil;
import com.xinli001.smallming.users.dao.UsersDao;
import com.xinli001.smallming.users.entity.Users;
import com.xinli001.smallming.users.service.UsersService;

import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;

@Service
public class UsersServiceImpl implements UsersService {
	@Resource
	private UsersDao usersDao;
	@Resource
	private SpringMailUtil mailSender;

	@Override
	public Users selByUsers(Users users) {
		users.setPassword(DigestUtils.md5DigestAsHex(users.getPassword().getBytes()));
		return usersDao.selByUsers(users);
	}

	@Override
	public Long selUsersExist(Users users) throws Exception {
		if (users == null || users.getEmail() == null || users.getEmail().equals("")) {
			return 0L;
		}
		Long index = usersDao.selCountByUsers(users);
		if (index > 0) {// 如果此用户存在调用发邮件的方法
			final Map<String, Object> session = ActionContext.getContext().getSession();//new一个session对象，将数据放入session对象中
			
			new Thread() {//新建一个线程，
				public void run() {
					try {
						String validateCode = mailSender.send(users.getEmail(), "壹心理", 2);//调用发送邮件的有参构造器方法     方法见SpringMailUtil文件
						Map<String, Object> map = new HashMap<>();//new一个map数组对象，将通过send方法获得的return值以key为code的方式放入map集合
						map.put("code", validateCode);
						map.put("time", System.currentTimeMillis());//将当前系统时间放入集合
						session.put("validateCode", map);//将带有数据的map集合放入session中
					} catch (Exception e) {
						e.printStackTrace();
					}
				};
			}.start();
			return 1L;
		} else {
			return 0L;
		}
	}

	@Override
	public boolean selValidate(String validateCode) {
		Object obj = ActionContext.getContext().getSession().get("validateCode");//获得页面用户输入的验证码
		if (obj != null) {
			Map<String, Object> map = (Map<String, Object>) obj;
			if (map.get("code").toString().equals(validateCode)) {
				Long time = (Long) map.get("time");
				if ((System.currentTimeMillis() - time) <= 120000) {//这里的数字不应该写死，这个数字表示是验证码的有效时间，应该从SpringMailUtil文件获得
					return true;
				} else {
					return false;
				}
			}
		}
		return false;
	}

	@Override
	public int updPassword(Users users) {
		users.setPassword(DigestUtils.md5DigestAsHex(users.getPassword().getBytes()));
		return usersDao.updPwdByUsers(users);
	}

}
