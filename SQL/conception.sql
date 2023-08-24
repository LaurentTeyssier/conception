create database conception_tp_db;

use conception_tp_db;

create table editeur (
id_editeur int primary key auto_increment not null,
nom_editeur varchar(50) not null
);

create table installer (
id_utilisateur int not null,
id_logiciel int not null,
num_licence varchar(50) not null,
date_assignation datetime
);

create table logiciel (
id_logiciel int primary key not null auto_increment,
nom_logiciel varchar(50) not null,
description_logiciel varchar(50) not null,
quantité_logiciel int,
id_editeur int not null
);

create table statut(
id_statut int primary key auto_increment not null,
nom_statut varchar(50) not null
);

create table utilisateur(
id_utilisateur int primary key not null auto_increment,
nom_utilisateur varchar(50) not null,
prenom_utilisateur varchar(50) not null,
age_utilisateur int not null,
mail_utilisateur varchar(50) not null,
password_utilisateur varchar(100) not null,
id_poste int not null
);

create table ticket(
id_ticket int primary key not null auto_increment,
nom_ticket varchar(50) not null,
description_ticket text not null,
date_ouverture_ticket datetime not null,
date_fermeture_ticket datetime not null,
id_logiciel int not null,
id_type_ticket int not null,
id_statut int not null,
id_materiel int not null,
id_utilisateur int not null
);

create table assigner(
id_utilisateur int not null,
id_materiel int not null,
reference_assigner varchar(50),
date_assignation_assigner datetime not null
);

create table type_ticket(
id_type_ticket int primary key not null auto_increment,
nom_type_ticket varchar(50) not null
);

create table intervention(
id_intervention int primary key not null auto_increment,
nom_intervention varchar(50) not null,
description_intervention varchar(50),
date_intervention datetime not null,
duree_intervention time,
verifie_intervention boolean,
id_utilisateur int not null,
id_ticket int not null
);

create table incorporer(
id_intervention int not null,
id_solution int not null
);

create table poste(
id_poste int primary key not null auto_increment,
nom_poste varchar(50) not null
);

create table materiel(
id_materiel int primary key not null auto_increment,
nom_materiel varchar(50) not null,
description_materiel varchar(50),
spare_materiel boolean,
quantite_materiel int,
id_fabricant int not null,
id_type_materiel int not null
);

create table type_solution(
id_type_solution int primary key not null auto_increment,
nom_type_solution varchar(50) not null
);

create table solution(
id_solution int primary key not null auto_increment,
nom_solution varchar(50) not null,
description_solution text,
date_creation_solution datetime not null,
date_modification_solution datetime,
id_type_solution int not null,
id_materiel int not null,
id_logiciel int not null,
id_utilisateur int not null
);

create table fabricant(
id_fabricant int primary key not null auto_increment,
nom_fabricant varchar(50) not null
);

create table type_materiel(
id_type_materiel int primary key not null auto_increment,
nom_type_materiel varchar(50) not null
);

alter table installer
add constraint fk_installer_utilisateur foreign key(id_utilisateur) references utilisateur(id_utilisateur),
add constraint fk_installer_logiciel foreign key (id_logiciel) references logiciel(id_logiciel);

alter table installer
add primary key (id_utilisateur, id_logiciel);

alter table logiciel 
add constraint fk_logiciel_editeur foreign key(id_editeur) references editeur(id_editeur);

alter table utilisateur
add constraint fk_utilisateur_poste foreign key (id_poste) references poste(id_poste);

alter table ticket
add constraint fk_ticket_logiciel foreign key(id_logiciel) references logiciel (id_logiciel),
add constraint fk_ticket_type_ticket foreign key(id_type_ticket) references type_ticket (id_type_ticket),
add constraint fk_ticket_statut foreign key(id_statut) references statut (id_statut),
add constraint fk_ticket_materiel foreign key(id_materiel) references materiel (id_materiel),
add constraint fk_ticket_utilisateur foreign key(id_utilisateur) references utilisateur (id_utilisateur);

alter table assigner
add constraint fk_assigner_materiel foreign key(id_materiel) references materiel (id_materiel),
add constraint fk_assigner_utilisateur foreign key(id_utilisateur) references utilisateur (id_utilisateur);

alter table intervention
add constraint fk_intervention_utilisateur foreign key(id_utilisateur) references utilisateur (id_utilisateur),
add constraint fk_intervention_ticket foreign key(id_ticket) references ticket (id_ticket);

alter table incorporer
add constraint fk_incorporer_solution foreign key(id_solution) references solution (id_solution),
add constraint fk_incorporer_intervention foreign key(id_intervention) references intervention (id_intervention);

alter table materiel
add constraint fk_materiel_fabricant foreign key(id_fabricant) references fabricant (id_fabricant),
add constraint fk_materiel_type_materiel foreign key(id_type_materiel) references type_materiel (id_type_materiel);

