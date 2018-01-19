<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head lang="zh">
    <meta charset="utf-8">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no"/>
    <!-- <link rel="shortcut icon" href="{HOME_THEME_PATH}images/base/title.png"> -->
    <meta name="applicable-device" content="pc,mobile"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/iscroll.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cash.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">  
        var verifyTimer = null;
        var verifySecond = 60;
        var nowSecond = 0;
        function page_onload(){
            checkLogin('',function(){
              errorMsg('请登陆后尝试下单');
              setTimeout(function(){
                  top.location.href = '/jsp/login.jsp';
              },500);
            });
            setTimeout(function(){
                if($_user.card_num){
                  $('.card_num').html($_user.card_num);
                }
            },200);
            $('.userinfo>a').on('click',function(){
                var url = '/jsp/cashview.jsp';
                window.location.href = url;
            })
            //initPage();
            $('.back_btn').on('click',function(){
                history.go(-1);
            });
            $('.cash_submit').on('click',function(){
                cashout();
            });
            BindVeriftyBtn();
            <%--setTimeout(function(){--%>
                <%--if($_user.coin){--%>
                  <%--$('.input_box>a>span').html($_user.coin);  --%>
                <%--}--%>
            <%--},200);--%>
        }

        function BindVeriftyBtn(){
            $('.verify_input>a').on('click',function(){
                var phonenum = $('#phonenum').val();
                if(phonenum==''){
                    errorMsg('请填写手机号');
                    return false;
                }
                $.ajax({
                    url:"/trade/vericode",
                    type:'GET',
                    data:{'phone': phonenum},
                    success: function(data){
                        nowSecond = verifySecond;
                        errorMsg('发送成功');
                        $(this).addClass('unclick');
                        $('.verify_input>a').unbind('click');
                        $('.verify_input>a').html('重新发送('+nowSecond+')');    
                        verifyTimer = setInterval(function(){
                            nowSecond--;
                            if( nowSecond <= 0 ){
                                $('.verify_input>a').removeClass('unclick');
                                $('.verify_input>a').html('获取验证码');    
                                BindVeriftyBtn();
                                clearInterval(verifyTimer);
                                verifyTimer = null;
                            }else{
                                $('.verify_input>a').html('重新发送('+nowSecond+')');    
                            }
                        },1000);
                    },
                    error: function(e){
                        errorMsg('网络错误,请稍后再试');
                    }
                });
            })
        }
        function cashout(){
            var name = $('#name').val();
            var phonenum = $('#phonenum').val();
            var idcard = $('#idcard').val();
            var cardnum = $('#cardnum').val();
            //var price = $('#price').val();
            //if(price=='') {errorMsg('请填写提现金额');return false;}
            if(name=='') {errorMsg('请填写真实姓名');return false;}
            if(idcard=='') {errorMsg('请填写身份证号');return false;}
            if(cardnum=='') {errorMsg('请填写银行卡号');return false;}
            if(phonenum=='') {errorMsg('请填写手机号');return false;}
            if(verify=='') {errorMsg('请填写验证码');return false;}
            //AJAX
            /*$.ajax({
                    url:"/cashout/cashoutaction",
                    type:'GET',
                    data:{'cardnum': cardnum , 'idcard':idcard ,'name':name , 'price':price},
                    dataType : 'json',
                    success: function(data){
                        errorMsg(data.message);
                    },
                    error: function(e){
                        errorMsg('网络错误,请稍后再试');
                    }
                });*/
            $.ajax({
                url:"/user/bindcard",
                type:'GET',
                data:{'cardnum': cardnum , 'idcard':idcard ,'name':name },
                dataType : 'json',
                success: function(data){
                    if(data.status == 1){
                        errorMsg('绑定成功！');
                        setTimeout(function(){
                            window.location.reload();
                        },600);
                    }else{
                        errorMsg(data.message);
                    }

                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
            });
        }
    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <!-- <div class='loadingbox' id='loadingbox'>
        <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
        <span>LOADING</span>
    </div> -->
    <div class='page_box'>
        <div class='page_bg'>
            <img src="${pageContext.request.contextPath}/images/vip_bg.jpg"/>
        </div>
        <div class='page_body'>
            <div class='cash_box'>
                <%--<div class='input_box'>--%>
                    <%--<span>可提现余额：</span>--%>
                    <%--<a><span></span>元</a>--%>
                <%--</div>--%>
                <div class='input_box'>
                    <span>已绑卡号：</span>
                    <a class='card_num'>未绑定银行卡</a>
                </div><!-- 
                <div class='input_box'>
                    <span>提现金额：</span>
                    <input type="number" id='price' placeholder="请输入提现金额" />
                </div> -->
                <div class='input_box'>
                    <span>真实姓名：</span>
                    <input type="text" id='name' placeholder="请输入真实姓名" />
                </div>
                <div class='input_box'>
                    <span>身份证号码：</span>
                    <input type="text" id='idcard' placeholder="请输入身份证号" />
                </div>
                <div class='input_box'>
                    <span>银行卡号：</span>
                    <input type="number" id='cardnum' placeholder="请输入银行卡号" />
                    <b>注：仅支持储蓄卡</b>
                </div>
                <div class='input_box nomargin'>
                    <span>手机号码：</span>
                    <input type="number" id='phonenum' placeholder="请输入手机号码" />
                </div>
                <div class='input_box verify_input'>
                    <span>验证码：</span>
                    <input type="text" id='verify' placeholder="请输入验证码" />
                    <a>获取验证码</a>
                </div>
                <div class='cash_btn'>
                    <span class='cash_submit'>确认绑定</span>
                    <span class='back_btn'>返回</span>
                </div>
            </div>
        </div>

    </div>
    </body>
</html>