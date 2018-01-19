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
    <!-- 测试 -->
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <META HTTP-EQUIV="expires" CONTENT="0">

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/iscroll.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mine.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">
    <%--page代表a标签跳转  view代表弹框 op代表get参数--%>
        var mineContentiScroll = '';
        var userinfoTimer = null;
        function getCity(){
            $.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js',function(){
              $('.city>span').html(remote_ip_info.city);
            });
        }
        function showview(view){
            view.fadeIn(100);
            setTimeout(function(){
                refreshAlertIScroll();
            },200);
        }
        function hideview(view){
            view.fadeOut(100);
            //view.animate({'left':'100%'},50);
        }
        function locationview(viewname,page=''){
            window.parent.navSetOn(viewname);
            var url = page!='' ? viewname + '.jsp?page='+page : viewname + '.jsp';
            window.location.href = url;
        }
        function page_onload(){
            checkLogin('',function(){
              errorMsg('请登陆后尝试下单');
              setTimeout(function(){
                  top.location.href = '/jsp/login.jsp';
              },500);
            });
            //initPage();

            userinfoTimer = setInterval(function(){
                if($_user){
                    if($_user != 'error'){
                      $('.headimgbox>img').attr('src',$_user.headimgurl+'0');
                      $('.userinfo>span>a').html($_user.id);
                      if($_user.coin){
                        $('.cashbox>span:eq(0)>a').html($_user.coin);
                      }/*
                      if($_user.coin){
                        $('.cashbox>span:eq(1)>a').html($_user.coin)
                      }*/
                      if($_user.card_num){
                        //alert($_user.card_num);
                        $('.userinfo>a').html('已绑定银行卡');
                      }
                    }
                    clearInterval(userinfoTimer);
                    userinfoTimer = null;
                }
            },200);


            $('.userinfo>a').on('click',function(){
                var url = '/jsp/cashview.jsp';
                window.location.href = url;
            })
            //getCity();
            mineContentiScroll = new IScroll('.page_body',{
                mouseWheel:true,
                scrollbars:false,
                bounce:false,
                click:iScrollClick()
            });
            $('.musicbtn').on('click',function(){
                window.top.audioChange();
                $('.musicbtn>img:nth-child(1)').toggle()

            });
            $('.option_box>div').on('click',function(){
                clickAudio()
                if($(this).attr('view')){
                    var viewname = $(this).attr('view');
                    $(this).find('b').hide();
                    showview($('.'+viewname));
                }
                if($(this).attr('page')){
                    locationview($(this).attr('page'),$(this).attr('op'));
                }
            });
            $('.city').on('click',function(){
              logout(function(){
                top.location.href = '/jsp/login.jsp';
              });
            });
            $('.view_btn').on('click',function(){
                hideview($(this).parent());
            })
            $('.vip_list>span').on('click',function(){
                var _self = $(this);
                $('.vip_list>span').removeClass('on');
                _self.addClass('on');
            });
        }
    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">

    <div class='alert_box setting_view'>
        <div class='alert_body'>
            <div class='alert_title'>
                <span>系统消息</span>
                <div class='alert_close'>
                    <img src="${pageContext.request.contextPath}/images/alert_close_btn.png"/>
                </div>

            </div>
            <div class='alert_content'>
              <div class='alert_scroll'>
                  <span class='setting_li'>
                      系统通知:<a>王者荣耀开放下注!下注即可获得英雄卡!集齐英雄卡有机会赢取大奖!</a>
                  </span>
                  <span class='setting_li'>
                      活动通知:<a>王者荣耀首次充值满100元赠送100%奖励</a>
                  </span>
                  <span class='setting_li'>
                      活动通知:<a>王者荣耀首次充值满100元赠送100%奖励</a>
                  </span>
                  <span class='setting_li'>
                      活动通知:<a>王者荣耀首次充值满100元赠送100%奖励</a>
                  </span>
                  <span class='setting_li'>
                      活动通知:<a>王者荣耀首次充值满100元赠送100%奖励</a>
                  </span>
              </div>
            </div>
        </div>
    </div>

    <div class='page_box'>
          <div class='page_bg'>
              <img src="${pageContext.request.contextPath}/images/vip_bg.jpg"/>
          </div>
          <div class='page_body'>
            <div class='page_controller'>
              <div class='headarea'>
                  <div class='headimgbox'>
                      <img src="${pageContext.request.contextPath}/images/channel_qrcode_errorimg.png" onerror='this.src="${pageContext.request.contextPath}/images/channel_qrcode_errorimg.png"'/>
                      <span><!--
                          <img src="${pageContext.request.contextPath}/images/mine_level_1.png"/> -->
                      </span>
                  </div>
                  <div class='userinfo'>
                      <span>用户ID：<a></a></span>
                      <a>绑定银行卡</a>
                  </div>
                  <div class='cashbox'>
                      <span style='width:100%;'>金币：<a>0</a></span><!--
                      <span>积分：<a>0</a></span>
                      <span>佣金：<a>0</a></span> -->
                  </div>
                  <span class='musicbtn'>
                      <img src="${pageContext.request.contextPath}/images/mine_icon_music.png"/>
                      <img src="${pageContext.request.contextPath}/images/s_video.png" alt="">
                  </span>
                  <span class='city'>
                      <img style='height:16px;padding-top:4px;' src="${pageContext.request.contextPath}/images/mine_icon_change.png"/>
                      <span>切换账号</span>
                  </span>
              </div>
              <div class='option_box'>
                  <div page='bagview'>
                      <img src="${pageContext.request.contextPath}/images/mine_icon_bag.png"/>
                      <span>我的背包</span>
                      <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                      <b></b>
                  </div><!--
                  <div page='integral'>
                      <img src="${pageContext.request.contextPath}/images/mine_icon_setting.png"/>
                      <span>积分寻宝</span>
                      <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                      <b></b>
                  </div>
                  <div page='shop' op='stage'>
                      <img src="${pageContext.request.contextPath}/images/mine_icon_stage.png"/>
                      <span>我要分期</span>
                      <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                  </div> -->
                  <%--<div page='shop' op='vip'>--%>
                      <%--<img src="${pageContext.request.contextPath}/images/mine_icon_vip.png"/>--%>
                      <%--<span>会员特权</span>--%>
                      <%--<a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>--%>
                  <%--</div>--%>
                  <%--<div page='shop' op='cash'>--%>
                      <%--<img src="${pageContext.request.contextPath}/images/mine_icon_stage.png"/>--%>
                      <%--<span>余额提现</span>--%>
                      <%--<a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>--%>
                  <%--</div>--%>
                    <div page='xs_animate'>
                        <img style='padding-left:3px;padding-right:10px;' src="${pageContext.request.contextPath}/images/mine_icon_bag_xs.png"/>
                        <span>新手指引</span>
                        <a>
                            <img src="${pageContext.request.contextPath}/images/option_arror.png"/>
                        </a>
                    </div>

                    <div page='shop' op='coin'>
                        <img style='padding-left:3px;padding-right:10px;' src="${pageContext.request.contextPath}/images/mine_icon_charges.png"/>
                        <span>金币充值</span>
                        <a>
                            <img src="${pageContext.request.contextPath}/images/option_arror.png"/>
                        </a>
                    </div>
                    <div page='shop' op='cash'>
                        <img src="${pageContext.request.contextPath}/images/mine_icon_vip.png"/>
                        <span>礼品兑换</span>
                        <a>
                            <img src="${pageContext.request.contextPath}/images/option_arror.png"/>
                        </a>
                    </div>
                    <div page='search'>
                        <img src="${pageContext.request.contextPath}/images/mine_icon_stage.png"/>
                        <span>订单查询</span>
                        <a>
                            <img src="${pageContext.request.contextPath}/images/option_arror.png"/>
                        </a>
                    </div>

                  <div page='chargesview'>
                      <img style='padding-left:3px;padding-right:10px;' src="${pageContext.request.contextPath}/images/mine_icon_yj.png"/>
                      <span>佣金提现</span>
                      <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                  </div>
                  <div view='setting_view'>
                      <img src="${pageContext.request.contextPath}/images/mine_icon_setting.png"/>
                      <span>系统消息</span>
                      <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                      <b></b>
                  </div>
              </div>

            </div>
          </div>


    </div>
    </body>
</html>