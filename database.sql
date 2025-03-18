-- ----------------------------------------------------
-- Script de creare a bazei de date pentru ierarhia de clădiri
-- Baza de date va conține tabele pentru fiecare nivel ierarhic
-- și va permite navigarea prin dropdown-uri în cascadă
-- ----------------------------------------------------

-- ----------------------------------------------------
-- Crearea tabelului pentru nivelul 1 (categorii principale)
-- ----------------------------------------------------
CREATE TABLE nivel1 (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    denumire TEXT NOT NULL UNIQUE
);

-- ----------------------------------------------------
-- Crearea tabelului pentru nivelul 2 (subcategorii)
-- nivel1_id face referință la categoria părinte din nivel1
-- ----------------------------------------------------
CREATE TABLE nivel2 (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    denumire TEXT NOT NULL,
    nivel1_id INTEGER NOT NULL,
    FOREIGN KEY (nivel1_id) REFERENCES nivel1(id) ON DELETE CASCADE,
    UNIQUE(denumire, nivel1_id)
);

-- ----------------------------------------------------
-- Crearea tabelului pentru nivelul 3 (tipuri specifice)
-- nivel2_id face referință la subcategoria părinte din nivel2
-- ----------------------------------------------------
CREATE TABLE nivel3 (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    denumire TEXT NOT NULL,
    nivel2_id INTEGER NOT NULL,
    FOREIGN KEY (nivel2_id) REFERENCES nivel2(id) ON DELETE CASCADE,
    UNIQUE(denumire, nivel2_id)
);

-- ----------------------------------------------------
-- Crearea tabelului pentru normative
-- Acest tabel va stoca informațiile relevante pentru fiecare tip specific de clădire
-- nivel3_id face referință la tipul specific de clădire din nivel3
-- ----------------------------------------------------
CREATE TABLE normative (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nivel3_id INTEGER NOT NULL,
    titlu TEXT NOT NULL,
    descriere TEXT NOT NULL,
    data_adaugare TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_modificare TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nivel3_id) REFERENCES nivel3(id) ON DELETE CASCADE
);

-- ----------------------------------------------------
-- Popularea tabelului nivel1 cu categoriile principale
-- ----------------------------------------------------
INSERT INTO nivel1 (denumire) VALUES 
    ('Cladiri monofunctionale'),
    ('Cladiri Mixte');

-- ----------------------------------------------------
-- Popularea tabelului nivel2 cu subcategoriile
-- ----------------------------------------------------
-- Subcategorii pentru 'Cladiri monofunctionale'
INSERT INTO nivel2 (denumire, nivel1_id) VALUES 
    ('Civile', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale')),
    ('Productie', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale')),
    ('Depozitare', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'));

-- Subcategorii pentru 'Cladiri Mixte'
INSERT INTO nivel2 (denumire, nivel1_id) VALUES 
    ('Civile functiuni diferite', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri Mixte')),
    ('Civile si productie', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri Mixte')),
    ('Civile si depozitare', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri Mixte')),
    ('Productie si depozitare', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri Mixte')),
    ('Civile productie si depozitare', (SELECT id FROM nivel1 WHERE denumire = 'Cladiri Mixte'));

-- ----------------------------------------------------
-- Popularea tabelului nivel3 cu tipurile specifice de clădiri
-- ----------------------------------------------------
-- Tipuri specifice pentru 'Civile' din 'Cladiri monofunctionale'
INSERT INTO nivel3 (denumire, nivel2_id) VALUES 
    ('Cladiri inalte', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Cladiri foarte inalte', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Cladiri de locuit', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Administrative', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Comert', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Turism', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Invatamant', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Sanatate', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Cultura', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Cult', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Cladiri subterane', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Parcaje subterane', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Parcaje supraterane', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Cladiri sport', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Amenajari aer liber', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Campinguri', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale'))),
    ('Cladiri montane', (SELECT id FROM nivel2 WHERE denumire = 'Civile' AND nivel1_id = (SELECT id FROM nivel1 WHERE denumire = 'Cladiri monofunctionale')));

-- ----------------------------------------------------
-- Exemplu de inserare a unui normativ
-- ----------------------------------------------------
INSERT INTO normative (nivel3_id, titlu, descriere) VALUES 
    (
        (SELECT id FROM nivel3 WHERE denumire = 'Cladiri inalte'), 
        'Normativ P118', 
        'Normativ de siguranță la foc a construcțiilor. Acesta stabilește cerințele tehnice privind securitatea la incendiu pentru clădirile înalte.'
    );