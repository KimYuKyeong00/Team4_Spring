<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/signup.css?after" rel="stylesheet">
<script type="text/javascript">
$(function() {
	$('#pwChk').blur(function() {
		const inputpwChk = $(this).val();
		const inputpw = $('#pw').val();
		const $resultMsg = $('#pwCheckMessage');
		if(inputpw === inputpwChk){
			$resultMsg.html('비밀번호 일치');
			$resultMsg.css('color','green');
		}else{
			$resultMsg.html('비밀번호 불일치');
			$resultMsg.css('color','red');
		}
	})
});
$(function() {
	$('#mailCheckBtn').click(function() {
		const email = $('#userEmail1').val() + $('#userEmail2').val(); 
		console.log('완성된 이메일 : ' + email);
		const checkInput = $('.mailCheckInput') 
		$('input[name=m_email]').attr('value', email)
		$.ajax({
			type : 'get',
			url : '<c:url value ="/mailCheck?email="/>' + email, 
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code =data;
				alert('인증번호가 전송되었습니다.')
			}
		});
	});
});

$(function () {
	$('.mailCheckInput').blur(function () {
		console.log("mailCheck");
		const inputCode = $(this).val();
		const $resultMsg = $('#mailCheckMessage');
		
		if(inputCode === code){
			$resultMsg.html('인증번호 일치');
			$resultMsg.css('color','green');
			$('#mailCheckBtn').attr('disabled',true);
			$('#userEmail1').attr('readonly',true);
			$('#userEmail2').attr('readonly',true);
			$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
	        $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
			$('#signCheckBtn').attr('disabled',false);
		}else{
			$resultMsg.html('인증번호 불일치');
			$resultMsg.css('color','red');
		}
	});
});
</script>
</head>
<body class="signupBody">
<form action="member.signup" method="post" enctype="multipart/form-data">
	<div class="whiteBack">
		<a id="back" onclick="history.go(-1)">◁ 회원가입</a>
		<table id="signupTbl">
			<tr>
				<td colspan="2">
					<input id="signupId" class="signTblInput" name="m_id" placeholder="ID" autocomplete="off" autofocus="autofocus">
					<div id="msg"></div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input id="pw" name="m_pw" class="signTblInput" placeholder="Password" autocomplete="off" maxlength="10">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input id="pwChk" name="m_pwChk" class="signTblInput" placeholder="Password Check" autocomplete="off" type="password">
					<span id="pwCheckMessage"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input name="m_name" class="signTblInput" placeholder="User Name" autocomplete="off">
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="userEmail1" id="userEmail1" placeholder="Email">
					<select name="userEmail2" id="userEmail2" >
						<option>@naver.com</option>
						<option>@daum.net</option>
						<option>@gmail.com</option>
						<option>@hanmail.com</option>
					</select>
					<input type="hidden" name="m_email" value="">
					<br>
					<button type="button" id="mailCheckBtn" >본인인증</button>
					<input class="form-control mailCheckInput" id="mailCheckInput" placeholder="인증번호 6자리"  disabled="disabled" maxlength="6">
					<span id="mailCheckMessage"></span>
				</td>
			</tr>
			<tr>
				<td>
					<div class="fileBox">
						<input class="uploadName" value="Profile Pic" placeholder="Profile Pic">
						<br>
						<label id="phototext" for="m_photo">파일찾기</label>		
						<input id="uploadPhoto" name="m_photo" type="file">
					</div>
				</td>
			</tr>
		</table>
		<table id="signupTblBtn">
			<tr>
				<td align="center" colspan="2">
					<button id="signCheckBtn" class="button btnPush btnRed" disabled="disabled">회원가입하기</button>
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>