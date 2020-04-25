<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="post.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./bootstrap/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <title>List Page</title>
    <style>
        .postText { font-weight: normal; }
    </style>
</head>
<body>
    <div class="container" style="text-align:center;">
        <div style="margin: 20px;">
            <form action="post" id="0">
                <jsp:element name="input">
                    <jsp:attribute name="type">hidden</jsp:attribute>
                    <jsp:attribute name="name">username</jsp:attribute>
                    <jsp:attribute name="value"><%= request.getAttribute("username") %></jsp:attribute>
                </jsp:element>
                <input type="hidden" name="postid" value="0">
                <button class="btn btn-outline-primary" type="submit" name="action" value="open">New Post</button>
            </form>
        </div>
        <table style="text-align: center; width: 100%;">
            <tbody>
                <tr>
                    <th>Title</th>
                    <th>Created</th>
                    <th>Modified</th>
                    <th>&nbsp</th>
                </tr>
                <% ArrayList<Post> posts = (ArrayList<Post>)request.getAttribute("posts"); %>

                <% for(int i = 0; i < posts.size(); i++) { %>
                    <tr>
                        <th class="postText"><%= posts.get(i).getTitle() %></th>
                        <th class="postText"><%= posts.get(i).getCreateDate() %></th>
                        <th class="postText"><%= posts.get(i).getModDate() %></th>
                        <th>
                            <form action="post" method="post">
                                <jsp:element name="input">
                                    <jsp:attribute name="type">hidden</jsp:attribute>
                                    <jsp:attribute name="name">username</jsp:attribute>
                                    <jsp:attribute name="value"><%=posts.get(i).getUsername()%></jsp:attribute>
                                </jsp:element>
                                <jsp:element name="input">
                                    <jsp:attribute name="type">hidden</jsp:attribute>
                                    <jsp:attribute name="name">postid</jsp:attribute>
                                    <jsp:attribute name="value"><%=posts.get(i).getPostid()%></jsp:attribute>
                                </jsp:element>
                                <button class="btn btn-outline-primary" type="submit" name="action" value="open">Open</button>
                                <button class="btn btn-outline-primary" type="submit" name="action" value="delete">Delete</button>
                            </form>
                        </th>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="./bootstrap/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>