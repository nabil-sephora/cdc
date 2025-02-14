SELECT * FROM inventory.customers;

INSERT INTO `inventory`.`customers`
    (`id`, `first_name`, `last_name`, `email`)
VALUES
    (1005, 'Nabil', 'Khan', 'mnabeel@hotmail.com');

UPDATE `inventory`.`customers`
SET
    `first_name` = 'Nabil M'
WHERE 
    `id` = 1005;
