<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css"><!--
    <link rel="stylesheet" href="css/imageflow.css"> -->
    <script src='${pageContext.request.contextPath}/js/numberAnimate.js'></script><!--
    <script src='js/imageflow.js'></script> -->
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">
        function page_onload(){
            initPage();


            //切换栏目按钮事件
            $('.search_nav>span').on('click',function(){
                var _self = $(this);
                if(_self.hasClass('on')){
                    return false;
                }else{
                    $('.search_nav>span').removeClass('on');
                    var show_box = _self.attr('name');
                    $('.search_content>div').removeClass('on');
                    $('#'+show_box).addClass('on');
                    _self.addClass('on');
                    initnumber();
                }
            });
        }
    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <div class='loadingbox' id='loadingbox'>
        <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
        <span>LOADING</span>
    </div>
    <div class='page_box'>
        <div class='page_bg'>
            <img src="${pageContext.request.contextPath}/images/bg.jpg"/>
        </div>
        <div class='page_body'>
            <div class='search_nav'>
                <span name='PAY' class='on'>充值</span>
                <span name='CASH'>提现</span>
                <span name='CHARGES'>佣金</span>
                <span name='ORDER'>竞猜</span>
            </div>
            <div class='search_content'>
                <div id='PAY' class='on'>
                    <table>
                        <tr>
                            <th>日期</th>
                            <th>充值金额</th>
                            <th>状态</th>
                        </tr>
                        <tr>
                            <td>10/20 17:00</td>
                            <td>￥100</td>
                            <td>成功</td>
                        </tr>
                    </table>
                </div>
            </div>
            

        </div>
    </div>
    </body>
</html>