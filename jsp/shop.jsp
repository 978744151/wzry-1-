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
    <!-- <link rel="shortcut icon" href="${pageContext.request.contextPath}/{HOME_THEME_PATH}images/base/title.png"> -->
    <meta name="applicable-device" content="pc,mobile"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/iscroll.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">
        var pageIScroll = '';
        function page_onload(){
            //initPage();
            checkLogin('',function(){
              errorMsg('请登陆后尝试下单');
              setTimeout(function(){
                  top.location.href = '/jsp/login.jsp';
              },500);
            });
            if($_GET['page'] && $('.'+$_GET['page']+'_list').length > 0){
                $('.'+$_GET['page']+'_list').addClass('shop_box_on');
                $('.optionbox>span').removeClass('on');
                $('.optionbox').find('[name="'+$_GET['page']+'"]').addClass('on');
                if($_GET['page']=='cashlist'){
                    ajaxCashList();
                }
            }else{
                $('.coin_list').addClass('shop_box_on');
                $('.optionbox').find('[name="coin"]').addClass('on');
            }

            pageIScroll = new IScroll('.page_content',{
                mouseWheel:true,
                scrollbars:false,
                bounce:false,
                click:iScrollClick()
            });
            $('.optionbox>span').on('click',function(){
                var _self = $(this);
                var boxid = _self.attr('name');
                if(_self.hasClass('on')){
                    return false;
                }else{
                    if(boxid=='cashlist'){
                        ajaxCashList();
                    }
                   $('.optionbox>span').removeClass('on');
                    _self.addClass('on');
                    $('.shop_box').hide();
                    $('.shop_box').removeClass('shop_box_on');
                    //$('#'+boxid).show();
                    $('#'+boxid).addClass('shop_box_on');
                    pageIScroll.refresh()
                }
            });
            $('.vip_list>span').on('click',function(){
                var _self = $(this);
                $('.vip_list>span').removeClass('on');
                _self.addClass('on');
            });
            $('.state_appear').on("click",function(){
                var money = parseInt($(this).parent().find('span').html());
                ajaxCoin2List(money);
            })
            $('.pop_none').on("click",function(){
                $(".shop_popups").hide()
                $(".shop_quit").hide()
            })
            $('.pop_conform').on('click',function(){
                $(".shop_popups").hide();
                $('.optionbox>span').removeClass('on');
                $('.shop_box').removeClass('shop_box_on');
                ajaxCashList();
                $('.cashlist_list').addClass('shop_box_on');
                $('.optionbox').find('[name="cashlist"]').addClass('on');
            });
        }

        function ajaxCashList(){
            $.ajax({
                url:"/login/cashrecord",
                type:'GET',
                data:{'page':'1'},
                dataType: 'json',
                success: function(data){
                    //alert(data);
                    if(data.status == 1){
                        var html = '';
                        for(var i =0;i<data.message.length;i++){
                            html += '<div class="stage_box"><img src="../images/bian_01.png" alt=""><img src="../images/bian_02.png" alt=""><img src="../images/bian_03.png" alt=""><img src="../images/bian_04.png" alt=""><div class="coin_icon_box">'
                            if(parseInt(data.message[i].money)==50){
                                html += '<img src="../images/cash_money1.png" alt=""></div><div class="content_box">';
                            }else if(parseInt(data.message[i].money)==100){
                                html += '<img src="../images/cash_money2.png" alt=""></div><div class="content_box">';
                            }else if(parseInt(data.message[i].money)==300){
                                html += '<img src="../images/cash_money3.png" alt=""></div><div class="content_box">';
                            }else if(parseInt(data.message[i].money)==500){
                                html += '<img src="../images/cash_money4.png" alt=""></div><div class="content_box">';
                            }else if(parseInt(data.message[i].money)==1000){
                                html += '<img src="../images/cash_money5.png" alt=""></div><div class="content_box">';
                            }else if(parseInt(data.message[i].money)==2000){
                                html += '<img src="../images/cash_money5.png" alt=""></div><div class="content_box">';
                            }else{
                                html += '<img src="../images/cash_money4.png" alt=""></div><div class="content_box">';
                            }
                            html += '<span>'+parseInt(data.message[i].money)+'</span><sub>元</sub>';

                            if(parseInt(data.message[i].status)==0){//未退款
                                html += '<a class="state_quit" orderid="'+(data.message[i].id)+'" money="'+(data.message[i].money)+'">我要退货</a>';
                                html += '<p>此魔法袋需要'+parseInt(data.message[i].money)+'个金币兑换</p>';
                            }else if(parseInt(data.message[i].status)==1){//处理中
                                html += '<a style="color:#72ac26;background:none;font-size: 16px;">退款中</a>';
                                html += '<p>此商品审核退货中,请耐心等待</p>';
                            }else if(parseInt(data.message[i].status)==2){//退款成功
                                html += '<a style="color:#284e6e;background:none;font-size: 16px;">退款成功</a>';
                                html += '<p>此商品已经退货完成,已存入您的银行卡</p>';
                            }else if(parseInt(data.message[i].status)==3){//退款失败
                                html += '<a style="color:#b74a59;background:none;font-size: 16px;">退款失败</a>';
                                html += '<p>此商品退货失败 详情咨询客服</p>';
                            }else{
                                html += '<a style="color:gray;background:none;font-size: 16px;">处理中</a>';
                                html += '<p>此商品退货审核处理中</p>';
                            }

                            html += "</div></div>" ;
                        }
                        $('.cashlist_list').html(html);
                        $('.state_quit').unbind('click');
                        $('.state_quit').on("click",function(){
                            var id = $(this).attr('orderid');
                            var money = $(this).attr('money');
                            //alert(money);
                            if(id){
                                $('.pop_quit').on('click',function(){
                                    // alert("退货");
                                    $.ajax({
                                        url:"/trade/giftToMoney",
                                        type:'GET',
                                        data:{'giftId':id},
                                        dataType: 'json',
                                        success: function(data){
                                            console.log(data);
                                            if(data.status == 1){
                                                errorMsg('申请退款成功');
                                                $(".shop_popups").hide()
                                                $(".shop_quit").hide()
                                            }else{
                                                errorMsg(data.message);
                                                $(".shop_popups").hide()
                                                $(".shop_quit").hide()
                                            }
                                            ajaxCashList();
                                        },
                                        error: function(e){
                                            alert("error");
                                            errorMsg('网络错误,请稍后再试');
                                        }
                                    });
                                });
                                if($_user.card_num){
                                    //$('.money_show').html(money);
                                    $('.card_num').html("银行卡："+$_user.card_num)
                                    $(".shop_quit").show()
                                }else{
                                    errorMsg('请先绑定银行卡');
                                    setTimeout(function(){
                                        window.location.href = '/jsp/cashview.jsp';
                                    })
                                }
                            }else{
                                errorMsg('网络错误,请稍后再试');
                            }
                        })
                    }else{
                        errorMsg('网络错误,请稍后再试');
                    }

                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
            });

        }
        function ajaxCoin2List(money){
            $.ajax({
                url:"/trade/coinToGift",
                type:'GET',
                data:{'money':money},
                dataType: 'json',
                success: function(data){
                    $(".shop_popups").show();
                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
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
        <div class="shop_popups">
                <div class="shop_popups_once">
                        <p>礼品兑换</p>
                        <p>兑换成功!</p>
                        <p>所有的礼品可去退货详情页面进行退货</p>
                     <div>
                            <a class="pop_conform">去兑换</a>
                            <span  class="pop_none">取消</span>
                    </div>
                </div>
        </div>
        <div class="shop_quit">
                <div class="shop_popups_once">
                    <p>我要退货</p>
                    <p>确认退货<a class='money_show'></a>吗?</p>
                    <p>退货的商品将自动存入您绑定的银行卡</p>
                    <p class='card_num'></p>
                    <div>
                            <a class="pop_quit">确定</a>
                            <span  class="pop_none">取消</span>
                    </div>
                </div>
        </div>
        <div class='page_bg'>
            <img src="${pageContext.request.contextPath}/images/vip_bg.jpg"/>
        </div>
        <div class='page_body'>
            <div class='optionbox'>
                <span name='coin' style='width:33.3%;' class="on">金币充值</span>
                <%--<span name='vip' style='width:33.3%;'>会员充值</span>--%>
                <span name='cash' style='width:33.3%;'>礼品兑换</span>
                <span name='cashlist' style='width:33.3%;'>我要退货</span>
                <!-- <span name='stage'>我要分期
                    <i class="state_i"></i>
                </span> -->
            </div>
            <div class='page_content'>
                <div class='pay_box'>
                    <div class='pay_bg'>
                        <img src="${pageContext.request.contextPath}/images/vip_bg.jpg"/>
                    </div>

                    <div class='coin_list shop_box' id='coin'>
                        <div class="coin_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/pay_coin_icon_1.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>10</span>
                                <sub>元</sub>
                                <a onclick='wechatPay(10)'>我要充值</a>
                                <p>可获得10金币</p>
                            </div>
                        </div>
                        <div class="coin_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/pay_coin_icon_2.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>20</span>
                                <sub>元</sub>
                                <a onclick='wechatPay(20)'>我要充值</a>
                                <p>可获得20金币</p>
                            </div>
                        </div>
                        <div class="coin_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/pay_coin_icon_3.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>50</span>
                                <sub>元</sub>
                                <a onclick='wechatPay(50)'>我要充值</a>
                                <p>可获得50金币</p>
                            </div>
                        </div>
                        <div class="coin_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/pay_coin_icon_4.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>100</span>
                                <sub>元</sub>
                                <a onclick='wechatPay(100)'>我要充值</a>
                                <p>可获得100金币</p>
                            </div>
                        </div>
                        <div class="coin_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/pay_coin_icon_5.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>200</span>
                                <sub>元</sub>
                                <a onclick='wechatPay(200)'>我要充值</a>
                                <p>可获得200金币</p>
                            </div>
                        </div>
                        <div class="coin_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/pay_coin_icon_6.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>500</span>
                                <sub>元</sub>
                                <a onclick='wechatPay(500)'>我要充值</a>
                                <p>可获得500金币</p>
                            </div>
                        </div>
                        <!-- <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_1.png"/></span>
                            <b>￥10</b>
                            <a class='coin_btn btn_y'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_2.png"/></span>
                            <b>￥20</b>
                            <a class='coin_btn btn_y'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_3.png"/></span>
                            <b>￥50</b>
                            <a class='coin_btn btn_y'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_4.png"/></span>
                            <b>￥100</b>
                            <a class='coin_btn btn_y'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_5.png"/></span>
                            <b>￥200</b>
                            <a class='coin_btn btn_y'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_6.png"/></span>
                            <b>￥500</b>
                            <a class='coin_btn btn_y'>购买</a>
                        </span>
                        <div class='clear'></div> -->
                    </div>
<!-- state开始 -->
                    <div class='stage_list shop_box' id='stage'>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/money_01.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>500</span>
                                <sub>元</sub>
                                <a>我要充值</a>
                                <p>可获取5万书币,并获赠5000金币</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/money_02.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>1000</span>
                                <sub>元</sub>
                                <a>我要充值</a>
                                <p>可获取10万书币,并获赠10000金币</p>
                            </div>
                        </div>
                        <!-- <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/money_03.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>30</span>
                                <sub>元</sub>
                                <a>我要充值</a>
                                <p>可获取XX书币,并获赠XXXX金币</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/money_04.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>40</span>
                                <sub>元</sub>
                                <a>我要充值</a>
                                <p>可获取XX书币,并获赠XXXX金币</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/money_05.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>40</span>
                                <sub>元</sub>
                                <a>我要充值</a>
                                <p>可获取XX书币,并获赠XXXX金币</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/money_06.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>40</span>
                                <sub>元</sub>
                                <a>我要充值</a>
                                <p>可获取XX书币,并获赠XXXX金币</p>
                            </div>
                        </div> -->
                    </div>
<!-- state结束 -->
                    <%--<div class='vip_list shop_box' id='vip'>--%>
                        <%--<a>以下所有VIP充值有效期为1个月</a>--%>
                        <%--<span onclick='vipPay(30)'>--%>
                             <%--<div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv1.png"></div>--%>
                             <%--<div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv1.png"></div>--%>
                             <%--<span><b>30</b>元/月</span>--%>
                             <%--<a>赠送15元余额</a>--%>
                             <%--<b>集卡率提高5%</b>--%>
                        <%--</span>--%>
                        <%--<span onclick='vipPay(50)'>--%>
                             <%--<div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv2.png"></div>--%>
                             <%--<div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv2.png"></div>--%>
                             <%--<span><b>50</b>元/月</span>--%>
                             <%--<a>赠送25元余额</a>--%>
                             <%--<b>集卡率提高10%</b>--%>
                        <%--</span>--%>
                        <%--<span onclick='vipPay(100)'>--%>
                             <%--<div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv3.png"></div>--%>
                             <%--<div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv3.png"></div>--%>
                             <%--<span><b>100</b>元/月</span>--%>
                             <%--<a>赠送50元余额</a>--%>
                             <%--<b>集卡率提高15%</b>--%>
                        <%--</span>--%>
                        <%--<span onclick='vipPay(300)'>--%>
                             <%--<div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv4.png"></div>--%>
                             <%--<div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv4.png"></div>--%>
                             <%--<span><b>300</b>元/月</span>--%>
                             <%--<a>赠送150元余额</a>--%>
                             <%--<b>集卡率提高25%</b>--%>
                        <%--</span>--%>
                        <%--<span onclick='vipPay(500)'>--%>
                             <%--<div class='vip_flag'><img src="${pageContext.request.contextPath}/images/icon_vipflag_lv5.png"></div>--%>
                             <%--<div class='vip_icon'><img src="${pageContext.request.contextPath}/images/icon_vip_lv5.png"></div>--%>
                             <%--<span><b>500</b>元/月</span>--%>
                             <%--<a>赠送250元余额</a>--%>
                             <%--<b>集卡率提高50%</b>--%>
                        <%--</span>--%>

                        <%--<div class='clear'></div>--%>
                    <%--</div>--%>

                    <div class='cash_list shop_box' id='cash' style='padding: 10px;'>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                            <img src="${pageContext.request.contextPath}/images/cash_money1.png" alt="">
                            </div>
                            <div class='content_box'>
                            <span>50</span>
                            <sub>元</sub>
                            <a class="state_appear">我要兑换</a>
                            <p>此魔法袋需要50个金币兑换</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/cash_money2.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>100</span>
                                <sub>元</sub>
                                <a class="state_appear">我要兑换</a>
                                <p>此魔法袋需要100个金币兑换</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                            <img src="${pageContext.request.contextPath}/images/cash_money3.png" alt="">
                            </div>
                            <div class='content_box'>
                            <span>300</span>
                            <sub>元</sub>
                            <a class="state_appear">我要兑换</a>
                            <p>此魔法袋需要300个金币兑换</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                            <img src="${pageContext.request.contextPath}/images/cash_money4.png" alt="">
                            </div>
                            <div class='content_box'>
                            <span>500</span>
                            <sub>元</sub>
                            <a class="state_appear">我要兑换</a>
                            <p>此魔法袋需要500个金币兑换</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                            <img src="${pageContext.request.contextPath}/images/cash_money5.png" alt="">
                            </div>
                            <div class='content_box'>
                            <span>1000</span>
                            <sub>元</sub>
                            <a class="state_appear">我要兑换</a>
                            <p>此礼品盒需要1000个金币兑换</p>
                            </div>
                        </div>
                        <div class="stage_box">
                                <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                                <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/cash_money6.png" alt="">
                                </div>
                                <div class='content_box'>
                                <span>2000</span>
                                <sub>元</sub>
                                <a class="state_appear">我要兑换</a>
                                <p>此礼品盒需要2000个金币兑换</p>
                            </div>
                        </div>
                    </div>

                    <div class='cashlist_list shop_box' id='cashlist' style='padding: 10px;'>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                            <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/cash_money1.png" alt="">
                            </div>
                            <div class='content_box'>
                                <span>50</span>
                                <sub>元</sub>
                                <a class="state_quit">我要退货</a>
                                <p>此魔法袋需要50个金币兑换</p>
                            </div>
                        </div>
                        <div class="stage_box">
                        <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                        <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                        <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                        <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                        <div class='coin_icon_box'>
                        <img src="${pageContext.request.contextPath}/images/cash_money2.png" alt="">
                        </div>
                        <div class='content_box'>
                        <span>100</span>
                        <sub>元</sub>
                        <a class="state_quit">我要退货</a>
                        <p>此流量卷需要100个金币兑换</p>
                        </div>
                        </div>
                        <div class="stage_box">
                        <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                        <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                        <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                        <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                        <div class='coin_icon_box'>
                            <img src="${pageContext.request.contextPath}/images/cash_money3.png" alt="">
                        </div>
                        <div class='content_box'>
                                <span>300</span>
                                <sub>元</sub>
                                <a class="state_quit">我要退货</a>
                                <p>此流量卷需要300个金币兑换</p>
                        </div>
                        </div>
                        <div class="stage_box">
                                <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                        <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/cash_money4.png" alt="">
                        </div>
                        <div class='content_box'>
                                <span>500</span>
                                <sub>元</sub>
                                <a class="state_quit">我要退货</a>
                                <p>此流量卷需要500个金币兑换</p>
                        </div>
                        </div>
                        <div class="stage_box">
                                <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                                <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                        <div class='coin_icon_box'>
                                <img src="${pageContext.request.contextPath}/images/cash_money5.png" alt="">
                        </div>
                            <div class='content_box'>
                                <span>1000</span>
                                <sub>元</sub>
                                <a class="state_quit">我要退货</a>
                                <p>此流量卷需要1000个金币兑换</p>
                            </div>
                        </div>
                        <div class="stage_box">
                            <img src="${pageContext.request.contextPath}/images/bian_01.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_02.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_03.png" alt="">
                            <img src="${pageContext.request.contextPath}/images/bian_04.png" alt="">
                        <div class='coin_icon_box'>
                            <img src="${pageContext.request.contextPath}/images/cash_money6.png" alt="">
                        </div>
                            <div class='content_box'>
                                <span>2000</span>
                                <sub>元</sub>
                                <a class="state_quit">我要退货</a>
                                <p>此流量卷需要2000个金币兑换</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>