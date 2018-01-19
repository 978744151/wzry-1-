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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/game.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bag.css?v=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src='${pageContext.request.contextPath}/js/numberAnimate.js'></script>
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script src="${pageContext.request.contextPath}/js/game.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/animate.min.css">
    <script>

    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <div class='loadingbox' id='loadingbox'>
        <img src="${pageContext.request.contextPath}/images/loading_logo.png"/>
        <div class='pointbox'>
            <span></span>
            <span></span>
            <span></span>
            <span></span><!--
            <span></span>
            <span></span>
            <span></span> -->
        </div>
        <div class='textbox'>
            <p>王者在线竞猜</p>
            <span>THE&nbsp;GLORY&nbsp;OF&nbsp;KING&nbsp;ONLINE&nbsp;CONTEST</span>
            <a>产品版权归萌鲨互娱所有，所有数据均来自腾讯官网</a>
        </div>
    </div>
    <div class='chest_open_view'>
        <div class='chest_open_img'>
            <img src='${pageContext.request.contextPath}/images/game_chest_img_2.png'>
        </div>
        <!-- <div class='view_close'>
            <img src="${pageContext.request.contextPath}/images/view_close_btn.png">
        </div> -->
        <div class='chest_open_text'>
            <span>恭喜获得50金币奖励</span>
        </div>
        <div class='close_btn btn_y'>确定</div>
    </div>
    <div class='alert_box' id='BAG'>
        <div class='alert_body'>
            <div class='alert_title'>
                <span>我的背包</span>
                <div class='alert_close'>
                    <img src="${pageContext.request.contextPath}/images/alert_close_btn.png"/>
                </div>
            </div>
            <div class='alert_content'>
                            <p class="none_kf">此功能暂未开放</p>
                <div class='alert_scroll'>
                    <div class='bag_body'>
                        <!----------BAG START------------>
                        <div class="person">
                            <ul>

                            </ul>
                        </div>
                        <!----------BAG END------------>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <div class='alert_box' id='PAY'>
        <div class='alert_body'>
            <div class='alert_content'>
                <div class='alert_scroll'>
                    <div class='coin_list'>
                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_1.png"/></span>
                            <b>￥10</b>
                            <a class='coin_btn btn_y' onclick='wechatPay(10)'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_2.png"/></span>
                            <b>￥20</b>
                            <a class='coin_btn btn_y' onclick='wechatPay(20)'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_3.png"/></span>
                            <b>￥50</b>
                            <a class='coin_btn btn_y' onclick='wechatPay(50)'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_4.png"/></span>
                            <b>￥100</b>
                            <a class='coin_btn btn_y' onclick='wechatPay(100)'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_5.png"/></span>
                            <b>￥200</b>
                            <a class='coin_btn btn_y' onclick='wechatPay(200)'>购买</a>
                        </span>
                        <div class='clear'></div>

                        <span class='coin_li'>
                            <span><img src="${pageContext.request.contextPath}/images/pay_coin_icon_6.png"/></span>
                            <b>￥500</b>
                            <a class='coin_btn btn_y' onclick='wechatPay(500)'>购买</a>
                        </span>
                        <div class='clear'></div>
                    </div>
                </div>
            </div>
            <div class='alert_title'>
                <span>金币充值</span>
                <div class='alert_close'>
                    <img src="${pageContext.request.contextPath}/images/alert_close_btn.png"/>
                </div>
            </div>
        </div>
    </div>
    <div class='alert_box' id='LINE'>
        <div class='alert_body'>
            <div class='alert_content'>

                <div class='alert_scroll'>
                    <table class='line_table'>
                        <tr>
                            <th class='line_left'><span>期号</span></th>
                            <th><span>大</span></th>
                            <th><span>小</span></th>
                            <th><span>单</span></th>
                            <th><span>双</span></th>
                            <th><span>三条</span></th>
                            <th class='line_left'><span>顺子</span></th>
                            <th><span>英雄</span></th>
                        </tr>
                        <%-- <c:forEach var="item" items="${chart2}">
                        <tr> --%>
                            <%--<td>${item.issue}</td>--%>
                            <%--<td><img src="${pageContext.request.contextPath}/images/line_icon_y.png"></td>--%>
                            <%--<td></td>--%>
                            <%--<td><img src="${pageContext.request.contextPath}/images/line_icon_b.png"></td>--%>
                            <%--<td></td>--%>
                            <%--<td><img src="${pageContext.request.contextPath}/images/line_icon_b.png"></td>--%>
                            <%--<td></td>--%>
                            <%--<td>王昭君</td>--%>
                        <%-- </tr>
                        </c:forEach> --%>
                    </table>
                </div>
            </div>
            <div class='alert_title'>
                <span>走势图</span>
                <div class='alert_close'>
                    <img src="${pageContext.request.contextPath}/images/alert_close_btn.png"/>
                </div>
            </div>
        </div>
    </div>

    <div class='alert_box' id='QUES'>
        <div class='alert_body'>
            <div class='alert_content'>
                <div class='alert_scroll'>
                    <p>本游戏竞猜根据腾讯官网适时在线人数参与让玩家进行投注，按每期开奖的“大小”、“单双”及“英雄”获得相应的赔率金币，游戏分为三个场次分别为“英雄场”、“精确场”，可重复多项下注，具体规则如下：</p>

                    <p>【英雄场】玩家根据自己喜欢及判断投注不同的英雄，开奖后玩家押中的英雄从而获得相应赔率的金币；赔率表如下：</p>

                    <table>
                        <tr>
                            <td>英雄</td><td>王昭君</td><td>小乔</td><td>武则天</td><td>韩信</td><td>程咬金</td><td>赵云</td><td>老夫子</td><td>项羽</td><td>鲁班</td>
                        </tr>
                        <tr>
                            <td>赔率</td><td>X8</td><td>X8</td><td>X8</td><td>X8</td><td>X8</td><td>X8</td><td>X8</td><td>X8</td><td>X8</td>
                        </tr>
                    </table>
                    <p>【大小】玩家根据每期不同的走势分析进行投注，最后三位尾号相加为14-27（含）则为“大”，例如：开奖尾号178（1+7+8=16为大）；最后尾数相加为0-13（含）则为“小”，例如：开奖尾号063（0+6+3=9为小）;</p>

                    <p>【单双】玩家根据每期不同的走势分析进行投注，最后三位尾号相加最终结果显示为：1、3、5、7、9、11、13、15、17、19、21、23、25、27则为“单号”，例如：开奖尾号236（2+3+6=11为单号）；最后三位尾号相加最终结果显示为：0、2、4、6、8、10、12、14、16、18、20、22、24、26则为“双号”，例如：开奖尾号457（4+5+7=16为双号）；最后三位尾号出现连号则为“顺子”相反顺序也算。例如：012、234、678、987、765….（不包括910和019）；“三条”则为三位尾号出现三个相同数字的，例如：333、666、777、000….</p>

                    <table>
                        <tr>
                            <td>结果</td><td>单</td><td>双</td><td>大</td><td>小</td><td>顺子</td><td>三条</td>
                        </tr>
                        <tr>
                            <td>赔率</td><td>X1.8</td><td>X1.8</td><td>X1.8</td><td>X1.8</td><td>X24</td><td>X48</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class='alert_title'>
                <span>规则说明</span>
                <div class='alert_close'>
                    <img src="${pageContext.request.contextPath}/images/alert_close_btn.png"/>
                </div>
            </div>
        </div>
    </div>
    <div class='page_box'>

        <div class='page_bg'>
            <img src="${pageContext.request.contextPath}/images/bg.jpg"/>
        </div>
        <div class='page_body'>

            <div class='header'>
                <div class='infobox'>
                    <div class='headimg'>
                        <img src="${pageContext.request.contextPath}/images/channel_qrcode_errorimg.png" onerror='this.src="${pageContext.request.contextPath}/images/channel_qrcode_errorimg.png"'/>
                    </div>
                    <span class='header_nickname'></span>
                    <div class='header_coin_box'>
                        <div class='header_coin'><img src="${pageContext.request.contextPath}/images/header_coin.png"/></div>
                        <span class='header_coinnum'>0</span>
                        <span class='header_addcoin'>+10</span>
                        <span class='header_mincoin'>-10</span>
                        <div class='header_plus btn' name='PAY'><img src="${pageContext.request.contextPath}/images/header_plus.png"/></div>
                    </div>
                </div>
                <div class='btnbox'>
                    <span class='header_icon_bag btn header_icon_btn' name='BAG'><img src="${pageContext.request.contextPath}/images/header_icon_bag.png"/></span>
                    <span class='header_icon_line btn header_icon_btn' name='LINE'><img src="${pageContext.request.contextPath}/images/header_icon_line.png"/></span>
                    <span class='header_icon_ques btn header_icon_btn' name='QUES'><img src="${pageContext.request.contextPath}/images/header_icon_ques.png"/></span>
                </div>
            </div>
            <div class='clear'></div>

            <div class='game_box'>
                <div class='game_nav'>
                    <span name='NUM' class='on'>精确场</span>
                    <span name='HERO'>英雄场</span><!--
                    <span name='SING-PLUR'>单双场</span> -->
                </div>
                <div class='game_content'>


                    <div id='HERO'>
                            <p class="page_p">玩家:<span class="page_span" style="color:white;">1377****4332</span>&nbsp;<img src="${pageContext.request.contextPath}/images/header_coin.png" alt="" style="display: inline; height: 16px; vertical-align:middle; "><span style="color:#f1de84">+</span><span class="page_span1" style="color:#f1de84"> 660 </span></p>
                          <p class="game_num_box_p1 infinite">10</p>
                         <img src="${pageContext.request.contextPath}/images/game_num_end_bg.png"/ class="game_num_box_img1">
                        <div class='game_show'>
                            <div class='game_logo'>
                                <div class="imageflow">
                                    <span><img src="${pageContext.request.contextPath}/images/hero_1.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_2.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_3.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_4.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_5.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_6.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_7.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_8.png"/></span>
                                    <span><img src="${pageContext.request.contextPath}/images/hero_9.png"/></span>
                                </div>
                                <div class='choose_border'><img src='${pageContext.request.contextPath}/images/showhero_border.png'/></div>
                            </div>
                            <div class='game_chest_box'>
                                <div class='game_chest_rate'>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                                <div class='game_chest_light none'>
                                    <img src="${pageContext.request.contextPath}/images/game_chest_light.png"/>
                                </div>
                                <div class='game_chest_img'>
                                </div>
                            </div>
                            <div class='game_timer_box'>
                                <div class='game_timer_bg'>
                                    <img src="${pageContext.request.contextPath}/images/game_timer_bg.png"/>
                                </div>
                                <span><a>-</a>s</span>
                            </div>
                        </div>

                        <div class='game_choose'>

                            <span id='op_1'><i>1</i><a>王昭君<b>1:3</b></a></span>
                            <span id='op_2'><i>2</i><a>小乔<b>1:3</b></a></span>
                            <span id='op_3'><i>3</i><a>武则天<b>1:3</b></a></span>
                            <span id='op_4'><i>4</i><a>韩信<b>1:6</b></a></span>
                            <span id='op_5'><i>5</i><a>程咬金<b>1:6</b></a></span>
                            <span id='op_6'><i>6</i><a>赵云<b>1:8</b></a></span>
                            <span id='op_7'><i>7</i><a>老夫子<b>1:8</b></a></span>
                            <span id='op_8'><i>8</i><a>项羽<b>1:40</b></a></span>
                            <span id='op_9'><i>9</i><a>鲁班<b>1:80</b></a></span>
                        </div>
                        <div class='game_input'>
                            <div class="z_show">
                                <span>停止下单</span>
                            </div>
                            <span class='max btn_b'>撤回</span>
                            <span class='deal btn_y'>下注</span>
                            <div class='moneyinput'>
                                <input type="number" value="10" onchange="check_value(this);"/>
                                <div class='minus'><img src="${pageContext.request.contextPath}/images/btn_game_minus.png"/></div>
                                <div class='plus'><img src="${pageContext.request.contextPath}/images/btn_game_plus.png"/></div>
                            </div>
                        </div>
                    </div>

                    <div id='NUM' class='on'>
                        <div class='game_show'>
                            <p class="page_p1">玩家:<span class="page_span" style="color:white;">1377****4332</span>&nbsp;<img src="${pageContext.request.contextPath}/images/header_coin.png" alt="" style="display: inline; height: 16px; vertical-align:middle; "><span style="color:#f1de84">+</span><span class="page_span1" style="color:#f1de84"> 660 </span></p>
                            <div class='game_logo'>
                                <span>王者在线人数竞猜</span>
                                <a class='game_allnum'>000,000,000</a>
                                <img src="${pageContext.request.contextPath}/images/game_num_box_bg.png"/>
                                <div class='game_num_box'>

                                     <p class="game_num_box_p infinite">10</p>
                                     <img src="${pageContext.request.contextPath}/images/game_num_end_bg.png"/ class="game_num_box_img">
                                    <span>
                                        <img src="${pageContext.request.contextPath}/images/game_num_border.png">
                                        <div>
                                            <a>0</a>
                                            <a>1</a>
                                            <a>2</a>
                                            <a>3</a>
                                            <a>4</a>
                                            <a>5</a>
                                            <a>6</a>
                                            <a>7</a>
                                            <a>8</a>
                                            <a>9</a>
                                        </div>
                                    </span>
                                    <span>
                                        <img src="${pageContext.request.contextPath}/images/game_num_border.png">
                                        <div>
                                            <a>0</a>
                                            <a>1</a>
                                            <a>2</a>
                                            <a>3</a>
                                            <a>4</a>
                                            <a>5</a>
                                            <a>6</a>
                                            <a>7</a>
                                            <a>8</a>
                                            <a>9</a>
                                        </div>
                                    </span>
                                    <span>
                                        <img src="${pageContext.request.contextPath}/images/game_num_border.png">
                                        <div>
                                            <a>0</a>
                                            <a>1</a>
                                            <a>2</a>
                                            <a>3</a>
                                            <a>4</a>
                                            <a>5</a>
                                            <a>6</a>
                                            <a>7</a>
                                            <a>8</a>
                                            <a>9</a>
                                        </div>
                                    </span>
                                </div>
                                <div class='game_num_end'>
                                    <img src="${pageContext.request.contextPath}/images/game_num_end_bg.png"/>
                                    <span>7+2+3=12</span>
                                    <a>小</a>
                                </div>
                            </div>
                            <div class='game_chest_box'>
                                <div class='game_chest_rate'>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                                <div class='game_chest_light none'>
                                    <img src="${pageContext.request.contextPath}/images/game_chest_light.png"/>
                                </div>
                                <div class='game_chest_img'>
                                </div>
                            </div>
                            <div class='game_timer_box'>
                                <div class='game_timer_bg'>
                                    <img src="${pageContext.request.contextPath}/images/game_timer_bg.png"/>
                                </div>
                                <span><a>-</a>s</span>
                            </div>
                        </div>
                        <!-- <div class='game_num_show'>
                            <div class='game_num_bg'>
                                <img src="${pageContext.request.contextPath}/images/game_num_bg.png"/>
                            </div>
                            <p>王者荣耀同时在线人数竞猜开奖</p>
                            <span></span>
                            <div class='game_num_stat'>
                               <b>大</b>
                            </div>
                        </div> -->
                        <div class='game_choose'>
                            <span class='big'><a>大<b>1:2</b></a></span>
                            <span class='singular'><a>顺子<b>1:60</b></a></span>
                            <span class='straight'><a>单号<b>1:60</b></a></span>
                            <span class='little'><a>小<b>1:2</b></a></span>
                            <span class='dual'><a>三条<b>1:60</b></a></span>
                            <span class='set'><a>双号<b>1:60</b></a></span>
                        </div>
                        <div class='game_input'>
                            <div class="z_show">
                            <span>停止下单</span>
                            </div>
                            <span class='max btn_b'>撤回</span>
                            <span class='deal btn_y'>下注</span>
                            <div class='moneyinput'>
                                <input type="number" value="10" onchange="check_value(this);"/>
                                <div class='minus'><img src="${pageContext.request.contextPath}/images/btn_game_minus.png"/></div>
                                <div class='plus'><img src="${pageContext.request.contextPath}/images/btn_game_plus.png"/></div>
                            </div>
                        </div>
                    </div>
