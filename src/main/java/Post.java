package post;
import java.sql.Timestamp;

public class Post
{
    public Post(String username, int postid, String title, String body, Timestamp modified, Timestamp created)
    {
		this.username = username;
		this.postid = postid;
		this.title= title;
		this.body = body;
		this.modified = modified;
		this.created = created;
    }
    
    public int getPostid()
    {
        return this.postid;
    }

    public String getUsername()
    {
        return this.username;
    }

    public String getTitle()
    {
        return this.title;
    }

    public String getBody()
    {
        return this.body;
    }

    public String getModDate()
    {
        return this.parseDate(this.modified.toString());
    }

    public String getCreateDate()
    {
        return this.parseDate(this.created.toString());
    }
    
    private String parseDate(String d)
    {
        String ret = "";
        ret += d.charAt(5);
        ret += d.charAt(6);
        ret += '/';
        ret += d.charAt(8);
        ret += d.charAt(9);
        ret += '/';
        for(int i = 0; i < 4; i++)
            ret += d.charAt(i);
        
        ret += ' ';
        ret += d.substring(11, 16);
        return ret;
    }

    private int postid;
    private String username;
	private String title;
	private String body;
	private Timestamp modified;
	private Timestamp created;
}