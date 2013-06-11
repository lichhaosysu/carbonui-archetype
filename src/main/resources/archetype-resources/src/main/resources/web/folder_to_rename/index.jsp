<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://wso2.org/projects/carbon/taglibs/carbontags.jar"
	prefix="carbon"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
</head>
<body>

	<fmt:bundle basename="demo.Resources">
		<carbon:breadcrumb label="${artifactId}" resourceBundle="${package}.i18n.Resources"
			topPage="true" request="<%=request%>" />

		<p>这是一个JSP测试页面。</p>

	</fmt:bundle>


</body>
</html>