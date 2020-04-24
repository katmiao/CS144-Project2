<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Preview Post</title>
</head>
<body>
    <div><h1>Preview Post</h1></div>
    <form action="post" method="post">
        <div>
            <button type="submit" name="action" value="edit">Close Preview</button>
        </div>
        <div>
            <label for="title">Title</label>
            <jsp:element name="input">
                <jsp:attribute name="type">text</jsp:attribute>
                <jsp:attribute name="id">title</jsp:attribute>
                <jsp:attribute name="value"><%= request.getAttribute("title") %></jsp:attribute>
            </jsp:element>
        </div>
        <div>
            <label for="body">Body</label>
            <jsp:element name="textarea">
                <jsp:attribute name="style">height: 20rem</jsp:attribute>
                <jsp:attribute name="id">body</jsp:attribute>
                <jsp:body><%= request.getAttribute("body") %></jsp:body>
            </jsp:element>
        </div>
    </form>
    </div>
        
    </div>
</body>
</html>

String postidStr = request.getParameter("postid");
        int postid = Integer.parseInt(postidStr);