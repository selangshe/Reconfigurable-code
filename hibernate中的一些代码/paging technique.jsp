package cn.selangshe.dao.impl;

import java.util.List;

import cn.selangshe.dao.NewsDao;
import cn.selangshe.entity.News;
import cn.selangshe.util.HibernateUtil;

/**
*@author 作者: selangshe
*@date 创建时间：2017年1月9日
*hibernate中的分页效果
*setFirstResult是设置 分页数据的其实位置  pageSize*(pageNumber-1)当pageNumber等于1的时候分页数据从零开始 ，也就是说当前显示的是第一页数据
*setMaxResults(pageSize)表示一页显示的个数，
*/
public class NewsDaoImpl implements NewsDao {

	@Override
	public List<News> selNews(int pageSize, int pageNumber, int id) {
		return HibernateUtil.getSession().createQuery("from News where type.id=?", News.class)
				.setParameter(0, id).setFirstResult(pageSize*(pageNumber-1)).setMaxResults(pageSize).getResultList();
	}

	@Override
	public Long selCount(int id) {
		return (Long) HibernateUtil.getSession().createQuery("select count(*) from News where type.id=?").setParameter(0, id).getSingleResult();
	}

}
