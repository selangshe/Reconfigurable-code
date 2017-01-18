<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- saved from url=(0033)http://account.xinli001.com/login -->
<html class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- 1484617150 -->
        <script async="" src="./login_files/analytics.js"></script><script type="text/javascript" id="zhuge-js" async="" src="./login_files/zhuge-lastest.min.js"></script><script>
        var pageName = 'account/login';
        var channel_name = '';
        var channel_id = '';
        var getGeetestUrl = 'http://account.xinli001.com/ajax/get-geetest-code';
        var checkGeetestUrl = 'http://account.xinli001.com/ajax/validate-geetest';
    </script>
    
<!--<base target="_self">--><base href="." target="_self">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=yes">
<title></title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta property="qc:admins" content="21604337436016410016375">
<link rel="stylesheet" href="./login_files/website_32e7a3581c.css"><script>
            var headerAuthUserUrl = "";
    
</script>

<link href="./login_files/default.css" rel="stylesheet" id="lhgdialoglink"><script src="./login_files/website_dabcb36b13.js"></script><!--html5shiv让ie678支持html5，respond_min让ie支持css3 query-->
<!--[if lt IE 9 ]>
  <script src="http://lapp.xinli001.com/jsmin/html5shiv.min.js"></script><script src="http://lapp.xinli001.com/jsmin/respond.min.js"></script><![endif]-->

<script type="text/javascript">
$(function(){
	
	/*
	账号密码登录按钮功能
	*/
	$(".login_submit_a").click(function(){//类选择器
		var isSubmit = true;
		if($("#login_username").val()==""){
			$("#login_username-tip").html("用户名不能为空");
			isSubmit = false;//当用户名为空的时候，在tip标签中添加“用户不能为空的信息”，并将isSubmit设置false 防止表单提交
		}else{
			$("#login_username-tip").html("");//当输入框不为空的时候清空tip标签内容
		}
		if($("#login_password").val()==""){
			$("#login_password-tip").html("密码不能为空");
			isSubmit = false;
		}else{
			$("#login_password-tip").html("");
		}
		
		if(!$("#login_username").val().match(/^\d{11}$/)&&!$("#login_username").val().match(/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/)){
			if($("#login_username-tip").html()==""){//通过正则表达式约束输入的信息
				$("#login_username-tip").html("格式不匹配");
				isSubmit = false;
			}
		}
		
		if(isSubmit){
			//serialize()把表单中数据转换为参数格式
			$.post("login",$("#form2").serialize(),function(data){//将form2中的数据准换为参数形式发送到login的action中
				if(data==1){
					location.href="main.jsp";
				}else{
					$("#login_password-tip").html("账号密码不匹配");
				}
			})
		}
		
		return false;
	});
	
	/*
	获取验证码按钮功能
	*/
	$(".login_validate_a").bind("click",validateBtn);//在获取验证码的按钮上绑定事件
	
	function validateBtn(){
		var  email = true;
		if($("#login_phone").val()==""){
			$("#login_phone-tip").html("手机或邮箱不能为空");
			email = false;
		}else{
			if(email!=false){
				$("#login_phone-tip").html("");//当输入框不为空的时候清除tip中数据
			}
		}
		if(!$("#login_phone").val().match(/^\d{11}$/)&&!$("#login_phone").val().match(/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/)){
			$("#login_phone-tip").html("格式不正确");//输入的信息不符合手机号或者邮箱的时候返回false
			email = false;
		}else{
			if(email!=false){
				$("#login_phone-tip").html("");
			}
		}
		if(email){
			$.post("usersExist",$("#form1").serialize(),function(data){
				if(data==1){
					$("#send_validcode").unbind("click");
					var num = 120;
					var setInter = setInterval(function(){
						$("#send_validcode").html(--num);
						if(num<=0){
							clearInterval(setInter);
							$(".login_validate_a").bind("click",validateBtn);
							$(".login_validate_a").html("获取验证码");
						}
					},1000);
				}else{
					$("#login_phone-tip").html("账号不存在!");
				}
			})
		}
		
		return false;
	}
	
	/**
	判断验证码是否正确

	*/
	var isLoginSuccess = false;
	$("#login_validcode").blur(function(){
		if($(this).val()!=""&&$(this).val().length==4){
			isLoginSuccess = false;
			$.post("validateExist",{"validateCode":$("#login_validcode").val()},function(data){
				if(data==1){
					//location.href="main.jsp";
					isLoginSuccess = true;
				}else{
					$("#login_validcode-tip").html('验证码不正确');	
					isLoginSuccess = false;
				}
			})
		}else{
			$("#login_validcode-tip").html('请输入4为验证码');	
			isLoginSuccess = false;
		}
	});
	
	$(".login_login_a").click(function(){
		if(isLoginSuccess==false){
			return false;
		}else{
			location.href="main.jsp";
		}
	})
});
</script>
</head>
<body><div class="" style="left: 0px; top: 0px; visibility: hidden; position: absolute;"><table class="ui_border"><tbody><tr><td class="ui_lt"></td><td class="ui_t"></td><td class="ui_rt"></td></tr><tr><td class="ui_l"></td><td class="ui_c"><div class="ui_inner"><table class="ui_dialog"><tbody><tr><td colspan="2"><div class="ui_title_bar"><div class="ui_title" unselectable="on" style="cursor: move;"></div><div class="ui_title_buttons"><a class="ui_min" href="javascript:void(0);" title="最小化" style="display: inline-block;"><b class="ui_min_b"></b></a><a class="ui_max" href="javascript:void(0);" title="最大化" style="display: inline-block;"><b class="ui_max_b"></b></a><a class="ui_res" href="javascript:void(0);" title="还原"><b class="ui_res_b"></b><b class="ui_res_t"></b></a><a class="ui_close" href="javascript:void(0);" title="关闭(esc键)" style="display: inline-block;">×</a></div></div></td></tr><tr><td class="ui_icon" style="display: none;"></td><td class="ui_main" style="width: auto; height: auto;"><div class="ui_content" style="padding: 10px;"></div></td></tr><tr><td colspan="2"><div class="ui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="ui_r"></td></tr><tr><td class="ui_lb"></td><td class="ui_b"></td><td class="ui_rb" style="cursor: se-resize;"></td></tr></tbody></table></div>
<div class="login">
    <!-- logo 和 slogen -->
    <div class="logoNslogen">
        <i class="logo"></i>
        <p class="slogen"></p>
    </div>
    <!-- logo 和 slogen -->
    <!-- 登陆框 -->
    <div class="login-box">
        <div class="login-form">
            <div class="head">
                <div class="tabs">
                    <div class="tab js-tab selected">手机验证登录</div>
                    <div class="tab js-tab">账号密码登录</div>
                </div>
            </div>
            <div class="body">
                <div class="tabconts">
                    <div class="tabcont  js-tabcont selected">
                        <form id="form1" method="post" action="#">
                            <div class="input-group">
                                <input type="text" name="users.email" class="input_full" placeholder="11位手机号" id="login_phone">
                                <p class="tip" id="login_phone-tip"></p>
                            </div>
                            <div class="input-group" id="validi">
                                <input type="text" name="validcode" class="input_sm fl" placeholder="6位验证码" id="login_validcode"><!-- 
                                <a id="send_validcode" data-url="http://account.xinli001.com/send-login-validcode" href="javascript:;" class="js-sendPhoneCode inputBtn_sm fr">获取验证码</a> -->
                                
                                <a id="send_validcode"  href="javascript:;" class="login_validate_a inputBtn_sm fr">获取验证码</a>
