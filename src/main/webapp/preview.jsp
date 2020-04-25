<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <title>Preview Post</title>
</head>
<body>
    <div class="row">
        <div class="col"></div>
        <div class="col">
            <div style="text-align: center; margin: 20px;">
                <form action="post" method="post">
                    <div>
                        <button class="btn btn-outline-primary" type="submit" name="action" value="open">Close Preview</button>
                    </div>
                    <input type="hidden" name="username" value='<%= request.getParameter("username") %>'>
                    <input type="hidden" name="postid" value='<%= request.getAttribute("postid") %>'>
                    <input type="hidden" name="title" value='<%= request.getAttribute("title") %>'>
                    <input type="hidden" name="body" value='<%= request.getAttribute("body") %>'>
                </form>
            </div>
            <div>
                <h1><%= request.getAttribute("markdownTitle") %></h1><br>
                <div><p><%= request.getAttribute("markdownBody") %></p></div>
            </div>
        </div>
        <div class="col"></div>
    </div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
