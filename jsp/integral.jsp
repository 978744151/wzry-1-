<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
    <script src="${pageContext.request.contextPath}/js/iscroll.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/integral.css">
    <script src="${pageContext.request.contextPath}/js/base.js"></script>
    <script>
      var chestCount = 38;
      var chainCount = 6;
      var chestImageArray = new Array();
      var chainImageArray = new Array();
      var chestLeftArr = [10,35,20,-35,-10,-20,10,35,20,
        -35,-10,-20,10,35,20,-35,-10,-20,10,35,20,-35,-10,
        -20,10,35,20,-35,-10,-20,10,35,20,-35,-10,-20,10,
        35,20,-35,-10,-20,10,35,20,-35,-10];
      var userChestList = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
      var chestImageLoadTimer = null;
      var integralContentiScroll = '';
      
      function gotoScroll(){ 
        integralContentiScroll = new IScroll('.page_body',{
            mouseWheel:true,
            scrollbars:false,
            bounce:false,
            click:iScrollClick()
        });
        var lastLockChest = $('.lock')[$('.lock').length-1];
        var clientHeight = parseInt($('.page_body').css('height'));
        var pageHeight = parseInt($('.page_content').css('height'));
        integralContentiScroll.scrollToElement(lastLockChest,0,0,pageHeight);
        integralContentiScroll.scrollToElement(lastLockChest,0,0,-clientHeight/2,IScroll.utils.ease.linear);

        bindLockBtn();
      }
      function page_onload(){
        loadChestImg();
        loadChainImg();
        getAllImgStatus();
      }
      function bindLockBtn(){
        $('.lock').on('click',function(){
          var index = chestCount - $('.lock').index(this);
          if( $('.lock').index(this) == $('.lock').length-1 ){
            $(this).removeClass('lock');
            $(this).unbind('click');
            alert("成功开启第"+index+"个宝箱");
          }else{
            alert("请先开启前置宝箱");
          }
        });
      }
      function chestInit(){
        for(var i = chestImageArray.length - 1 ; i > 0 ; i-- ){
          if(chestImageArray[i]){
            var chestLeft = parseInt(chestLeftArr[chestImageArray.length - 1 - i]);
            var imghtml = "";

            imghtml += "<div "
            imghtml += "style='left:"+ chestLeft + "%'";
            if(userChestList[i]) 
              imghtml += "class='lock'>";
            else 
              imghtml += ">";
            imghtml += "<img src='"+chestImageArray[i].src+"'/>";
            imghtml += "<span><img src='${pageContext.request.contextPath}/images/lock.png'/></span></div>";

            $('.chest_box').append(imghtml);
          }
        }
      }
      function chainInit(){
        var chestList = $('.chest_box>div');
        for(var i = 0 ; i < chestList.length ; i++ ){
          if(chestList[i+1]){
            var chainWidth = chestLeftArr[i] - chestLeftArr[i+1];
            
            //chainType 
            var chainType = 0 , chainLeft = 0;
            if(chestLeftArr[i] - chestLeftArr[i+1] < 0){
              chainLeft = 50 + chestLeftArr[i];
              chainType = Math.abs(chestLeftArr[i] - chestLeftArr[i+1]) < 20 ? 3 : 1;
              chainType = Math.abs(chestLeftArr[i] - chestLeftArr[i+1]) > 60 ? 5 : chainType;
            }else{
              chainLeft = 50 + chestLeftArr[i+1];
              chainType = Math.abs(chestLeftArr[i] - chestLeftArr[i+1]) < 20 ? 4 : 2;
              chainType = Math.abs(chestLeftArr[i] - chestLeftArr[i+1]) > 60 ? 6 : chainType;
            }
            //chainCSS
            var chainMarginTop = i == 0 ? parseInt($(chestList[i]).css('height'))/2 : 0;
            var chainMarginLeft = 0//chestList[i].width/2;
            var chainHeight = ( 
                  parseInt($(chestList[i]).css('height')) + parseInt($(chestList[i+1]).css('height')) 
                )/2;
            var chainWidth = Math.abs(chestLeftArr[i] - chestLeftArr[i+1]);
            //chainHtml
            var imghtml = "";
            imghtml += "<img ";
            imghtml += "style='left:"+chainLeft+"%;margin-top:"+chainMarginTop+"px;";
            imghtml += "margin-left:"+chainMarginLeft+"px;height:"+chainHeight+"px;width:"+chainWidth+"%;'";
            imghtml += " src='${pageContext.request.contextPath}/images/score_chestimg_ironChain_"+chainType+".png'/>"
            $('.chain_box').append(imghtml);
          }
        }
        gotoScroll();
      }
      function getAllImgStatus(){
        chestImageLoadTimer = setInterval(function(){
          if(chestImageArray.length >= chestCount + 1){//所有图片加载完毕
            clearInterval(chestImageLoadTimer);
            chestImageLoadTimer = null;
            chestInit();//宝箱位置初始化
            chainInit();//链条位置初始化
          }
        },100);
      }

      function loadChestImg(){
        var callback = function(id,img){
          if(img.width){
            chestImageArray[id] = img;  
          }
        }
        for(var i = 1 ; i <= chestCount ; i++){
          var chestimgurl = '${pageContext.request.contextPath}/images/score_chest_box'+i+'.png';
          preLoadImg(i,chestimgurl,callback);
        }
      }
      function loadChainImg(){
        var callback = function(id,img){
          if(img.width){
            chainImageArray[id] = img;  
          }
        }
        for(var i = 1 ; i <= chainCount ; i++){
          var chainimgurl = '${pageContext.request.contextPath}/images/score_chestimg_ironChain_'+i+'.png';
          preLoadImg(i,chainimgurl,callback);
        }
      }
      function preLoadImg(id,url,callback) { 
        var img = new Image(); 
        img.src = url;
        if(img.complete) {
          callback(id,img);
          return;
        }
        img.onload = function(){
          callback(id,img);
        };
      } 
    </script>
</head>
<body>
<div class="page_box">
  <div class='page_body'>
    <div class='page_content'>
      <div class='chest_box'>
        <!-- 宝箱 -->
      </div>
      <div class='chain_box'>
        <!-- 链条 -->
      </div>
    </div>
  </div>
</div>
</body>
</html>