package com.smallming.action;
@ParentPackage("default")
@Namespace("/")
public class MenuAction extends ActionSupport{
	private MenuService menuService = new MenuServiceImpl();
	private List<Menu> list;
	public List<Menu> getList() {
		return list;
	}
	public void setList(List<Menu> list) {
		this.list = list;
	}
	//这里如果将parent也转换成json对象，因为parent是从零开始的所以在转换的时候会报json异常
	@Action(value="show",results=@Result(type="json",params={"root","list","excludeProperties","\\[\\d+\\]\\.parent"}))
	public String show(){
		list=menuService.selParentId();
		return SUCCESS;
	}
	/**
	*1. 如何设置Struts2中转换为JSON时包含属性和不包含属性
1.1 在xml中配置办法
		<action name="show" class="com.smallming.action.MenuAction" method="show">
			<result type="json">
				<param name="root">list</param>
				<param name="excludeProperties">\[\d+\]\.parent</param>
			</result>
		</action>
1.2 在注解中配置办法    因为java代码中存在转义字符所以使用双斜杠
@Action(value="show",results=@Result(type="json",params={"root","list","excludeProperties","\\[\\d+\\]\\.parent"}))
1.3 includeProperties 设定只包含哪些属性.
1.4 excludeProperties 不包含哪些属性.

	*/
}
