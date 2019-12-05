
### [Makers Academy](http://www.makersacademy.com) - Week 4 Pair Programming Project

Bookmark Manager Challenge 
-

[Outline](#Outline) | [Task](#Task) | [Installation Instructions](#Installation) | [Domain Model](#Domain_Model) | [User Stories](#Story) | [Feature Tests](#Feature_Tests) | [Objects & Methods](#Methods) |


## <a name="Outline">Outline</a>
 
This week, we're building a web app that stores web bookmarks in a database.

## <a name="Task">The Task</a>

We're going to build a bookmark manager. A bookmark manager is a website to maintain a collection of bookmarks (URLs). You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse bookmarks other users have added. You can comment on the bookmarks.

## <a name="Installation">Installation Instructions</a>

Clone the repository from github then change directory into it. Run bundle then rackup to initialise the server.

```
$ git clone git@github.com:BenSheridanEdwards/Bookmark_Manager.git
$ cd Bookmark_Manager
$ bundle
$ rackup
```

## <a name="Story">User Stories</a>

```
As a user of the bookmark manager,
so I can access websites I go to regularly,
I would like to view all my bookmarks,
```

```
As a time-pressed user
So that I can save a website
I would like to add the site's address and title to bookmark manager
```

```
As a user
So that I can prevent my bookmark manager from being cluttered
I would like to be able to delete bookmarks from my bookmark manager
```

```
As a user
So that I can make changes to bookmark information
I would like to be able to update my bookmarks
```

## <a name="Domain_Model">Domain Model</a>

![Model](https://raw.githubusercontent.com/BenSheridanEdwards/Bookmark_Manager/98498848e117fac2cf863d19e71e4e7c0902ddb8/Screenshot%202019-12-02%20at%2015.15.26.png)

## <a name="Set_database">Setting up</a>

Setting up the SQL development database

```
> psql postgres
> CREATE DATABASE bookmark_manager;
> \c bookmark_manager
> CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));
```

Setting up the SQL test database

```
> psql postgres
> CREATE DATABASE bookmark_manager_test;
> \c bookmark_manager
> CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));
```
