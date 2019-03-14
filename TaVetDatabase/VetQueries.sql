 /* 1. Display the Staff Member ID and Staff Member Name for all staff member at the clinic. */
 SELECT * FROM staff;
 
 /* 2. Display the total number of Pets that have been treated by the Veterinary clinic. */
 SELECT COUNT(DISTINCT petID) AS 'Total Number of Pets Treated' 
 FROM invoice, appointment 
 WHERE invoice.appID = appointment.appID;
 
 /* 3. Display only once all of the species of Pets that have been treated in alphabetical order. */
 SELECT DISTINCT petSpecies AS 'Species treated' 
 FROM invoice, appointment, pet 
 WHERE invoice.appID = appointment.appID AND appointment.petID = pet.petID 
 ORDER BY petSpecies;
 
 /* 4. Display each Client's unique ID and Name along with the name and age of each Pet that Client has brought in, sorted by Client and Pet Name */
 SELECT client.clientID, clientName, petName, YEAR(NOW()) - YEAR(petBirthday) AS 'Age' 
 FROM client, invoice, appointment, pet
 WHERE invoice.appID = appointment.appID AND appointment.petID = pet.petID AND pet.clientID = client.clientID 
 GROUP BY clientName, petName;
 
 /* 5. Display the total number of Invoices with the Column header "Invoice Total" */
 SELECT COUNT(*) AS 'Invoice Total'
 FROM invoice;
 
 /* 6. Display each Invoice ID, Date, and Balance along with the Client ID and Name for each
       invoice that is greater than the average balance of all invoices. */
 SELECT invoiceID, appDATE, client.clientID, clientName, sum(treatment.tPrice) AS 'Outstanding Balance'
 FROM client, invoice, appointment, administer, treatment, pet
 WHERE invoice.appID = appointment.appID AND administer.appID = appointment.appID AND treatment.treatmentID = administer.treatmentID AND appointment.petID = pet.petID AND pet.clientID = client.clientID
 GROUP BY invoiceID
 HAVING SUM(treatment.tPrice) > ((SELECT SUM(tprice) FROM treatment, invoice, appointment, administer WHERE invoice.appID = appointment.appID AND administer.appID = appointment.appID AND treatment.treatmentID = administer.treatmentID) / (SELECT COUNT(invoice.invoiceID) FROM invoice));
 
 /* 7. Display each Staff member sorted by name along with the number of treatments
	   they have administered in a column named "Total Treatments". */
 SELECT staffName, Count(*) AS 'Total Treatments'
 FROM staff, appointment, administer, treatment
 WHERE administer.appID = appointment.appID AND appointment.staffID = staff.staffID AND treatment.treatmentID = administer.treatmentID
 GROUP BY staffName
 ORDER BY staffName;