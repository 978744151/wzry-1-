<%@ page contentType="text.jsp;charset=UTF-8" language="java" %>
<html>
<head lang="zh">
    <meta charset="utf-8">
    <title></title>
    <meta http-equiv="Content-Type" content="text.jsp; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no"/>
    <!-- <link rel="shortcut icon" href="{HOME_THEME_PATH}images/base/title.png"> -->
    <meta name="applicable-device" content="pc,mobile"/>

    <!-- 测试 -->
    <META HTTP-EQUIV="Cache-Control" CONTENT= "no-cache, must-revalidate"> 

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/iscroll.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css"><!-- 
    <link rel="stylesheet" href="css/imageflow.css"> -->
    <script src='${pageContext.request.contextPath}/js/numberAnimate.js'></script><!-- 
    <script src='js/imageflow.js'></script> -->
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">
        var bgmusic = '';
        var msgBoxTimer = '';
        var nowMsgnum = 0;
        var msgClock = 2000;
        var msgSpeed = 50;
        var window_Width = document.documentElement.clientWidth;
        var defaultMsg = '欢迎来到王者荣耀';//默认显示

        function msgBoxFunc(){
            var msgCount = $('.msg_box>span>a').length;
            switch(msgCount){
                case 0 :
                    var html ='<a>'+defaultMsg+'</a>'+'<a>'+defaultMsg+'</a>';
                    $('.msg_box>span').html(html);
                break;
                case 1 :
                    var html = $('.msg_box>span').jsp();
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
            msgBoxFunc();
            msgBoxTimer = setInterval(function(){
                msgBoxFunc();
            },msgClock);

            //loading
            //initPage();

            if($_GET['page'] && $('#'+$_GET['page']).length > 0){
                navChangeOn($('#'+$_GET['page']));  
            }else{
                $('.indexiframe')[0].src = '${pageContext.request.contextPath}/jsp/game.jsp';
            }

            //底部导航栏点击事件
            $('.nav_li').on('click',function(){
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
                $('.indexiframe')[0].src = url;
                //history.pushState(history.length+1,"message",window.location.href.split('?')[0]+"?page="+nowOn);
            //}
        }
        function audioPlay(audio){
            if(audio.paused) {
                audio.play();
            }
        }
    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <!-- <div class='loadingbox' id='loadingbox'>
        <img src="images/game_logo.png"/>
        <span>LOADING</span>
    </div> -->
    <audio id='bgmusic' src="http://fs.w.kugou.com/201711131902/f55833be9650418eef01963ec2547582/G041/M03/0F/0F/CZQEAFY22E6AT1_UACyNtcFtF1c778.mp3">
    </audio>

    <div class='page_box'>
        <div class='msg_box'>
            <a><img src="${pageContext.request.contextPath}/images/icon_msg.png"/></a>
            <span>
                <!-- <a>欢迎来到王者荣耀，敌军还有30秒到达战场！</a> -->
            </span>
        </div>
        <iframe class='indexiframe' src=""></iframe>
        <div class='nav'>
            <div id='game' class='nav_li on' off="${pageContext.request.contextPath}/images/nav_icon_1.png" on="${pageContext.request.contextPath}/images/nav_icon_1_on.png" url='${pageContext.request.contextPath}/jsp/game.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_1_on.png"/>
                </div>
                <span>游戏</span>
            </div>
            <div id='shop' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_2.png" on="${pageContext.request.contextPath}/images/nav_icon_2_on.png" url='${pageContext.request.contextPath}/jsp/shop.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_2.png"/>
                </div>
                <span>商城</span>
            </div>
            <div id='search' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_3.png" on="${pageContext.request.contextPath}/images/nav_icon_3_on.png" url='${pageContext.request.contextPath}/jsp/search.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_3.png"/>
                </div>
                <span>查询</span>
            </div>
            <div id='channel' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_4.png" on="${pageContext.request.contextPath}/images/nav_icon_4_on.png" url='${pageContext.request.contextPath}/jsp/channel.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_4.png"/>
                </div>
                <span>推广</span>
            </div>
            <div id='mine' class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_5.png" on="${pageContext.request.contextPath}/images/nav_icon_5_on.png" url='${pageContext.request.contextPath}/jsp/mine.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_5.png"/>
                </div>
                <span>我的</span>
            </div>
        </div>
    </div>


    
    </body>
<html>