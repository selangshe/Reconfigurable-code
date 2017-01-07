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
	
	var pageSize = 2;
	var pageNumber = 1;
	var total = 0 ;
	getMyData();//页面第一次加载时运行是程序。默认每页显示数据为2，起始页为1
	
	//当选按钮点击事件
	$(":radio[name=pageSize]").click(function(){//当触发点击按钮的时候，调用此方法
		pageSize = parseInt($(this).val());//获得此按钮对应的值。并赋予pageSize
		pageNumber = 1;
		getMyData();
	});
	//首页
	$("#firstPage").click(function(){
		pageNumber = 1;
		getMyData();
		return false;
	});
	//上一页
	$("#forwardPage").click(function(){
		pageNumber -= 1;
		if(pageNumber<=0){
			pageNumber = 1;
		}else{
			getMyData();
		}
		return false;
	});
	//尾页
	$("#lastPage").click(function(){
		pageNumber = total;
		getMyData();
		return false;
	});
	//下一页
	$("#nextPage").click(function(){
		pageNumber += 1;
		if(pageNumber>total){
			pageNumber = total;
		}else{
			getMyData();
		}
		return false;
	});
	//跳转到第几页
	$("#goPage").click(function(){
		//prev() 前一个兄弟标签，通过兄弟标签获得<input type="text" size="1"/>中的数据。
		var value = $(this).prev().val().trim();
		if(!isNaN(value)){//判断输入的是否是数字
			var valueInt = parseInt(value);//转换成int类型
			if(valueInt>0&&valueInt<=total){//判断输入的数字是否符合规则
				pageNumber = valueInt;//赋值给pageNumber
				getMyData();
			}else{
				alert("请输入1到"+total+"的数字");
				$(this).prev().val("");//清空输入的数据
			}
		}else{
			alert("请输入数字");
			$(this).prev().val("");
		}
	})
	/*
	根据不同pageSize和pageNumber获取到当前页数据和总页数
	*/
	function getMyData(){//创建获得数据的方法，在重置页面显示个数的和页数的时候，重新调用此方法，获得数据。
		$.post("users_show",{"page.pageSize":pageSize,"page.pageNumber":pageNumber},function(data){
			var result = "";
			for(var i = 0 ;i<data.list.length;i++){//当data中只有一个数据对象时，可以省略数据对象属性名list。此data中返回了两个数据对象：list total.
				result+="<tr>";
				result+="<td>"+data.list[i].id+"</td>";
				result+="<td>"+data.list[i].username+"</td>";
				result+="<td>"+data.list[i].borndate+"</td>";
				result+="</tr>"
			}
			$("#mytbody").html(result);//找到想要传入的对象#mytbody并通过.html()方式将数据传入到对象中。
			total = data.total;
		});
	}
});
</script>
</head>
<body>
            每页个数
	<input type="radio" name="pageSize" value="2" checked="checked"/>2
	<input type="radio" name="pageSize" value="3"/>3
	<input type="radio" name="pageSize" value="4"/>4
	<table border="1">
		<tr>
			<th>编号</th>
			<th>用户名</th>
			<th>出生日期</th>
		</tr>
		<tbody id="mytbody">
		</tbody>
	</table>
	<a href="" id="firstPage">首页</a>
	<a href="" id="forwardPage">上一页</a>
	<a href="" id="nextPage">下一页</a>
	<a href="" id="lastPage">尾页</a>
	跳转到:<input type="text" size="1"/><input id="goPage" type="button" value="确定"/>
</body>
</html>