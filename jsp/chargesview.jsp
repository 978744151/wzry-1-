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
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/charges.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <script type="text/javascript">
        // var verifyTimer = null;
        // var verifySecond = 60;
        // var nowSecond = 0;
        var money;
        var view_tx
        function page_onload(){

           setTimeout(function(){
                  money = $_user.fanlimoney
                  console.log(money);
                  $('.view_money').html(money)
            },200);
              $('.view_confirm').on('click',function(){
                $.ajax({
                    url:" /trade/commission",
                    type:"get",
                    data:{"money":money},
                    success:function(data){
                        view_tx = $('.view_tx').val()
                        console.log(view_tx);
                        console.log(data);
                        if(view_tx>money){
                            errorMsg("你没有足够的金额")
                        }
                        else if(view_tx>12 && data.status == 1){
                            errorMsg("提现成功")
                        }else{
                            errorMsg(data.message)
                        }
                    }
                })
            })

        //     //initPage();
        //     $('.back_btn').on('click',function(){
        //         history.go(-1);
        //     });
        //     $('.charges_submit').on('click',function(){
        //         cashout();
        //     });
        //     BindVeriftyBtn();
        }
        // function BindVeriftyBtn(){
        //     $('.verify_input>a').on('click',function(){
        //         var phonenum = $('#phonenum').val();
        //         if(phonenum==''){
        //             errorMsg('请填写手机号');
        //             return false;
        //         }
        //         //AJAX
        //         nowSecond = verifySecond;
        //         errorMsg('发送成功');
        //         $(this).addClass('unclick');
        //         $('.verify_input>a').unbind('click');
        //         $('.verify_input>a').html('重新发送('+nowSecond+')');
        //         verifyTimer = setInterval(function(){
        //             nowSecond--;
        //             if( nowSecond <= 0 ){
        //                 $('.verify_input>a').removeClass('unclick');
        //                 $('.verify_input>a').html('获取验证码');
        //                 BindVeriftyBtn();
        //                 clearInterval(verifyTimer);
        //                 verifyTimer = null;
        //             }else{
        //                 $('.verify_input>a').html('重新发送('+nowSecond+')');
        //             }
        //         },1000);
        //     })
        // }
        // function cashout(){
        //     var name = $('#name').val();
        //     var phonenum = $('#phonenum').val();
        //     var idcard = $('#idcard').val();
        //     var cardnum = $('#cardnum').val();
        //     if(name=='') {errorMsg('请填写真实姓名');return false;}
        //     if(idcard=='') {errorMsg('请填写身份证号');return false;}
        //     if(cardnum=='') {errorMsg('请填写银行卡号');return false;}
        //     if(phonenum=='') {errorMsg('请填写手机号');return false;}
        //     if(verify=='') {errorMsg('请填写验证码');return false;}
        //     //AJAX
        // }
        function view_tx(){

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
            <img src="${pageContext.request.contextPath}/images/login_bg.jpg"/>
        </div>
        <div class='page_body' style="text-align: center;">
            <p class="view_p">可提现佣金余额：<span class="view_money"></span></p>
            <div class="view_d">
                <img src="${pageContext.request.contextPath}/images/view_bottom.png" alt="">
                <input class="view_tx" type="text" placeholder="请输入提现金额">
            </div>
            <button type="" class="view_confirm">确认提现</button>
        </div>

    </div>
    </body>
</html>