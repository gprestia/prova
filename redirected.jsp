<!--
     Installed on ncelsdev02 in C:\Tomcat70\webapps\ROOT
     URL is http://ncelsdev02:8080/redirected.jsp
 -->

<%@ page session="false" %>
<%@ page isELIgnored="false" import="org.owasp.esapi.ESAPI,org.owasp.esapi.Encoder"%>

<!DOCTYPE html>
<html>
 <head>
    <title>Success</title>
 </head>

  <%! String encodeJavaScript(String toEncode){
    if(toEncode==null){
      return "";
    }
    return ESAPI.encoder().encodeForJavaScript(toEncode);
  }
  %>
 
    <body>
        <div>Authentication successful</div>
        <div id="id_token">Id token : <%=encodeJavaScript(request.getParameter("id_token"))%> </div>
        <div id="access_token">Access token : <%=encodeJavaScript(request.getParameter("access_token"))%> </div>                                   
        <div id="code">Code : <%=encodeJavaScript(request.getParameter("code"))%> </div>                                   
    </body>
    <script>
        document.getElementById("id_token").innerHTML+= ParseQuery("id_token");
        document.getElementById("access_token").innerHTML+= ParseQuery("access_token");
        document.getElementById("code").innerHTML+= ParseQuery("code");
        
        function ParseQuery(variable) {
            var result="";
            var currentval = document.getElementById(variable).innerHTML;
            var endcurrentval = currentval.substr(currentval.length -3);
            if (currentval.substr(currentval.length - 4) == " :  ")
            {
                result="not found";
                var query = window.location.hash.substring(1);
                var vars = query.split('&');
                for (var i = 0; i < vars.length; i++) {
                    var pair = vars[i].split('=');
                    console.log(decodeURIComponent(pair[0]) == variable)
                    if (decodeURIComponent(pair[0]) == variable) {
                        result=pair[1];
                    }
                 }
            }
            return result;
        }
    </script>
</html>