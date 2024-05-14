CREATE DATABASE `smak` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE `smak`.`catalogs`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(155) NOT NULL,
  `image` VARCHAR(255) NULL,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `smak`.`catalogs`(`id`, `name`,`image`) VALUES
(DEFAULT, "Молочные изделия", "/img/catalogs/milk.jpg");

CREATE TABLE `smak`.`brands`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(155) NOT NULL,
  `image` VARCHAR(255) NULL,
  PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `smak`.`brands`(`id`, `name`, `image`) VALUES
(DEFAULT, "Молком Павлодар", "/img/brands/molkom.jpg");

CREATE TABLE `smak`.`products`(
  `id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
  `catalog_id` INTEGER UNSIGNED NOT NULL, -- Категория
  `brand_id`INTEGER UNSIGNED NOT NULL, -- Бренд 
  `name` VARCHAR(155) NOT NULL, -- Название
  `description` TEXT NULL, -- Описание
  `type` ENUM("Жидкость", "Еда") NOT NULL, -- Тип продукта (нужен для указания литров или граммов)
  `compound` TEXT NULL, -- Состав
  `price` FLOAT NULL, -- Стоимость
  `weight` FLOAT NULL, -- Вес
  `count` INTEGER NULL, -- Кол-во
  `image` VARCHAR(255) NULL, -- Изображение
  FOREIGN KEY(`catalog_id`) REFERENCES `smak`.`catalogs`(`id`)
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
  `brand_id`,
  `name`,
  `description`,
  `type`, 
  `compound`,
  `price`,
  `weight`,
  `count`,
  `image`) 
VALUES 
  (DEFAULT,
  1,
  1,
  "Ряженка 2.5%",
  "Это натуральный кисломолочный продукт, который обладает богатым вкусом и нежной текстурой. Она изготавливается из натурального коровьего молока с использованием традиционных технологий, которые сохраняют все полезные свойства молока. Ряженка обладает освежающим кисломолочным вкусом с легкой сладостью и приятным послевкусием.",
  "Жидкость",
  "2.5% - жиры; 2.9 - белки; 4.2 - углеводы",
  2500,
  1,
  50,
  "/img/products/milk/ryazhenka.png"
  ),
  (DEFAULT,
  1,
  1,
  "Сыр плавленный",
  "это продукт, который обычно состоит из натурального сыра, добавленного воды, эмульгаторов, соли и иногда других добавок, таких как молоко или молочные продукты. Он имеет гладкую текстуру и способность плавиться при нагревании, что делает его идеальным для использования в блюдах, таких как гриль-сыр, сэндвичи, соусы или пицца.",
  "Еда",
  "100 грамм, вода - 50 грамм, эмульгаторы - 2 грамма, соль - 1 грамм, молоко - 20 грамм, ароматизаторы - 1 грамм",
  650,
  100,
  250,
  "/img/products/milk/syr.jpg"
  );

DROP VIEW IF EXISTS `smak`.`products-data`;
CREATE VIEW `smak`.`products-data` AS 
  SELECT 
    `products`.`id` AS `id`,
    `catalogs`.`id` AS `catalog_id`,
    `catalogs`.`name` AS `catalog_name`,
    `brands`.`id` AS `brand_id`,
    `brands`.`name` AS `brand_name`,
    `products`.`name` AS `product_name`,
    `products`.`description`,
    `products`.`type`,
    `products`.`compound`,
    `products`.`price`,
    `products`.`weight`,
    `products`.`count`,
    `products`.`image`
  FROM 
    `smak`.`products`,
    `smak`.`catalogs`,
    `smak`.`brands`
  WHERE 
    `products`.`catalog_id` = `catalogs`.`id`
  AND
    `products`.`brand_id` = `brands`.`id`
  ORDER BY `products`.`id`; 