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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mine.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css"><!-- 
    <link rel="stylesheet" href="css/imageflow.css"> -->
    <script src='${pageContext.request.contextPath}/js/numberAnimate.js'></script><!-- 
    <script src='js/imageflow.js'></script> -->
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">

        function getCity(){
            $.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js',function(){
              $('.city>span').html(remote_ip_info.city);  
            });
        }
        function showview(view){
            view.fadeIn(100);
            //view.animate({'left':'0'},50);
        }
        function hideview(view){
            view.fadeOut(100);
            //view.animate({'left':'100%'},50);
        }
        function page_onload(){
            //initPage();
            getCity();


            $('.option_box>div').on('click',function(){
                var viewname = $(this).attr('view');
                $(this).find('b').hide();
                showview($('.'+viewname));
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
    <!-- <div class='loadingbox' id='loadingbox'>
        <img src="images/game_logo.png"/>
        <span>LOADING</span>
    </div> -->

    <div class='mine_view bag_view'>
    </div>
    <div class='mine_view vip_view'>
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
    <div class='mine_view cash_view'>
        <span class='view_title'>可提现余额:<a>68764</a></span>
        <input type="number" placeholder="请输入提现金额"/>
        <span class='view_btn cash_submit'>确认提现</span>
        <!-- <span class='view_back_btn'>返回</span> -->
        <p class='view_text'>
            提现说明：<br/>
            1.提现时间为工作日早上6点至晚上5点<br/>
            2.提现到账时间以银行实际到账时间<br/>
            3.提现金额低于50元收取5%手续费<br/>
            4.提现金额高于100元收取2%手续费<br/>
        </p>
    </div>
    <div class='mine_view charges_view'>
        <span class='view_title'>可提现佣金:<a>8174</a></span>
        <input type="number" placeholder="请输入提现金额"/>
        <span class='view_btn charges_submit'>确认提现</span>
        <!-- <span class='view_back_btn'>返回</span> -->
        <p class='view_text'>
            提现说明：<br/>
            1.提现时间为工作日早上6点至晚上5点<br/>
            2.提现到账时间以银行实际到账时间<br/>
            3.提现金额低于50元收取5%手续费<br/>
            4.提现金额高于100元收取2%手续费<br/>
        </p>
    </div>
    <div class='alert_box setting_view'>
        <div class='alert_body'>
            <div class='alert_title'>
                <span>系统消息</span>
                <div class='alert_close'>
                    <img src="${pageContext.request.contextPath}/images/alert_close_btn.png"/>
                </div>

            </div>
            <div class='alert_content'>
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

    <div class='page_box'>
        <div class='page_bg'>
            <img src="${pageContext.request.contextPath}/images/bg.jpg"/>
        </div>
                
        <div class='page_body'>
            <div class='headarea'>
                <div class='headimgbox'>
                    <img src="${pageContext.request.contextPath}/images/headimg.jpg" />
                    <span>
                        <img src="${pageContext.request.contextPath}/images/mine_level_1.png"/>
                    </span>
                </div>
                <div class='userinfo'>
                    <span>用户ID：125468426</span>
                    <a>绑定手机号</a>
                </div>
                <div class='cashbox'>
                    <span>账户余额：12487</span>
                    <span>佣金余额：254</span>
                </div>
                <span class='musicbtn'>
                    <img src="${pageContext.request.contextPath}/images/mine_icon_music.png"/>
                </span>
                <span class='city'>
                    <img src="${pageContext.request.contextPath}/images/mine_icon_address.png"/>
                    <span>定位中</span>
                </span>
            </div>
            <div class='option_box'>
                <div view='bag_view'>
                    <img src="${pageContext.request.contextPath}/images/mine_icon_bag.png"/>
                    <span>我的背包</span>
                    <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                    <b></b>
                </div>
                <div view='vip_view'>
                    <img src="${pageContext.request.contextPath}/images/mine_icon_vip.png"/>
                    <span>会员充值</span>
                    <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                </div>
                <div view='cash_view'>
                    <img src="${pageContext.request.contextPath}/images/mine_icon_cash.png"/>
                    <span>余额提现</span>
                    <a><img src="${pageContext.request.contextPath}/images/option_arror.png"/></a>
                </div>
                <div view='charges_view'>
                    <img src="${pageContext.request.contextPath}/images/mine_icon_charges.png"/>
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
    </body>
</html>