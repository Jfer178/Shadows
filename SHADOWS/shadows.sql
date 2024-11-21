-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-11-2024 a las 19:51:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `shadows`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `password` varchar(255) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`password`, `id_cliente`, `Direccion`, `correo`, `nombre`) VALUES
('jf123', 1024, 'fvdfvdfv', 'j@gmail.com', 'jerem'),
('j1234', 13265987, 'Call101', 'jeremy@gmail.com', 'Jeremy'),
('jeremyfontalvo12', 1042248087, 'Calle101#1sur63', 'fvdsfv@gmail.com', 'Jeremy Fontalvo'),
('scascascasc', 1326598445, 'dcasdcsdc', 'marilis@gamil.com', 'dasdcasd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conctame`
--

CREATE TABLE `conctame` (
  `id_contactame` int(11) NOT NULL,
  `id_cliente_fk` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `telefono` int(11) NOT NULL,
  `mensaje` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_trans`
--

CREATE TABLE `detalle_trans` (
  `cantidad` int(11) NOT NULL,
  `id_transaccion_fk` int(11) NOT NULL,
  `bruto` int(11) NOT NULL,
  `id_detalles_trans` int(11) NOT NULL,
  `neto` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `precio` int(11) NOT NULL,
  `imp` double NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opinion`
--

CREATE TABLE `opinion` (
  `id_transaccion` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `descrip` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `calificacion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `nombre` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `img` blob NOT NULL,
  `id_producto` int(11) NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion`
--

CREATE TABLE `transaccion` (
  `Monto` int(11) NOT NULL,
  `direccion_envio` varchar(255) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `transaccion`
--

INSERT INTO `transaccion` (`Monto`, `direccion_envio`, `id_cliente`, `fecha`, `id`) VALUES
(3000, 'fvdfvdfv', 1024, '2024-11-21 17:23:28', 5),
(7000, 'fvdfvdfv', 1024, '2024-11-21 17:45:13', 6);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `conctame`
--
ALTER TABLE `conctame`
  ADD PRIMARY KEY (`id_contactame`),
  ADD KEY `id_cliente_fk` (`id_cliente_fk`);

--
-- Indices de la tabla `detalle_trans`
--
ALTER TABLE `detalle_trans`
  ADD PRIMARY KEY (`id_detalles_trans`),
  ADD KEY `detalle_trans_id_producto_index` (`id_producto`),
  ADD KEY `id_transaccion_fk` (`id_transaccion_fk`);

--
-- Indices de la tabla `opinion`
--
ALTER TABLE `opinion`
  ADD PRIMARY KEY (`id_transaccion`),
  ADD KEY `opinion_id_product_index` (`id_product`),
  ADD KEY `opinion_id_cliente_index` (`id_cliente`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `transaccion`
--
ALTER TABLE `transaccion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `conctame`
--
ALTER TABLE `conctame`
  MODIFY `id_contactame` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_trans`
--
ALTER TABLE `detalle_trans`
  MODIFY `id_detalles_trans` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `transaccion`
--
ALTER TABLE `transaccion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `conctame`
--
ALTER TABLE `conctame`
  ADD CONSTRAINT `conctame_ibfk_1` FOREIGN KEY (`id_cliente_fk`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_trans`
--
ALTER TABLE `detalle_trans`
  ADD CONSTRAINT `detalle_trans_ibfk_1` FOREIGN KEY (`id_transaccion_fk`) REFERENCES `transaccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_trans_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `opinion`
--
ALTER TABLE `opinion`
  ADD CONSTRAINT `opinion_id_cliente_foreign` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `opinion_id_product_foreign` FOREIGN KEY (`id_product`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `transaccion`
--
ALTER TABLE `transaccion`
  ADD CONSTRAINT `transaccion_id_cliente_foreign` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
