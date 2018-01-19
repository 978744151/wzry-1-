<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="zh">
    <meta charset="utf-8">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no"/>
    <!-- <link rel="shortcut icon" href="{HOME_THEME_PATH}../images/base/title.png"> -->
    <meta name="applicable-device" content="pc,mobile"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/iscroll.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/game.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css"><!--
    <link rel="stylesheet" href="css/imageflow.css"> -->
    <script src='${pageContext.request.contextPath}/js/numberAnimate.js'></script><!--
    <script src='js/imageflow.js'></script> -->
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script type="text/javascript">
        var mindeal = 10;//最小下单金额
        var maxdeal = 5000;//最大下单金额

        var touchspeed = 50;//增减按钮触发频率
        var touchlong = 0;
        var touchtimer = '';
        var touchthis = '';

        var numRun_SINGPLUR,numRun_BIGLITTLE;
        var numspeed = 2000;
        var numshow = '11238468';

        var heartbeatTimer = null;
        var heartbeattime = 10;
        var heartstoptime = 5;
        var timeover = 0;

        var imageflowTimer = null;
        var imageflow = '';//$('.imageflow>span')
        var imageflow_left = 10;//间距
        var imageflow_depth = 0.8;//深度
        var imageflow_count = 2;//一边有几个
        var imageflow_shift = 3;
        var nowimglength = 0;//起始元素

        function heartbeat(){
            var tureBeatTime = heartbeattime + heartstoptime;
            var timestamp = Date.parse(new Date())/1000;
            var second = tureBeatTime - timestamp % tureBeatTime - 1 ;
            
            if(( second > heartbeattime || second <= 0 ) && timeover == 0){
                timeover = 1;
                numshow = parseInt(100000000 * Math.random() + 1);
                updatenumber(numshow);
                imageflowStartanimate();
            }else if( second <= heartbeattime && second > 0 ){
                timeover = 0;
                imageflowStopanimate();
            }else{
                second = 0;
            }
            $('.game_timer_box>span>a').html(second);

        }


        function imageflowinit(){
            imageflow = $('.imageflow>span');
            var imgflowlength = imageflow.length-1;//总儿子数
            var thisimglength = 0;
            imageflow.each(function(){
                if((thisimglength - imageflow_shift ) <= imageflow_count && (thisimglength - imageflow_shift ) >= 0){//偏移量左边显示图片
                    $(this).css({
                        'z-index': 10 + (thisimglength - imageflow_shift ) ,
                        'margin-left': (thisimglength - imageflow_shift ) * imageflow_left - imageflow_count * imageflow_left + '%',
                        'margin-top': (100 - 100 * Math.pow(imageflow_depth, imageflow_count - (thisimglength - imageflow_shift ))) / 4 + '%',
                        'height': 100 * Math.pow(imageflow_depth, imageflow_count - (thisimglength - imageflow_shift )) + '%',
                        'opacity':'1'
                    });    
                }else if((thisimglength - imageflow_shift) <= imageflow_count*2 && (thisimglength - imageflow_shift) >= imageflow_count ){
                    $(this).css({//偏移量右边显示图片
                        'z-index': 10 + imageflow_count*2- (thisimglength - imageflow_shift),
                        'margin-left': (thisimglength - imageflow_shift) * imageflow_left - imageflow_count * imageflow_left + '%',
                        'margin-top': (100 - 100 * Math.pow(imageflow_depth, (thisimglength - imageflow_shift) - imageflow_count)) / 4 + '%',
                        'height': 100 * Math.pow(imageflow_depth,(thisimglength - imageflow_shift) - imageflow_count) + '%',
                        'opacity':'1'
                    });
                }else{
                    $(this).css({
                        'z-index': 10 ,
                        'margin-left': imageflow_count * imageflow_left + '%',
                        'margin-top': (100 - 100 * Math.pow(imageflow_depth, imageflow_count)) / 4 + '%',
                        'height': 100 * Math.pow(imageflow_depth, imageflow_count) + '%',
                        'opacity':'0'
                    });
                }
                thisimglength++;
            })
            if(imgflowlength - imageflow_shift - imageflow_count*2 < 0){
                thisimglength = 0;
                imageflow.each(function(){
                    if( imgflowlength - imageflow_shift + thisimglength + 1 < imageflow_count  && imgflowlength - imageflow_shift + thisimglength + 1 >= 0){
                        $(this).css({//偏移量右边显示图片
                            'z-index': 10 + (imgflowlength - imageflow_shift + thisimglength + 1) ,
                            'margin-left': (imgflowlength - imageflow_shift + thisimglength + 1) * imageflow_left - imageflow_count * imageflow_left + '%',
                            'margin-top': (100 - 100 * Math.pow(imageflow_depth, imageflow_count - (imgflowlength - imageflow_shift + thisimglength + 1))) / 4 + '%',
                            'height': 100 * Math.pow(imageflow_depth, imageflow_count - (imgflowlength - imageflow_shift + thisimglength + 1)) + '%',
                            'opacity':'1'
                        });
                    }else if(imgflowlength - imageflow_shift + thisimglength + 1 <= imageflow_count*2 && imgflowlength - imageflow_shift + thisimglength + 1 >= imageflow_count ){
                        $(this).css({//偏移量右边显示图片
                            'z-index': 10 + (-( imgflowlength - imageflow_shift - imageflow_count*2 + 1) - thisimglength) ,
                            'margin-left': (imgflowlength - imageflow_shift + thisimglength + 1) * imageflow_left - imageflow_count * imageflow_left + '%',
                            'margin-top': (100 - 100 * Math.pow(imageflow_depth, (imgflowlength - imageflow_shift + thisimglength + 1) - imageflow_count)) / 4 + '%',
                            'height': 100 * Math.pow(imageflow_depth,(imgflowlength - imageflow_shift + thisimglength + 1) - imageflow_count) + '%',
                            'opacity':'1'
                        });
                    }
                    thisimglength++;
                });
                if(imageflow_shift - imgflowlength - (imageflow_count) == 0){
                    imageflow_shift = 1;
                }
            }
            
        }



        function imageflowStartanimate(){
            if(imageflowTimer == null){
                $('#HERO .game_choose').fadeOut(200);
                $('#HERO .game_show').animate({'height':'70%','top':'10%'});
                $('#HERO .game_chest_box').fadeOut(200);
                setTimeout(function(){
                    imageflowTimer = setInterval(function(){
                        imageflow_shift++;
                        imageflowinit();
                    },150)  
                },500)    
            }
        }
        function imageflowStopanimate(){
            if(imageflowTimer != null){
                setTimeout(function(){
                    $('#HERO .game_choose').fadeIn(200);
                    $('#HERO .game_chest_box').fadeIn(200);
                    $('#HERO .game_show').animate({'height':'40%','top':'0%'});
                },500);
                clearInterval(imageflowTimer);
                imageflowTimer = null;
            }
        }

        function check_value(_self){
            var value = _self.value;
            if(value==''){
                value = mindeal;
            }else if(parseInt(value)>maxdeal){
                value = maxdeal;
            }else if(parseInt(value)<mindeal){
                value = mindeal;
            }
            _self.value = value;
        }
        function BindTouchTime(op){
            var value = touchthis.parent().find('input')[0].value;
            var num = 10;
            if(touchlong>20){
                num = 10;
            }
            if(touchlong>40){
                num = 100;
            }
            if(touchlong>90){
                //num = 1000;
            }
            if(touchlong==1||touchlong>5){
                if(op=='+'){
                    value = parseInt(value) + num > maxdeal ? maxdeal : parseInt(value) + num;
                }else{
                    value = parseInt(value) - num < mindeal ? mindeal : parseInt(value) - num;
                }
            }
            touchthis.parent().find('input')[0].value = value;
        }

        function clearTouchTimer(){
            clearInterval(touchtimer);
            touchtimer = '';
            touchlong = 0;
        }
        function updatenumber(newnum){

            numRun_SINGPLUR = $("#SING-PLUR .game_num_show>span").numberAnimate({
                num:newnum,
                speed:numspeed,
                numlength:true
            });
            numRun_BIGLITTLE = $("#BIG-LITTLE .game_num_show>span").numberAnimate({
                num:newnum,
                speed:numspeed,
                numlength:true
            });
            //numRun_SINGPLUR.resetData(newnum);
            //numRun_BIGLITTLE.resetData(newnum);
        }
        function initnumber(){
            //初始化数字动效
            numRun_SINGPLUR = $("#SING-PLUR .game_num_show>span").numberAnimate({
                num:numshow,
                speed:0,
                numlength:true
            });
            numRun_BIGLITTLE = $("#BIG-LITTLE .game_num_show>span").numberAnimate({
                num:numshow,
                speed:0,
                numlength:true
            });
        }
        function BindChestEvent(){
            $('.game_chest_img').unbind('click');
            $('.game_chest_img_on').unbind('click');

            $('.game_chest_img').on('click',function(){
                var oncount = 0;
                oncount = $(this).parent().find('.game_chest_rate>.on').length;
                $(this).parent().find('.game_chest_rate>span').eq(5-oncount-1).addClass('on');
                if(oncount>=4){
                    $(this).addClass('game_chest_img_on');
                    $(this).parent().find('.game_chest_rate>span').addClass('on');
                    $(this).parent().find('.game_chest_light').removeClass('none');
                    BindChestEvent();
                }
            });
            $('.game_chest_img_on').on('click',function(){
                $(this).removeClass('game_chest_img_on');
                $(this).parent().find('.game_chest_rate>span').removeClass('on');
                $(this).parent().find('.game_chest_light').addClass('none');
                BindChestEvent();
            });
        }
        function page_onload(){
            imageflowinit();
            $('.imageflow>span').on('click',function(){
                imageflowanimate();
            });
            initPage();
            //心跳
            heartbeatTimer = setInterval(function(){
                heartbeat();
            },1000);
            //初始化数字
            initnumber();
            BindChestEvent();

            //下单选项按钮事件
            $('.game_choose>span').on('click',function(){
                if($(this).hasClass('on')){
                    return false;
                }else{
                    $(this).parent().find('span').removeClass('on');
                    $(this).addClass('on');
                }
            });



            //切换游戏按钮事件
            $('.game_nav>span').on('click',function(){
                var _self = $(this);
                if(_self.hasClass('on')){
                    return false;
                }else{
                    $('.game_nav>span').removeClass('on');
                    var show_box = _self.attr('name');
                    $('.game_content>div').removeClass('on');
                    $('#'+show_box).addClass('on');
                    _self.addClass('on');
                    initnumber();
                }
            });



            //加减号按钮事件
            $('.minus').on('touchstart',function(e){
                e.preventDefault();
                $(this).css({'height': '94%','top': '3%'});
                touchthis = $(this);
                touchtimer = setInterval(function(){
                    BindTouchTime('-');
                    touchlong++;
                },touchspeed);
                touchlong++;
            });
            $('.plus').on('touchstart',function(e){
                e.preventDefault();
                $(this).css({'height': '94%','top': '3%'});
                touchthis = $(this);
                touchtimer = setInterval(function(){
                    touchlong++;
                    BindTouchTime('+');
                },touchspeed);
            });
            $('.minus').on('touchend',function(){
                clearTouchTimer();
                $(this).css({'height': '100%','top': '0%'});
            });
            $('.plus').on('touchend',function(){
                clearTouchTimer();
                $(this).css({'height': '100%','top': '0%'});
            });

            //最大按钮事件
            $('.max').on('click',function(){
                $(this).parent().find('input')[0].value = maxdeal;
            });
            $('.max').on('touchstart',function(){
                $(this).css({'width':'22%','left':'3.5%','height':'38px','margin-top':'11px'});
            });
            $('.max').on('touchend',function(){
                $(this).css({'width':'23%','left':'3%','height':'40px','margin-top':'10px'});
            });

            //下单按钮事件
            $('.deal').on('click',function(){
                var value = $(this).parent().find('input')[0].value;
                var type = $(this).parent().parent().attr('id');
                //AJAX
            });
            $('.deal').on('touchstart',function(){
                $(this).css({'width':'22%','right':'3.5%','height':'38px','margin-top':'11px'});
            });
            $('.deal').on('touchend',function(){
                $(this).css({'width':'23%','right':'3%','height':'40px','margin-top':'10px'});
            });
            




            

            //headerBTN动画效果
            $('.btnbox>span').on('touchstart',function(){
                $(this).css({
                    'height': '18px',
                    'margin': '29px 0px',
                    'padding': '0px 8px'
                });
            });
            $('.btnbox>span').on('touchend',function(){
                $(this).css({
                    'height': '20px',
                    'margin': '28px 0px',
                    'padding': '0px 7px'
                });
            });

            $('.alert_close').on('click',function(){
                $(this).parent().parent().parent().fadeOut(200);
            });
            $('.btnbox>span').on('click',function(){
                var boxid = $(this).attr('name');
                $('#'+boxid).fadeIn(200);
            })
        }
    </script>
