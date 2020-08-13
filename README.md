# CS144-Project2
Tomcat-Based Markdown Editor
Developing an online markdown editor using a “traditional” stack: MySQL and Apache Tomcat (Java servlet).

Application is available at the following path: `/editor/post?action=type&username=name&postid=num&title=title&body=body`
The parameter “action” specifies one of five actions that site can take: open, save, delete, preview, and list.
### open
- required parameters: username and postid
- function: return the “edit page” for the post with the given postid by the user
- If postid == 0,
  - if title and body parameters have been passed, use the passed parameter values as the initial title and body values and return with status code 200 (OK)
  - otherwise, set missing title and/or body to empty string and return with status code 200 (OK)
- If postid > 0,
  - if title and body parameters have been passed, use the passed parameter values as the initial title and body values and return with status code 200 (OK)
  - otherwise
    - if (username, postid) row exists in the database, retrieve the title and body from the database and return with status code 200 (OK).
    - otherwise, return with status code 404 (Not found).
### save
- required parameters: username, postid, title, and body
- function: save the post into the database and go to the “list page” for the user
- if postid == 0
  - assign a new postid, and save the content as a “new post”
- if postid > 0
  - if (username, postid) row exists in the database, update the row with new title, body, and modification date.
  - if (username, postid) row does not exist, do not make any change to the database
### delete
- required parameters: username and postid
- function: delete the corresponding post and go to the “list page”
### preview
- required parameters: username, postid, title, and body
- function: return the “preview page” with the html rendering of the given title and body
### list
- required parameters: username
- function: return the “list page” for the user