<!--                                <a style="display: none;" id="checkGeetest" data-url="--><!--" href="javascript:;" class="inputBtn_sm fr" >获取验证码</a>-->
                                <p class="tip fl" id="login_validcode-tip"></p>
                            </div>
                            <div id="popup-captcha"></div>
                            <div class="submit-group">
                                <a class="login_login_a btn_blue" href="javascript:;">登录</a>
                            </div>
                        </form>
                    </div>
                    <div class="tabcont js-tabcont">
                        <form id="form2" method="post" action="login">
                        <div class="input-group">
                            <input type="text" name="users.email" class="input_full" placeholder="手机号/邮箱" id="login_username">
                            <p class="tip" id="login_username-tip"></p>
                        </div>
                        <div class="input-group">
                            <input type="password" name="users.password" class="input_md fl" placeholder="密码" id="login_password">
                            <a href="forgetpwd.jsp" class="inputBtn_sm btn_link fr">忘记密码？</a>
                            <p class="tip fl" id="login_password-tip"></p>
                        </div>
                        <div class="submit-group">
                            <!-- <a type="submit" class="js-submit_accout btn_blue" href="javascript:;">登录</a> -->
                            <a type="submit" class="btn_blue login_submit_a" href="javascript:;">登录122</a>
                        </div>
                        </form>
                    </div>
                </div>
                <div class="thirdParty">
                    <a class="js-showThirdParty" href="javascript:;">第三方登录</a>
                    <div class="thirdParty-cont">
                        <table>
                            <tbody><tr>
                                <td>
                                    <a href="http://account.xinli001.com/oauth/weixin" class="wechat"><i></i>微信</a>
                                </td>
                                <td>
                                    <a href="http://account.xinli001.com/oauth/weibo" class="weibo"><i></i>微博</a>
                                </td>
                                <td>
                                    <a href="http://account.xinli001.com/oauth/qq" class="qq"><i></i>QQ</a>
                                </td>
                            </tr>
                        </tbody></table>
                    </div>
                    <a href="javascript:;" class="js-showThirdParty showThirdParty">
                        <i></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="downloadApp">
            <div class="qrcode">
                <img src="./login_files/68337782.png">
            </div>
            <h1><i class="icon-qrcode"></i>扫码下载壹心理App</h1>
        </div>
    </div>
    <!-- 登陆框 -->

</div>
<script>
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
//document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fd64469e9d7bdbf03af6f074dffe7f9b5' type='text/javascript'%3E%3C/script%3E"));
var _bdurl = unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fd64469e9d7bdbf03af6f074dffe7f9b5' type='text/javascript'%3E%3C/script%3E");
document.write(_bdurl);
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-74218902-1', 'auto');'
ga('send', 'pageview');
</script><script src="./login_files/h.js" type="text/javascript"></script>
<script>
    $(function(){
        //合作方用户引流注册统计
//        $('.thirdParty-cont').find('a').click(function(){
//            if(channel_name != '' && channel_id != '') {
//                zhuge.track('测评_PC渠道_登录数', {'channel_id': channel_id, 'channel_name': channel_name});
//            }
//        });
     });
</script>

</body></html>