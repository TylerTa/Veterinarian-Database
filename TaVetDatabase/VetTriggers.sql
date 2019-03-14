

CREATE TRIGGER PriceInsertTotal
BEFORE INSERT ON treatment
FOR EACH ROW
BEGIN
	DECLARE priceTotal INT DEFAULT 0;
    SELECT COUNT(*) INTO priceTotal
    FROM treatment
    WHERE treatmentID = NEW.treatmentID;
    IF (priceTotal > 3000) THEN
		SET invoiceTotal = 1.00;
	END IF;
END;

/*******************
CREATE TRIGGER InvoiceInsertTotal
BEFORE INSERT ON invoice
FOR EACH ROW
BEGIN
	DECLARE invoiceTotal INT DEFAULT 0;
    SELECT COUNT(*) INTO invoiceTotal
    FROM invoice
    WHERE invoiceID = NEW.invoiceID;
    IF (invoiceTotal > 3000) THEN
		SET invoiceTotal = 1.00;
	END IF;
END;
*******************/