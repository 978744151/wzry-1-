var page_controller;
var alert_controller = new Array();
var UA = navigator.userAgent.toLowerCase();//UserAgent
var heroOptionArray = [[1,"王昭君",8],[2,"小乔",8],[3,"武则天",8],[4,"韩信",8],[5,"程咬金",8],[6,"赵云",8],[7,"老夫子",8],[8,"项羽",8],[9,"鲁班",8]];
var numOptionArray = [[10,"单号",1.8],[11,"双号",1.8],[12,"大",1.8],[13,"小",1.8],[14,"顺子",24],[15,"三条",48]];
var $_user = new Object();

document.addEventListener('touchmove',function(e){
    e.preventDefault();//移除浏览器默认操作
},false);
function initPage(){
    var objLoading = document.getElementById("loadingbox");
    if (objLoading != null)   {
        //setTimeout(function(){
            //$('.loadingbox').animate({'top':'2%','opacity':'0'},50);
            //setTimeout(function(){
                $('.loadingbox').hide();
            //},50);
        //},0);
    }
}
window.onload = function(){
    FastClick.attach(document.body);//加载FastClick插件
    bindClickEvent();//绑定共用部分点击事件
    page_onload();//加载页面onload事件
}
function iScrollClick(){
    //iScroll click 兼容性问题
    if(/iPhone|iPad|iPod|Macintoch/i.test(UA)) return false;
    if(/Chrome/i.test(UA)) return true;//(/Android/i.test(UA))
    if(/Silk/i.test(UA)) return false;
    if(/Android/i.test(UA)){
        var s = UA.match(/Android [\d+.]{1,5}/)[0].replace('Android','');
        return parseFloat(s[0]+s[2]+s[4])<=442&&parseFloat(s[0]+s[2]+s[4])>430 ? true:false;
    }
}
function bindClickEvent(){
    getWechatInfo();
    getUserInfo();
    $('.alert_close').on('click',function(){
        $(this).parent().parent().parent().fadeOut(200);
    });
    $('.chest_open_view>.close_btn').on('click',function(){
        $(this).parent().fadeOut(200);
    });
    if($('.alert_body').length){
        if($('.alert_content').length){
            for(var i=0;i<$('.alert_content').length;i++){
                $('.alert_content:eq('+i+')').attr('id','iScroll');
                alert_controller[i] = new IScroll('#iScroll',{
                    mouseWheel:true,
                    scrollbars:false,
                    bounce:false,
                    click:iScrollClick()
                });
                $('#iScroll').attr('id','');
           }
        }
    }
}
function refreshAlertIScroll(){
    if($('.alert_content').length){
        for(var i=0;i<$('.alert_content').length;i++){
            alert_controller[i].refresh();
       }
    }
}
function errorMsg(msg){
    var randomId = parseInt(Math.random()*1000000+1);
    $('body').append("<div class='error_box' id='"+randomId+"'><span>"+msg+"</span></div>");
    $('#'+randomId).fadeIn(200);
    setTimeout(function(){
        $('#'+randomId).fadeOut(200);
    },1200);
}
function loadImage(url){//预加载图片
    var img = new Image();
    img.src = url;
}
var $_GET = (function(){
    var url = window.document.location.href.toString();
    var u = url.split("?");
    if(typeof(u[1]) == "string"){
        u = u[1].split("&");
        var get = {};
        for(var i in u){
            var j = u[i].split("=");
            get[j[0]] = j[1];
        }
        return get;
    } else {
        return {};
    }
})();

function setCookie(name,value) {
    var Days = 1;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

//读取cookies
function getCookie(name) {
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}

//删除cookies
function delCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null)
        document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}
