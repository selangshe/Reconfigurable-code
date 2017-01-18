package com.xinli001.smallming.users.dao.impl;

import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.xinli001.smallming.users.dao.UsersDao;
import com.xinli001.smallming.users.entity.Users;

@Repository
public class UsersDaoImpl extends HibernateDaoSupport implements UsersDao{

	@Override
	public Users selByUsers(Users users) {
		try {
			return currentSession().createQuery("from Users where phone=? and password=? or email=? and password=?",Users.class)
					.setParameter(0, users.getEmail()).setParameter(1, users.getPassword()).setParameter(2, users.getEmail()).setParameter(3, users.getPassword())
					.getSingleResult();
		} catch (Exception e) {
//			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Long selCountByUsers(Users users) {
		return (Long) currentSession().createQuery("select count(*) from Users where email=? or phone=?").setParameter(0, users.getEmail()).setParameter(1, users.getEmail()).getSingleResult();
	}

	@Override
	public int updPwdByUsers(Users users) {
		return currentSession().createQuery("update Users set password=? where email=?").setParameter(0, users.getPassword()).setParameter(1, users.getEmail()).executeUpdate();
	}

}