</head>
    <body onselectstart="return false;" oncontextmenu="self.event.returnValue=false;">
    <div class='loadingbox' id='loadingbox'>
        <img src="../images/game_logo.png"/>
        <span>LOADING</span>
    </div>
    <div class='alert_box' id='BAG'>
        <div class='alert_body'>
            <div class='alert_title'>
                <span>我的背包</span>
                <div class='alert_close'>
                    <img src="../images/alert_close_btn.png"/>
                </div>
            </div>
        </div>
    </div>
    <div class='alert_box' id='LINE'>
        <div class='alert_body'>
            <div class='alert_title'>
                <span>走势图</span>
                <div class='alert_close'>
                    <img src="../images/alert_close_btn.png"/>
                </div>
            </div>
            <div class='alert_content'>
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
                <tr>
                    <td>0572</td>
                    <td><img src="../images/line_icon_y.png"></td>
                    <td></td>
                    <td><img src="../images/line_icon_b.png"></td>
                    <td></td>
                    <td><img src="../images/line_icon_b.png"></td>
                    <td></td>
                    <td>王昭君</td>
                </tr>
            </table>
            </div>
        </div>
    </div>
    <div class='alert_box' id='QUES'>
        <div class='alert_body'>
            <div class='alert_title'>
                <span>帮助</span>
                <div class='alert_close'>
                    <img src="../images/alert_close_btn.png"/>
                </div>
            </div>
        </div>
    </div>
    <div class='page_box'>
        <div class='page_bg'>
            <img src="../images/bg.jpg"/>
        </div>
        <div class='page_body'>

            <div class='header'>
                <div class='infobox'>
                    <div class='headimg'>
                        <img src="../images/headimg.jpg"/>
                    </div>
                    <span class='header_nickname'>昵称：小马同学</span>
                    <div class='header_coin_box'>
                        <div class='header_coin'><img src="../images/header_coin.png"/></div>
                        <span class='header_coinnum'>199999</span>
                        <div class='header_plus'><img src="../images/header_plus.png"/></div>
                    </div>
                </div>
                <div class='btnbox'>
                    <span class='header_icon_bag' name='BAG'><img src="../images/header_icon_bag.png"/></span>
                    <span class='header_icon_line' name='LINE'><img src="../images/header_icon_line.png"/></span>
                    <span class='header_icon_ques' name='QUES'><img src="../images/header_icon_ques.png"/></span>
                </div>
            </div>
            <div class='clear'></div>

            <div class='game_box'>
                <div class='game_nav'>
                    <span name='HERO' class='on'>英雄场</span>
                    <span name='BIG-LITTLE'>大小场</span>
                    <span name='SING-PLUR'>单双场</span>
                </div>
                <div class='game_content'>


                    <div id='HERO' class='on'>
                        <div class='game_show'>
                            <div class='game_logo'>
                                <div class="imageflow"> 
                                    <span><img src="../images/hero.png"/></span>
                                    <span><img src="../images/hero_q.png"/></span>
                                    <span><img src="../images/hero_x.png"/></span>
                                    <span><img src="../images/hero_l.png"/></span>
                                    <span><img src="../images/hero_z.png"/></span>
                                    <span><img src="../images/hero_j.png"/></span>
                                </div>
                            </div>
                            <div class='game_chest_box'>
                                <div class='game_chest_rate'>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                </div>
                                <div class='game_chest_light'>
                                    <img src="../images/game_chest_light.png"/>
                                </div>
                                <div class='game_chest_img game_chest_img_on'>
                                </div>
                            </div>
                            <div class='game_timer_box'>
                                <div class='game_timer_bg'>
                                    <img src="../images/game_timer_bg.png"/>
                                </div>
                                <span><a>-</a>s</span>
                            </div>
                        </div>
                        <div class='game_choose'>
                            <span class='on'><a>孙尚香<b>1:60</b></a></span>
                            <span><a>孙尚香<b>1:860</b></a></span>
                            <span><a>孙尚香<b>1:60</b></a></span>
                            <span><a>孙尚香<b>1:60</b></a></span>
                            <span><a>孙尚香<b>1:60</b></a></span>
                            <span><a>孙尚香<b>1:60</b></a></span>
                            <span><a>孙尚香<b>1:60</b></a></span>
                            <span><a>孙尚香<b>1:60</b></a></span>
                            <span><a>孙尚香<b>1:60</b></a></span>
                        </div>
                        <div class='game_input'>
                            <span class='max btn_b'>最大</span>
                            <span class='deal btn_y'>下注</span>
                            <div class='moneyinput'>
                                <input type="number" value="10" onchange="check_value(this);"/>
                                <div class='minus'><img src="../images/btn_game_minus.png"/></div>
                                <div class='plus'><img src="../images/btn_game_plus.png"/></div>
                            </div>
                        </div>
                    </div>

                    <div id='BIG-LITTLE'>
                        <div class='game_show'>
                            <div class='game_logo'>
                                <img src="../images/game_logo.png"/>
                            </div>
                            <div class='game_chest_box'>
                                <div class='game_chest_rate'>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                    <span class='on'></span>
                                </div>
                                <div class='game_chest_light'>
                                    <img src="../images/game_chest_light.png"/>
                                </div>
                                <div class='game_chest_img game_chest_img_on'>
                                </div>
                            </div>
                            <div class='game_timer_box'>
                                <div class='game_timer_bg'>
                                    <img src="../images/game_timer_bg.png"/>
                                </div>
                                <span><a>-</a>s</span>
                            </div>
                        </div>
                        <div class='game_num_show'>
                            <div class='game_num_bg'>
                                <img src="../images/game_num_bg.png"/>
                            </div>
                            <p>王者荣耀同时在线人数竞猜开奖</p>
                            <span></span>
                            <div class='game_num_stat'>
                               <b>大</b>
                            </div>
                        </div>
                        <div class='game_choose'>
                            <span class='on'><a>大<b>1:2</b></a></span>
                            <span><a>合<b>1:8</b></a></span>
                            <span><a>小<b>1:2</b></a></span>
                        </div>
                        <div class='game_input'>
                            <span class='max btn_b'>最大</span>
                            <span class='deal btn_y'>下注</span>
                            <div class='moneyinput'>
                                <input type="number" value="10" onchange="check_value(this);"/>
                                <div class='minus'><img src="../images/btn_game_minus.png"/></div>
                                <div class='plus'><img src="../images/btn_game_plus.png"/></div>
                            </div>
                        </div>
                    </div>



                    <div id='SING-PLUR'>
                        <div class='game_show'>
                            <div class='game_logo'>
                                <img src="../images/game_logo.png"/>
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
                                    <img src="../images/game_chest_light.png"/>
                                </div>
                                <div class='game_chest_img'>
                                </div>
                            </div>
                            <div class='game_timer_box'>
                                <div class='game_timer_bg'>
                                    <img src="../images/game_timer_bg.png"/>
                                </div>
                                <span><a>-</a>s</span>
                            </div>
                        </div>
                        <div class='game_num_show'>
                            <div class='game_num_bg'>
                                <img src="../images/game_num_bg.png"/>
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
                                <div class='minus'><img src="../images/btn_game_minus.png"/></div>
                                <div class='plus'><img src="../images/btn_game_plus.png"/></div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>

        </div>
        
    </div>


    
    </body>
</html>