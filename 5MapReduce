$ sudo service mongod start   # Start MongoDB service
$ mongo                       # Enter MongoDB shell

> db.city.insertMany([        # Start inserting documents
... { cityname: "Mumbai", area: "500 sq km", population: 20000000 },
... { cityname: "Pune", area: "400 sq km", population: 8000000 },
... { cityname: "Nagpur", area: "300 sq km", population: 2400000 },
... { cityname: "Bangalore", area: "700 sq km", population: 12000000 },
... { cityname: "Indore", area: "150 sq km", population: 1500000 },
... { cityname: "Mysore", area: "200 sq km", population: 900000 }
... ])                        # Finish insertion

> db.city.mapReduce(          # Start writing mapReduce
...   function () { 
...     if (this.population < 1000000) { 
...       emit("Low Populated", 1); 
...     } else { 
...       emit("Highly Populated", 1); 
...     } 
...   },
...   function (key, values) { 
...     return Array.sum(values); 
...   },
...   { out: "city_population" }
... )                         # Execute mapReduce

> db.city_population.find()    # Verify the result of mapReduce

> db.city.getIndexes()         # List indexes of city collection

> db.city.createIndex({ cityname: 1 })  # Create simple index

> db.city.createIndex({ cityname: 1, population: -1 })  # Create compound index

> db.city.getIndexes()         # Verify the indexes after creation
