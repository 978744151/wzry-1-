<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">
        var verifyTimer = null;
        var verifySecond = 60;
        var nowSecond = 0;
        var errmsg="${message}";
        function returnIndexPage(){
            window.location.href = 'index.jsp';
        }
        function page_onload(){
            if(errmsg){
                errorMsg(errmsg);
            }
            //initPage();
            if($_GET['page'] && $('.'+$_GET['page']+'_box').length > 0){
                $('.'+$_GET['page']+'_box').show();
            }else{
                $('.login_box').show();
            }
            $('.login_reg').on('click',function(){
                $('.view_box').hide();
                $('.regist_box').show();
            });
            $('.login_forget').on('click',function(){
                $('.view_box').hide();
                $('.forget_box').show();
            });
            $('.login_index').on('click',function(){
                returnIndexPage();
            });
            $('.close_btn').on('click',function(){
                returnIndexPage();
            });
            $('.login_submit>span').on('click',function(){
                login();
            });
            $('.regist_submit>span').on('click',function(){
                regist();
            });
            $('.forget_submit>span').on('click',function(){
                forget();
            });
            BindVeriftyBtn();
        }
        function login(){
            var phonenum = $('#login_phonenum').val();
            //var verify = $('#login_verify').val();
            var password = $('#login_password').val();
            if(phonenum==''){
                errorMsg('请填写手机号');
                return false;
            }
            if(password==''){
                errorMsg('请填写密码');
                return false;
            }
            //form
            $('#login_form').submit();
            //AJAX
            /*$.ajax({
                url:"/login/loginaction",
                type:'GET',
                data:{'phone': phonenum,'pwd':password},
                dataType: 'json',
                success: function(data){
                    alert(data);
                    //returnIndexPage();
                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
            });*/
            //success
            //returnIndexPage();

            //error
            //errorMsg(msg);
        }
        function regist(){
            var phonenum = $('#regist_phonenum').val();
            var verify = $('#regist_verify').val();
            var password = $('#regist_password').val();
            if(phonenum==''){
                errorMsg('请填写手机号');
                return false;
            }
            if(verify==''){
                errorMsg('请填写验证码');
                return false;
            }
            if(password==''){
                errorMsg('请填写密码');
                return false;
            }
            //AJAX
             // alert(password);
            $.ajax({
                url:"/login/regphone",
                type:'POST',
                data:{'phone': phonenum,'pwd':password,'vericode':verify},
                dataType: 'json',
                success: function(data){
                    if(data.status==0){
                        errorMsg(data.message);
                    }else{
                        returnIndexPage();
                    }
                    //returnIndexPage();
                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
            });
        }
        function forget(){
            var phonenum = $('#forget_phonenum').val();
            var verify = $('#forget_verify').val();
            var password = $('#forget_password').val();
            if(phonenum==''){
                errorMsg('请填写手机号');
                return false;
            }
            if(verify==''){
                errorMsg('请填写验证码');
                return false;
            }
            if(password==''){
                errorMsg('请填写新密码');
                return false;
            }
            //AJAX

            //success
            //returnIndexPage();

            //error
            //errorMsg(msg);
        }
        function BindVeriftyBtn(){
            $('.verify_input>b>a').on('click',function(){
                var phonenum = $(this).parent().parent().parent().find('[name="phone"]').val();
                if(phonenum==''){
                    errorMsg('请填写手机号');
                    return false;
                }
                $.ajax({
                    url:"/trade/vericode",
                    type:'get',
                    data:{'phone': phonenum},
                    success: function(data){
                        nowSecond = verifySecond;
                        errorMsg('发送成功');
                        $(this).addClass('unclick');
                        $('.verify_input>b>a').unbind('click');
                        $('.verify_input>b>a').html('重新发送('+nowSecond+')');
                        verifyTimer = setInterval(function(){
                            nowSecond--;
                            if( nowSecond <= 0 ){
                                $('.verify_input>b>a').removeClass('unclick');
                                $('.verify_input>b>a').html('获取验证码');
                                BindVeriftyBtn();
                                clearInterval(verifyTimer);
                                verifyTimer = null;
                            }else{
                                $('.verify_input>b>a').html('重新发送('+nowSecond+')');
                            }
                        },1000);
                        //returnIndexPage();
                    },
                    error: function(e){
                        errorMsg('网络错误,请稍后再试');
                    }
                });
                //AJAX

            })
        }
    </script>


    <script>
//         var signPackage= "";
//         setTimeout( "calldiaoyong()", 500*1 );
//         function calldiaoyong(){
//             var spanObj = document.getElementById("signPackage");
//             if( spanObj == null ){
//                 setTimeout("calldiaoyong()",500*1);
//                 return;
//             }
//             signPackage = document.getElementById("signPackage").innerText;
//             calldiaoyong2();
//         }

//         function calldiaoyong2(){
//             var userid = document.getElementById("userId").innerText;
//             var obj =JSON.parse(signPackage);
//             alert(obj);
//             wx.config({
//                 debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
//                 appId: 'wxa425be4d44210149', // 必填，公众号的唯一标识
//                 timestamp: obj.timestamp, // 必填，生成签名的时间戳
//                 nonceStr: obj.noncestr, // 必填，生成签名的随机串
//                 signature: obj.signature,// 必填，签名，见附录1
//                 jsApiList: [
//                     'checkJsApi',
//                     'onMenuShareTimeline',
//                     'onMenuShareAppMessage'
//                 ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
//             });

//             wx.ready(function () {
//                 wx.onMenuShareTimeline({
//                     title: '王者荣耀在线竞猜', // 分享标题
//                     link: 'http://gok.tc2stgs.com?shareid='+userid, // 分享链接,将当前登录用户转为puid,以便于发展下线
//                     imgUrl: 'http://gok.tc2stgs.com/images/game_logoshare.jpg', // 分享图标
//                     success: function () {
//                         // 用户确认分享后执行的回调函数
// //                       alert('分享成功');
//                     },
//                     cancel: function () {
//                         // 用户取消分享后执行的回调函数
// //                        alert('取消分享');
//                     }
//                 });
//                 wx.onMenuShareAppMessage({
//                     title: '王者荣耀在线竞猜', // 分享标题
//                     desc: '风靡全国的王者荣耀在线竞猜火爆登场，你目前20位好友与你并肩作战！', // 分享描述
//                     link: 'http://gok.tc2stgs.com?shareid='+userid, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
//                     imgUrl: 'http://gok.tc2stgs.com/images/game_logoshare.jpg', // 分享图标
//                     type: '', // 分享类型,music、video或link，不填默认为link
//                     dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
//                     success: function () {
// // 用户确认分享后执行的回调函数
//                     },
//                     cancel: function () {
// // 用户取消分享后执行的回调函数
//                     }
//                 });


//                 wx.error(function(res){
//                     // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
//                     // alert("errorMSG:"+res);
//                 });
//             });
//         }

    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <!-- <div class='loadingbox' id='loadingbox'>
        <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
        <span>LOADING</span>
    </div> -->
    <span style="display: none;" id="signPackage">${signPackage}</span>
    <span style="display: none" id="userId">${userid}</span>
    <div class='page_box'>
        <div class='page_bg'>
            <img src="${pageContext.request.contextPath}/images/login_bg.jpg"/>
        </div>

        <div class='page_body'>
            <div class='login_box view_box'>
                <div class='close_btn'>
                    <img src="${pageContext.request.contextPath}/images/login_close_btn.png"/>
                </div>
                <div class='login_logo'>
                    <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
                </div>
                <div class='login_content'>
                    <form id='login_form' method="POST" action="/login/loginaction">
                        <div class='regist_input'>
                            <span>
                                <img src="${pageContext.request.contextPath}/images/icon_phone.png"/>
                            </span>
                            <b>
                                <input value="" type="number" name="phone" id='login_phonenum' placeholder="请输入您的手机号" />
                            </b>
                        </div>
                        <div class='login_input'>
                            <span>
                                <img src="${pageContext.request.contextPath}/images/icon_lock.png"/>
                            </span>
                            <b>
                                <input type="password" name="pwd" id='login_password' placeholder="请输入您的密码" />
                            </b>
                        </div>
                    </form>
                </div>
                <div class='login_submit'>
                    <span>登陆</span>
                </div>
                <div class='login_reg'>
                    <span>还没账号？请先注册</span>
                </div>
                <div class='login_other'>
                    <span class='login_index'>随便逛逛</span>
                    <span class='login_forget'>忘记密码</span>
                </div>
               <!--  <div class='login_third'>
                   <span><b></b>
                       <a>第三方登陆</a>
                   <b></b></span>
                   <div class='clear'></div>
                   <div class='login_third_op'>
                       <span class='login_wx'>
                           <img src="${pageContext.request.contextPath}/images/icon_wechat.png"/>
                       </span>
                       <span class='login_qq'>
                           <img src="${pageContext.request.contextPath}/images/icon_qq.png"/>
                       </span>
                   </div>
               </div> -->
           </div>
           <div class='regist_box view_box'>
                <div class='close_btn'>
                    <img src="${pageContext.request.contextPath}/images/login_close_btn.png"/>
                </div>
                <div class='regist_logo'>
                    <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
                </div>
                <div class='regist_content'>
                    <div class='regist_input'>
                        <span>
                            <img src="${pageContext.request.contextPath}/images/icon_phone.png"/>
                        </span>
                        <b>
                            <input type="num" name="phone" id='regist_phonenum' placeholder="请输入您的手机号" />
                        </b>
                    </div>
                    <div class='regist_input verify_input'>
                        <span>
                            <img src="${pageContext.request.contextPath}/images/icon_verify.png"/>
                        </span>
                        <b>
                            <input type="text" name="verify" id='regist_verify' placeholder="请输入验证码" />
                            <a>获取验证码</a>
                        </b>
                    </div>
                    <div class='regist_input'>
                        <span>
                            <img src="${pageContext.request.contextPath}/images/icon_lock.png"/>
                        </span>
                        <b>
                            <input type="password" name="pwd" id='regist_password' placeholder="请输入您的密码" />
                        </b>
                    </div>
                </div>
                <div class='regist_submit'>
                    <span>注册</span>
                </div>
           </div>

           <div class='forget_box view_box'>
                <div class='close_btn'>
                    <img src="${pageContext.request.contextPath}/images/login_close_btn.png"/>
                </div>
                <div class='forget_logo'>
                    <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
                </div>
                <div class='forget_content'>
                    <div class='forget_input'>
                        <span>
                            <img src="${pageContext.request.contextPath}/images/icon_phone.png"/>
                        </span>
                        <b>
                            <input type="number" name="phone" id='forget_phonenum' placeholder="请输入您的手机号" />
                        </b>
                    </div>
                    <div class='forget_input verify_input'>
                        <span>
                            <img src="${pageContext.request.contextPath}/images/icon_verify.png"/>
                        </span>
                        <b>
                            <input type="text" name="verify" id='forget_verify' placeholder="请输入验证码" />
                            <a>获取验证码</a>
                        </b>
                    </div>
                    <div class='forget_input'>
                        <span>
                            <img src="${pageContext.request.contextPath}/images/icon_lock.png"/>
                        </span>
                        <b>
                            <input type="password" name="pwd" id='forget_password' placeholder="请输入新密码" />
                        </b>
                    </div>
                </div>
                <div class='forget_submit'>
                    <span>设置</span>
                </div>
           </div>
        </div>

    </div>
    </body>
</html>
