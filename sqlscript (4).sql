REM   Script: UPDATED ASSESMENT
REM   UPDATED ASSESMENT

CREATE TABLE Author        
(  AuthorId     VARCHAR2 (30),         
   Name    VARCHAR2(30),  
   CONSTRAINT pk_Author PRIMARY KEY (AuthorId)  
);

INSERT INTO Author       
VALUES ('A011','Dingle R'      
);

INSERT INTO Author       
VALUES ('A012','Ransome A'      
);

INSERT INTO Author       
VALUES ('A013','Wardale R '      
);

INSERT INTO Author       
VALUES ('A014','Alexander T'      
);

INSERT INTO Author       
VALUES ('A015','Spurrier S'      
);

SELECT   *  FROM  Author;

CREATE TABLE Publisher        
(  PublisherId     VARCHAR2 (30),         
   PublisherName    VARCHAR2(30),  
   CONSTRAINT pk_Publisher PRIMARY KEY (PublisherId)      
  );

INSERT INTO Publisher       
VALUES ('P01','Pearson'      
);

INSERT INTO Publisher       
VALUES ('P02','HarperCollins'      
);

INSERT INTO Publisher       
VALUES ('P03','Simon and Schuster'      
);

SELECT   *  FROM  Publisher;

CREATE TABLE Category        
(  CategoryId     VARCHAR2 (30),         
   Type    VARCHAR2(30),  
   CONSTRAINT pk_Category PRIMARY KEY (CategoryId)      
  );

INSERT INTO Category       
VALUES ('C911','Short stories'      
);

INSERT INTO Category       
VALUES ('C912','Journal articles'      
);

INSERT INTO Category       
VALUES ('C913','Biography'      
);

INSERT INTO Category       
VALUES ('C914','Illustrations'      
);

SELECT   *  FROM  Publisher;

SELECT   *  FROM  Category;

CREATE TABLE Publication      
(  PubId  VARCHAR2 (30) NOT NULL,     
  AuthorId     VARCHAR2 (30) NOT NULL,         
   Title    VARCHAR2(30) NOT NULL,     
  CategoryId  VARCHAR2 (30) NOT NULL ,     
  PublishedYear     VARCHAR2 (30) NOT NULL,      
  PublisherId   VARCHAR2 (30) NOT NULL,  
  CONSTRAINT pk_Publication PRIMARY KEY (PubId),     
CONSTRAINT fk_Publication_Author FOREIGN KEY(AuthorId)     
REFERENCES Author(AuthorId),     
  CONSTRAINT fk_Publication_Category FOREIGN KEY(CategoryId)     
REFERENCES Category(CategoryId),     
  CONSTRAINT fk_Publication_Publisher FOREIGN KEY(PublisherId)     
REFERENCES Publisher(PublisherId)     
);

SELECT   *  FROM  Publication;

INSERT ALL     
   INTO Publication (PubId, AuthorId, Title,CategoryId,PublishedYear,PublisherId) VALUES ('P001', 'A011', 'The Blue Treacle','C911', '1911', 'P01')     
   INTO Publication (PubId, AuthorId, Title,CategoryId,PublishedYear,PublisherId) VALUES ('P002', 'A012', 'In Aleppo Once','C911', '2001', 'P01')     
   INTO Publication (PubId, AuthorId, Title,CategoryId,PublishedYear,PublisherId) VALUES ('P003', 'A012', 'Illustrating Arthur Ransome','C914', '1973', 'P03')     
   INTO Publication (PubId, AuthorId, Title,CategoryId,PublishedYear,PublisherId) VALUES ('P004', 'A012', 'Ransome the Artist','C914', '1994', 'P03')     
   INTO Publication (PubId, AuthorId, Title,CategoryId,PublishedYear,PublisherId) VALUES ('P005', 'A014', 'Bohemia In London','C914', '2008', 'P02')     
   INTO Publication (PubId, AuthorId, Title,CategoryId,PublishedYear,PublisherId) VALUES ('P006', 'A011', 'The Best of Childhood','C911', '2002', 'P01')     
   INTO Publication (PubId, AuthorId, Title,CategoryId,PublishedYear,PublisherId) VALUES ('P007', 'A015', 'Distilled Enthusiasms ','C912', '2010', 'P02')     
  SELECT 1 FROM DUAL;

 SELECT   *  FROM  Publication;

