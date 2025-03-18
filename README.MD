# Sistem de gestionare a normativelor de incendiu

Acest proiect oferă o soluție pentru gestionarea bazei de date cu normative de incendiu, inclusiv funcționalități pentru inițializarea bazei de date și gestionarea documentelor PDF asociate.

## Funcționalități

- Verificare și inițializare automată a bazei de date
- Mecanism de import a structurii bazei de date din fișier SQL
- Sistem de gestionare a documentelor PDF:
  - Încărcare și asociere cu normative de incendiu
  - Stocare organizată a fișierelor pe disc
  - Asociere între documente și înregistrări din baza de date
  - Acces și descărcare documente din interfața utilizator

## Structura proiectului

```
fire_norms_system/
├── init_db.py            # Script pentru inițializarea bazei de date
├── database.sql          # Structura bazei de date
├── fire_norms.db         # Baza de date SQLite (generată automat)
├── document_manager.py   # Modul pentru gestionarea documentelor PDF
├── uploads/              # Director pentru stocarea fișierelor încărcate
│   └── pdf/              # Subdirector pentru documente PDF
└── README.md             # Acest fișier
```


Baza de date include:

- Tabela `normative_incendiu` pentru stocarea informațiilor despre normative
- Tabela `documents` pentru gestionarea documentelor încărcate și asocierea lor cu normativele

Relația între documente și normative este implementată prin chei străine, permițând asocierea mai multor documente la un singur normativ.

