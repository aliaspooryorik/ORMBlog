<!--- Document Information -----------------------------------------------------
`
Title:      index.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    home page for the tBlog

Usage:

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<!--- get an array of all Category entites ordered by OrderIndex --->
<cfset categories = EntityLoad( "Category", {}, "OrderIndex" ) />

<!--- get an array all Post entities ordered by date --->
<cfset posts = EntityLoad( "Post", {}, "DateTime desc" ) />

<cfimport prefix="tags" taglib="tags">

<tags:wireframe>

<cfoutput>

<h1>ORMBlog - ORM Blog Example Application</h1>

<cfif !ArrayLen( categories )>
<p>Please Note: You need to create a user and a category before you can add a post.</p>
<cfelse>

<!--- display category list --->
<div id="categories">
	Categories
	<ul>
	<cfloop array="#categories#" index="Category">
		<li><a href="showPostByCategory.cfm?ID=#Category.getIDCategory()#">#Category.getName()#</a></li>
	</cfloop>
	</ul>
</div>

<!--- display posts --->
<cfloop array="#posts#" index="Post">
<div class="post">
	<h2><a href="displayPost.cfm?ID=#Post.getIDPost()#">#Post.getTitle()#</a></h2>
	<div class="postDate">
		Posted on
			#Post.getFormattedDateTime()#
		by #Post.getAuthorName()#
	</div>
	<div class="postBody">
	#ReReplace( Post.getBody(), "\n", "<br />", "all" )#
	</div>
	<!--- check that we have some categories for this post --->
	<cfif Post.hasCategories()>
	<ul>
		<cfloop array="#Post.getCategories()#" index="Category">
		<li><a href="showPostByCategory.cfm?ID=#Category.getIDCategory()#">#Category.getName()#</a></li>
		</cfloop>
	</ul>
	</cfif>
</div>
</cfloop>
</cfif>

</cfoutput>

</tags:wireframe>
