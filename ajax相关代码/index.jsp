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
	//加载菜单内容
	$.post("show",function(data){
		var result="";
		for(var i = 0 ;i<data.length;i++){
			result+="<div class='index_parentmenu_div'>"+data[i].name+"</div>";
			result+="<div style='padding-left:20px;'>";
			for(var j = 0 ;j<data[i].menus.length;j++){
				result+="<span class='index_children_menu'>"+ data[i].menus[j].name+ "</span><br/>";//在这里套上一个无意义的span标签，便于触发点击事件获得属性值				
			}
			result+="</div>";
		}
		$("#index_left_div").html(result);
	});
	//给父菜单绑定点击事情
	$(".index_parentmenu_div").live("click",function(){
		$(this).next().slideToggle(200); //slideToggle(200)为上下切换的出现和隐藏的效果标签，括号中设置的是时间
	});
	
	//给子菜单添加点击事情
	$(".index_children_menu").live("click",function(){//绑定live动态标签
		
		var $menu = $(this);
		var $result = null;
		//i 遍历时的脚标   n 遍历时的元素.   n = 对象[i];  n是DOM对象,需要通过$(n)转换成Jquery对象.
		$.each($("#index_tab_title").children(),function(i,n){
			if($(n).html()==$menu.html()){
				$result = $(n);
			}
		});
		
		if($result==null){
			$(".tab_title_span").css("background","white");
			$("#index_tab_title").append("<span class='tab_title_span' style='border:1px solid black;background-color:red;'>"+$menu.html()+"</span>");
		}else{
			$(".tab_title_span").css("background","white");
			$result.css("background","red");
		}
		$("#idnex_tab_content").html($menu.html()+"的内容");
	});
});
</script>
</head>
<body>
<div id="index_left_div" style="width:300px; height:500px; float:left;border:1px solid black; cursor:default;">

</div>
<div id="index_right_div" style="width:800px;height:500px; float:left;border:1px solid black;">
	<div id="index_tab_title"></div>
	<div id="idnex_tab_content"></div>
</div>
</body>
</html>