function String2Array(stringObject){
    stringObject = stringObject.replace(/\"/g, "");
    stringObject = stringObject.substr(2,stringObject.length-4);
    var stringArray = stringObject.split("],[");
    var returnArray = new Array();
    for(var i = 0 ; i < stringArray.length; i++){
        var thisArray = stringArray[i].split(",");
        returnArray.push(thisArray);
    }
    return returnArray;
}
function getUserInfo(){
    $.ajax({
        url:"/login/getUserInfo",
        type:'GET',
        success: function(data){
            $_user = data.userinfo;
            console.log($_user);
        },
        error: function(e){
            errorMsg('获取用户数据失败');
            $_user = 'error';
        }
    });
}
function getWechatInfo(){
    $.ajax({
        url:"/login/getWechatInfo",
        type:'GET',
        dataType : 'json',
        success: function(data){
            $_user = data;
            //alert($_user);
        },
        error: function(e){
            //errorMsg('获取用户数据失败');
        }
    });
}
function logout(sucfunc = ''){
    $.ajax({
        url:"/login/loginout",
        type:'GET',
        success: function(data){
            sucfunc();
        }
    });
}
function wechatPay(money){
    var plat = 'qx';
    var url = "/wxpay/wechatpublicpay?type=coin&price="+money+"&plat="+plat;
    checkLogin(function(){
        top.location.href = url;
    },function(){
        errorMsg('请先登陆');
    });
}
function vipPay(money){
    var plat = 'qx';
    var url = "/wxpay/wechatpublicpay?type=vip&price="+money+"&plat="+plat;
    checkLogin(function(){
        top.location.href = url;
    },function(){
        errorMsg('请先登陆');
    });
}
function checkLogin(sucfunc = '',errfunc = ''){
    $.ajax({
        url:"/trade/iflogin",
        type:'GET',
        dataType : 'json',
        success: function(data){
            if(data.status == 1){
                if(sucfunc){
                    sucfunc();
                }
            }else{
                if(errfunc){
                    errfunc();
                }
            }
        },
        error: function(e){
            if(errfunc){
                errfunc();
            }
        }
    });
}

// 新手指导
function clickAudio(){
    //window.top.document.getElementById('clickAudio').play();
    var audio = $('#clickAudio',top.window.document);
    if(audio.length>0){
        audio[0].play();
    }
}
function novice(){
    $(".page_box").animate({"opacity":"0.1"});
    function append_con_one(){
        $("#maskIn1").css({"display":"block"}).siblings("div").css({"display":"none"});
        //显示高亮
        $("section .goods").siblings().animate({"opacity":"0.1"});
        //从第一步跳转到第二步
        $("#maskIn1 .on_c_next").click(function(){
            append_con_two();
        });

    }
    function append_con_two(){
        $(window).scrollTop(0);
        $("#maskIn2").css({"display":"block"}).siblings("div").css({"display":"none"});
        $("section .game_time").animate({"opacity":"1"}).siblings().animate({"opacity":"0.1"});
        $(".swiper-container").siblings().animate({"opacity":"0.1"});
        $(".swiper-container").children("i").animate({"opacity":"0.1"});
        //从第二步返回第一步
        $("#maskIn2 .mask_true").click(function(){
            append_con_one();
        });
        $("#maskIn2 .on_c_next").click(function(){
            append_con_three();
        })
    }
    function append_con_three(){
        $(window).scrollTop(0);
        $("#maskIn3").css({"display":"block"}).siblings("div").css({"display":"none"});
        $("section .game_time").animate({"opacity":"1"}).siblings().animate({"opacity":"0.1"});
        $(".swiper-container").siblings().animate({"opacity":"0.1"});
        $(".swiper-container").children("div").animate({"opacity":"0.1"});
        $(".kxt").animate({"opacity":"1"});
        $("#maskIn3 .mask_true").click(function(){
            append_con_two();
        });
        $("#maskIn3 .on_c_next").click(function(){
            append_con_four();
        })

    }
    // function append_con_four(){
    //     $(window).scrollTop(0);
    //     $("#maskIn4").css({"display":"block"}).siblings("div").css({"display":"none"});
    //     $("section").children().animate({"opacity":"0.1"});
    //     $("#maskIn4 .mask_true").click(function(){
    //         append_con_three();
    //     });
    //     $("#maskIn4 .on_c_next").click(function(){
    //         append_con_five();
    //     })


    // }
    function append_con_four(){
        $(window).scrollTop(0);
        $("#maskIn4 .mask_true").click(function(){
            append_con_three();
        });
        $("#maskIn4").css({"display":"block"}).siblings("div").css({"display":"none"});
        $("section").children().animate({"opacity":"0.1"});

        $("#maskIn4 .on_c_next").click(function(){
            // $(this).parent().parent("div").css({"display":"none"});
            window.location.href = "/"
            $("#novice").animate({"opacity":"1"});
            $("section>*").animate({"opacity":"1"});
            $(".swiper-container").children().animate({"opacity":"1"});
            $(".game_time").children().animate({"opacity":"1"});
            $(".page_box").animate({"opacity":"1"});
        })

    }
    var window_h = $(window).height();
    $("body>div").height(window_h);
    $("#novice").animate({"opacity":"0.1"});
    //执行第一个动画
    append_con_one();
    $(".mask_guan").click(function(){
        console.log(1);
        window.location.href = "/"
        // $(this).parent("div").css({"display":"none"});
        $("#novice").animate({"opacity":"1"});
        $("section>*").animate({"opacity":"1"});
        $(".swiper-container").children().animate({"opacity":"1"});
        $(".game_time").children().animate({"opacity":"1"});
        $(".page_box").animate({"opacity":"1"});
    });

}
$("#novice").click(function(){
    novice();
});