<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>ログインページ</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
body {
 background-color   :#fff;
}
h1{
	font-size: 28px;
	margin:8px 20px;
}
p{
    color: #767676;


}
.p2{
	color: #ff0000;
	font-size: 13px;
	text-align:center;
}
.p3{
	margin:2px 77px;
	font-size: 13px;
	font-weight: 700;
	color:#111;
}
.p4{
	color: #ff0000;
	font-size: 13px;
	margin:20px 0px 0px 12px;
}

.errorText{
	color:red;
	font-size:10px;
	text-align:center;
	font-weight:bold;
}


.box {
	border:1px solid;
	border-radius: 8px; /* 半径が8pxの角丸 */
	border-color: #c0c0c0;
	margin       : auto;
	width        : 400px;
	height       : 300px;
	background   : linear-gradient(to bottom, #ffffff, #ffffff);
}
.box2{
	border:1px solid;
	border-radius: 8px; /* 半径が8pxの角丸 */
	border-color: #c0c0c0;
	margin       : auto;
	width        : 400px;
	height       : 480px;
	background   : linear-gradient(to bottom, #ffffff, #ffffff);
}

.btn--white,
a.btn--white {
  color: #000000;
  background-color: #e7e9ec;
  border:1px solid;
	border-radius: 2px; /* 半径が8pxの角丸 */
	border-color: #adb1b8;
	padding:3px 80px;
}
.btn--white:hover,
a.btn--white:hover {
  color: #000000;
  background: #c0c0c0;
}
.btn--orange,
a.btn--orange {
  color: #000000;
  background: linear-gradient(#f7dfa5,#f0c14b);

  border:1px solid;
	border-radius: 2px; /* 半径が8pxの角丸 */
	border-color: #a88734;
	padding:3px 100px;
}
.btn--orange:hover,
a.btn--orange:hover {
  color: #000000;
  background: #f1c85a;
}
.btn--orange2,
a.btn--orange2 {
  color: #000000;
  background: linear-gradient(#f7dfa5,#f0c14b);

  border:1px solid;
	border-radius: 2px; /* 半径が8pxの角丸 */
	border-color: #a88734;
	padding:3px 36px;
	margin:10px 0px;
}
.btn--orange2:hover,
a.btn--orange2:hover {
  color: #000000;
  background: #f1c85a;
}
.btn_position{
	text-align: center;
}
.btn{
	margin:5px 70px;
}


input[type="text"] {
  border: 1px solid #999;
  background-color: #fff;
  width: 250px;
   height:20px;
    margin:0px 0px 6px 70px;
}
input[type="text"]:focus {
  /*border: 1px solid #ff9900;*/
  outline: 0;
}

input[type="password"] {
  border: 1px solid #999;
  background-color: #e7e9ec !important;
   width: 250px;
   height:20px;
   margin:0px 0px 5px 70px;
}
input[type="password"]:focus {
  /*border: 1px solid #ff9900;*/
  outline: 0;
}
</style>

</head>
<body>

<div class="box" id="makeImg">
<h1>ログイン</h1>

	<input type="radio" name="ck01" value="1" checked>求職者
	<input type="radio" name="ck01" value="2">求人者
	<input type="radio" name="ck01" value="2">管理者

<!-- 認証に飛ばす -->
	<form id="loginForm" name="loginForm" method="post" action="loginCheck">

		<p class="p3">メールアドレス</p><input type="text" id="mailCheck" name="mailAddress">
		<div class="errorText" id="mailError"></div>
		<div class="toggle">
			<p class="p3">パスワード</p><input type="password"class="field js-password" id="passCheck" name="passWord" maxlength="20">
			<div class="errorText" id="passError"></div>

			<div class="btn">
	  				<input class="btn-input js-password-toggle" id="eye" type="checkbox">
	  				<label class="btn-label js-password-label" for="eye"><i class="fas fa-eye"></i></label>
	  				パスワードを表示する
			</div>
		</div>
		<div class="btn_position"><input type="button" id="submitBtn" value="ログイン" class="btn btn--orange"></div>
	</form>
<!-- 認証エラーメッセージ取得 -->
<!--<p class="p2">${message}</p>-->
</div>
<div class="btn_position">
<p>--初めて日本jobをご利用ですか--</p>
<a href="registAccount" class="btn btn--white">新規登録画面へ</a>
</div>





<script type="text/javascript">
	var mailTextPattern = /^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}.[A-Za-z0-9]{1,}$/; // メアドの正規表現
	var passPattern=/^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[a-zA-Z0-9]{8,20}$/ // パスワードの正規表現(大文字、小文字、数字を少なくとも一回含める)
	var emptyPattern = /^[ 　\r\n\t]*$/; // スペースなども空白と判定するための正規表現

	$(function(){
		$(".animTarget").hide();

		$("#mailCheck").bind("blur", function() {
			var input_mail = $(this).val();
			check_mail(input_mail);
		});

		$("#passCheck").bind("blur", function() {
			var input_pass = $(this).val();
			check_pass(input_pass);
		});

		$("#submitBtn").on('click',function(){
			var mail = $("#mailCheck").val();
			var pass = $("#passCheck").val();

			var result1 = check_mail(mail);

			var result2 = check_pass(pass);

			if(result1 && result2){
				$("#loginForm").submit();
			}
		});
	});

	function check_mail(str){ // メアドチェック関数
		var _result = true;
		var _textbox = $.trim(str);

		console.log(_textbox);

		if(_textbox.match(emptyPattern)){
			$("#mailError").html("メールアドレスを入力してください");
			_result = false;
		}else if(!_textbox.match(mailTextPattern)){
			$("#mailError").html("正しいメールアドレスの書式ではありません");
			_result = false;
		}else{
			$("#mailError").html("");
		}
		return _result;
	}

	function check_pass(str){ // パスワード関数
		var _result = true;
		var _textbox = $.trim(str);

		console.log(_textbox);

		if(_textbox.match(emptyPattern)){
			$("#passError").html("パスワードを入力してください");
			_result = false;
		}else if(_textbox.length < 8){
			$("#passError").html("パスワードは8文字以上である必要があります");
			_result = false;
		}else if(!_textbox.match(passPattern)){
			$("#passError").html("正しいパスワードの書式ではありません");
			_result = false;
		}else{
			$("#passError").html("");
		}
		return _result;
	}

	//パスワード表示js
	  const passwordToggle = document.querySelector('.js-password-toggle');
	  passwordToggle.addEventListener('change', function () {
	    const password = document.querySelector('.js-password'),
	          passwordLabel = document.querySelector('.js-password-label');
	    if (password.type === 'password') {
	      password.type = 'text';
	      passwordLabel.innerHTML = '<i class="fas fa-eye-slash"></i>';
	    } else {
	      password.type = 'password';
	      passwordLabel.innerHTML = '<i class="fas fa-eye"></i>';
	    }
	    password.focus();
	  });
	</script>



</body>
</html>