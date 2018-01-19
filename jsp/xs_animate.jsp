<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head lang="zh">
    <meta charset="utf-8">
    <title></title>
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
    <script type="text/javascript">
        function page_onload(){
            novice()
        }
    </script>

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


    <span style="display: none;" id="signPackage">${signPackage}</span>
    <span style="display: none" id="userId">${userid}</span>
    <span style="display: none" id="token">${token}</span>
 <div id="maskIn1" style="display: none;">
            <span class="mask_guan">跳过 &gt; &gt;</span>
            <div class="mask_first4">
                <i class="mask_hand animated bounce" style="animation-iteration-count:infinite;animation-duration: 2s;"></i>
                <h1 class="animated fadeInDown">第一步</h1>
                <p class="animated fadeInUp">选择场次（精确场或者英雄）</p>
            </div>
            <div  style="overflow: hidden;margin-top: 1%;position: absolute;transform: translateX(-50%);left: 50%;top: 44%;">
                <img src="${pageContext.request.contextPath}/images/new_img2.png" alt="" class="pic_novice1 animated bounceInRight">
            </div>
    <!--         <p class="animated fadeIn">
                欢迎來到微云投，这将是一个全新的体验，跟我一起来赚取您的第一桶金吧！
            </p> -->
            <div style="width: 100%;height:  60px;position:  absolute; bottom: 24%;">
               <button class="mask_next on_c_next"><span class="tada animated" style="animation-iteration-count:infinite;animation-delay: 2s;">下 一 步 &gt;&gt;</span></button>
            </div>

        </div>
        <div id="maskIn2" style="display: none;">
            <span class="mask_guan">跳过 &gt; &gt;</span>
            <div class="mask_first mask_second">
                <h1 class="animated fadeInDown">第二步</h1>
                <p class="animated fadeInUp">选择投注金额,并点击"下注"确认</p>
            </div>

            <img src="${pageContext.request.contextPath}/images/new_img3.png" alt="" class="pic_novice1 pic_novice2 animated bounceInRight">
            <div>
                <button class="mask_next mask_true" style="float: left;margin-left: 10%;"><span class="" style="animation-iteration-count:infinite;animation-delay: 2s;">&lt;&lt; 上一步</span></button>
                <button class="mask_next on_c_next" style="float: right;margin-right: 10%;"><span class="tada animated " style="animation-iteration-count:infinite;animation-delay: 2s;">下一步 &gt;&gt;</span></button>
            </div>
                <i class="mask_hand1 animated bounce" style="animation-iteration-count:infinite;animation-duration: 2s;"></i>
        </div>
        <div id="maskIn3" style="display: none;">
            <span class="mask_guan">跳过 &gt; &gt;</span>
            <i class="mask_hand2 animated bounce" style="animation-iteration-count:infinite;animation-duration: 2s;"></i>
            <div class="mask_first3 mask_third" >
                <h1 class="animated fadeInDown">第三步</h1>
                <p class="animated fadeInUp">根据走势图来判断并选择投注区域</p>
            </div>
            <div style="overflow: hidden;margin-top: 1%;position: absolute;transform: translateX(-50%);left: 50%;top: 57%;">
                <img src="${pageContext.request.contextPath}/images/new_img3.png" alt="" class="pic_novice1 pic_novice3 animated bounceInRight" style="margin: 0 auto;
        ;margin-top: 1%;height:160px;">
                <!--<img src="{:RES}/jinrong/Mobile/Public/images/novice/third_right.png" alt="" class="pic_novice1 pic_novice3 animated bounceInRight" style="float: right;-->
                <!--margin-right: 5%;margin-top: 30%;width:100px;height:100px">-->
            </div>
            <div style="width: 100%;height:  60px;position:  absolute; top: 82%;">
                <button class="mask_next mask_true" style="float: left;margin-left: 10%;"><span class="" style="animation-iteration-count:infinite;animation-delay: 2s;">&lt;&lt; 上一步</span></button>
                <button class="mask_next on_c_next" style="float: right;margin-right: 10%;"><span class="tada animated " style="animation-iteration-count:infinite;animation-delay: 2s;">下一步 &gt;&gt;</span></button>
            </div>
        </div>
        <div id="maskIn4" style="display: none;">
            <i class="mask_hand3 animated bounce" style="animation-iteration-count:infinite;animation-duration: 2s;"></i>
            <span class="mask_guan">跳过 &gt; &gt;</span>
            <div class="mask_first1 mask_fourth">
             <!-- style="position: absolute; top: 30%; left: 8%; text-align: center;" -->
                <h1 class="animated fadeInRight">第四步</h1>
                <p class="animated fadeInLeft">英雄场操作类似于精确场</p>
            </div>
                <img src="${pageContext.request.contextPath}/images/new_img1.png" alt="" class="pic_novice1 pic_novice4 animated bounceInRight" style="z-index: 2;">
            <div  style="width: 100%;height:  60px;position:  absolute; bottom: 8%;">
                <button class="mask_next mask_true" style="float: left;margin-left: 10%;"><span class="" style="animation-iteration-count:infinite;animation-delay: 2s;">&lt;&lt; 上一步</span></button>
                <button class="mask_next on_c_next" style="float: right;margin-right: 10%;"><span class="tada animated " style="animation-iteration-count:infinite;animation-delay: 2s;">立即战斗 &gt;&gt;</span></button>
            </div>
        </div>
    </body>
</html>