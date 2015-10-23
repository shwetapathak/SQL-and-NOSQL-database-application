namespace :my_namespace do
  desc "TODO"
  
  # SQL DATABASE QUERIES
  task my_task1: :environment do
     
     require 'open-uri'
     require 'json'
     require 'pp'
     request_uri = 'nps-boundary.json'
     request_query = ''
     url = "#{request_uri}#{request_query}"
     buffer = open(url).read
     result = JSON.parse(buffer)

     require 'sqlite3'
     begin
       
        db = SQLite3::Database.open "boundarydata.db"
        db.execute "CREATE TABLE IF NOT EXISTS BOUNDARY(Id INTEGER PRIMARY KEY AUTOINCREMENT, GIS_NOTES TEXT, UNIT_NAME TEXT, META_MIDF TEXT, GROUP_CODE TEXT, UNIT_CODE TEXT, LANDS_CODE TEXT, observed TEXT, DATE_EDIT TEXT, UNIT_TYPE TEXT, GIS_LOC_ID TEXT)"
        
        db.execute "DELETE FROM BOUNDARY"
        result.each do |user|
        db.execute "INSERT INTO BOUNDARY(GIS_NOTES, UNIT_NAME, META_MIDF, GROUP_CODE, UNIT_CODE, LANDS_CODE, observed, DATE_EDIT, UNIT_TYPE, GIS_LOC_ID) VALUES('#{user['GIS_NOTES']}','#{user['UNIT_NAME']}','#{user['META_MIDF']}','#{user['GROUP_CODE']}','#{user['UNIT_CODE']}','#{user['LANDS_CODE']}','#{user['observed']}','#{user['DATE_EDIT']}','#{user['UNIT_TYPE']}','#{user['GIS_LOC_ID']}')"
        end
        
        puts("Records inserted :")
        puts(result.length)
        
        puts("Retreiving a single record based on the primary key value of id = 5000 :")
        id = 5000
    
        stm = db.prepare "SELECT * FROM BOUNDARY WHERE Id=?"
        stm.bind_param 1, id
        rs = stm.execute
    
        row = rs.next
    
        puts row.join "\s"
        
        puts("Retreiving the records based on other attribute than primary key UNIT_CODE = 'NACE' : ")
    
        stm1 = db.prepare "SELECT * FROM BOUNDARY WHERE UNIT_CODE = 'NACE'"
        rs1 = stm1.execute
    
        while (row1 = rs1.next) do
            puts row1.join "\s"
        end

       
        rescue SQLite3::Exception => e 
        puts "Exception occurred"
        puts e
     
        ensure
          stm.close if stm
          stm1.close if stm1
          db.close if db
      end
    
  end

# NOSQL DATABASE QUERIES

  desc "TODO"
  task my_task2: :environment do
    
    require 'open-uri'
    require 'json'
    require 'pp'
    require 'mongo'
    include Mongo
    
    request_uri = 'nps-boundary.json'
    request_query = ''
    url = "#{request_uri}#{request_query}"
 
    buffer = open(url).read
    result = JSON.parse(buffer)

    mongo_client = MongoClient.new("localhost")
    db = mongo_client.db("test")
    coll = db.collection("BoundaryCollection")
    
    coll.find({}).each do |empty_doc|
      coll.remove(empty_doc)
    end
    
    id = coll.insert(result)
    
    
    puts("Records inserted :")
    puts(result.length)

    puts("Retreiving a single record based on the primary key value _id  :")
    
     
    coll.find(:_id => BSON::ObjectId('552340201d41c8080c000415')).each do |data| 
    puts data.inspect 
    end
    
    puts("Retreiving the records based on other attribute than primary key UNIT_CODE => NACE: ")
    myCursor = coll.find("UNIT_CODE" => "NACE")

    myCursor.each do |doc|
    puts("#{doc['_id']}\t#{doc['id']}\t#{doc['GIS_NOTES']}\t#{doc['UNIT_NAME']}\t#{doc['META_MIDF']}\t#{doc['GROUP_CODE']}\t#{doc['META_MIDF']}\t#{doc['UNIT_CODE']}\t#{doc['LANDS_CODE']}\t#{doc['observed']}\t#{doc['DATE_EDIT']}\t#{doc['UNIT_TYPE']}\t#{doc['GIS_LOC_ID']}")
  end

end
end