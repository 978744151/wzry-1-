<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="zh">

    <title></title>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no"/>
    <!-- <link rel="shortcut icon" href="{HOME_THEME_PATH}../images/base/title.png"> -->
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
        function page_onload(){
            //loading
            initPage();
            //底部导航栏点击事件
            $('.nav_li').on('click',function(){
                var _self = $(this);
                if(_self.hasClass('on')){
                    return false;
                }else{
                    $('.nav_li').removeClass('on');
                    $('.nav_li').each(function(){
                        var src = $(this).attr('off');
                        $(this).find('img').attr('src',src);
                    });
                    _self.addClass('on');
                    var src = _self.attr('on');
                    _self.find('img').attr('src',src);
                    var url = _self.attr('url');
                    var random = parseInt(Math.random()*10000000);
                    $('.indexiframe')[0].src = url+'?v='+random;
                }
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

        function audioPlay(audio){
            if(audio.paused) {
                audio.play();
            }
        }
    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <div class='loadingbox' id='loadingbox'>
        <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
        <span>LOADING</span>
    </div>
    <audio id='bgmusic' src="http://fs.w.kugou.com/201711131902/f55833be9650418eef01963ec2547582/G041/M03/0F/0F/CZQEAFY22E6AT1_UACyNtcFtF1c778.mp3">
    </audio>

    <div class='page_box'>
        <iframe class='indexiframe' src="${pageContext.request.contextPath}/jsp/game.jsp"></iframe>
        <div class='nav'>
            <div class='nav_li on' off="${pageContext.request.contextPath}/images/nav_icon_1.png" on="../images/nav_icon_1_on.png" url='game.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_1_on.png"/>
                </div>
                <span>游戏</span>
            </div>
            <div class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_2.png" on="../images/nav_icon_2_on.png" url='order.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_2.png"/>
                </div>
                <span>记录</span>
            </div>
            <div class='nav_li' off="${pageContext.request.contextPath}/images/nav_icon_3.png" on="../images/nav_icon_3_on.png" url='search.jsp'>
                <div class='nav_icon'>
                    <img src="${pageContext.request.contextPath}/images/nav_icon_3.png"/>
                </div>
                <span>查询</span>
            </div>
            <div class='nav_li' off="../images/nav_icon_4.png" on="../images/nav_icon_4_on.png" url='channel.jsp'>
                <div class='nav_icon'>
                    <img src="../images/nav_icon_4.png"/>
                </div>
                <span>代理</span>
            </div>
            <div class='nav_li' off="../images/nav_icon_5.png" on="../images/nav_icon_5_on.png" url='mine.jsp'>
                <div class='nav_icon'>
                    <img src="../images/nav_icon_5.png"/>
                </div>
                <span>我的</span>
            </div>
        </div>
    </div>


    
    </body>
</html>