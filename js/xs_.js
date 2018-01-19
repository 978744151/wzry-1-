function novice(){
    $("nav").animate({"opacity":"0.1"});
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
        $(window).scrollTop(150);
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
    function append_con_four(){
        $(window).scrollTop(0);
        $("#maskIn4").css({"display":"block"}).siblings("div").css({"display":"none"});
        $("section").children().animate({"opacity":"0.1"});
        $("#maskIn4 .mask_true").click(function(){
            append_con_three();
        });
        $("#maskIn4 .on_c_next").click(function(){
            append_con_five();
        })
