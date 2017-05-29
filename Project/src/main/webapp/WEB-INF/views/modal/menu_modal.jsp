<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Modal Structure -->
<%
	if (request.getAttribute("storelist") != null) {
		List<StoreVO> svo = (List<StoreVO>) request.getAttribute("storelist");
		HashMap<Integer, List<MenuVO>> menulist = (HashMap<Integer, List<MenuVO>>) request.getAttribute("menulist");
		List<TypeVO> tvo = (List<TypeVO>) request.getAttribute("typelist");
%>

<%
	for (int i = 0; i < svo.size(); i++) {
			int store_code = svo.get(i).getStore_code();
			List<MenuVO> menu = menulist.get(store_code);
%>
<style>
.modal {
		width:90%;
		height: 100%;
	}
@media only screen and (min-width : 321px) and (max-width : 500px) {
	.modal {
		width:100%;
	}
	
	.modal .type{
		width:80px;
	}
	
	.modal .price{
		width:60px;
	}
}
</style>
<div class="container center-align">
	<div id="<%=store_code%>modal_menu" class="modal">
		<div class="modal-content">
			<h4><%=svo.get(i).getStore_name()%></h4>
			<table class="centered highlight">
				<thead>
					<tr>
						<th>메뉴타입</th>
						<th>메뉴이름</th>
						<th>가격(원)</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int j = 0; j < menu.size(); j++) {
					%>
					<tr>
						<td><%=menu.get(j).getMenu_type()%></td>
						<td><%=menu.get(j).getMenu_name()%></td>
						<td><%=menu.get(j).getMenu_price()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<a href="#!" class="modal-action modal-close btn green floting" style="float:none;">확인</a>
			<a href="#<%=store_code%>modal_menu_re" class="modal-action modal-close btn red floting" style="float:none;">변경</a>
		</div>
	</div>
	
	<div id="<%=store_code%>modal_menu_re" class="modal modal-fixed-footer">
		<div class="modal-content">
			<table class="centered highlight">
				<thead>
					<tr id="<%=svo.get(i).getStore_code()%>">
						<td>
							<select class="browser-default" name="menu_type">
								<option value="" disabled selected>메뉴종류 선택</option>
								<% for(int t=0; t<tvo.size(); t++){ %>
									<option value="<%=tvo.get(t).getType_name()%>"><%=tvo.get(t).getType_name()%></option>
								<%} %>
							</select>
						</td>
						<td><input type="text" id="menu_name" value=""></td>
						<td><input type="text" id="menu_price" value=""></td>
						<td colspan="2"><input type="button" class="btn blue" value="메뉴추가" id="add_menu"></td>
					<tr>
					<tr>
						<th class="type">메뉴타입</th>
						<th>메뉴이름</th>
						<th class="price">가격(원)</th>
						<th>변경</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int j = 0; j < menu.size(); j++) {
					%>
						<tr id="<%=svo.get(i).getStore_code()%>">
							<td>
								<select class="browser-default" name="new_type">
									<% for(int t=0; t<tvo.size(); t++){ %>
										<%if(tvo.get(t).getType_name().equals(menu.get(j).getMenu_type())){ %>
											<option value="<%=tvo.get(t).getType_name()%>" selected><%=tvo.get(t).getType_name()%></option>
										<%}else{ %>
											<option value="<%=tvo.get(t).getType_name()%>"><%=tvo.get(t).getType_name()%></option>
										<%} %>
									<%} %>
								 </select>
							</td>
							<td><input type="text" value="<%=menu.get(j).getMenu_name()%>" name="new_name">
								<input type="hidden" value="<%=menu.get(j).getMenu_name()%>" name="ori_name"></td>
							<td><input type="text" value="<%=menu.get(j).getMenu_price()%>" name="new_price"></td>
							<td><a href="javascript:re_menu" style="color:red"><i class="material-icons" id="re_menu">reply</i></a></td>
							<td><a href="javascript:del_menu" style="color:black"><i class="material-icons" id="del_menu">delete</i></a></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<a href="javascript:close();" class="modal-action modal-close btn green" id="close" style="float:none;">확인</a>
		</div>
	</div>
</div>
<%
	}
	}
%>

<script type="text/javascript">
$(document).ready(function() {
	$('i[id=re_menu]').on('click',function(){
		var icon = $(this);
		var parent = $(this).parents('tr');
		var store_code = parent.attr('id');
		var ori_name = parent.children().next().children('input[name=ori_name]').val()
		var new_type = parent.children().children().val();
		var new_name = parent.children().next().children('input[name=new_name]').val()
		var new_price = parent.children().next().next().children().val();

		$.ajax({
			url : 'remenu.whame',
			type: 'post',
			data : {
					'store_code' : store_code,
					'ori_name' : ori_name,
					'new_type' : new_type,
					'new_name' : new_name,
					'new_price' : new_price
				},
			success : function(result){
					if(result == 1)
						{
							icon.html('done');
							icon.parent().attr('style','color:green');
						}
				}
		});
	})

	$('i[id=del_menu]').on('click',function(){
		var parent = $(this).parents('tr');
		var store_code = parent.attr('id');
		var ori_name = parent.children().next().children('input[name=ori_name]').val()

		$.ajax({
			url : 'delmenu.whame',
			type: 'post',
			data : {
					'store_code' : store_code,
					'ori_name' : ori_name
				},
			success : function(result){
					if(result == 1)
						{
							parent.empty();
						}
				}
		});
		
	})

	$("a[id=close]").on('click',function(){
		$(location).attr('href','store.whame');
	});

	$('input[id=add_menu]').on('click',function(){
		var top = $(this).parents('thead');
		var parent = $(this).parents('tr');
		
		
		var store_code = parent.attr('id');
		var menu_type = parent.children().children().val();
		var menu_name = parent.children().next().children().val();
		var menu_price = parent.children().next().next().children().val();

		var one = "<select class=\"browser-default\" name=\"new_type\"><option value=\""+menu_type+"\" disabled selected>"+menu_type+"</option></select>";
		var two = "<td><input type=\"text\" id=\"menu_name\" value=\""+menu_name+"\"></td>";
		var three = "<td><input type=\"text\" id=\"menu_price\" value=\""+menu_price+"\"></td>";
		var four = "<td><a href=\"javascript:re_menu\" style=\"color:red\"><i class=\"material-icons\" id=\"re_menu\">reply</i></a></td>";
		var five = "<td><a href=\"javascript:del_menu\" style=\"color:black\"><i class=\"material-icons\" id=\"del_menu\">delete</i></a></td>";
		if(menu_type != null && menu_name != '' && menu_price != '' )
		{
			$.ajax({
				url : 'addmenu.whame',
				type: 'post',
				data : {
						'store_code' : store_code,
						'menu_type' : menu_type,
						'menu_name' : menu_name,
						'menu_price' : menu_price
					},
				success : function(result){
						if(result == 1)
							{
								alert('추가완료!');
								top.next().append("<tr><td>"+one+"</td>"+two+three+four+five+"</tr>");
							}
					}
			});
		}else
			{
				alert("정보를 기재 후 추가해주세요");
			}
		
	})
})
</script>