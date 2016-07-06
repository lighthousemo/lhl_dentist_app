# ActiveRecord Demo

## Naming Conventions
AR conventions require tables to be pluralized and lowercase. `articles`  or `blog_articles`.

AR classes are singular and camel cased. For a table called `articles` the class will be called `Article`. camel cased example: `BlogArticle` for a table called `blog_articles`.

## articles table

- title:   string
- content: text
- author:  string

## Validations

http://guides.rubyonrails.org/active_record_validations.html#validation-helpers

## Query Methods

http://guides.rubyonrails.org/active_record_querying.html

## Associations

http://guides.rubyonrails.org/association_basics.html

http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html


#### Validation Examples

The `persisted?` method: http://edgeapi.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-persisted-3F

The `valid?` method: http://edgeapi.rubyonrails.org/classes/ActiveRecord/Validations.html#method-i-valid-3F


```
>  mark = Mark.create()
#=> #<Author:0x000001052ab3a8 id: nil, name: nil, created_at: nil, updated_at: nil>
>  mark
#=> #<Author:0x000001052ab3a8 id: nil, name: nil, created_at: nil, updated_at: nil>
>  mark.persisted?
#=> false
>  mark.valid?
#=> false
>  mark.errors
#=> #<ActiveModel::Errors:0x000001028e2238
 @base=#<Author:0x000001052ab3a8 id: nil, name: nil, created_at: nil, updated_at: nil>,
 @messages={:name#=>["can't be blank"]}>
>  mark.errors.full_messages
#=> ["Name can't be blank"]
>  puts mark.errors.full_messages.first
Name can't be blank
#=> nil
```

#### Query Method Examples

```
>  Author.all
D, [2016-05-11T10:34:55.997859 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors"
#=> [#<Author:0x0000010303b318
  id: 1,
  name: "Mark Twain",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>,
 #<Author:0x00000103038050
  id: 2,
  name: "J. K. Rowling",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>,
 #<Author:0x00000103033d70
  id: 3,
  name: "Charles Dickens",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>,
 #<Author:0x00000103033be0
  id: 4,
  name: "Charles Chaplin",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>]
>  Author.where(name: "Charles Dickens")
D, [2016-05-11T10:35:39.695378 #91303] DEBUG -- :   Author Load (0.3ms)  SELECT "authors".* FROM "authors" WHERE "authors"."name" = $1  [["name", "Charles Dickens"]]
#=> [#<Author:0x00000105189830
  id: 3,
  name: "Charles Dickens",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>]
>  Author.where("name LIKE %Charles%")
D, [2016-05-11T10:36:59.539505 #91303] DEBUG -- :   Author Load (0.6ms)  SELECT "authors".* FROM "authors" WHERE (name LIKE %Charles%)
#=> #<Author::ActiveRecord_Relation:0x82875e38>
>  Author.where("name LIKE '%Charles%")
'D, [2016-05-11T10:37:16.111035 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE (name LIKE '%Charles%)
#=> #<Author::ActiveRecord_Relation:0x80beae6c>
>  Author.where("name LIKE '%Charles%'")
D, [2016-05-11T10:37:20.340840 #91303] DEBUG -- :   Author Load (8.0ms)  SELECT "authors".* FROM "authors" WHERE (name LIKE '%Charles%')
#=> [#<Author:0x00000105396448
  id: 3,
  name: "Charles Dickens",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>,
 #<Author:0x000001053962b8
  id: 4,
  name: "Charles Chaplin",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>]
>  Author.where("name='Charles Dickens'")
D, [2016-05-11T10:38:34.339621 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE (name='Charles Dickens')
#=> [#<Author:0x00000104a711b0
  id: 3,
  name: "Charles Dickens",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>]
>  Author.where("name='?'", "Charles Dickens")
D, [2016-05-11T10:39:13.247258 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE (name=''Charles Dickens'')
#=> #<Author::ActiveRecord_Relation:0x828e4dc4>
>  Author.where("name='?'", "Charles Dickens?")
D, [2016-05-11T10:39:26.191216 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE (name=''Charles Dickens?'')
#=> #<Author::ActiveRecord_Relation:0x824bd91c>
>  Author.where("name=?", "Charles Dickens")
D, [2016-05-11T10:39:48.494803 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE (name='Charles Dickens')
#=> [#<Author:0x0000010164d258
  id: 3,
  name: "Charles Dickens",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>]
>  Author.where("monkey=?", "Charles Dickens")
D, [2016-05-11T10:40:29.955902 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE (monkey='Charles Dickens')
#=> #<Author::ActiveRecord_Relation:0x811caea4>
>  Author.where("name LIKE '%?%'", "Charles")
D, [2016-05-11T10:41:38.982375 #91303] DEBUG -- :   Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE (name LIKE '%'Charles'%')
#=> #<Author::ActiveRecord_Relation:0x81302844>
>  Author.where("name LIKE ?", "%Charles%")
D, [2016-05-11T10:42:17.532452 #91303] DEBUG -- :   Author Load (0.4ms)  SELECT "authors".* FROM "authors" WHERE (name LIKE '%Charles%')
#=> [#<Author:0x00000102338c88
  id: 3,
  name: "Charles Dickens",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>,
 #<Author:0x00000102338ad0
  id: 4,
  name: "Charles Chaplin",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>]
>  Author.where("name LIKE '%?%'", Charles)
NameError: uninitialized constant Charles
from (pry):13:in `<main>'
>  name = "Charles"
#=> "Charles"
>  Author.where("name LIKE ?", "%#{name}%")
D, [2016-05-11T10:43:55.334728 #91303] DEBUG -- :   Author Load (0.4ms)  SELECT "authors".* FROM "authors" WHERE (name LIKE '%Charles%')
#=> [#<Author:0x00000102069070
  id: 3,
  name: "Charles Dickens",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>,
 #<Author:0x00000102068d50
  id: 4,
  name: "Charles Chaplin",
  created_at: 2016-05-11 17:34:24 UTC,
  updated_at: 2016-05-11 17:34:24 UTC>]
> 
```

