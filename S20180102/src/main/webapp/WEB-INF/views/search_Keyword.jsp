<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div {
		box-sizing: border-box;
	}
	.cityImg {
		width: 100%;
		height: 400px;
	}
	.tour {
		padding: 100px 400px 0 400px;
		min-width: 1103px;
	}
	
	#heart{
		width: 30px;
	}
	
	#servImg {
		width: 300px;
		height: 198px;
		display: inline-block;
		position: absolute;
	}
	
	#gimg {
		width: 50px;
		height: 50px;
		border-radius: 25px;
	}
	#tourCard {
		height: 200px;
		width: 85%;
		border: 1px solid lightgray;
		min-width: 937.55px;
	}
	
	.tc_wrap {
		position: absolute;
		left: 730px;
		min-width: 580px;
		max-width: 580px;
	}
	.page-item {
		float:left;
	}
</style>
<script type="text/javascript">

// --------------------------------------------------------------------------  Ordering  : 정렬 
	$(document).ready(function(){
		var order = '${order}';
		$("#selectBox").val(order).attr("selected", "selected");
	});   

	function ordering(value) {
		// Ordering 경로 설정
		var s = location.href;
		s = s.replace('http://localhost:8181/s20180102/','');
		s = s.replace('&order=gservCreDate','');
		s = s.replace('&order=likeIt','');
		s = s.replace('&order=gservPrice','');
		s = s.replace('&order=rvCnt','');
		s = s + "&order="+value;
		// Ordering 실행
		location.href= s;                	
	}
	

// --------------------------------------------------------------------------  좋아요 FUNCTION
	function delLikeIt(gservNo) {
		// 경로 설정
		s = 'delLikeItPro.do?keyword=${keyword}&order=${order}&call=2&currentPage=${currentPage}&gservNo='+gservNo;
		location.href= s;        
	}
	
	function inLikeIt(gservNo) {
		// 경로 설정
		s = 'inLikeItPro.do?keyword=${keyword}&order=${order}&call=2&currentPage=${currentPage}&gservNo='+gservNo;
		location.href= s;        
	}
	

</script>

</head>
<body>

<img class ="cityImg" alt="여행이미지" src="${pageContext.request.contextPath}/items/searchPic1.jpg">
<jsp:include page="filterBar.jsp"></jsp:include>
<div class="tour">
		<!-- ORDER -->
		<select id="selectBox" onchange="ordering(this.value)">
			  <option value="gservCreDate">신상품순</option>
			  <option value="likeIt">인기순</option>
			  <option value="gservPrice">가격순</option>
			  <option value="rvCnt">후기순</option>
		</select>
		<!-- 상품 리스트 -->

		<c:forEach var="list" items="${tcDto }">
		<hr style="min-width:1103px;">
			<li id="tourCard">
							<a href="tour_detail.do?gservNo=${list.gservNo }">
								<img id="servImg" src="${pageContext.request.contextPath}/images/${list.imgSrc }" 
									 onerror="this.src='${pageContext.request.contextPath}/items/imgforError1.png'">
							</a>
							<div class="tc_wrap">
								<div class="author" style="display: inline-block; margin-top: 10px;">
									<a href="author_detail.do?gno=${list.gno }">
										<img id="gimg" alt="프로필사진" src="${pageContext.request.contextPath}/images/${list.gimg }" onerror="this.src='${pageContext.request.contextPath}/items/login.png'">
										<b>${list.nickName }</b></a>
									
								
								</div>
								<c:if test="${list.heart>0 }">
									<img id="heart" src="${pageContext.request.contextPath}/items/redHeart1.png" alt="빨강하트" id='heart' onclick='delLikeIt(${list.gservNo})'>						
								</c:if>
								<c:if test="${list.heart==0 }">
									<img id="heart" src="${pageContext.request.contextPath}/items/heart.png" alt="하양하트" id='heart' onclick='inLikeIt(${list.gservNo})'>						
								</c:if>
							<br>
							
							<div style="display: inline-block;">
								<strong>
								<a href="tour_detail.do?gservNo=${list.gservNo }"
							       style="font-size: 18px; color: black"
								>${list.gservTitle }</a></strong><br>
								${list.gservArea } <br>
								<span style="font-size: 14px; color: gray;">${list.servTag }</span><br>
								
								 <div style="position: absolute; top: 90px; right: 260px; width: 500px">	
									<table style="float:right; margin-right: -270px">
										<tr style="font-size: 20px">
											<td colspan=3 style="text-align: right">							
											<fmt:formatNumber value = "${list.gservPrice }" type="currency" currencySymbol="￦"/>/인<br>
											<td>
										</tr>
										<tr>
											<td colspan=3><hr></td>
										</tr>
										<tr style="margin-top: 20px;">
											<td style="display: inline-block;">
											<img style="width:25px; margin-left:30px" src="${pageContext.request.contextPath}/items/leadTime1.png">
											${list.gservLeadTime }</td>
											<td style="display: inline-block;">
											<img style="width:28px; margin-left:30px" src="${pageContext.request.contextPath}/items/heart1.png">
											${list.likeIt }</td>
											<td style="display: inline-block;">
											<img style="width:35px; margin-left:30px" src="${pageContext.request.contextPath}/items/battery1.png">
											${list.remainSize }</td>									
										</tr>
									</table>
								</div>
								
							
							</div>
						 </div>
			</li>
		</c:forEach>

	<div style="clear: both"></div>
	
	<div class="pagination" style="margin-top: 50px; margin-bottom: 50px;">
		  <ul style="display: inline-block; padding: 0px; margin: auto;">
			<c:if test="${pg.startPage > pg.pageBlock }">
				<li class="page-item"><a class="page-link" href="search_Keyword.do?currentPage=${pg.startPage-pg.pageBlock}&keyword=${keyword}&order=${order}"> 이전 </a></li>
			</c:if>
			<c:forEach var="i" begin="${pg.startPage }" end="${pg.endPage }">
				<li class="page-item"><a class="page-link" href="search_Keyword.do?currentPage=${i}&keyword=${keyword}&order=${order}">${i}</a></li>
			</c:forEach>
			<c:if test="${pg.endPage < pg.totalPage }">
				<li class="page-item"><a class="page-link" href="search_Keyword.do?currentPage=${pg.startPage+pg.pageBlock}&keyword=${keyword}&order=${order}"> 다음 </a></li>
			</c:if>
		  </ul>
	</div>
</div>

<div style="clear: both">
<br>
<br>
<br>
</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>