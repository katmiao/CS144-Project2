<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Preview Post</title>
</head>
<body>
    <div>
        <form action="post" method="post">
            <div>
                <button type="submit" name="action" value="open">Close Preview</button>
            </div>
            <input type="hidden" name="username" value='<%= request.getParameter("username") %>'>
            <input type="hidden" name="postid" value='<%= request.getParameter("postid") %>'>
            <input type="hidden" name="title" value='<%= request.getParameter("title") %>'>
            <input type="hidden" name="body" value='<%= request.getParameter("body") %>'>
        </form>
    </div>
    <div>
        <h1><%= request.getAttribute("markdownTitle") %></h1><br>
        <div><p><%= request.getAttribute("markdownBody") %></p></div>
    </div>
</body>
</html>
