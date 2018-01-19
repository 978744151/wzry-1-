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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vip.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">  
        function page_onload(){
            //initPage();

            $('.vip_list>span').on('click',function(){
                var _self = $(this);
                $('.vip_list>span').removeClass('on');
                _self.addClass('on');
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
            <div class='vip_list shop_box' id='VIP'>
                <a>以下所有VIP充值有效期为1个月</a>
                <span class='on'>
                     <div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv1.png"></div>
                     <div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv1.png"></div>
                     <span><b>30</b>元/月</span>
                     <a>赠送20元余额</a>
                     <b>集卡率提高5%</b>
                </span>
                <span>
                     <div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv2.png"></div>
                     <div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv2.png"></div>
                     <span><b>50</b>元/月</span>
                     <a>赠送20元余额</a>
                     <b>集卡率提高10%</b>
                </span>
                <span>
                     <div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv3.png"></div>
                     <div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv3.png"></div>
                     <span><b>100</b>元/月</span>
                     <a>赠送20元余额</a>
                     <b>集卡率提高15%</b>
                </span>
                <span>
                     <div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv4.png"></div>
                     <div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv4.png"></div>
                     <span><b>300</b>元/月</span>
                     <a>赠送20元余额</a>
                     <b>集卡率提高25%</b>
                </span>
                <span>
                     <div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv5.png"></div>
                     <div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv5.png"></div>
                     <span><b>500</b>元/月</span>
                     <a>赠送20元余额</a>
                     <b>集卡率提高50%</b>
                </span>
                
                <div class='clear'></div>
            </div>
        </div>
    

    </div>
    </body>
</html>