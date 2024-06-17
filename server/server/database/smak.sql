
CREATE DATABASE `smak` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP VIEW IF EXISTS `smak`.`products-data`;
DROP TABLE IF EXISTS `smak`.`products`;
DROP TABLE IF EXISTS `smak`.`brands`;
DROP TABLE IF EXISTS `smak`.`sub_catalogs`;
DROP TABLE IF EXISTS `smak`.`catalogs`;
DROP TABLE IF EXISTS `smak`.`companies`;

DROP TABLE IF EXISTS `smak`.`companies`;
CREATE TABLE `smak`.`companies`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(155) NOT NULL,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `smak`.`companies`(`id`, `name`) VALUES
(DEFAULT, "Смак");



DROP TABLE IF EXISTS `smak`.`catalogs`;
CREATE TABLE `smak`.`catalogs`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(155) NOT NULL,
  `image` VARCHAR(255) NULL,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `smak`.`catalogs`(`id`, `name`,`image`) VALUES
(DEFAULT, "Молочные изделия", "/img/catalogs/milk.jpg");

DROP TABLE IF EXISTS `smak`.`sub_catalogs`;
CREATE TABLE `smak`.`sub_catalogs`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `catalog_id` INTEGER UNSIGNED NOT NULL,
  `name` VARCHAR(155) NOT NULL,
  `image` VARCHAR(255) NULL,
  FOREIGN KEY(`catalog_id`) REFERENCES `smak`.`catalogs`(`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `smak`.`sub_catalogs`(`id`, `catalog_id`, `name`,`image`) VALUES
(DEFAULT, 1,"Сыр",  "/img/catalogs/milk.jpg");


DROP TABLE IF EXISTS `smak`.`brands`;
CREATE TABLE `smak`.`brands`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `provider_id` INTEGER UNSIGNED NOT NULL,
  `name` VARCHAR(155) NOT NULL,
  `image` VARCHAR(255) NULL,
  FOREIGN KEY(`provider_id`) REFERENCES `smak`.`companies`(`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `smak`.`brands`(`id`,`provider_id`, `name`, `image`) VALUES
(DEFAULT, 1, "Молком Павлодар", "/img/brands/molkom.jpg");


DROP TABLE IF EXISTS `smak`.`products`;
CREATE TABLE `smak`.`products`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `catalog_id` INTEGER UNSIGNED NOT NULL, -- Категория
  `sub_catalog_id` INTEGER UNSIGNED NOT NULL, -- Подкатегория
  `brand_id`INTEGER UNSIGNED NOT NULL, -- Бренд 
  `name` VARCHAR(155) NOT NULL, -- Название
  `price` FLOAT NULL, -- Стоимость
  `description` TEXT NULL, -- Описание
  `compound` TEXT NULL, -- Состав
  `image_path` VARCHAR(255) NULL, -- Изображение
  `exp_date` INTEGER NOT NULL, -- Срок годности
  `exp_type` ENUM("Дней", "Месяцев", "Лет") NOT NULL, -- Тип данных
  `country` VARCHAR(100) NOT NULL, -- Страна
  `unit` VARCHAR(30) NOT NULL, -- грамм литры и тд
  `capacity` FLOAT NULL, -- Обьем
  `sale` INTEGER NULL, -- Скидка
  `promo` VARCHAR(255) NULL,
  `total_price` FLOAT NOT NULL,
  FOREIGN KEY(`catalog_id`) REFERENCES `smak`.`catalogs`(`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY(`sub_catalog_id`) REFERENCES `smak`.`sub_catalogs`(`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY(`brand_id`) REFERENCES `smak`.`brands`(`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `smak`.`products`(
  `id`,
  `catalog_id`,
  `sub_catalog_id`,
  `brand_id`,
  `name`,
  `description`,
  `price`,
  `compound`,
  `image_path`,
  `exp_date`,
  `exp_type`,
  `country`,
  `unit`,
  `capacity`,
  `sale`,
  `promo`,
  `total_price`
) VALUES 
(
  DEFAULT,
  1,
  1,
  1,
  "Ряженка 2.5%",
  "Это натуральный кисломолочный продукт, который обладает богатым вкусом и нежной текстурой. Она изготавливается из натурального коровьего молока с использованием традиционных технологий, которые сохраняют все полезные свойства молока. Ряженка обладает освежающим кисломолочным вкусом с легкой сладостью и приятным послевкусием.",
  2500,
  "2.5% - жиры; 2.9 - белки; 4.2 - углеводы",
  "/img/products/milk/ryazhenka.png",
  7,
  "Дней", 
  "Россия",
  "грамм",
  1,
  0, -- Значение для sale
  NULL, -- Значение для promo
  2500 -- Значение для total_price
),
(
  DEFAULT,
  1,
  1,
  1,
  "Сыр плавленный",
  "Это продукт, который обычно состоит из натурального сыра, добавленного воды, эмульгаторов, соли и иногда других добавок, таких как молоко или молочные продукты. Он имеет гладкую текстуру и способность плавиться при нагревании, что делает его идеальным для использования в блюдах, таких как гриль-сыр, сэндвичи, соусы или пицца.",
  650,
  "100 грамм, вода - 50 грамм, эмульгаторы - 2 грамма, соль - 1 грамм, молоко - 20 грамм, ароматизаторы - 1 грамм",
  "/img/products/milk/syr.jpg",
  15,
  "Дней",
  "Россия",
  "грамм",
  1,
  0, -- Значение для sale
  NULL, -- Значение для promo
  650 -- Значение для total_price
);



DROP VIEW IF EXISTS `smak`.`products-data`;
CREATE VIEW `smak`.`products-data` AS 
  SELECT 
    `products`.`id` AS `id`,
    `products`.`catalog_id` AS `catalog_id`,
    `catalogs`.`name` AS `catalog_name`,
    `products`.`sub_catalog_id` AS `sub_catalog_id`, -- Добавлено для учета подкатегории
    `sub_catalogs`.`name` AS `sub_catalog_name`, -- Добавлено для учета подкатегории
    `products`.`brand_id` AS `brand_id`,
    `brands`.`name` AS `brand_name`,
    `products`.`name` AS `product_name`,
    `products`.`description`,
    `products`.`price`,
    `products`.`compound`,
    `products`.`image_path` AS `image`, -- Поле переименовано для соответствия таблице `products`
    `products`.`exp_date`, 
    `products`.`exp_type`, 
    `products`.`country`, 
    `products`.`unit`, 
    `products`.`capacity`, 
    `products`.`sale`, 
    `products`.`promo`, 
    `products`.`total_price` 
  FROM 
    `smak`.`products`
    INNER JOIN `smak`.`catalogs` ON `products`.`catalog_id` = `catalogs`.`id`
    INNER JOIN `smak`.`sub_catalogs` ON `products`.`sub_catalog_id` = `sub_catalogs`.`id` -- Добавлено для учета подкатегории
    INNER JOIN `smak`.`brands` ON `products`.`brand_id` = `brands`.`id`
  ORDER BY `products`.`id`; 
