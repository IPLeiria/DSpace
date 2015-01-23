<%--
    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
--%>
<%--
  - Default navigation bar
--%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="/WEB-INF/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="java.util.Map" %>
<%
    String siteName = ConfigurationManager.getProperty("dspace.name");

    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");

    // Is the logged in user an admin
    Boolean admin = (Boolean)request.getAttribute("is.admin");
    boolean isAdmin = (admin == null ? false : admin.booleanValue());

    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf( '?' );
    if( c > -1 )
    {
        currentPage = currentPage.substring( 0, c );
    }

    // E-mail may have to be truncated
    String navbarEmail = null;

    if (user != null)
    {
        navbarEmail = user.getEmail();
    }
%>

<div class="container">
    <nav class="navbar">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<%= request.getContextPath() %>/" title="<fmt:message key="jsp.layout.navbar-default.home"/>"><img src="<%= request.getContextPath() %>/image/logo.png" alt="<%= siteName %>" /></a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right main-menu">
                <li class="dropdown">
                    <% if (user != null){ %>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                        <fmt:message key="jsp.layout.navbar-default.loggedin">
                            <fmt:param><%= navbarEmail %></fmt:param>
                        </fmt:message> <b class="caret"></b>
                    </a>
                    <% } else { %>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                        <fmt:message key="jsp.layout.navbar-default.sign"/> <b class="caret"></b>
                    </a>
                    <% } %>             
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="<%= request.getContextPath() %>/mydspace"><fmt:message key="jsp.layout.navbar-default.users"/></a></li>
                        <li><a href="<%= request.getContextPath() %>/subscribe"><fmt:message key="jsp.layout.navbar-default.receive"/></a></li>
                        <li><a href="<%= request.getContextPath() %>/profile"><fmt:message key="jsp.layout.navbar-default.edit"/></a></li>
                            <% if (isAdmin){ %>
                        <!--<li class="divider"></li>-->
                        <li><a href="<%= request.getContextPath() %>/dspace-admin"><fmt:message key="jsp.administer"/></a></li>
                            <% } 
                               if (user != null) {
                            %>
                        <li>
                            <a href="<%= request.getContextPath() %>/logout">
                                <fmt:message key="jsp.layout.navbar-default.logout"/>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</div>