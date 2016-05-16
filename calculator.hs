{-# LANGUAGE OverloadedStrings 		#-}
{-# LANGUAGE QuasiQuotes      		#-}
{-# LANGUAGE TemplateHaskell  		#-}
{-# LANGUAGE TypeFamilies      		#-}
{-# LANGUAGE ViewPatterns      		#-}
{-# LANGUAGE GADTs			  	    #-}
{-# LANGUAGE FlexibleContexts  		#-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import           Yesod
import Data.Text (Text)
import Database.Persist
import Database.Persist.Sqlite (runSqlite, runMigration)
import Database.Persist.TH (mkPersist, mkMigrate, persistLowerCase,
       share, sqlSettings)
import Database.Persist.Sql (rawQuery, {-hi-}insert{-/hi-})

data App = App
instance Yesod App

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Users
   username    String
   password    String
   deriving Show
|]


mkYesod "App" [parseRoutes|
/add/#Integer/#Integer AddR GET
/subtract/#Integer/#Integer SubtractR GET
/multiply/#Integer/#Integer MultiplyR GET
/devide/#Integer/#Integer DevideR GET
/createuser/#String/#String CreateuserR PUT
|]



getAddR :: Integer ->Integer -> Handler Html
getAddR a b = defaultLayout [whamlet|<h1>#{a} plus #{b} = #{a + b}|]

getSubtractR :: Integer ->Integer -> Handler Html
getSubtractR a b = defaultLayout [whamlet|<h1>#{a} minus #{b} = #{a - b}|]

getMultiplyR :: Integer ->Integer -> Handler Html
getMultiplyR a b = defaultLayout [whamlet|<h1>#{a} multiplied by #{b} = #{a * b}|]

getDevideR :: Integer -> Integer -> Handler Html
getDevideR a b  = 	defaultLayout [whamlet|<h1>#{a} devided by #{b} = #{devideInts a b}|]

devideInts :: Integer -> Integer -> Float
devideInts a b = (fromIntegral a) / (fromIntegral b)

putCreateuserR ::  String -> String  -> Handler Html -- -> Entity Users
putCreateuserR user pass =  defaultLayout [whamlet|<h1> Account created with username - #{user} and password -  #{pass}|] >>
							insert $ Users (user) (pass){-/hi-} 
							  

--insertUser :: String -> String
--insertUser user pass = insert $ Users (user) (pass){-/hi-}
							

main :: IO ()
main = runSqlite ":memory:" (runMigration migrateAll) >>
		warp 3000 App
		