USE Municipios;

INSERT INTO Pais VALUES (1, 'argentina');
INSERT INTO Pais VALUES (2, 'uruguay');
INSERT INTO Pais VALUES (3, 'inglaterra');
INSERT INTO Pais VALUES (4, 'londres');
INSERT INTO Pais VALUES (5, 'cardiff');
INSERT INTO Pais VALUES (6, 'Reino Unido');

INSERT INTO Provincia VALUES (1, 'cordoba', 1, 0);
INSERT INTO Provincia VALUES (2, 'buenos aires', 1, 1);
INSERT INTO Provincia VALUES (3, 'la rioja', 1, 1);
INSERT INTO Provincia VALUES (4, 'santa fe', 1, 0);
INSERT INTO Provincia VALUES (5, 'entre rios', 1, 0);

INSERT INTO Provincia VALUES (6, 'flores', 2, 0);
INSERT INTO Provincia VALUES (7, 'montevideo', 2, 0);
INSERT INTO Provincia VALUES (8, 'maldonado', 2, 1);
INSERT INTO Provincia VALUES (9, 'salto', 2, 1);
INSERT INTO Provincia VALUES (10, 'paysandu', 2, 1);

DELETE FROM Pais
WHERE Nombre_pais = 'Reino Unido'

UPDATE Pais SET Nombre_pais = 'gales' WHERE ID_Pais = 5;