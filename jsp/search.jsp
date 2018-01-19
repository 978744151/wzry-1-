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
    <%--<script src="${pageContext.request.contextPath}/js/game.js"></script>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">

        var searchContentiScroll = new Array();

        function page_onload(){
            //initPage();
            checkLogin(
                function(){
                    AjaxOrder();
                },
                function(){
                  errorMsg('请登陆后尝试下单');
                  setTimeout(function(){
                      top.location.href = '/jsp/login.jsp';
                  },500);
                }
            );


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
                    if(show_box=='ORDER'){
                        AjaxOrder();
                    }
                    if(show_box=='CASH'){
                        AjaxCash();
                    }
                    if(show_box=='PAY'){
                        AjaxPay();
                    }
                    if(show_box=='PAYJK'){
                        AjaxPAYJK()
                    }
                }
            });
        }
        function iScrollBind(){
            $('.search_content>div').each(function(){
                $_thisid = $(this).attr('id');
                var thisIScroll = new IScroll('#'+$_thisid,{
                    mouseWheel:true,
                    scrollbars:false,
                    bounce:false,
                    click:iScrollClick()
                });
                searchContentiScroll.push(thisIScroll);
            });
        }
        function AjaxOrder(){//获取结果接口
            $.ajax({
                url:"/trade/orderList",
                type:'GET',
                data:{'page':'0'},
                dataType: 'json',
                success: function(data){
                    // alert(data);
                    $("#ORDER table").html('');
                    var html = '';
                    html += '<tr>';
                    html += '<td>场次</td>';
                    html += '<td>投注金额</td>';
                    html += '<td>投注内容</td>';
                    html += '<td>状态</td>';
                    html += '</tr>';
                    for(var i =0;i<data.length;i++){
                        var capital = '';
                        if( heroOptionArray.length >= data[i].capital ){
                            var capitalArr = heroOptionArray;
                        }else{
                            var capitalArr = numOptionArray;
                        }
                        for(var c =0;c<capitalArr.length;c++){
                            if(data[i].capital == capitalArr[c][0]){
                                capital = capitalArr[c][1];
                            }
                        }
                        var is_win = '';
                        if(data[i].is_win == 0){
                            is_win = '<td class="green">亏损</td>';
                        }else if(data[i].is_win == 1){
                            is_win = '<td class="red">盈利</td>';
                        }else{
                            is_win = '<td class="gray">和局</td>';
                        }
                        if(data[i].type == 0){
                            is_win = '<td >处理中</td>';
                        }
                        html += '<tr>';
                        html += '<td>'+data[i].issue+'</td>';
                        html += '<td>￥'+data[i].amount+'</td>';
                        html += '<td>'+capital+'</td>';
                        html += is_win;
                        html += '</tr>';
                    }
                    $('#ORDER table').html(html);
                    iScrollBind();
                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
            });

        }

        function AjaxPAYJK(){
            $.ajax({
            url:"http://gok.tc2stgs.com/login/payrecord?page=1",
            type:"get",
            dataType: 'json',
            success: function(data){
                //console.log(data)
                $("#PAYJK table").html('');
                var html = '';
                html += '<tr>';
                html += '<td>日期</td>';
                html += '<td>订单号</td>';
                html += '<td>充值金额</td>';
                html += '<td>状态</td>';
                html += '</tr>';
                for(var i =0;i<data.message.length;i++){
                    var status = '';

                    if(data.message[i].status == 4){
                    status = '<td >假充值，充值异常</td>';
                    }
                    if(data.message[i].status == 3){
                    status = '<td >失败</td>';
                    }
                    if(data.message[i].status == 2){
                        status = '<td class="red">成功</td>';
                    }
                    if(data.message[i].status == 1){
                        status = '<td class="green">已付款</td>';
                    }
                    if(data.message[i].status == 0){
                    status = '<td class="green">未成功</td>';
                    }
                    if(data.message[i].status == -1){
                    status = '<td class="green">取消状态</td>';
                    }

                    var date = new Date();
                    date.setTime(parseInt(data.message[i].createtime)*1000);
                    var year=date.getYear()-100;
                    var month=date.getMonth()+1;
                    var day = date.getDate();
                    
                    html += '<tr>';
                    html += '<td>'+year+'.'+month+'.'+day+'</td>';
                    html += '<td>'+data.message[i].ordersn+'</td>';
                    html += '<td>￥'+data.message[i].price+'</td>';
                    html += status;
                    html += '</tr>';
                }

                $("#PAYJK table").html(html);
                iScrollBind();
            },
            error: function(e){
                errorMsg('网络错误,请稍后再试');
            }
        })
    }
        function AjaxPay(){//获取结果接口
            $.ajax({
                url:"/trade/payList",
                type:'GET',
                data:{'page':'0'},
                dataType: 'json',
                success: function(data){
                    //alert(data);
                    for(var i =0;i<data.length;i++){
                        var status = '';
                        if(data[i].status == 2){
                            status = '<td class="red">已成功</td>';
                        }
                        if(data[i].status == 1){
                            status = '<td class="green">失败</td>';
                        }
                        if(data[i].status == 0){
                            status = '<td >处理中</td>';
                        }
                        var html = ''
                        html += '<tr>';
                        html += '<td>'+data[i].date+'</td>';
                        html += '<td>￥'+data[i].id+'</td>';
                        html += '<td>'+data[i].amount+'</td>';
                        html += status;
                        html += '</tr>';
                        $('#CASH table').append(html);
                    }
                    iScrollBind();
                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
            });
        }
        function AjaxCash(){//获取结果接口
            $.ajax({
                url:"/trade/cashList",
                type:'GET',
                data:{'page':'0'},
                dataType: 'json',
                success: function(data){
                    //alert(data);
                    for(var i =0;i<data.length;i++){
                        var status = '';
                        if(data[i].status == 2){
                            status = '<td class="red">已成功</td>';
                        }
                        if(data[i].status == 1){
                            status = '<td class="green">驳回</td>';
                        }
                        if(data[i].status == 0){
                            status = '<td >处理中</td>';
                        }
                        var html = ''
                        html += '<tr class="">';
                        html += '<td>'+data[i].date+'</td>';
                        html += '<td>￥'+data[i].id+'</td>';
                        html += '<td>'+data[i].amount+'</td>';
                        html += status;
                        html += '</tr>';
                        $('#CASH table').append(html);
                    }
                    iScrollBind();
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
        <div class='page_bg'>
            <img src="${pageContext.request.contextPath}/images/vip_bg.jpg"/>
        </div>
        <div class='page_body'>
            <div class='search_nav'>
                <span name='ORDER' style='width:50%;' class='on'>竞猜</span>
                <span name='PAYJK' style='width:50%;'>充值</span>
                <%--<span name='CASH' style='width:33%;'>提现</span>--%>
                <!-- <span name='CHARGES'>佣金</span> -->
            </div>
            <div class='search_content'>
                <div id='PAYJK'>
                    <div>
                        <table>
                            <tr>
                                <th>日期</th>
                                <th>订单号</th>
                                <th>充值金额</th>
                                <th>状态</th>
                            </tr><!--
                            <tr>
                                <td>10/20 17:00</td>
                                <td>C34589712</td>
                                <td>￥100</td>
                                <td class='red'>已成功</td>
                            </tr> -->
                        </table>
                    </div>
                </div>
                <div id='CASH'>
                    <div>
                        <table>
                            <tr>
                                <th>日期</th>
                                <th>订单号</th>
                                <th>提现金额</th>
                                <th>状态</th>
                            </tr>
                           <!--  <tr>
                               <td>11/11 13:00</td>
                               <td>K485468484</td>
                               <td>￥800</td>
                               <td class='gray'>失败</td>
                           </tr> -->
                        </table>
                    </div>
                </div>
                <div id='pay'>
                    <div>
                    <table>
                        <tr>
                            <th>日期</th>
                            <th>来源用户</th>
                            <th>金额</th>
                            <th>状态</th>
                        </tr><!--
                        <tr>
                        <td>10/20 17:00</td>
                        <td>Pyxxxx</td>
                        <td>￥10</td>
                        <td>处理中</td>
                        </tr>
                        <tr>
                        <td>10/20 17:00</td>
                        <td>Pyxxxx</td>
                        <td>￥3</td>
                        <td class='red'>已到账</td>
                        </tr> -->
                        </table>
                    </div>
                </div>
                <div id='CHARGES'>
                    <div>
                        <table>
                            <tr>
                                <th>日期</th>
                                <th>来源用户</th>
                                <th>金额</th>
                                <th>状态</th>
                            </tr><!--
                            <tr>
                                <td>10/20 17:00</td>
                                <td>Pyxxxx</td>
                                <td>￥10</td>
                                <td>处理中</td>
                            </tr>
                            <tr>
                                <td>10/20 17:00</td>
                                <td>Pyxxxx</td>
                                <td>￥3</td>
                                <td class='red'>已到账</td>
                            </tr> -->
                        </table>
                    </div>
                </div>
                <div id='ORDER' class='on'>
                    <div>
                        <table>
                            <tr>
                                <th>场次</th>
                                <th>投注金额</th>
                                <th>投注内容</th>
                                <th>状态</th>
                            </tr>
                            <!-- <tr>
                                <td>10576845</td>
                                <td>￥100</td>
                                <td>王昭君</td>
                                <td class='red'>盈利</td>
                            </tr> -->
                        </table>
                    </div>
                </div>
            </div>


        </div>
    </div>
    </body>
</html>