CREATE TABLE Users   
(   
  UserId VARCHAR2(30) NOT NULL,   
  Name VARCHAR2(30) NOT NULL,  
  Email VARCHAR2(30) NOT NULL,   
  Password VARCHAR2(30) NOT NULL,   
  CONSTRAINT pk_Users PRIMARY KEY (UserId)  
);

INSERT ALL    
INTO Users (UserId, Name, Email,Password) VALUES ('U111', 'Kenderine J','KenderineJ@hotmail.com','Kenj2')   
INTO Users (UserId, Name, Email,Password) VALUES ('U241', 'Wang F ',    'WangF@hotmail.com','Wanf05')   
INTO Users (UserId, Name, Email,Password) VALUES ('U55', 'Flavel K ','FlavelK@hotmail.com ','Flak77')   
INTO Users (UserId, Name, Email,Password) VALUES ('U016', 'Zidane Z','ZidaneZ@hotmail.com','Zidz13')   
INTO Users (UserId, Name, Email,Password) VALUES ('U121', 'Keita R','KeitaR@hotmail.com ','Keir22')   
SELECT 1 FROM DUAL;

 SELECT   *  FROM  Users;

CREATE TABLE Request (   
  UserId VARCHAR2(30) NOT NULL,   
  PublicationId VARCHAR2(30) NOT NULL,   
  RequestDate DATE NOT NULL,  
  
  CONSTRAINT fk_Request_User FOREIGN KEY(UserId) REFERENCES Users(UserId),     
  CONSTRAINT fk_Request_Publication FOREIGN KEY(PublicationId) REFERENCES Publication(PubId)  
);

INSERT ALL    
INTO Request (UserId, PublicationId, RequestDate) VALUES ('U016', 'P001', to_date('05-Oct-2020', 'dd-mm-yyyy'))   
INTO Request (UserId, PublicationId, RequestDate) VALUES ('U241', 'P001', to_date('28-Sep-2020', 'dd-mm-yyyy'))   
INTO Request (UserId, PublicationId, RequestDate) VALUES ('U55', 'P002', to_date('08-Sep-2020' , 'dd-mm-yyyy'))   
INTO Request (UserId, PublicationId, RequestDate) VALUES ('U016', 'P004', to_date('06-Oct-2020', 'dd-mm-yyyy'))   
INTO Request (UserId, PublicationId, RequestDate) VALUES ('U121', 'P002', to_date('23-Sep-2020', 'dd-mm-yyyy'))   
SELECT 1 FROM DUAL;

SELECT   *  FROM  Request;

SELECT DISTINCT Name, Email, RequestDate 
FROM Users,Request 
INNER JOIN Request  ON u.UserId = r.UserId 
ORDER BY Name, RequestDate;

select a.Name, a.Email, b.RequestDate from Users a join Request b on 
a.UserId = b.UserId;

SELECT b.PubId, b.Title, a.RequestDate FROM Request a JOIN Publication b on a.PublicationId = b.PubId  
WHERE  
EXTRACT(MONTH FROM a.RequestDate) = 09 AND EXTRACT(YEAR FROM a.RequestDate) = 2020;

SELECT c.Name, b.Title, d.Name as AuthorName FROM Request a  
LEFT JOIN Publication b ON a.PublicationId = b.PubId 
LEFT JOIN Users c ON a.UserId = c.UserId 
LEFT JOIN Author d ON d.AuthorId = b.AuthorId;

SELECT a.Type, COUNT(c.PublicationId) FROM Category a 
LEFT JOIN Publication b ON a.CategoryId = b.CategoryId 
LEFT JOIN Request c ON b.PubId = c.PublicationId 
GROUP BY a.Type;

SELECT b.Name, COUNT(a.UserId) as RequestCount FROM Request a 
LEFT JOIN Users b ON a.UserId = b.UserId 
GROUP BY b.Name 
HAVING COUNT(a.UserId) > 1;

