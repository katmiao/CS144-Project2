<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="post.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Page</title>
    <style>
        .postText { font-weight: normal; }
    </style>
</head>
<body>
    <div>
        <form action="post" id="0">
            <input type="hidden" name="username" value="test_user">
            <input type="hidden" name="postid" value="0">
            <button type="submit" name="action" value="open">New Post</button>
        </form>
    </div>
    <table>
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
                            <button type="submit" name="action" value="open">Open</button>
                            <button type="submit" name="action" value="delete">Delete</button>
                        </form>
                    </th>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>