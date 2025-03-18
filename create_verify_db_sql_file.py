import os
import sqlite3
import sys

def init_database():
    db_file = "fire_norms.db"
    sql_file = "database.sql"
    
    # Verifică dacă baza de date există deja
    if os.path.exists(db_file):
        print(f"Baza de date {db_file} există deja.")
        return
    
    # Verifică dacă fișierul SQL există
    if not os.path.exists(sql_file):
        print(f"Eroare: Fișierul {sql_file} nu a fost găsit.")
        sys.exit(1)
    
    try:
        # Citește conținutul fișierului SQL
        with open(sql_file, 'r', encoding='utf-8') as f:
            sql_script = f.read()
        
        # Creează conexiunea la baza de date SQLite
        conn = sqlite3.connect(db_file)
        cursor = conn.cursor()
        
        # Execută scriptul SQL
        cursor.executescript(sql_script)
        
        # Salvează (commit) schimbările și închide conexiunea
        conn.commit()
        conn.close()
        
        print(f"Baza de date {db_file} a fost creată cu succes din {sql_file}.")
    
    except sqlite3.Error as e:
        # În caz de eroare, șterge fișierul bazei de date dacă a fost creat
        if os.path.exists(db_file):
            os.remove(db_file)
        print(f"Eroare SQLite: {e}")
        sys.exit(1)
    
    except Exception as e:
        # În caz de alte erori
        if os.path.exists(db_file):
            os.remove(db_file)
        print(f"Eroare: {e}")
        sys.exit(1)

if __name__ == "__main__":
    init_database()