alter table solution
add constraint fk_solution_logiciel foreign key(id_logiciel) references logiciel (id_logiciel),
add constraint fk_solution_type_solution foreign key(id_type_solution) references type_solution (id_type_solution),
add constraint fk_solution_materiel foreign key(id_materiel) references materiel (id_materiel),
add constraint fk_solution_utilisateur foreign key(id_utilisateur) references utilisateur (id_utilisateur);

alter table ticket
modify column date_fermeture_ticket datetime;

select nom_utilisateur, prenom_utilisateur, nom_poste
from utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste;

select nom_utilisateur, prenom_utilisateur, nom_poste
from utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste
where nom_poste = "technicien";

select nom_materiel, description_materiel, quantite_materiel, nom_fabricant, nom_type_materiel
from materiel
inner join fabricant
on materiel.id_fabricant = fabricant.id_fabricant
inner join type_materiel
on materiel.id_type_materiel = type_materiel.id_type_materiel;

select nom_logiciel, description_logiciel, nom_editeur
from logiciel
inner join editeur 
on logiciel.id_editeur = editeur.id_editeur;

select nom_ticket, description_ticket, date_ouverture_ticket, nom_statut, nom_utilisateur, prenom_utilisateur, nom_type_ticket
from ticket
inner join statut
on ticket.id_statut = statut.id_statut
inner join utilisateur
on ticket.id_utilisateur = utilisateur.id_utilisateur
inner join type_ticket
on ticket.id_type_ticket = type_ticket.id_type_ticket;

select nom_intervention, description_intervention, date_intervention, duree_intervention, nom_utilisateur, prenom_utilisateur, nom_poste
from intervention
inner join utilisateur
on intervention.id_utilisateur = utilisateur.id_utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste
where nom_poste = "technicien";

select nom_intervention, description_intervention, date_intervention, duree_intervention, nom_utilisateur, prenom_utilisateur
from intervention
inner join utilisateur
on intervention.id_utilisateur = utilisateur.id_utilisateur
where date_intervention = "2024-12-06";

select distinct nom_utilisateur, prenom_utilisateur, count(intervention.id_utilisateur) over (partition by intervention.id_utilisateur) as nombre_demandes
from utilisateur
inner join intervention
on utilisateur.id_utilisateur = intervention.id_utilisateur
order by nom_utilisateur asc, prenom_utilisateur asc;

select nom_utilisateur, prenom_utilisateur, count(intervention.id_utilisateur) over (partition by nom_utilisateur ) as nombre_demandes, nom_poste
from utilisateur
inner join intervention
on utilisateur.id_utilisateur = intervention.id_utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste
order by nombre_demandes desc limit 1;

select nom_ticket, description_ticket, date_ouverture_ticket, count(intervention.id_ticket) over (partition by id_intervention) as nombre_ticket
from ticket
inner join intervention 
on ticket.id_ticket = intervention.id_ticket;

insert into poste(nom_poste)
values("employe"), ("admin"), ("technicien"), ("responsable");

insert into utilisateur(nom_utilisateur, prenom_utilisateur, age_utilisateur, mail_utilisateur, password_utilisateur, id_poste)
values ("jean", "jo", 12, "abc","1234azerty", 2), ("kevin", "serda" , 31,"ae", "azeazrzar", 3), ("laurent", "teyssier", 30,"1234azerty", "etzerarazr", 1), ("leyla", "pasaj", 36,"1234azerty", "pezrozerzer", 4);

insert into fabricant (nom_fabricant)
values("acer"), ("nvidia"), ("gigabyte");

insert into type_materiel(nom_type_materiel)
values("ecran"), ("pc portable"), ("desktop"), ("clavier"), ("souris");

insert into materiel (nom_materiel, description_materiel, spare_materiel, quantite_materiel, id_fabricant, id_type_materiel)
values ("aa", "aae", false, 8, 1, 1), ("ee", "eea", true, 41, 2, 2);

insert into editeur(nom_editeur)
values("microsoft"),("oracle");

insert into logiciel(nom_logiciel, description_logiciel, quantité_logiciel, id_editeur)
values("photoshop", "photo", 12, 1), ("word", "texte", 5, 1), ("apache", "bdd", 4, 2);

insert into statut(nom_statut)
values ("en cours"), ("traité"), ("à point"), ("saignant");

insert into type_ticket(nom_type_ticket)
values ("pikachu"), ("feu"), ("metro"), ("eau");

insert into ticket(nom_ticket, description_ticket, date_ouverture_ticket, id_type_ticket, id_statut, id_materiel, id_utilisateur, id_logiciel)
values ("aeae", "aeaeae", "2023-05-05", 1, 1, 1, 1,1), ("aae", "aeaeae", "2023-05-25", 2, 2, 1, 1,1);

insert into intervention (nom_intervention, description_intervention, date_intervention, duree_intervention, verifie_intervention,id_utilisateur, id_ticket)
values("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 1 , 1),
("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 1 , 1),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 1 , 1),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 2 , 2),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 2 , 2),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 3 , 2);
