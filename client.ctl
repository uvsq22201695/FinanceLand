LOAD DATA
CHARACTERSET UTF8
INFILE *
APPEND
INTO TABLE client
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_client, email, nom, prenom, adresse, telephone, ville, pays)
BEGINDATA
1, "john.doe@example.com", "Doe", "John", "123 Main Street", "555-0101", "Springfield", "USA"
2, "jane.smith@example.com", "Smith", "Jane", "456 Elm Street", "555-0202", "Shelbyville", "USA"
3, "emily.johnson@example.com", "Johnson", "Emily", "789 Oak Avenue", "555-0303", "Ogdenville", "Canada"
4, "michael.brown@example.com", "Brown", "Michael", "321 Pine Lane", "555-0404", "North Haverbrook", "USA"
5, "sarah.davis@example.com", "Davis", "Sarah", "654 Maple Boulevard", "555-0505", "Capital City", "UK"
6, "david.wilson@example.com", "Wilson", "David", "987 Cedar Road", "555-0606", "Springfield", "Australia"
7, "lisa.taylor@example.com", "Taylor", "Lisa", "135 Willow Circle", "555-0707", "Shelbyville", "New Zealand"
8, "paul.martin@example.com", "Martin", "Paul", "246 Aspen Court", "555-0808", "Ogdenville", "Ireland"
9, "laura.thomas@example.com", "Thomas", "Laura", "357 Birch Way", "555-0909", "North Haverbrook", "France"
10, "james.moore@example.com", "Moore", "James", "468 Cherry Street", "555-1010", "Capital City", "Germany"
11, "ana.robin@example.com", "Robin", "Ana", "10 Rue Jean Moulin", "0756123487", "Grenoble", "France"
12, "marc.garcia@example.com", "Garcia", "Marc", "11 Rue de Provence", "0623456790", "Dijon", "France"
13, "elise.benoit@example.com", "Benoit", "Elise", "12 Rue des Carmes", "0645236789", "Le Havre", "France"
14, "nathan.morel@example.com", "Morel", "Nathan", "13 Rue du Marché", "0634236789", "Toulon", "France"
15, "ines.bernard@example.com", "Bernard", "Ines", "14 Rue Saint-Honoré", "0612234789", "Saint-Étienne", "France"
16, "emilie.martinez@example.com", "Martinez", "Emilie", "15 Rue de la République", "0698123456", "Rennes", "France"
17, "mathieu.fabre@example.com", "Fabre", "Mathieu", "16 Rue de Metz", "0623456789", "Aix-en-Provence", "France"
18, "lea.clement@example.com", "Clément", "Lea", "17 Rue des Peupliers", "0678236789", "Montpellier", "France"
19, "juliette.david@example.com", "David", "Juliette", "18 Rue des Acacias", "0654123678", "Orléans", "France"
20, "maxime.renard@example.com", "Renard", "Maxime", "19 Avenue de l'Europe", "0687345678", "Clermont-Ferrand", "France"
21, "emilie.dupuis@example.com", "Dupuis", "Emilie", "20 Rue des Lilas", "0645123789", "Nancy", "France"
22, "vincent.robert@example.com", "Robert", "Vincent", "21 Rue des Tulipes", "0698123478", "Metz", "France"
23, "sophie.lopez@example.com", "Lopez", "Sophie", "22 Boulevard Gambetta", "0634234789", "Tours", "France"
24, "lucas.navarro@example.com", "Navarro", "Lucas", "23 Rue des Mimosas", "0687345789", "Angers", "France"
25, "melanie.dumont@example.com", "Dumont", "Melanie", "24 Avenue Jules Ferry", "0623456897", "Perpignan", "France"
26, "etienne.guillaume@example.com", "Guillaume", "Etienne", "25 Rue de Lorraine", "0654123489", "Limoges", "France"
27, "florence.roger@example.com", "Roger", "Florence", "26 Rue de l'Abbaye", "0678123467", "Béziers", "France"
28, "quentin.lefevre@example.com", "Lefevre", "Quentin", "27 Rue de la Liberté", "0689234789", "Pau", "France"
29, "helene.durieux@example.com", "Durieux", "Helene", "28 Rue des Vignes", "0612234689", "Avignon", "France"
30, "thibault.rousseau@example.com", "Rousseau", "Thibault", "29 Rue des Marronniers", "0698123467", "Valence", "France"