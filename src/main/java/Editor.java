import java.io.IOException;
import java.sql.* ;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.commonmark.node.*;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;

import java.io.PrintWriter;
import java.util.*;
import post.*;
import java.sql.Timestamp;

/**
 * Servlet implementation class for Servlet: ConfigurationTest
 *
 */
public class Editor extends HttpServlet {
    /**
     * The Servlet constructor
     * 
     * @see javax.servlet.http.HttpServlet#HttpServlet()
     */
    public Editor() {}

    public void init() throws ServletException
    {
        /*  write any servlet initialization code here or remove this function */
        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
        } 
        catch (ClassNotFoundException e) 
        {
            System.out.println(e);
            return;
        }        
    }
    
    public void destroy()
    {
        /*  write any servlet cleanup code here or remove this function */
    }

    /**
     * Handles HTTP GET requests
     * 
     * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request,
     *      HttpServletResponse response)
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        // GET available for open, list, preview
        String queryStr = request.getQueryString();
        if(queryStr != null && !queryStr.equals(""))
        {
            Hashtable<String, String> nameValDict = new Hashtable<String, String>();

            String[] pairs = queryStr.split("&", 0);
            for(int i = 0; i < pairs.length; i++)
            {
                if(pairs[i].equals(""))
                    this.handleInvalidRequest(request, response);
                String[] p = pairs[i].split("=", 2);
                if(p.length != 2)
                    this.handleInvalidRequest(request, response);
                nameValDict.put(p[0], p[1]);
            }

            String actionVal = nameValDict.get("action");
            
            if(actionVal == null)
            {
                this.handleList(request, response);
            }
            else if(actionVal.equals("open"))
            {
                this.handleOpen(request, response);
            }
            else if(actionVal.equals("list"))
            {
                this.handleList(request, response);
            }
            else if(actionVal.equals("preview"))
            {
                this.handlePreview(request, response);
            }
            else
            {
                this.handleInvalidRequest(request, response);
            }
        }
        else
        {
            this.handleList(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException 
    {
        // implement your POST method handling code here
        // POST available for open, list, preview, save, delete
        String actionVal = request.getParameter("action");
        System.err.println("-----doPost! actionVal = " + actionVal);
        if(actionVal == null)
        {
            this.handleList(request, response);
        }
        else if(actionVal.equals("open"))
        {
            this.handleOpen(request, response);
        }
        else if(actionVal.equals("list"))
        {
            this.handleList(request, response);
        }
        else if(actionVal.equals("preview"))
        {
            this.handlePreview(request, response);
        }
        else if(actionVal.equals("save"))
        {
            this.handleSave(request, response);
        }
        else if(actionVal.equals("delete"))
        {
            this.handleDelete(request, response);
        }
        else 
        {
            this.handleInvalidRequest(request, response);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        String passedUsername = request.getParameter("username");
        if(passedUsername == null || passedUsername.equals(""))
        {
            this.handleInvalidRequest(request, response);
            return;
        }

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CS144", "cs144", "");
            stmt = con.createStatement();
            String sql = "SELECT * FROM Posts;";
            rs = stmt.executeQuery(sql);

            String username, title, body;
            Timestamp createdDate, modifiedDate;
            int postid;
            ArrayList<Post> posts = new ArrayList();
            while(rs.next())
            {
                username = rs.getString("username");
                title = rs.getString("title");
                postid = rs.getInt("postid");
                body = rs.getString("body");
                createdDate = rs.getTimestamp("created");
                modifiedDate = rs.getTimestamp("modified");
                
                Post p = new Post(username, postid, title, body, modifiedDate, createdDate);
                posts.add(p);
            }

            request.setAttribute("posts", posts);
        }
        catch(Exception e)
        {
            System.err.println(e);
            return;
        }
        finally
        {
            // close connectiosn to db
            if(rs != null)
            {
                try
                {
                    rs.close();
                }
                catch(SQLException e)
                {
                    System.err.println("SQL Exception: unable to close ResultSet: " + e);
                }
            }

            if(stmt != null)
            {
                try
                {
                    stmt.close();
                }
                catch(SQLException e)
                {
                    System.err.println("SQL Exception: unable to close Statement: " + e);
                }
            }

            if(con != null)
            {
                try
                {
                    con.close();
                }
                catch(SQLException e)
                {
                    System.err.println("SQL Exception: unable to close Connection: " + e);
                }
            }
        }

        request.getRequestDispatcher("/list.jsp").forward(request, response);
    }

    private void handleOpen(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        String username = request.getParameter("username");
        String postidStr = request.getParameter("postid");
        String title = "";
        String body = "";

        // username and postid were supplied
        if(username != null && postidStr != null && !username.equals("") && !postidStr.equals(""))
        {
            int postid = Integer.parseInt(postidStr);
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            // post id is greater than 0
            if(postid > 0)
            {
                String passedTitle = request.getParameter("title");
                String passedBody = request.getParameter("body");
                // if both title and body are passed in, use them as default values
                if(passedTitle != null && passedBody != null)
                {
                    title = passedTitle;
                    body = passedBody;
                }
                // try to look for the post using username and postid
                else
                {
                    try
                    {
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CS144", "cs144", "");
                        pstmt = con.prepareStatement("SELECT * FROM Posts WHERE username = ? AND postid = ?;");
                        pstmt.setString(1, username);
                        pstmt.setInt(2, postid);

                        rs = pstmt.executeQuery();

                        // should only iterate once, even though it's a while loop
                        while(rs.next())
                        {
                            title = rs.getString("title");
                            body = rs.getString("body");
                        }
                    }
                    catch(Exception e)
                    {
                        System.err.println(e);
                        return;
                    }
                    finally
                    {
                        // close connections to db
                        if(rs != null)
                        {
                            try
                            {
                                rs.close();
                            }
                            catch(SQLException e)
                            {
                                System.err.println("SQL Exception: unable to close ResultSet: " + e);
                            }
                        }

                        if(pstmt != null)
                        {
                            try
                            {
                                pstmt.close();
                            }
                            catch(SQLException e)
                            {
                                System.err.println("SQL Exception: unable to close PreparedStatement: " + e);
                            }
                        }

                        if(con != null)
                        {
                            try
                            {
                                con.close();
                            }
                            catch(SQLException e)
                            {
                                System.err.println("SQL Exception: unable to close Connection: " + e);
                            }
                        }
                    }

                    // post was NOT found
                    if(title.equals("") && body.equals(""))
                    {
                        this.handleInvalidRequest(request, response);
                    }
                }
            }
            // postid is less than or equal to 0
            else
            {   
                // if both title and body are passed in, use them as default values
                String passedTitle = request.getParameter("title");
                String passedBody = request.getParameter("body");
                if(passedTitle != null && passedBody != null)
                {
                    title = passedTitle;
                    body = passedBody;
                }
            }

            request.setAttribute("title", title);
            request.setAttribute("body", body);
            request.getRequestDispatcher("/edit.jsp").forward(request, response);
        }
        else
        {
            this.handleInvalidRequest(request, response);
        }
    }

    private void handlePreview(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
    }

    private void handleSave(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        System.out.println("-----handleSave!");
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CS144", "cs144", "");

            String username = request.getParameter("username");
            String title = request.getParameter("title");
            String body = request.getParameter("body");
            String postidStr = request.getParameter("postid");
            int postid = Integer.parseInt(postidStr);

            System.err.println("username: " + username + ", title: " + title + ", body: " + body + ", postid: " + postid);

            // post should exist, update it
            if(postid > 0) {
                System.out.println("-----postid (>0) = " + postid);
                // check to see if username and postid exist in the database
                pstmt = con.prepareStatement("SELECT * FROM Posts WHERE username = ? AND postid = ?;");
                pstmt.setString(1, username);
                pstmt.setInt(2, postid);

                rs = pstmt.executeQuery();
                while(rs.next())
                {
                    // post exists, update the rows in the database
                    pstmt = con.prepareStatement("UPDATE Posts SET title = ?, body = ? WHERE username = ? AND postid = ?;");
                    pstmt.setString(1, title);
                    pstmt.setString(2, body);
                    pstmt.setString(4, username);
                    pstmt.setInt(5, postid);

                    pstmt.executeUpdate();
                }
            }

            // new post
            else {
                // find next postid
                pstmt = con.prepareStatement("SELECT MAX(postid) FROM Posts;");
                rs = pstmt.executeQuery();
                while(rs.next())
                {
                    postid = rs.getInt("postid") + 1;
                }
                System.out.println("-----postid (new) = " + postid);

                // make new post with the next postid, save it to the database
                pstmt = con.prepareStatement("INSERT INTO Posts(username, title, body, postid) VALUES ?, ?, ?, ?);");
                pstmt.setString(1, username);
                pstmt.setString(2, title);
                pstmt.setString(3, body);
                pstmt.setInt(4, postid);

                pstmt.executeUpdate();
            }
            
        }
        catch(Exception e)
        {
            System.err.println(e);
            return;
        }
        finally
        {
            if(rs != null) {
                try {
                    rs.close();
                }
                catch(SQLException e) {
                    System.err.println("SQL Exception: unable to close ResultSet: " + e);
                }
            }

            if(pstmt != null) {
                try {
                    pstmt.close();
                }
                catch(SQLException e) {
                    System.err.println("SQL Exception: unable to close PreparedStatement: " + e);
                }
            }

            if(con != null) {
                try {
                    con.close();
                }
                catch(SQLException e) {
                    System.err.println("SQL Exception: unable to close Connection: " + e);
                }
            }
        }
        System.out.println("-----return to list");
        request.getRequestDispatcher("/list.jsp").forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        Connection con = null;
        PreparedStatement pstmt = null;

        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CS144", "cs144", "");

            String username = request.getParameter("username");
            String postidStr = request.getParameter("postid");
            int postid = Integer.parseInt(postidStr);

            System.err.println("username: " + username + ", postid: " + postid);

            // post should exist, delete it
            if(postid > 0) {
                pstmt = con.prepareStatement("DELETE FROM Posts WHERE username = ? AND postid = ?;");
                pstmt.setString(1, username);
                pstmt.setInt(2, postid);

                pstmt.executeQuery();
            }    
        }
        catch(Exception e)
        {
            System.err.println(e);
            return;
        }
        finally
        {

            if(pstmt != null) {
                try {
                    pstmt.close();
                }
                catch(SQLException e) {
                    System.err.println("SQL Exception: unable to close PreparedStatement: " + e);
                }
            }

            if(con != null) {
                try {
                    con.close();
                }
                catch(SQLException e) {
                    System.err.println("SQL Exception: unable to close Connection: " + e);
                }
            }
        }
        request.getRequestDispatcher("/list.jsp").forward(request, response);
    }

    private void handleInvalidRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        request.getRequestDispatcher("/invalid_request.jsp").forward(request, response);
    }
}

