<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Footer for home page
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ResourceBundle" %>

<%
    String sidebar = (String) request.getAttribute("dspace.layout.sidebar");

    Locale sessionLocale = UIUtil.getSessionLocale(request);

    ResourceBundle res = ResourceBundle.getBundle("MessagesIPLeiria", sessionLocale);
    String stringFooter = "";
    String stringLoading = "";
    if (res.containsKey("jsp.layout.ipleiria.footer-default.footer")) {
        stringFooter = res.getString("jsp.layout.ipleiria.footer-default.footer");
    }
    if (res.containsKey("jsp.layout.ipleiria.header-default.loading")) {
        stringLoading = res.getString("jsp.layout.ipleiria.header-default.loading");
    }
%>

<%-- Right-hand side bar if appropriate --%>
<%
    if (sidebar != null) {
%>
</div>
<div class="col-md-3">
    <%= sidebar%>
</div>
</div>       
<%
    }
%>
</div>
</main>
<%-- Page footer --%>
<footer>
    <iframe id="ipleiria-footer-panel" title="<%= stringFooter%>" src="http://www.ipleiria.pt/IPLeiriaFooter.html?lang=<%=sessionLocale.toString()%>&amp;technical-sheet-url=false" class="IPLeiriaFooterClientFrame" style="width: 100%; height: 465px; overflow: hidden; display: block;" sandbox="allow-same-origin allow-top-navigation allow-forms allow-scripts"><%= stringLoading%></iframe>
    <script>
        (function ($) {
            if($('#ipleiria-footer-panel').responsiveIframe){
                $('#ipleiria-footer-panel').responsiveIframe({'xdomain': '*'});
            }
        })(jQuery.noConflict());
    </script>
</footer>
</body>
</html>