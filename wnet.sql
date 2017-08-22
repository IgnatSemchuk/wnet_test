-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Июл 31 2017 г., 18:04
-- Версия сервера: 10.1.16-MariaDB
-- Версия PHP: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `wnet`
--

-- --------------------------------------------------------

--
-- Структура таблицы `obj_contracts`
--

CREATE TABLE `obj_contracts` (
  `id_contract` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `number` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `date_sign` date NOT NULL,
  `staff_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `obj_contracts`
--

INSERT INTO `obj_contracts` (`id_contract`, `id_customer`, `number`, `date_sign`, `staff_number`) VALUES
(1, 1, '4444', '2017-07-27', '10000'),
(2, 2, '1243', '2017-07-26', '1000'),
(3, 3, '4752', '2017-07-21', '3000'),
(4, 4, '5642', '2017-07-27', '200'),
(5, 5, '2356', '2017-07-29', '20000'),
(6, 2, '9775', '2017-07-25', '4000'),
(7, 3, '6575', '2017-07-30', '40000'),
(8, 5, '8675', '2017-07-26', '5000');

-- --------------------------------------------------------

--
-- Структура таблицы `obj_customers`
--

CREATE TABLE `obj_customers` (
  `id_customer` int(11) NOT NULL,
  `name_customer` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `company` enum('company_1','company_2','company_3') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `obj_customers`
--

INSERT INTO `obj_customers` (`id_customer`, `name_customer`, `company`) VALUES
(1, 'Иван', 'company_1'),
(2, 'Александр', 'company_2'),
(3, 'Юра', 'company_3'),
(4, 'Александр', 'company_1'),
(5, 'Петр', 'company_2');

-- --------------------------------------------------------

--
-- Структура таблицы `obj_services`
--

CREATE TABLE `obj_services` (
  `id_service` int(11) NOT NULL,
  `id_contract` int(11) NOT NULL,
  `title_service` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('work','connecting','disconnected') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `obj_services`
--

INSERT INTO `obj_services` (`id_service`, `id_contract`, `title_service`, `status`) VALUES
(9, 5, 'service_1', 'work'),
(10, 2, 'service_2', 'connecting'),
(11, 3, 'service_3', 'disconnected'),
(12, 3, 'service_1', 'work'),
(13, 6, 'service_2', 'connecting'),
(14, 7, 'service_3', 'disconnected'),
(15, 7, 'service_4', 'connecting'),
(16, 3, 'service_5', 'work'),
(17, 2, 'service_6', 'disconnected'),
(18, 5, 'service_4', 'work'),
(19, 4, 'service_5', 'connecting');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `obj_contracts`
--
ALTER TABLE `obj_contracts`
  ADD PRIMARY KEY (`id_contract`),
  ADD UNIQUE KEY `number` (`number`),
  ADD KEY `id_customer` (`id_customer`);

--
-- Индексы таблицы `obj_customers`
--
ALTER TABLE `obj_customers`
  ADD PRIMARY KEY (`id_customer`);

--
-- Индексы таблицы `obj_services`
--
ALTER TABLE `obj_services`
  ADD PRIMARY KEY (`id_service`),
  ADD KEY `id_contract` (`id_contract`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `obj_contracts`
--
ALTER TABLE `obj_contracts`
  MODIFY `id_contract` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `obj_customers`
--
ALTER TABLE `obj_customers`
  MODIFY `id_customer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `obj_services`
--
ALTER TABLE `obj_services`
  MODIFY `id_service` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `obj_contracts`
--
ALTER TABLE `obj_contracts`
  ADD CONSTRAINT `obj_contracts_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `obj_customers` (`id_customer`);

--
-- Ограничения внешнего ключа таблицы `obj_services`
--
ALTER TABLE `obj_services`
  ADD CONSTRAINT `obj_services_ibfk_1` FOREIGN KEY (`id_contract`) REFERENCES `obj_contracts` (`id_contract`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
