package com.xinli001.smallming.commons.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.core.ParseException;
import freemarker.template.Configuration;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;

public class SpringMailUtil {
	private JavaMailSenderImpl sender;
	private Configuration freemarker;
	public JavaMailSenderImpl getSender() {
		return sender;
	}
	public void setSender(JavaMailSenderImpl sender) {
		this.sender = sender;
	}
	public Configuration getFreemarker() {
		return freemarker;
	}
	public void setFreemarker(Configuration freemarker) {
		this.freemarker = freemarker;
	}
	
	public  String send(String toUser,String subject,int minutes) throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException, MessagingException, TemplateException{
		MimeMessage mime = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mime, true,"UTF-8");
		helper.setFrom("jxzyyx2@163.com");//发送者的邮箱，必须开启服务
		helper.setTo(toUser);
		helper.setSubject(subject);
		
		Template template = freemarker.getTemplate("mail.ftl");
		Map<String,Object> map = new HashMap<>();
		map.put("user",toUser);
		
		StringBuffer sf = new StringBuffer();
		Random random = new Random();//生成随机数
		for(int i =0 ;i<4;i++){
			sf.append(random.nextInt(10));//追加数组 追加位数为四位
		}
		map.put("validateCode",sf.toString());//对形成的数字进行toString方法，并放为key为validateCode的map数组中
		map.put("minutes", minutes);//设置验证码的有效时间，单位为分钟
		String result = FreeMarkerTemplateUtils.processTemplateIntoString(template, map);//将map数组放入模型文件中，在模型文件中同过map的key的值调取想要的数据
		//第二个参数,表示支持html标签.
		helper.setText(result,true);
		
		sender.send(mime);
		
		return sf.toString();
	}
	
}