<!--


                    <div id='SING-PLUR'>
                        <div class='game_show'>
                            <div class='game_logo'>
                                <img src="${pageContext.request.contextPath}/images/game_logo.png"/>
                            </div>
                            <div class='game_chest_box'>
                                <div class='game_chest_rate'>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                </div>
                                <div class='game_chest_light none'>
                                    <img src="${pageContext.request.contextPath}/images/game_chest_light.png"/>
                                </div>
                                <div class='game_chest_img'>
                                </div>
                            </div>
                            <div class='game_timer_box'>
                                <div class='game_timer_bg'>
                                    <img src="${pageContext.request.contextPath}/images/game_timer_bg.png"/>
                                </div>
                                <span><a>-</a>s</span>
                            </div>
                        </div>
                        <div class='game_num_show'>
                            <div class='game_num_bg'>
                                <img src="${pageContext.request.contextPath}/images/game_num_bg.png"/>
                            </div>
                            <p>王者荣耀同时在线人数竞猜开奖</p>
                            <span></span>
                            <div class='game_num_stat'>
                               <b>单</b>
                               <b>双</b>
                            </div>
                        </div>
                        <div class='game_choose'>
                            <span class='on'><a>三条<b>1:60</b></a></span>
                            <span><a>顺子<b>1:60</b></a></span>
                            <span><a>单号<b>1:60</b></a></span>
                            <span><a>双号<b>1:60</b></a></span>
                        </div>
                        <div class='game_input'>
                            <span class='max btn_b'>最大</span>
                            <span class='deal btn_y'>下注</span>
                            <div class='moneyinput'>
                                <input type="number" value="10" onchange="check_value(this);"/>
                                <div class='minus'><img src="${pageContext.request.contextPath}/images/btn_game_minus.png"/></div>
                                <div class='plus'><img src="${pageContext.request.contextPath}/images/btn_game_plus.png"/></div>
                            </div>
                        </div>
                    </div>
 -->

                </div>
            </div>

        </div>

    </div>



    </body>
</html>