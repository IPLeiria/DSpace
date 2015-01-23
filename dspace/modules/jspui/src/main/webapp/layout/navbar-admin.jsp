<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Navigation bar for admin pages
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="org.dspace.sort.SortOption" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>

<%@ taglib uri="/WEB-INF/dspace-tags.tld" prefix="dspace" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="org.dspace.core.I18nUtil" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ResourceBundle;" %>
<%
    String siteName = ConfigurationManager.getProperty("dspace.name");

    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");

    // Is the logged in user an admin
    Boolean admin = (Boolean) request.getAttribute("is.admin");
    boolean isAdmin = (admin == null ? false : admin.booleanValue());

    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf('?');
    if (c > -1) {
        currentPage = currentPage.substring(0, c);
    }

    // E-mail may have to be truncated
    String navbarEmail = null;
    if (user != null) {
        navbarEmail = user.getEmail();
    }

    // get the locale languages
    Locale[] supportedLocales = I18nUtil.getSupportedLocales();
    Locale sessionLocale = UIUtil.getSessionLocale(request);

    ResourceBundle res = ResourceBundle.getBundle("MessagesIPLeiria", sessionLocale);
    String stringNetwork = "";
    String stringSearchFieldCaption = "";
    String stringSearchField = "";
    String stringSearchSubmit = "";
    String stringLoading = "";
    if (res.containsKey("jsp.layout.ipleiria.header-default.network")) {
        stringNetwork = res.getString("jsp.layout.ipleiria.header-default.network");
    }
    if (res.containsKey("jsp.layout.ipleiria.header-default.search-field-caption")) {
        stringSearchFieldCaption = res.getString("jsp.layout.ipleiria.header-default.search-field-caption");
    }
    if (res.containsKey("jsp.layout.ipleiria.header-default.search-field-title")) {
        stringSearchField = res.getString("jsp.layout.ipleiria.header-default.search-field-title");
    }
    if (res.containsKey("jsp.layout.ipleiria.header-default.search-submit")) {
        stringSearchSubmit = res.getString("jsp.layout.ipleiria.header-default.search-submit");
    }
    if (res.containsKey("jsp.layout.ipleiria.header-default.loading")) {
        stringLoading = res.getString("jsp.layout.ipleiria.header-default.loading");
    }
%>

<div id="IPLeiria-top-bar" class="ipleiria-bar">
    <div class="wrapper">
        <div class="container">
            <ul class="pull-left nav navbar-nav">
                <li><a id="ipleiria-bar" href="#"><%= stringNetwork%></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <abbr class="user-abbr" title="<fmt:message key="jsp.layout.navbar-default.loggedin"><fmt:param><%= StringUtils.abbreviate(navbarEmail, 15)%></fmt:param></fmt:message> ">
                            <span class="inner-abbr"><%= StringUtils.abbreviate(navbarEmail, 10)%></span>
                        </abbr>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="<%= request.getContextPath()%>/mydspace"><fmt:message key="jsp.layout.navbar-default.users"/></a></li>
                        <li><a href="<%= request.getContextPath()%>/subscribe"><fmt:message key="jsp.layout.navbar-default.receive"/></a></li>
                        <li><a href="<%= request.getContextPath()%>/profile"><fmt:message key="jsp.layout.navbar-default.edit"/></a></li>
                        <li>
                            <a href="<%= request.getContextPath()%>/logout">
                                <fmt:message key="jsp.layout.navbar-default.logout"/>
                            </a>
                        </li>
                    </ul>
                </li>
                <li><form role="search" method="get" class="search-form" action="<%= request.getContextPath()%>/simple-search">
                        <label class="screen-reader-text" for="IPLeiria-top-bar-search"><%= stringSearchFieldCaption%></label>
                        <input id="IPLeiria-top-bar-search" type="search" class="search-field" placeholder="<fmt:message key="jsp.layout.navbar-default.search"/>" value="" name="query" id="tequery" title="<%= stringSearchField%>">
                        <input type="submit" class="search-submit screen-reader-text" value="<%= stringSearchSubmit%>">
                    </form></li>
            </ul>
            <% if (supportedLocales != null && supportedLocales.length > 1) { %>
            <div id="language-bar" class="pull-right">
                <ul class="language-chooser" title="<fmt:message key="jsp.layout.navbar-default.language"/>">
                    <% for (int i = supportedLocales.length - 1; i >= 0; i--) {%>
                    <li class="lang-item lang-item-<%=supportedLocales[i].toString()%> <%=(sessionLocale.equals(supportedLocales[i]) ? "current-lang" : "")%>">
                        <a hreflang="<%=supportedLocales[i].toString()%>" onclick="javascript:document.repost.locale.value = '<%=supportedLocales[i].toString()%>';
                                document.repost.submit();" href="<%= request.getContextPath()%>?locale=<%=supportedLocales[i].toString()%>">
                            <abbr lang="<%=supportedLocales[i].toString()%>" title="<%= supportedLocales[i].getDisplayLanguage(supportedLocales[i])%>"><%=supportedLocales[i].toString()%></abbr>
                        </a>
                    </li>
                    <% } %>
                </ul>
            </div>
            <% }%>
        </div>
    </div>
