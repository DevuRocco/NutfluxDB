# NutfluxDB
Home of the knowledgeable MovieNut


1. Introduction
Databases are essential part of every project and makes our work easier by providing different storage strategies, data backup and archiving designs. Not only this we can monitor usage, volumes, and response times, we can perform indexing, we can implement functions to ease out the repetitive activities and triggers to alert on performance and integrity issues.
With the vision to develop a rich knowledge-based database providing attractive information to users through our platform NUTFLUX. With this, the company is seeking to improve its offerings by providing additional features that would enrich the product experience, attract the new subscribers, and nourish the relationship with the current subscribers. To offer such a rich experience, I will be replicating the key data elements from IMDb (The Internet Movie Database) so that I could provide to users the creative talent behind each title (Movie or TV Show). I am also planning to add the year information for titles such as release year and end year for tv shows and for people such as birth year, death year, award year, relationship year. This database will augment the NUTFLUX platform on two guises which are standard users and the power users. The standard users will be enriched by the IMDb style additions in the browser such as cast information, movie ratings and top charters. The power users are more professional kind of users which can obtain specific answers to complex queries.
The database will store the content information such as stars of the show, the actors and presenters who carry direction and production responsibilities. It will store the information in such a way that users will be able to see the main actors, liked titles and their related cast first. It will store the information on famous titles and known roles so that it could relate the new movie titles with the cast and productions of famous titles. The user’s rating will also play an essential role while displaying such content information. The platform will be able to provide to users the information about their favorite characters and roles by storing general category of such characters like (hero, villain, superhero) and genres like (Suspense, Action, Horror, Rom-Com). This way the content will be organized by timeworn and cross over categories which would appeal to hardcore fans.
2
NUTFLUX also aims to augment the domain content with the social content which would make certain aspects of it interesting and gossipy to users. It will add a social dimension and will fulfill the aim to attract new level of users. Real world romantic relationships and entanglements of the stars who make their favorite content. This platform sets its aim to build an application which would cater to the needs of all types of users.
According to the data and development requirements, some of the data is non-volatile and it will need very less maintenance or updates in terms of manipulation of same such as movie information or awards information but some of the details would be regularly changing like the connections between the people. Therefore, the database needs to be designed in a way such that all the necessary requirements will be adhered to.
I would be using MySQL database to support this application, which is efficient, capable, and cost-efficient to build this application. MySQL is an RDBMS based database, which supports schema, table-based data structure and provide facility to join multiple tables to derive the data from complex queries. Additionally, it also has primary and foreign key-based constraints to support data validation and entity relations.
Regarding the nature of the data which would be populated in the database, the most part would be in a textual form of up to 255 characters and some of the key data elements would be float and numeric in nature as well such as ratings, year information, season, and episode information for tv shows. Another type of data could be Boolean type to store information about the originality and content rating of the titles. The NUTFLUX aims to display information of multiple aspects thus the database schema would consist of multiple tables to store information of titles, users, cast, awards, known roles, famous personalities, ratings, directors, writers, production houses, relations, connections, genre, characters.
There will be addition of data when we add any new title, there will be deletion if contract ends with production owner and few updates regarding involved people and their current affairs. Although, the perfect database design will not do all the required work, some of it will be covered by the dynamic queries on landing page of each title which will get all basic information from database and
3
represent it intuitively. To cover some of the essential requirements I will be implementing procedural elements like triggers and procedures which would help in fixing the repeated tasks and to store the audit information.
There would be elements in NUTFLUX such as user profile where the user can see personal information such as liked and rated content. In addition to it, he will be able to prepare his watchlist to define his own personal content library. This will be derived from the user base tables in connection with the title tables. The NUTFLUX application would be able to display the personalized content library based on watched content, famous titles and ratings given. The queries would fetch all the relevant titles from database and put it as suggestions to the users based on the user activity.
By using the database tables like awards information and known roles, the library will be able to show the titles with the awards it has received and the famous roles and characters in relation with that title. Also, which other titles provide the similar type of content as the selected title.
It aims to implement a database design which can accommodate all necessary data and can be searched and presented with minimal effort and time. To achieve this, I will introduce multiple new tables, constraints, indexes, views, and procedural elements.
