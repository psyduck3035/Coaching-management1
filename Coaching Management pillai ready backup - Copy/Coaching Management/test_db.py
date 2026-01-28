import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="saiel",
        database="mindseed",
        port=3306
    )
    print("✅ Database connected successfully")
except Exception as e:
    print("❌ Error:", e)
