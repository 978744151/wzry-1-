<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head lang="zh">
    <meta charset="utf-8">
    <title>王者荣耀竞猜小游戏</title>
    <meta http-equiv="Content-Type" content="text-html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no"/>
    <!-- <link rel="shortcut icon" href="{HOME_THEME_PATH}images/base/title.png"> -->
    <meta name="applicable-device" content="pc,mobile"/>

    <!-- 测试 -->
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <META HTTP-EQUIV="expires" CONTENT="0">

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/iscroll.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/zepto.min.js" ></script>
    <script src="${pageContext.request.contextPath}/js/zepto_fx.js" ></script>
    <script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.animate1.0.2.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/resource.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animate.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <!-- <script src="${pageContext.request.contextPath}/js/xs_.js"></script> -->
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>
        var signPackage= "";
        setTimeout( "calldiaoyong()", 500*1 );
        function calldiaoyong(){
            var spanObj = document.getElementById("signPackage");
            if( spanObj == null ){
                setTimeout("calldiaoyong()",500*1);
                return;
            }
            signPackage = document.getElementById("signPackage").innerText;
            calldiaoyong2();
        }

        function calldiaoyong2(){
            var userid = document.getElementById("userId").innerText;
            var token = document.getElementById("token").innerText;
            var obj =JSON.parse(signPackage);
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: 'wxa425be4d44210149', // 必填，公众号的唯一标识
                timestamp: obj.timestamp, // 必填，生成签名的时间戳
                nonceStr: obj.noncestr, // 必填，生成签名的随机串
                signature: obj.signature,// 必填，签名，见附录1
                jsApiList: [
                    'checkJsApi',
                    'onMenuShareTimeline',
                    'onMenuShareAppMessage'
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });

            wx.ready(function () {
                wx.onMenuShareTimeline({
                    title: '王者荣耀在线竞猜', // 分享标题
                    link: 'http://gok.tc2stgs.com?shareid='+userid+'&token='+token, // 分享链接,将当前登录用户转为puid,以便于发展下线
                    imgUrl: 'http://gok.tc2stgs.com/images/game_logoshare.jpg', // 分享图标
                    success: function () {
                        // 用户确认分享后执行的回调函数
//                       alert('分享成功');
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
//                        alert('取消分享');
                    }
                });
                wx.onMenuShareAppMessage({
                    title: '王者荣耀在线竞猜', // 分享标题
                    desc: '风靡全国的王者荣耀在线竞猜火爆登场，你目前20位好友与你并肩作战！', // 分享描述
                    link: 'http://gok.tc2stgs.com?shareid='+userid+'&token='+token, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
                    imgUrl: 'http://gok.tc2stgs.com/images/game_logoshare.jpg', // 分享图标
                    type: '', // 分享类型,music、video或link，不填默认为link
                    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                    success: function () {
// 用户确认分享后执行的回调函数
                    },
                    cancel: function () {
// 用户取消分享后执行的回调函数
                    }
                });


                wx.error(function(res){
                    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
                   // alert("errorMSG:"+res);
                });
            });
        }

    </script>
    <script type="text/javascript">
        var bgmusic = '';
        var msgBoxTimer = '';
        var nowMsgnum = 0;
        var msgClock = 2000;
        var msgSpeed = 50;
        var window_Width = document.documentElement.clientWidth;
        var defaultMsg = '为了秉持公平、公正的宗旨，本游戏在线人数数据与腾讯QQ在线人数一致同步！';//默认显示

        function msgBoxFunc(){
            var msgCount = $('.msg_box>span>a').length;
            switch(msgCount){
                case 0 :
                    var html ='<a>'+defaultMsg+'</a>'+'<a>'+defaultMsg+'</a>';
                    $('.msg_box>span').html(html);
                break;
                case 1 :
                    var html = $('.msg_box>span').html();
                    html = html+html;
                    $('.msg_box>span').html(html);
                break;
            }
            nowMsgnum = $('.msg_box>span>a:eq('+nowMsgnum+')').length > 0 ? nowMsgnum : 0;
            var thismsgwidth = $('.msg_box>span>a:eq('+nowMsgnum+')').width();
            var nowMsgleft = parseInt($('.msg_box>span>a:eq('+nowMsgnum+')').css('left'));
            if( nowMsgleft >= -(thismsgwidth)){
                nowMsgleft = nowMsgleft - msgSpeed + 'px';
                $('.msg_box>span>a:eq('+nowMsgnum+')').animate({'left':nowMsgleft},msgClock,'linear');
                if( parseInt(nowMsgleft) + thismsgwidth < window_Width/2  && $('.msg_box>span>a').length > 1 ){
                    var nextMsgnum = $('.msg_box>span>a:eq('+(nowMsgnum+1)+')').length > 0 ? nowMsgnum+1 : 0;
                    var nextMsgleft = parseInt($('.msg_box>span>a:eq('+nextMsgnum+')').css('left'));
                    nextMsgleft = nextMsgleft - msgSpeed + 'px';
                    $('.msg_box>span>a:eq('+nextMsgnum+')').animate({'left':nextMsgleft},msgClock,'linear');
                }
            }else{
                $('.msg_box>span>a:eq('+nowMsgnum+')').stop();
                $('.msg_box>span>a:eq('+nowMsgnum+')').css({'left':'100%'});
                nowMsgnum++;
                msgBoxFunc();
            }

        }
        function page_onload(){
            // novice()
            msgBoxFunc();
            msgBoxTimer = setInterval(function(){
                msgBoxFunc();
            },msgClock);

            //loading
            //initPage();

            if($_GET['page'] && $('#'+$_GET['page']).length > 0){
                navChangeOn($('#'+$_GET['page']));
            }else{
                if($_GET['page']){
                    <%--alert( "${pageContext.request.contextPath}/jsp/"+$_GET['page']+'.jsp?v=2' );--%>
                    $('.indexiframe')[0].src = "${pageContext.request.contextPath}/jsp/"+$_GET['page']+'.jsp?v=2';
                }else{
                    $('.indexiframe')[0].src = '${pageContext.request.contextPath}/jsp/game.jsp?v=1';
                }
            }

            //底部导航栏点击事件
            $('.nav_li').on('click',function(){
                // novice()
                clickAudio();
                navChangeOn($(this));
            });
            //navBTN动画效果
            $('.nav_li').on('touchstart',function(){
                $(this).find('div').css({
                    'width': '26px',
                    'left': '1px',
                    'margin-top': '2px'
                });
            });
            $('.nav_li').on('touchend',function(){
                $(this).find('div').css({
                    'width': '28px',
                    'left': '0px',
                    'margin-top': '0px'
                });
            });
            bgmusic = document.getElementById("bgmusic");
            audioPlay(bgmusic);
            //IOS微信浏览器自动播放
            document.addEventListener("WeixinJSBridgeReady", function () {
                audioPlay(bgmusic);
            }, false);

        }

        function navChangeOn(_self){
            //if(_self.hasClass('on')){
            //    return false;
            //}else{
                var nowOn = $('.nav .on').attr('id');
                $('.nav_li').removeClass('on');
                $('.nav_li').each(function(){
                    var src = $(this).attr('off');
                    $(this).find('img').attr('src',src);
                });
                _self.addClass('on');
                var src = _self.attr('on');
                _self.find('img').attr('src',src);
                var url = _self.attr('url');
                var rand = parseInt(Math.random()*100000);
                $('.indexiframe')[0].src = "/jsp/"+url + '.jsp?v=1';
                if( url == "channel" ) {
                    $('.indexiframe')[0].src = "/"+url + '?v=1';
                }
                var nextOn = _self.attr('id');
                //window.history.pushState(history.length,"message",window.location.href.split('?')[0]+"?page="+nextOn);

            //}
        }
        function setHistory(op){
            var webview = window.frames[0];
            //alert(webview.location.pathname.split('/')[webview.location.pathname.split('/').length-1]);
            var origin = webview.location.origin;
            var pathArr = webview.location.pathname.split('/');
            var path = '';
            for(var i = 0;i < webview.location.pathname.split('/').length-1;i++){
                path += webview.location.pathname.split('/')[i];
            }
            //var url = origin+'/'+path+'/'+op+'.html';
            //webview.history.pushState(webview.history.length+1,"message",url);
            //window.history.pushState(window.history.length+1,"message",window.location.href.split('?')[0]+"?page="+op);
        }
        function navSetOn(op){
            /*
            $('.nav_li').removeClass('on');
            $('.nav_li').each(function(){
                var src = $(this).attr('off');
                $(this).find('img').attr('src',src);
            });
            */
            if($('#'+op).length>0){
                $('.nav_li').removeClass('on');
                $('.nav_li').each(function(){
                    var src = $(this).attr('off');
                    $(this).find('img').attr('src',src);
                });
                $('#'+op).addClass('on');
                var src = $('#'+op).attr('on');
                $('#'+op).find('img').attr('src',src);
            }

        }
        function audioPlay(audio){
            if(audio.paused) {
                audio.play();
            }
        }
        function audioChange(){
            audio = document.getElementById("bgmusic");
            if(audio.paused) {//检验视频是否暂停
                audio.play();
                $('.musicbtn>img:nth-child(2)').hide()
            }else{
                audio.pause();
                $('.musicbtn>img:nth-child(2)').show()

            }
        }
    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <!-- <div class='loadingbox' id='loadingbox'>
        <img src="images/game_logo.png"/>
        <span>LOADING</span>
    </div> -->
    <span style="display: none;" id="signPackage">${signPackage}</span>
    <span style="display: none" id="userId">${userid}</span>
    <span style="display: none" id="token">${token}</span>
    <span style="display: block" id="nickname">${nickname}</span>
    <span style="display: block" id="headimgurl">${headimg}</span>
    <audio id='bgmusic' src="/media/bg.mp3"  loop="loop">
    </audio>
    <audio id='clickAudio' src="/media/click.wav">
    </audio>

    <section class='page_box'>
        <div class='msg_box'>
            <a><img src="${pageContext.request.contextPath}/images/icon_msg.png"/></a>
            <span>
                <!-- <a>欢迎来到王者荣耀，敌军还有30秒到达战场！</a> -->
            </span>
        </div>

    <iframe class='indexiframe' name='indexiframe' src=""></iframe>
        <div class='nav'>
            <div id='game' class='nav_li on' off="${pageContext.request.contextPath}/images/nav_icon_1.png" on="${pageContext.request.contextPath}/images/nav_icon_1_on.png" url='game'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_1_on.png"/>
                </div>
                <span>游戏</span>
            </div>
            <div id='shop' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_2.png" on="${pageContext.request.contextPath}/images/nav_icon_2_on.png" url='shop'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_2.png"/>
                </div>
                <span>商城</span>
            </div>
            <div id='search' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_3.png" on="${pageContext.request.contextPath}/images/nav_icon_3_on.png" url='search'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_3.png"/>
                </div>
                <span>查询</span>
            </div>
            <div id='channel' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_4.png" on="${pageContext.request.contextPath}/images/nav_icon_4_on.png" url='channel'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_4.png"/>
                </div>
                <span>推广</span>
            </div>
            <div id='mine' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_5.png" on="${pageContext.request.contextPath}/images/nav_icon_5_on.png" url='mine'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_5.png"/>
                </div>
                <span>我的</span>
            </div>
        </div>
    </section>






    <!--新手教程页面  -->



    <!--新手页面结束-->


    </body>
<html>