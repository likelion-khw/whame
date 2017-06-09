<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>


</style>
<div id="coupon1" class="modal center-align modal-fixed-footer">
	<h4>${store.store_name} 이벤트</h4>
		 <label>행사진행상태</label>
		 	<center>
				<select class="browser-default" id="coupon_state" style="width:40%" name="${store.store_code }">
	   				<option>진행중</option>
	   				<option>예정</option>
	 			</select>
			</center>
			<div class="showinfo_coupon modal-content">
			 <c:forEach items="${couponlist}" var="coupon">
				 <div class="row " >
			        <div class="col s12 m12 ">
			          <div class="card blue-grey darken-1 ${store.store_code }coupon_list_div hidemenu" name="${store.store_code }${coupon.state }">
			            <div class="card-content white-text">
			              <span class="card-title">쿠폰이름</span>
			              <p>${coupon.contents}</p>
			            </div>
			            <div class="card-action">
			              <a href="#">${coupon.s_time}</a>
			              <a href="#">${coupon.e_time}</a>
			            </div>
			          </div>
			        </div>
			      </div>
			  </c:forEach> 
		</div>
		<div class="modal-footer">
			<a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">OK</a>
		</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$('select#coupon_state').each(function(){
		var store_code = $(this).attr('name');
		selectState = $(this).val();
		$('div[class='+store_code+'coupon_list_div]').addClass('hidemenu');
		if(selectState == '진행중'){
			$('div[name='+store_code+'진행중]').removeClass('hidemenu');
			$('div[name='+store_code+'예정]').addClass('hidemenu');
		}else{
			$('div[name='+store_code+selectState+']').removeClass('hidemenu');
			$('div[name='+store_code+'진행중]').addClass('hidemenu');
		}
	})
	
	$('select#coupon_state').on('change',function(){
		var store_code = $(this).attr('name');
		selectState = $(this).val();
		$('div[class='+store_code+'coupon_list_div]').addClass('hidemenu');
		if(selectState == '진행중'){
			$('div[name='+store_code+'진행중]').removeClass('hidemenu');
			$('div[name='+store_code+'예정]').addClass('hidemenu');
		}else{
			$('div[name='+store_code+selectState+']').removeClass('hidemenu');
			$('div[name='+store_code+'진행중]').addClass('hidemenu');
		}
	})
})


</script>
