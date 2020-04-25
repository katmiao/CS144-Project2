<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <title>Edit Post</title>
</head>
<body>
<div class="container" style="text-align: center;">
    <div><h1>Edit Post</h1></div>
    <form action="post" method="post">
        <div>
            <jsp:element name="input">
                <jsp:attribute name="type">hidden</jsp:attribute>
                <jsp:attribute name="name">username</jsp:attribute>
                <jsp:attribute name="value"><%= request.getAttribute("username") %></jsp:attribute>
            </jsp:element>
            <jsp:element name="input">
                <jsp:attribute name="type">hidden</jsp:attribute>
                <jsp:attribute name="name">postid</jsp:attribute>
                <jsp:attribute name="value"><%= request.getAttribute("postid") %></jsp:attribute>
            </jsp:element>
            <button class="btn btn-outline-primary" type="submit" name="action" value="save">Save</button>
            <button class="btn btn-outline-primary" type="submit" name="action" value="list">Close</button>            
            <button class="btn btn-outline-primary" type="submit" name="action" value="preview">Preview</button>
            <button class="btn btn-outline-primary" type="submit" name="action" value="delete">Delete</button>
        </div>
        <div style="text-align: left; margin-bottom: 20px;">
            <label for="title">Title</label>
            <jsp:element name="input">
                <jsp:attribute name="class">form-control</jsp:attribute>
                <jsp:attribute name="style">width: 100%;</jsp:attribute>
                <jsp:attribute name="type">text</jsp:attribute>
                <jsp:attribute name="name">title</jsp:attribute>
                <jsp:attribute name="placeholder">Write the title of your post here...</jsp:attribute>
                <jsp:attribute name="value"><%= request.getAttribute("title") %></jsp:attribute>
            </jsp:element>
        </div>
        <div style="text-align: left;">
            <label for="body">Body</label>
            <jsp:element name="textarea">
                <jsp:attribute name="name">body</jsp:attribute>
                <jsp:attribute name="class">form-control</jsp:attribute>
                <jsp:attribute name="style">height: 20rem; width: 100%;</jsp:attribute>
                <jsp:attribute name="placeholder">Write the body of your post here...</jsp:attribute>
                <jsp:body><%= request.getAttribute("body") %></jsp:body>
            </jsp:element>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
