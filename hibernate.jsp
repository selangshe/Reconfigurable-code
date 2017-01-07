<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
<script type="text/javascript">
$(function(){
	$.post("show",function(data){//通过post的方式发送数据，调用show方法，并产生回调函数将结果放入到data中。
		var result="";//声明一个属性名，存放数据
		for (var i = 0; i < data.length; i++) {//遍历list数组，将得到的数据以表格形式打印出来
			result+="<tr>";
			result+="<td>"+data[i].cpu+"</td>"
			result+="<td>"+data[i].harddisk+"</td>"
			result+="<td>"+data[i].member+"</td>"
			result+="<td><a class='delete_a' href='"+data[i].id+"'>删除</a> </td>"
			result+="</tr>";
		}
		$("#mytbody").html(result);//并发送到mytbody中进行显示。
	});
	//动态绑定事件 对象.live("事件名",function(){执行功能});
	//无法元素什么时候添加进来都能绑定上指定事件.
	$(".delete_a").live("click",function(){
		if(confirm("确定要删除吗?")){
			var $aEle = $(this);//ajax中不能通过$(this)的方式调用点击事件的标签。
			$.post("delete",{"computer.id":$aEle.attr("href")},function(data){//将从删除标签得到的id传给computer.id，在后台通过属性调用获得id，并传给delete方法
				if(data==1){//这里接受的是一个int类型的回调函数，所以后台中应该使用(type="json",params={"root","msg"})便于判断
				/**
				*private Integer msg;

	public Integer getMsg() {
	return msg;
}

public void setMsg(Integer msg) {
	this.msg = msg;
}

	@Action(value = "delete", results = @Result(type="json",params={"root","msg"}))
	public String delById(Computer computer) {
		try {
			computerservice.delById(computer);
			msg=1;
		} catch (Exception e) {
			msg = 0 ;
			e.printStackTrace();
		}		
		return SUCCESS;
	}
				*/
					$aEle.parent().parent().remove();//通过超级链接标签，调用parent()寻找它的父类<tr>并删除标签。
				}else{
					alert("删除失败");
				}
			});
		}
		return false;
	});
});
</script>
</head>
<body>
	<table border="1">
		<tr>
			<td>CPU型号</td>
			<td>硬盘大小</td>
			<td>内存大小</td>
			<td>操作</td>
		</tr>
		<tbody id="mytbody">
			
		</tbody>
	</table>
	在第一次的hibernate练习中，犯了一个严重的错误。使用hibernate首先要建立数据库表与代码的关系，
	第一步：在entity包中建立一个与实体类同名的*.hbm.xml文件
	<!--
	<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC 
    "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
    "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">  DTD文件
<hibernate-mapping>
	<class name="com.smallming.entity.Computer">    class中的name必须指向实体类对应的位置
		<id name="id">                               主键必须设置
			<generator class="sequence">
				<param name="sequence_name">seq_computer</param>
			</generator>
		</id>
		<property name="cpu"></property>             这里设置的属性名必须和数据库表中的列名对应，不能出错
		<property name="harddisk"></property>
		<property name="member"></property>
	</class>
</hibernate-mapping>
-->
    第二步：在scr文件下建立一个hibernate.cfg.xml的配置文件
	<!--
	<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-configuration PUBLIC
	"-//Hibernate/Hibernate Configuration DTD 3.0//EN"
	"http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">   DTD文件
<hibernate-configuration>
	<session-factory>
		<property name="connection.driver_class">oracle.jdbc.driver.OracleDriver</property>   数据库驱动
		<property name="connection.url">jdbc:oracle:thin:@localhost:1521:orcl</property>      数据库连接地址
		<property name="connection.username">scott</property>								  数据库用户名
		<property name="connection.password">tiger</property>								  密码
		<property name="dialect">org.hibernate.dialect.Oracle10gDialect</property>			  方言，就是数据库版本
		<property name="show_sql">true</property>                   输出sql语句
		<property name="format_sql">true</property>                 在控制台格式化输出sql语句
		<mapping resource="com/smallming/entity/Computer.hbm.xml"/>           最重要 一定要与实体类xml文件对应。
	</session-factory>
</hibernate-configuration>
	-->
</body>
</html>