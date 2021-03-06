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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/channel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">
        var channelContentiScroll = '';
        function page_onload(){
            //initPage();
            channelContentiScroll = new IScroll('.page_body',{
                mouseWheel:true,
                scrollbars:false,
                bounce:false,
                click:iScrollClick()
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
            <div class='page_content'>
                <div class='channel_qrcode_box'>
                    <span class='channel_qrcode_img'>
                        <%--<img src="/${qrcode_img}" onerror='this.src="${pageContext.request.contextPath}/images/channel_qrcode_errorimg.png"'/>--%>
                        <img src="${qrcode_img}" onerror='this.src="${pageContext.request.contextPath}/images/channel_qrcode_errorimg.png"'/>
                        <%--<img src="${qrcode_img}" onerror='this.src="${pageContext.request.contextPath}/images/channel_qrcode_errorimg.png"'/>--%>
                    </span>
                    <a>点击右上角分享</a>
                    <%--<a>${qrcode_img}</a>--%>
                    <a>给微信或其他好友即可绑定</a>
                </div>
                <div class='channel_table_box'>
                    <table>
                        <tr>
                            <th>层级</th>
                            <th>佣金比例</th>
                            <th width='46%'>说明</th>
                        </tr>
                        <tr>
                            <td>一级用户</td>
                            <td>投注金额x5%</td>
                            <td>直接通过微信或其他渠道成为下级的用户</td>
                        </tr>
                        <tr>
                            <td>二级用户</td>
                            <td>投注金额x3%</td>
                            <td>一级用户通过微信或其他渠道成为下级的用户</td>
                        </tr>
                        <tr>
                            <td>三级用户</td>
                            <td>投注金额x1%</td>
                            <td>二级用户通过微信或其他渠道成为下级的用户</td>
                        </tr>
                    </table>
                </div>
                <div class='channel_text_box'>
                    <p>
                        例如：您邀请30位用户，这些用户各自再邀请30位用户成为您的二级用户，二级用户再各邀请30位用户成为您的三级用户；
                        如每人进行10局10元竞猜游戏，此时您所获取的佣金为： 
                        30人×10局×10元×5%+30²人×10局×10元×3%+30³人×10局×10人×1%=29850元
                        同时可以在“<a>查询</a>”里查看佣金的所有交易记录，
                        点击“<a>我的</a>”→“<a>佣金提现</a>”记录可随时进行提现到帐。
                    </p>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>