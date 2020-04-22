<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Post</title>
</head>
<body>
    <div><h1>Edit Post</h1></div>
    <form action="/editor/post" method="post">
        <div>
            <jsp:element name="input">
                <jsp:attribute name="type">hidden</jsp:attribute>
                <jsp:attribute name="name">username</jsp:attribute>
                <jsp:attribute name="value"><%= request.getAttribute("username") %></jsp:attribute>
            </jsp:element>
            <button type="submit" name="action" value="save">Save</button>
            <button type="submit" name="action" value="list">Close</button>            
            <button type="submit" name="action" value="preview">Preview</button>
            <button type="submit" name="action" value="delete">Delete</button>
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
</body>
</html>
