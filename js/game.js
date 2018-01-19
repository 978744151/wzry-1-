    var usermoney = 0;
    var lastmoney = 0;
    var addmoney = 0;
    var userinfoTimer = null;
    var dealType = false;
    var heroid = 0;

    var mindeal = 10;//最小下单金额
    var maxdeal = 5000;//最大下单金额

    var touchspeed = 50;//增减按钮触发频率
    var touchlong = 0;
    var touchtimer = '';
    var touchthis = '';

    var numRun_SINGPLUR,numRun_BIGLITTLE;
    var numspeed = 3000;
    var numshow = 0;
    var numArr = new Array();
    var numStop = new Array();
    var numAnimateTimer = '';

    var heartbeatTimer = null;
    var heartbeattime = 55;//时间模式
    var heartstoptime = 5;
    var second_deviation = 0;
    var second_deviation_timer = null;
    var timeover = 0;

    var imageflowTimer = null;
    var imageflowCheckTimer = null;
    var imageflow = '';//$('.imageflow>span')
    var imageflow_left = 10;//间距
    var imageflow_depth = 0.8;//深度
    var imageflow_count = 2;//一边有几个
    var imageflow_shift = 3;//初始偏移量
    var imageflow_target = 0;//目标结果
    var imageflow_type = 0;
    var imageflow_marigintop = -22;//margintop偏移量
    var window_Width = 0;
    var nowimglength = 0;//起始元素
    var path = "${pageContext.request.contextPath}/";
    var index;
    var timer;
    var center_timer;//p标签倒计时
    var center_p;
    //同步倒计时
    function loadSecond_deviation(){
        $.ajax({
            url:"/trade/countdown",
            type:'GET',
            dataType: 'json',
            success: function(data){
                var tureBeatTime = heartbeattime + heartstoptime;
                var timestamp = Date.parse(new Date())/1000;
                var second = tureBeatTime - timestamp % tureBeatTime - 1;
                second_deviation = second - data - 3;
                console.log(data);
                console.log(second);
                console.log(second_deviation);
            }
        });
    }
    //MAIN

    function heartbeat(){
        // 60
        var tureBeatTime = heartbeattime + heartstoptime;
        var timestamp = Date.parse(new Date())/1000;
        var second = tureBeatTime - timestamp % tureBeatTime - 1 - second_deviation;
        second = second > tureBeatTime ? second % tureBeatTime : second;
        // 当定时器结束的时候 进行的动画
        if(( second > heartbeattime || second <= 0 ) && timeover == 0){
            timeover = 1;
            second = 0;
            clearInterval(center_timer);
            $('.game_num_box_p,.game_num_box_p1').fadeOut(200);
            $('.game_num_box_img,.game_num_box_img1').fadeOut(200);
// 停止下单开启
            // $('.deal').unbind('click');
            // // 停止出现
            // $('.z_show').fadeIn(200);
            // // 文字出现
            // //


            $(".game_allnum").fadeOut(200);
            dealType = false;
            $('.game_choose>span>p').each(function(){
                if($(this).find('span').html() == '0'){
                    $(this).parent().removeClass('once');
                    $(this).remove();
                }else{
                    $(this).find('a').html($(this).find('span').html());
                }
            });

            $('.deal').css({'background':'url("../images/btn_unbind.png")','background-size':'100% 100%','color':'white'});

            var sucfunc = function(){
                updatenumber();
                if(heroid){
                    imageflowStartanimate();
                    setTimeout(function(){
                        imageflowStopanimate();
                    },heartstoptime*1000/2)
                }else{
                    $('.choose_border').fadeOut();
                }
                setTimeout(function(){
                    lastmoney = parseInt($('.header_coinnum').html());
                    getUserInfo();
                    setTimeout(function(){
                        $('.header_coinnum').html($_user.coin);
                        addmoney = $_user.coin - lastmoney;
                        if(addmoney>0){
                            $('.header_addcoin').html('+'+addmoney);
                            $('.header_addcoin').fadeIn(100);
                            setTimeout(function(){
                                $('.header_addcoin').fadeOut(500);
                            },1000);
                        }
                    },1000);
                },heartstoptime*1000);
            }
            var errFunc = function(){
                // 停止出现
                $('.z_show').fadeOut(200);
                // 文字出现
                // >???????????????????
                $(".game_allnum").fadeIn(200)
                dealType = true;
                $('.deal').css({'background':'url("../images/btn_yellow.png")','background-size':'100% 100%','color':'#460202'});
                $('.deal').on('click',function(){
                    bindDealBtn(this);
                });
            }
            AjaxGame(sucfunc,errFunc);
        }else if( second <= heartbeattime && second > 0 ){
            timeover = 0;
            dealType = true;
        }else{
            second = 0;
        }
//如果if小于10的情况下
        if(second < 10){
            $('.deal').unbind('click');
            // // 停止出现
            $('.z_show').fadeIn(200);

            // center_p = second+1;
            // console.log(center_p);
            // setInterval(function(){
            //     $('.game_num_box_p').fadeIn()
            //     $('.game_num_box_img').fadeIn()
            //     center_p--
            //     $('.game_num_box_p').html(center_p)
            // },1000)
        }
//如果if等于10的情况下
        if(second == 10){
// 停止下单开启
            $('.deal').unbind('click');
            // // 停止出现
            $('.z_show').fadeIn(100);
            $('.game_timer_box').fadeOut(1500);
            // // 文字出现
            // //
            center_p = 10;
            $('.game_num_box_p,.game_num_box_p1').html(center_p);
            center_timer = setInterval(function(){
                $('.game_num_box_p,.game_num_box_p1').fadeIn();
                $('.game_num_box_img,.game_num_box_img1').fadeIn();
                center_p =  $('.game_num_box_p').text();
                center_p--;
                $('.game_num_box_p').html(center_p);
                $('.game_num_box_p1').html(center_p);
                $('.game_num_box_p,.game_num_box_p1').addClass('animated flash');
            },1000)
                $('.game_num_box_p,.game_num_box_p1').removeClass('animated flash');
        }
        $('.game_timer_box>span>a').html(second);
    }


    //英雄动画滚动
    function imageflowinit(){//执行2.5秒后停止
        imageflow = $('.imageflow>span');
        var imgflowlength = imageflow.length;//总儿子数
        var thisimglength = 0;
        imageflow.each(function(){
            if((thisimglength - imageflow_shift ) <= imageflow_count && (thisimglength - imageflow_shift ) >= 0){//偏移量左边显示图片
                $(this).css({
                    'z-index': 10 + (thisimglength - imageflow_shift ) ,
                    'margin-left': (thisimglength - imageflow_shift ) * imageflow_left - imageflow_count * imageflow_left + '%',
                    'margin-top': (100 + imageflow_marigintop - 100 * Math.pow(imageflow_depth, imageflow_count - (thisimglength - imageflow_shift ))) / 4 + '%',
                    'height': 100 * Math.pow(imageflow_depth, imageflow_count - (thisimglength - imageflow_shift )) + '%',
                    'opacity':'1'
                });
            }else if((thisimglength - imageflow_shift) <= imageflow_count*2 && (thisimglength - imageflow_shift) >= imageflow_count ){
                $(this).css({//偏移量右边显示图片
                    'z-index': 10 + imageflow_count*2- (thisimglength - imageflow_shift),
                    'margin-left': (thisimglength - imageflow_shift) * imageflow_left - imageflow_count * imageflow_left + '%',
                    'margin-top': (100 + imageflow_marigintop - 100 * Math.pow(imageflow_depth, (thisimglength - imageflow_shift) - imageflow_count)) / 4 + '%',
                    'height': 100 * Math.pow(imageflow_depth,(thisimglength - imageflow_shift) - imageflow_count) + '%',
                    'opacity':'1'
                });
            }else{
                $(this).css({
                    'z-index': 10 ,
                    'margin-left': imageflow_count * imageflow_left + '%',
                    'margin-top': (100 + imageflow_marigintop - 100 * Math.pow(imageflow_depth, imageflow_count)) / 4 + '%',
                    'height': 100 * Math.pow(imageflow_depth, imageflow_count) + '%',
                    'opacity':'0'
                });
            }
            thisimglength++;
        })
        if(imgflowlength - imageflow_shift - imageflow_count*2 < 0){
            thisimglength = 0;
            imageflow.each(function(){
                if( imgflowlength - imageflow_shift + thisimglength < imageflow_count  && imgflowlength - imageflow_shift + thisimglength >= 0){
                    $(this).css({//偏移量右边显示图片
                        'z-index': 10 + (imgflowlength - imageflow_shift + thisimglength ) ,
                        'margin-left': (imgflowlength - imageflow_shift + thisimglength ) * imageflow_left - imageflow_count * imageflow_left + '%',
                        'margin-top': (100 + imageflow_marigintop - 100 * Math.pow(imageflow_depth, imageflow_count - (imgflowlength - imageflow_shift + thisimglength ))) / 4 + '%',
                        'height': 100 * Math.pow(imageflow_depth, imageflow_count - (imgflowlength - imageflow_shift + thisimglength)) + '%',
                        'opacity':'1'
                    });
                }else if(imgflowlength - imageflow_shift + thisimglength <= imageflow_count*2 && imgflowlength - imageflow_shift + thisimglength >= imageflow_count ){
                    $(this).css({//偏移量右边显示图片
                        'z-index': 10 + (-( imgflowlength - imageflow_shift - imageflow_count*2 ) - thisimglength) ,
                        'margin-left': (imgflowlength - imageflow_shift + thisimglength ) * imageflow_left - imageflow_count * imageflow_left + '%',
                        'margin-top': (100 + imageflow_marigintop - 100 * Math.pow(imageflow_depth, (imgflowlength - imageflow_shift + thisimglength ) - imageflow_count)) / 4 + '%',
                        'height': 100 * Math.pow(imageflow_depth,(imgflowlength - imageflow_shift + thisimglength ) - imageflow_count) + '%',
                        'opacity':'1'
                    });
                }
                thisimglength++;
            });
            if(imageflow_shift - imgflowlength == 0){
                imageflow_shift = 0;
            }
        }

    }


    //英雄动画开始
    function imageflowStartanimate(){
        $('.choose_border').fadeOut(200);
        setTimeout(function(){
            if(imageflowTimer == null){
                $('#HERO .game_choose').fadeOut(200);
                $('#HERO .game_show').animate({'height':'70%','top':'10%'});
                $('#HERO .game_chest_box').fadeOut(200);
                $('#HERO .game_timer_box').fadeOut(200);
                setTimeout(function(){
                    imageflow_type = 1;
                    imageflowTimer = setInterval(function(){
                        var heronum =  imageflow_shift + imageflow_count < $('#HERO .game_choose>span').length ? imageflow_shift + imageflow_count : imageflow_shift + imageflow_count - $('#HERO .game_choose>span').length;
                        if(imageflow_type == 0 && heronum+1 == imageflow_target ){
                            clearInterval(imageflowTimer);
                            imageflowTimer = null;
                        }else{
                            imageflow_shift++;
                            imageflowinit();
                        }
                    },150)
                },500)
            }
        },400);
    }
    //英雄动画停止
    function imageflowStopanimate(){
        if(imageflow_type==1){

            imageflow_type = 0;
            imageflowCheckTimer = setInterval(function(){
                if(imageflowTimer == null){
                    clearInterval(imageflowCheckTimer);
                    imageflowCheckTimer = null;
                    setTimeout(function(){
                        var heronum =  imageflow_shift + imageflow_count < $('#HERO .game_choose>span').length ? imageflow_shift + imageflow_count : imageflow_shift + imageflow_count - $('#HERO .game_choose>span').length;

                        $('#HERO .game_choose').fadeIn(200);
                        $('#HERO .game_chest_box').fadeIn(200);
                        $('#HERO .game_timer_box').fadeIn(200);
                        $('#HERO .game_show').animate({'height':'40%','top':'0%'},200);
                        setTimeout(function(){
                            $('#HERO .game_choose>span:eq('+heronum+')').addClass('on');
                            $('#HERO .game_choose>span>b').each(function(){
                                if(!$(this).parent().hasClass('on')){
                                    $(this).fadeOut(300);
                                    $(this).parent().find('p').remove();
                                    $(this).parent().removeClass('once');
                                }
                            })
                            setTimeout(function(){
                                $('#HERO .game_choose>span>b').each(function(){
                                    if($(this).parent().hasClass('on')){
                                        var parleft = $(this).parent()[0].offsetLeft;
                                        $(this).animate({'top': '-800%','left': 120 - parleft + 'px',},300);
                                        addChestStep();//增加宝箱进度条
                                    }
                                })
                                setTimeout(function(){
                                    $('#HERO .game_choose>span>b').remove();
                                    $('#HERO .game_choose>span').removeClass('on');
                                    $('#HERO .game_choose>span').removeClass('once');
                                    $('#HERO .game_choose>span>p').remove();
                                    dealType = true;
                                },500)
                            },1000);
                            $('.choose_border').fadeIn(200);
                            // 停止下单结束
                            $('.z_show').fadeOut(200);
                            $('.game_timer_box').show()
                             // 精准数字消失
                             $(".game_allnum").fadeIn(200)
                            $('#HERO .deal').css({'background':'url("../images/btn_yellow.png")','background-size':'100% 100%','color':'#460202'});
                            $('#HERO .deal').on('click',function(){
                                bindDealBtn(this);
                            });
                        },400);
                    },500);
                    /*clearInterval(imageflowTimer);
                    imageflowTimer = null;*/
                }
            },100)
        }
    }

    function check_value(_self){
        var value = _self.value;
        if(value==''){
            value = mindeal;
        }else if(parseInt(value)>maxdeal){
            value = maxdeal;
        }
        if(parseInt(value)>parseInt($('.header_coinnum').html())){
            value = parseInt($('.header_coinnum').html())
        }
        if(parseInt(value)<mindeal){
            value = mindeal;
        }
        _self.value = value;
    }
    //+-按钮长按
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
                value = parseInt(value) + num > parseInt($('.header_coinnum').html()) && parseInt($('.header_coinnum').html()) >= mindeal ? parseInt($('.header_coinnum').html()) : parseInt(value);
            }else{
                value = parseInt(value) - num < mindeal ? mindeal : parseInt(value) - num;
            }
        }
        touchthis.parent().find('input')[0].value = value;
    }
    function clearTouchTimer(){
        clearInterval(touchtimer);
        touchtimer = ''
        touchlong = 0;
    }
    function editnum(num){
        //handle
        //
        var new_number = num.toString()
        var new_number= num.split("");
        new_number.splice(3,0,",")
        new_number.splice(7,0,",")
        var numstring = new_number.join("");
        //alert(numstring);
        return numstring;
    }
    //更新数字
    function updatenumber(){
        //numRun_SINGPLUR.resetData(numshow);
        //
        //add
        //
            var _numshow = editnum(numshow);
            $('.game_allnum').html(_numshow);
        /* = $("#NUM .game_allnum").numberAnimate({
            num:numshow,
            speed:numspeed,
            numlength:false
        });*/
        numStop[0] = 1;
        numStop[1] = 1;
        numStop[2] = 1;
        numAnimateTimer = setInterval(function(){
            var lineHeight = parseFloat($('.game_num_box>span').css('line-height'));
            if(numStop[0]){
                numArr[0] = parseInt(numArr[0])+1 <= 9? parseInt(numArr[0])+1 : 0;
                $('.game_num_box>span:eq(0)>div').animate({'top':'-'+lineHeight*numArr[0]+'px'},100,'linear');
            }
            if(numStop[1]){
                numArr[1] = parseInt(numArr[1])+1 <= 9? parseInt(numArr[1])+1 : 0;
                $('.game_num_box>span:eq(1)>div').animate({'top':'-'+lineHeight*numArr[1]+'px'},100,'linear');
            }
            if(numStop[2]){
                numArr[2] = parseInt(numArr[2])+1 <= 9? parseInt(numArr[2])+1 : 0;
                $('.game_num_box>span:eq(2)>div').animate({'top':'-'+lineHeight*numArr[2]+'px'},100,'linear');
            }
        },80)
        setTimeout(function(){
            setnumber();//更新尾数
        },numspeed/3);
    }

    //更新尾数
    function setnumber(){
        setTimeout(function(){
            numStop[0] = 0;
            var lastnum = (numshow % 1000).toString();
            numArr[0] = parseInt(lastnum/100);
            var lineHeight = parseFloat($('.game_num_box>span:eq(0)>div').css('line-height'));
            $('.game_num_box>span:eq(0)>div').stop();
            $('.game_num_box>span:eq(0)>div').animate({'top':'-'+lineHeight*numArr[0]+'px'},200);
        },0);
        setTimeout(function(){
            numStop[1] = 0;
            var lastnum = (numshow % 1000).toString();
            numArr[1] = parseInt(lastnum/10 - numArr[0]*10);
            var lineHeight = parseFloat($('.game_num_box>span:eq(1)>div').css('line-height'));
            $('.game_num_box>span:eq(1)>div').stop();
            $('.game_num_box>span:eq(1)>div').animate({'top':'-'+lineHeight*numArr[1]+'px'},400);
        },500);
        setTimeout(function(){
            numStop[2] = 0;
            var lastnum = (numshow % 1000).toString();
            numArr[2] = parseInt(lastnum/1 - numArr[0]*100 - numArr[1]*10);
            var lineHeight = parseFloat($('.game_num_box>span:eq(2)>div').css('line-height'));
            $('.game_num_box>span:eq(2)>div').stop();
            $('.game_num_box>span:eq(2)>div').animate({'top':'-'+lineHeight*numArr[2]+'px'},600);
        },1000);
        setTimeout(function(){
            clearInterval(numAnimateTimer);numAnimateTimer='';
            setTimeout(function(){
                var endnum = parseInt(numArr[0]) + parseInt(numArr[1]) + parseInt(numArr[2]);
                var spanhtml = numArr[0] + '+' + numArr[1] + '+'  + numArr[2] + '=' + endnum;
                var ahtml = '';
                ahtml += endnum >= 13 ? "大":"小";
                ahtml += endnum%2==0 ? '/双':'/单';
                ahtml += numArr[0]==numArr[1] && numArr[1]==numArr[2] ? '/三条':'';
                ahtml += (numArr[0]+1==numArr[1] && numArr[1]+1==numArr[2])||(numArr[0]-1==numArr[1] && numArr[1]-1==numArr[2])?'/顺子':'';
                $('#NUM .game_num_end>span').html(spanhtml);
                $('#NUM .game_num_end>a').html(ahtml);
                $('#NUM .game_num_end').fadeIn(200);

                if(endnum>=13){$('#NUM .game_choose>.big').addClass('on');}
                else{$('#NUM .game_choose>.little').addClass('on');}
                if(endnum%2==0){$('#NUM .game_choose>.dual').addClass('on');}
                else{$('#NUM .game_choose>.singular').addClass('on');}
                if(numArr[0]==numArr[1] && numArr[1]==numArr[2]){$('#NUM .game_choose>.set').addClass('on');}
                if((numArr[0]+1==numArr[1] && numArr[1]+1==numArr[2])||(numArr[0]-1==numArr[1] && numArr[1]-1==numArr[2])){$('#NUM .game_choose>.straight').addClass('on');}
                $('#NUM .game_coin').each(function(){
                    if(!$(this).parent().hasClass('on')){
                        $(this).fadeOut(200);
                        $(this).parent().find('p').remove();
                        $(this).parent().removeClass('once');
                    }
                });
                setTimeout(function(){
                    $('#NUM .game_coin').each(function(){
                        if($(this).parent().hasClass('on')){
                            var parleft = $(this).parent()[0].offsetLeft;
                            $(this).animate({'top': '-800%','left': 120 - parleft + 'px',},300,'linear');
                            addChestStep();//增加宝箱进度条
                        }
                    });
                    $('#NUM .game_num_end').fadeOut(200);
                    $('#NUM .game_choose>span').removeClass('on');
                    $('#NUM .game_choose>span').removeClass('once');
                    $('#NUM .game_choose>span>p').remove();
                    setTimeout(function(){
                        $('#NUM .game_coin').remove();
                        // 停止下单结束
                        $('.z_show').fadeOut(200);
                        $('.game_timer_box').show()
                        // 精准数字消失
                        $(".game_allnum").fadeIn(200)
                        dealType = true;
                        $('#NUM .deal').css({'background':'url("../images/btn_yellow.png")','background-size':'100% 100%','color':'#460202'});
                        $('#NUM .deal').on('click',function(){
                            bindDealBtn(this);
                        });
                    },300)
                },2000);
            },1500);
        },1000);
    }

    //重新定位数字位置
    function resizenumber(){
        if(numStop[0] == 0){
            var lastnum = (numshow % 1000).toString();
            numArr[0] = parseInt(lastnum/100);
            var lineHeight = parseFloat($('.game_num_box>span:eq(0)>div').css('line-height'));
            $('.game_num_box>span:eq(0)>div').stop();
            $('.game_num_box>span:eq(0)>div').css({'top':'-'+lineHeight*numArr[0]+'px'});
        }
        if(numStop[1] == 0){
            var lastnum = (numshow % 1000).toString();
            numArr[1] = parseInt(lastnum/10 - numArr[0]*10);
            var lineHeight = parseFloat($('.game_num_box>span:eq(1)>div').css('line-height'));
            $('.game_num_box>span:eq(1)>div').stop();
            $('.game_num_box>span:eq(1)>div').css({'top':'-'+lineHeight*numArr[1]+'px'});
        }
        if(numStop[2] == 0){
            var lastnum = (numshow % 1000).toString();
            numArr[2] = parseInt(lastnum/1 - numArr[0]*100 - numArr[1]*10);
            var lineHeight = parseFloat($('.game_num_box>span:eq(2)>div').css('line-height'));
            $('.game_num_box>span:eq(2)>div').stop();
            $('.game_num_box>span:eq(2)>div').css({'top':'-'+lineHeight*numArr[2]+'px'});
        }
    }

    //初始化数字动效
    function initnumber(){
            var _numshow = editnum(numshow);
            $('.game_allnum').html(_numshow);
//add
        /*numRun_SINGPLUR = $("#NUM .game_allnum").numberAnimate({
            num:numshow;,
            speed:numspeed,
            numlength:true
        });*/
        var lastnum = (numshow % 1000).toString();
        numArr[0] = parseInt(lastnum/100);
        numArr[1] = parseInt(lastnum/10 - numArr[0]*10);
        numArr[2] = parseInt(lastnum/1 - numArr[0]*100 - numArr[1]*10);

        var lineHeight = parseFloat($('.game_num_box>span').css('line-height'));

        //初始化结尾数字结果
        $('.game_num_box>span:eq(0)>div').css({'top':'-'+lineHeight*numArr[0]+'px'},200);
        $('.game_num_box>span:eq(1)>div').css({'top':'-'+lineHeight*numArr[1]+'px'},200);
        $('.game_num_box>span:eq(2)>div').css({'top':'-'+lineHeight*numArr[2]+'px'},200);

        //alert(lineHeight);
    }

    //宝箱点击事件
    function BindChestEvent(){
        $('.game_chest_img').unbind('click');
        /*
            $('.game_chest_img').unbind('click');
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
        */
        $('.game_chest_img_on').on('click',function(){
            var sucfunc = function(){
                $('.chest_open_view').fadeIn(200);
                $('.game_chest_img').removeClass('game_chest_img_on');
                $('.game_chest_rate>span').removeClass('on');
                $('.game_chest_light').addClass('none');
                BindChestEvent();
            }
            AjaxCheat(sucfunc);
        });
    }
    function addChestStep(){
        var oncount = 0;
        oncount = $('.game_chest_rate>.on').length / 2;
        if(oncount < 5){
            $('.game_chest_rate>span:eq('+(5-oncount-1)+')').addClass('on');
            $('.game_chest_rate>span:eq('+(5-oncount-1 + 5)+')').addClass('on');
        }
        if(oncount>=4){
            $('.game_chest_img').addClass('game_chest_img_on');
            $('.game_chest_rate>span').addClass('on');
            $('.game_chest_light').removeClass('none');
            BindChestEvent();
        }
    }

    //下单按钮点击事件
    function bindDealBtn(e){

        if($(e).parent().parent().find('.game_choose').find('p').length){
            var func = function(e){
                var _self = e;
                var chooseSpan = $(_self).parent().parent().find('.game_choose');
                var oldmoney = parseInt(chooseSpan.find('p>span').html());
                var newmoney = parseInt(chooseSpan.find('p>a').html());
                $(_self).find('p>span').html(newmoney + oldmoney);
                //alert(newmoney + oldmoney);
                var value = $(_self).parent().find('input')[0].value;
                var type = $(_self).parent().parent().attr('id');
                if($(_self).parent().parent().find('.game_choose').find('p').length){
                    $(_self).parent().parent().find('.game_choose').find('p').each(function(){
                        if($(this).find('span').html() != $(this).find('a').html()){
                            $(this).find('span').html($(this).find('a').html());
                            $(this).parent().append('<b class="game_coin"><img src="../images/game_coin_icon.png"/></b>');
                            var nowbtop = parseInt($(this).parent().find('b:last').css('top'));
                            var nowbleft = parseInt($(this).parent().find('b:last').css('left'));
                            var parleft = $(this).parent()[0].offsetLeft;
                            var bleft = $(this).parent().find('b:last')[0].offsetLeft;
                            var random_l = Math.random()*16 - 8;
                            var random_t = Math.random()*10 - 5;
                            $(this).parent().find('b:last').css({'left':window_Width/2 - parleft + 'px','top':'200%'});
                            $(this).parent().find('b:last').animate({'top': nowbtop + random_t + 'px','left': nowbleft + random_l + 'px','opacity':'1'},200);
                            //$(this).remove();
                            //$('.game_choose span').removeClass('once')
                        }
                    });
                }
            }
            //AJAX
            $('.deal').unbind('click');
            AjaxDeal(func,e);
        }else{
            errorMsg('请选择下注选项!');
        }
    }
    function bindChooseBtn(){
        $('.game_choose>span').unbind('click');
        $('.game_choose>span').on('click',function(){
            if(dealType){
                clickAudio();

                var addmoney = $(this).parent().parent().find('input')[0].value;
                //判断有没有下过单
                if($(this).find('p>span').length>=1){
                        var spanphtml = parseInt($(this).find('p>span').html());
                        var ahtml = parseInt($(this).find('p>a').html());
                        //var phtml = ahtml + parseInt(addmoney);

                        phtml = parseInt(ahtml) + parseInt(addmoney);
                        //alert(phtml)
                        if( phtml > maxdeal ) {
                            $(this).find('p>a').html(maxdeal);
                            errorMsg('单选项下注最大金额为'+maxdeal);
                        }else{
                            $(this).find('p>a').html(phtml);
                        }
                }else{

                    $(this).addClass("once")
                    if($(this).find('p').length>=1){
                        var phtml = $(this).find('p').find('a').html();
                        phtml = parseInt(phtml) + parseInt(addmoney);
                        if( phtml > maxdeal ) {
                            $(this).find('p').find('a').html(maxdeal);
                            errorMsg('单选项下注最大金额为'+maxdeal);
                        }else{
                            $(this).find('p').find('a').html(phtml);
                        }
                    }else{
                        $(this).append('<p>x<a>'+addmoney+'</a><span style="display:none">0</span></p>');
                    }
                }
            }


        });
    }
    //var heroOptionArray = [[1,"王昭君",3],[2,"小乔",3],[3,"武则天",3],[4,"韩信",6],[5,"程咬金",6],[6,"赵云",8],[7,"老夫子",8],[8,"项羽",40],[9,"鲁班",80]];
    //var numOptionArray = [[10,"单号",2],[11,"双号",2],[12,"大",2],[13,"小",2],[14,"顺子",30],[15,"三条",30]];
    function initOption(){
        var heroOptionHtml = '';
        for(var i = 0; i < heroOptionArray.length;i++){
            //console.log(heroOptionArray);
            heroOptionHtml += "<span id='op_"+heroOptionArray[i][0]+"'><i>"+heroOptionArray[i][0]+"</i><a>"+heroOptionArray[i][1]+"<b>1:"+heroOptionArray[i][2]+"</b></a></span>";
        }
        var numOptionHtml = '';
        numOptionHtml += "<span class='big' id='op_"+numOptionArray[2][0]+"'><a>"+numOptionArray[2][1]+"<b>1:"+numOptionArray[2][2]+"</b></a></span>";
        numOptionHtml += "<span class='straight' id='op_"+numOptionArray[4][0]+"'><a>"+numOptionArray[4][1]+"<b>1:"+numOptionArray[4][2]+"</b></a></span>";
        numOptionHtml += "<span class='singular' id='op_"+numOptionArray[0][0]+"'><a>"+numOptionArray[0][1]+"<b>1:"+numOptionArray[0][2]+"</b></a></span>";
        numOptionHtml += "<span class='little' id='op_"+numOptionArray[3][0]+"'><a>"+numOptionArray[3][1]+"<b>1:"+numOptionArray[3][2]+"</b></a></span>";
        numOptionHtml += "<span class='set' id='op_"+numOptionArray[5][0]+"'><a>"+numOptionArray[5][1]+"<b>1:"+numOptionArray[5][2]+"</b></a></span>";
        numOptionHtml += "<span class='dual' id='op_"+numOptionArray[1][0]+"'><a>"+numOptionArray[1][1]+"<b>1:"+numOptionArray[1][2]+"</b></a></span>";

        $('#HERO .game_choose').html(heroOptionHtml);
        $('#NUM .game_choose').html(numOptionHtml);

    }

    function setUserMoney(num){
        var usermoney = parseInt($('.header_coinnum').html());
        usermoney += num;
        $('.header_coinnum').html(usermoney);
    }

    function number_xh(){
        var price = 99
       var nuM = [];
        nuM.push( 1 );
        var test = [3,4,5,7,8];
        for(var i =0; i<2;i++){
            var num = test[Math.floor(Math.random()*test.length)];
            nuM.push(num)
              }
            nuM.push('*')
            nuM.push('*')
            nuM.push('*')
            nuM.push('*')
        for(var i =0; i<4; i++){
            var num = Math.floor(Math.random()*10)
            nuM.push(num)
        }
        nuM = nuM.join("");
        // console.log(nuM);
        if( price <= 99){
            price = Math.floor(Math.random()*100);
            price = price + '0'
        }
        $('.page_span').html(nuM);
        $('.page_span1').html(price)
    }

    function number_page(){
        number_xh()
        $('.page_p').show( );
        $('.page_p').css("top","10%")
        $('.page_p').css('z-index','0')
        $('.page_p').animate({
            // 'bottom':'8%'
            'top':'0%'
        },1000,'linear',function(){
        // $('.page_p').animate({
        //         'bottom':'-5%'
        // })
        $('.page_p').css('z-index','999')
        $('.page_p').fadeIn(1500)
        })

// page1
        $('.page_p1').show( );
        $('.page_p1').css("bottom","0%")
        $('.page_p1').css('z-index','-1')
        $('.page_p1').animate({
            // 'bottom':'8%'
            'bottom':'0%'
        },1000,'linear',function(){
        // $('.page_p').animate({
        //         'bottom':'-5%'
        // })
        $('.page_p1').css('z-index','999')
        $('.page_p1').fadeIn(1500)
        })
    }
    //页面加载完毕后的第一个方法

    function page_onload(){


        window_Width = document.body.clientWidth;

        //初始化选项列表
        initOption();

        //alert(getCookie('para'));
        //alert(getCookie('gameIssus'));
        var gameIssus = parseInt(( Date.parse(new Date())/1000 + second_deviation - heartstoptime )/60);
        var _gameIssus = getCookie('gameIssus');
        if(_gameIssus&&_gameIssus == gameIssus){
            var _para = getCookie('para');
            var paraArr = _para.split("-");
            for(var i=0;i<paraArr.length;i++){
                var item = paraArr[i].split(",");
                if($('#op_'+item[0]).find('p').length == 0){
                    var html = "<p>x<a>"+item[1]+"</a><span style='display:none'>"+item[1]+"</span></p>";
                    html += '<b class="game_coin" style="left: 35.9237px; top: 13.814px; opacity: 1;"><img src="../images/game_coin_icon.png"></b></span>';
                    $('#op_'+item[0]).append(html);
                    $('#op_'+item[0]).addClass('once')
                }else{
                    var oldnum = parseInt($('#op_'+item[0]).find('p>a').html());
                    $('#op_'+item[0]).find('p>a').html(oldnum+parseInt(item[1]));
                    $('#op_'+item[0]).find('p>span').html(oldnum+parseInt(item[1]));
                }
            }
            //alert(getCookie('gameIssus'));
        }else{
            delCookie('para');
            delCookie('gameIssus');
        }


        //改变窗口大小时重新定位数字位置
        window.onresize = resizenumber;

        //HIDE LOADING VIEW
        initPage();

        loadSecond_deviation();
        second_deviation_timer = setInterval(function(){
            loadSecond_deviation();
        },10000);

        // 数字跳动
        setInterval(function(){
            number_page();
        },3000)

        //获取当前数据
        var initFunction = function(){

            imageflow_shift = imageflow_target - imageflow_count - 1 <= $('.imageflow>span').length ? imageflow_target - imageflow_count - 1: imageflow_target - imageflow_count - 1 - $('.imageflow>span').length;
            //初始化英雄场
            imageflowinit();
            /*imageflow_type = 1;
            imageflowTimer = setInterval(function(){
                var heronum =  imageflow_shift + imageflow_count < $('#HERO .game_choose>span').length ? imageflow_shift + imageflow_count : imageflow_shift + imageflow_count - $('#HERO .game_choose>span').length;
                if(imageflow_type == 0 && heronum+1 == imageflow_target ){
                    clearInterval(imageflowTimer);
                    imageflowTimer = null;
                }else{
                    imageflow_shift++;
                    imageflowinit();
                }
            },150)
            imageflowStopanimate();*/
            //初始化数字场
            initnumber();

            $('.choose_border').fadeIn(200);
        }
        AjaxGame(initFunction)
        userinfoTimer = setInterval(function(){
            if($_user){
                if($_user != 'error'){

                    $('.header_nickname').html($_user.username);
                    $('.header_coinnum').html($_user.coin);
                    $('.headimg>img').attr('src',$_user.headimgurl+'0')
                    $('.game_chest_rate').html('');
                    //alert($_user.star)
                    for(var i = 0;i<5-$_user.star;i++){
                        $('.game_chest_rate').append('<span></span>');
                    }
                    for(var i = 0;i<$_user.star;i++){
                        $('.game_chest_rate').append('<span class="on"></span>');
                    }
                    if($('.game_chest_rate>.on').length/2>=5){
                        $('.game_chest_img').addClass('game_chest_img_on');
                        $('.game_chest_rate>span').addClass('on');
                        $('.game_chest_light').removeClass('none');
                        BindChestEvent();
                    }
                }
                clearInterval(userinfoTimer);
                userinfoTimer = null;
            }
        },200);

        //心跳
        heartbeatTimer = setInterval(function(){
            heartbeat();
        },1000);
        BindChestEvent();

        //下单选项按钮事件
        bindChooseBtn()

        //切换游戏按钮事件
        $('.game_nav>span').on('click',function(){
            clickAudio();
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
            clickAudio();
            clearTouchTimer();
            $(this).css({'height': '100%','top': '0%'});
        });
        $('.plus').on('touchend',function(){
            clickAudio();
            clearTouchTimer();
            $(this).css({'height': '100%','top': '0%'});
        });

        //最大按钮事件
        $('.max').on('click',function(){
            clickAudio();
            $('.game_choose>span>p').each(function(){
                var a = parseInt($(this).find('span').html());
                if(a == 0){
                    $(this).parent().removeClass("once");
                    $(this).remove();
                }else{
                    $(this).find('a').html(a);
                }
            });
            //$('.game_choose>span>p').remove();

            //$(this).parent().find('input')[0].value = maxdeal;
        });
        $('.max').on('touchstart',function(){
            $(this).css({'width':'22%','left':'3.5%','height':'38px','margin-top':'11px'});
        });
        $('.max').on('touchend',function(){
            $(this).css({'width':'23%','left':'3%','height':'40px','margin-top':'10px'});
        });

        //下单按钮事件
        $('.deal').on('click',function(){
            clickAudio();
            bindDealBtn(this);
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

        $('.btn').on('click',function(){
            if($(this).hasClass('header_icon_line')){
                AjaxLine();
            }
            if($(this).hasClass('header_icon_bag')){
                AjaxBag();
            }
            var boxid = $(this).attr('name');
            $('#'+boxid).fadeIn(200);
            setTimeout(function(){
                refreshAlertIScroll();
            },200);
        })
    }

    function AjaxLine(){//下单接口
        //var data = 1;//Math.random()*10 > 8 ? 1 : 0;
        $.ajax({
            url:"/trade/trendchart",
            type:'GET',
            dataType: 'json',
            success: function(data){
                if(data){
                    //data = String2Array(data);
                    //alert(data[9]);
                    var html = "<tr><th class='line_left'><span>期号</span></th><th><span>大</span></th><th><span>小</span></th><th><span>单</span></th><th><span>双</span></th><th><span>三条</span></th><th class='line_left'><span>顺子</span></th><th><span>英雄</span></th></tr>";
                    for(var i = 0 ; i < data.length ; i++){
                        data[i][11] = !data[i][11] ? '和局' : data[i][11];
                        html += "<tr>";
                        html += "<td>"+data[i][1]+"</td>";
                        html += data[i][3] ? "<td><img src='/images/line_icon_y.png'></td>" : "<td></td>";
                        html += data[i][4] ? "<td><img src='/images/line_icon_y.png'></td>" : "<td></td>";
                        html += data[i][5] ? "<td><img src='/images/line_icon_y.png'></td>" : "<td></td>";
                        html += data[i][6] ? "<td><img src='/images/line_icon_y.png'></td>" : "<td></td>";
                        html += data[i][7] ? "<td><img src='/images/line_icon_b.png'></td>" : "<td></td>";
                        html += data[i][8] ? "<td><img src='/images/line_icon_b.png'></td>" : "<td></td>";
                        html += "<td>"+data[i][11]+"</td>";
                        html += "</tr>";
                    }
                    $('#LINE .line_table').html(html);
                }else{
                    errorMsg('获取数据失败,请稍后再试');
                }
            }
        });

    }
    function AjaxCheat(func,e){//宝箱领取接口
        //var data = 1;//Math.random()*10 > 8 ? 1 : 0;
        $.ajax({
            url:"/trade/chestOpen",
            type:'GET',
            success: function(data){
                //alert(data);
                $('.chest_open_text>span').html('恭喜获得'+parseInt(data)+'金币奖励')
                var mycoin = parseInt($('.header_coinnum').html());
                mycoin += parseInt(data);
                $('.header_coinnum').html(mycoin);
                if(data>0){
                    $('.header_addcoin').html('+'+parseInt(data));
                    $('.header_addcoin').fadeIn(100);
                    setTimeout(function(){
                        $('.header_addcoin').fadeOut(500);
                    },1000);
                }
                func(e);
            },
            error: function(e){
                errorMsg('领取失败');
            }
        });
    }
    function AjaxDeal(func,e){//下单接口
        var sucfunc = function(){
            var chooseLength = $(e).parent().parent().find('.game_choose').find('p').length;
            var para = '';
            var coinnum = 0;
            var type = 1;
            for(var i = 0 ; i < chooseLength ; i++){
                var thisChoose = $(e).parent().parent().find('.game_choose').find('p')[i];
                var thisoldAmount = parseInt($(thisChoose).find('span').html());
                var thisallAmount = parseInt($(thisChoose).find('a').html());
                var thisAmount = parseInt(thisallAmount - thisoldAmount);
                //alert(thisAmount);
                if(thisAmount>=10){
                    var thisCapital = $(thisChoose).parent().attr('id').substr(3);
                    type = thisCapital >= 10 ? 2 : type;
                    para += '-' + thisCapital + ',' + thisAmount;
                    coinnum+=parseInt(thisAmount);
                    //$(thisChoose).find('span').html(thisallAmount);
                }
            }
            para = para.substr(1);
            if(para){

                setCookie('ajax_para',para);
                $.ajax({
                    url:"/trade/placeorder1?para="+para+"&type="+type,
                    type:'GET',
                    dataType: 'json',
                    success: function(data){
                        //alert(data);
                        if(data.status == 1){

                            var gameIssus = parseInt(( Date.parse(new Date())/1000 + second_deviation - heartstoptime )/60);
                            var _gameIssus = getCookie('gameIssus');
                            var para = getCookie('ajax_para');
                            if(_gameIssus&&_gameIssus == gameIssus){
                                var _para = getCookie('para');
                                setCookie('para',_para+"-"+para);
                                setCookie('gameIssus',gameIssus);
                            }else{
                                setCookie('para',para);
                                setCookie('gameIssus',gameIssus);
                            }


                            var mycoin = parseInt($('.header_coinnum').html());
                            mycoin -= parseInt(coinnum);
                            $('.header_coinnum').html(mycoin);
                            if(coinnum>0){
                                $('.header_mincoin').html('-'+parseInt(coinnum));
                                $('.header_mincoin').fadeIn(100);
                                setTimeout(function(){
                                    $('.header_mincoin').fadeOut(500);
                                },1000);
                            }
                            func(e);
                        }else{
                            errorMsg(data.message);
                        }

                        $('.deal').on('click',function(){
                            clickAudio();
                            bindDealBtn(this);
                        });
                    },
                    error: function(e){
                        errorMsg('网络错误,请稍后再试');
                        $('.deal').on('click',function(){
                            clickAudio();
                            bindDealBtn(this);
                        });
                    }
                });
            }else{
                errorMsg('请先下注');
            }

        }
        var errfunc = function(){
            errorMsg('请登陆后尝试下单');
            setTimeout(function(){
                top.location.href = '/jsp/login.jsp';
            },500);
        }


        checkLogin(sucfunc,errfunc);

    }
    function AjaxGame(sucfunc,errFunc){//获取结果接口
        $.ajax({
            url:"/trade/gameresult",
            type:'GET',
            dataType: 'json',
            success: function(data){
                //alert(data);
                if(data){//成功
                    if(data.winhero){
                        //获得英雄
                    }
                    numshow = data.opencode;
                    heroid = data.heroId;//data.heroId;
                    imageflow_target = heroid> 0 ? heroid: $('#HERO .game_choose>span').length - heroid;
                    sucfunc();
                }else{//失败
                    errorMsg('网络异常,请刷新页面查看结果');
                    if(errFunc) errFunc();
                }
            },
            error: function(e){
                errorMsg('网络错误,请稍后再试');
            }
        });

    }
    function AjaxBag(){//获取背包接口
        var errfunc = function(){
            errorMsg('请登陆后尝试下单');
            setTimeout(function(){
                top.location.href = '/jsp/login.jsp';
            },500);
        }
        var sucfunc = function(){
            var bodyview = $('.bag_body .person>ul');
            bodyview.html('');
            $.ajax({
                url:"/trade/knapsackdisplay",
                type:'GET',
                success: function(data){
                    var isGetAll = data.indexOf(0) < 0;
                    var minNum = eval("Math.min(" + data.split(',').toString() + ")");
                    var html_ul = '';
                    //alert(isGetAll);
                    //isGetAll = 1;
                    if(isGetAll){
                        for(var i = 0; i < minNum ; i++){
                            html_ul += "<li class='selected'>";
                            html_ul += "<img src='/images/mine-person-bg1.png' class='four-angle'>";
                            html_ul += "<div class='person-top'>";
                            html_ul += "<img src='/images/mine-person_12.png'>";
                            html_ul += "</div>";
                            html_ul += "<div class='person-top1'>";
                            html_ul += "<img src='/images/mine-person-bg2.png'>";
                            html_ul += "<div class='line'></div>";
                            html_ul += "<div class='collect-all'>已集齐</div>";
                            html_ul += "<div class='hero'>";
                            html_ul += "<div class='hero-main'>";
                            html_ul += "<img src='/images/mine-person-hero.png'>";
                            html_ul += "</div>";
                            html_ul += "</div>";
                            html_ul += "<a href='javascript:;' class='click-all'>";
                            html_ul += "<div class='click'>点击兑换</div>";
                            html_ul += "</a>";
                            html_ul += "</div>";
                            html_ul += "</li>";
                        }

                    }
                    data = data.split(',');
                    for(var i = 0;i<data.length;i++){
                        if( data[i] - minNum == 0 ){
                            html_ul += '<li>';
                        }else{
                            html_ul += '<li class="on">';
                        }
                        html_ul += '<img src="/images/mine-person-bg1.png" class="four-angle">';
                        html_ul += '<div class="person-top">';
                        html_ul += '<img src="/images/mine-person_0'+(i+1)+'.png">';
                        if(data[i] - minNum <=1){
                            html_ul += '<div class="name-bg">'+heroOptionArray[i][1]+'</div>';
                        }else{
                            html_ul += '<div class="name-bg">'+heroOptionArray[i][1]+'<a style="color:white;">x'+( data[i] - minNum )+'</a></div>';
                        }
                        html_ul += '<div class="line"></div>';
                        html_ul += '</div>';
                        html_ul += '<div class="person-top1">';
                        html_ul += '<img src="/images/mine-person-bg2.png">';
                        html_ul += '</div>';
                        html_ul += '<div class="shade">';
                        html_ul += '<div class="shade-title">';
                        html_ul += '<div class="lock-main">';
                        html_ul += '<img src="/images/mine-person-lock.png">';
                        html_ul += '</div>';
                        html_ul += '<p>'+heroOptionArray[i][1]+'</p>';
                        html_ul += '</div>';
                        html_ul += '</div>';
                        html_ul += '</li>';
                    }
                    bodyview.html(html_ul);
                },
                error: function(e){
                    errorMsg('网络错误,请稍后再试');
                }
            });
        }

        checkLogin(sucfunc,errfunc);


    }