</div>
<iframe id="ipleiria-bar-panel" title="<%= stringNetwork%>" src="http://www.ipleiria.pt/IPLeiriaBar.html?lang=<%=sessionLocale.toString()%>" class="IPLeiriaBarClientFrame" style="width: 100%; height: 0px; overflow: hidden; display: none;" sandbox="allow-same-origin allow-top-navigation allow-forms allow-scripts"><%= stringLoading%></iframe>
<script>
    (function ($) {
        if ($('#ipleiria-bar-panel').responsiveIframe) {
            $('#ipleiria-bar-panel').responsiveIframe({'xdomain': '*', 'autoHeight': false});
        }
        $("#ipleiria-bar").click(function () {
            $("#ipleiria-bar-panel").trigger("ResponsiveIframeToggle");
            return false;
        });
    })(jQuery.noConflict());
</script>
<div class="container">

    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="<%= request.getContextPath()%>/" title="<fmt:message key="jsp.layout.navbar-default.home"/>"><img src="<%= request.getContextPath()%>/image/logo.png" alt="<%= siteName%>" /></a>
    </div>
    <nav class="collapse navbar-collapse bs-navbar-collapse main-menu" role="navigation">
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="jsp.layout.navbar-admin.contents"/> <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%= request.getContextPath()%>/tools/edit-communities"><fmt:message key="jsp.layout.navbar-admin.communities-collections"/></a></li>
                    <li class="divider"></li>
                    <li><a href="<%= request.getContextPath()%>/tools/edit-item"><fmt:message key="jsp.layout.navbar-admin.items"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/workflow"><fmt:message key="jsp.layout.navbar-admin.workflow"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/supervise"><fmt:message key="jsp.layout.navbar-admin.supervisors"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/curate"><fmt:message key="jsp.layout.navbar-admin.curate"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/withdrawn"><fmt:message key="jsp.layout.navbar-admin.withdrawn"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/privateitems"><fmt:message key="jsp.layout.navbar-admin.privateitems"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/metadataimport"><fmt:message key="jsp.layout.navbar-admin.metadataimport"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/batchimport"><fmt:message key="jsp.layout.navbar-admin.batchimport"/></a></li>             
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="jsp.layout.navbar-admin.accesscontrol"/> <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/edit-epeople"><fmt:message key="jsp.layout.navbar-admin.epeople"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/tools/group-edit"><fmt:message key="jsp.layout.navbar-admin.groups"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/tools/authorize"><fmt:message key="jsp.layout.navbar-admin.authorization"/></a></li>
                </ul>
            </li>
            <li><a href="<%= request.getContextPath()%>/statistics"><fmt:message key="jsp.layout.navbar-admin.statistics"/></a></li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="jsp.layout.navbar-admin.settings"/> <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/metadata-schema-registry"><fmt:message key="jsp.layout.navbar-admin.metadataregistry"/></a></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/format-registry"><fmt:message key="jsp.layout.navbar-admin.formatregistry"/></a></li>
                    <li class="divider"></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/news-edit"><fmt:message key="jsp.layout.navbar-admin.editnews"/></a></li>
                    <li class="divider"></li>
                    <li><a href="<%= request.getContextPath()%>/dspace-admin/license-edit"><fmt:message key="jsp.layout.navbar-admin.editlicense"/></a></li>
                </ul>
            </li>          
            <li class="<%= (currentPage.endsWith("/help") ? "active" : "")%>"><dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.site-admin\") %>"><fmt:message key="jsp.layout.navbar-admin.help"/></dspace:popup></li>
        </ul>
    </nav>
</div>
