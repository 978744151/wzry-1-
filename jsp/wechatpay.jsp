<%--
  Created by IntelliJ IDEA.
  User: mac
  Date: 2017/12/29
  Time: 下午12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>正在支付</title>
    <link src=""/>

    <script type="text/javascript">
        var Gjsapipara = "";
        //调用微信JS api 支付
        function jsApiCall()
        {

            Gjsapipara = document.getElementById("jsApiParameters").innerText;
            var obj = JSON.parse(Gjsapipara);
            WeixinJSBridge.invoke(
                    'getBrandWCPayRequest',
                    obj,
                    function(res){
//                        WeixinJSBridge.log(res.err_msg);
                       // alert(res.err_code+" "+res.err_desc+" "+res.err_msg);
//                        console.log( res.err_code+" "+res.err_desc+" "+res.err_msg );
                        if( res.err_msg == "get_brand_wcpay_request:ok" ){
                            window.location.href = "http://"+window.location.host;
                        }
                    }
            );
        }

        function callpay( )
        {
            Gjsapipara = document.getElementById("jsApiParameters").innerText;
            if( Gjsapipara.length <= 1 )
            {
                setTimeout("callpay()",1000*1);
                return;
            }

            if (typeof WeixinJSBridge == "undefined"){

                if( document.addEventListener ){
                    document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
                }else if (document.attachEvent){
                    document.attachEvent('WeixinJSBridgeReady', jsApiCall);
                    document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
                }
            }else{
                jsApiCall();
            }
        }
    </script>
    <script type="text/javascript">
        //获取共享地址

        window.onload = function(){

            setTimeout("callpay()",1000*1);
        };

    </script>
</head>
<body>
<span style="display: none;" id="jsApiParameters">${jsApiParameters}</span>

</body>
</html>
