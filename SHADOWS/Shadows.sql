-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-11-2024 a las 01:23:08
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

--
-- Volcado de datos para la tabla `conctame`
--

INSERT INTO `conctame` (`id_contactame`, `id_cliente_fk`, `nombre`, `correo`, `telefono`, `mensaje`) VALUES
(1, 13265987, 'jeremy', 'bdfbdfb@gmail', 22215211, 'fdgbdsfbdfbdfbsgbsfg'),
(2, 1024, 'jerem', 'j@gmail.com', 30123659, 'vxfbvdfbdfb'),
(3, 1024, 'jerem', 'j@gmail.com', 30123659, 'gbfgndfhndfgndfgn');

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
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_trans`
--

INSERT INTO `detalle_trans` (`cantidad`, `id_transaccion_fk`, `bruto`, `id_detalles_trans`, `neto`, `id_producto`, `precio`, `imp`, `nombre`) VALUES
(1, 13, 1000, 14, 900, 0, 1000, 100, 'Abrigo 02'),
(1, 13, 1000, 15, 900, 0, 1000, 100, 'Abrigo 03'),
(1, 13, 1000, 16, 900, 0, 1000, 100, 'Abrigo 04'),
(1, 14, 1000, 17, 900, 0, 1000, 100, 'Abrigo 01'),
(1, 14, 1000, 18, 900, 0, 1000, 100, 'Abrigo 03'),
(1, 15, 1000, 19, 900, 0, 1000, 100, 'Abrigo 01'),
(1, 15, 1000, 20, 900, 0, 1000, 100, 'Abrigo 02'),
(1, 15, 1000, 21, 900, 0, 1000, 100, 'Abrigo 03'),
(1, 15, 1000, 22, 900, 0, 1000, 100, 'Abrigo 04'),
(2, 16, 2000, 23, 1800, 0, 1000, 200, 'Abrigo 01');

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
  `Descripcion` varchar(255) NOT NULL,
  `img` varchar(60) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`nombre`, `Descripcion`, `img`, `id_producto`, `precio`) VALUES
('abrigo-01', 'sdcsadcasdcadsc', '/img/stati/imi.png', 1, 10000),
('Abrigo 01', 'Abrigo de lana de corte clásico, ideal para los días fríos. Combina confort y estilo en una sola pieza.', 'static/img/abrigos/01.jpg', 11, 1000),
('Abrigo 02', 'Abrigo de diseño elegante, perfecto para un look sofisticado durante las estaciones más frías.', 'static/img/abrigos/02.jpg', 12, 1000),
('Abrigo 03', 'Abrigo de doble faz con capucha removible, ideal para protegerte del viento y la lluvia sin perder estilo.', 'static/img/abrigos/03.jpg', 13, 1000),
('Abrigo 04', 'Abrigo de corte moderno, perfecto para mantenerte abrigado durante el invierno con un toque urbano.', 'static/img/abrigos/04.jpg', 14, 1000),
('Abrigo 05', 'Abrigo cálido y confortable, ideal para los días más fríos sin sacrificar el estilo.', 'static/img/abrigos/05.jpg', 15, 1000),
('Camiseta 01', 'Camiseta de algodón suave y respirante, ideal para el uso diario. Disponible en varios colores.', 'static/img/camisetas/01.jpg', 21, 1000),
('Camiseta 02', 'Camiseta casual con un diseño sencillo y elegante, perfecta para cualquier ocasión.', 'static/img/camisetas/02.jpg', 22, 1000),
('Camiseta 03', 'Camiseta de corte moderno con estampado, una pieza cómoda para tu look diario.', 'static/img/camisetas/03.jpg', 23, 1000),
('Camiseta 04', 'Camiseta con cuello redondo y manga corta, fabricada con materiales de alta calidad para mayor durabilidad.', 'static/img/camisetas/04.jpg', 24, 1000),
('Camiseta 05', 'Camiseta básica que no puede faltar en tu armario, ideal para combinar con jeans o pantalones.', 'static/img/camisetas/05.jpg', 25, 1000),
('Camiseta 06', 'Camiseta cómoda y versátil, perfecta para actividades informales y descansar en casa.', 'static/img/camisetas/06.jpg', 26, 1000),
('Camiseta 07', 'Camiseta con diseño gráfico atractivo, una opción ideal para los amantes de los looks más atrevidos.', 'static/img/camisetas/07.jpg', 27, 1000),
('Camiseta 08', 'Camiseta con corte slim fit, diseñada para ofrecerte comodidad y un ajuste perfecto.', 'static/img/camisetas/08.jpg', 28, 1000),
('Pantalón 01', 'Pantalón clásico de corte recto, ideal para cualquier ocasión. Hecho de materiales resistentes y cómodos.', 'static/img/pantalones/01.jpg', 31, 1000),
('Pantalón 02', 'Pantalón de mezclilla con un diseño atemporal, perfecto para el día a día o una salida casual.', 'static/img/pantalones/02.jpg', 32, 1000),
('Pantalón 03', 'Pantalón cómodo de algodón con cintura elástica, perfecto para descansar o hacer actividades al aire libre.', 'static/img/pantalones/03.jpg', 33, 1000),
('Pantalón 04', 'Pantalón de corte recto con detalles modernos, ideal para un look casual y relajado.', 'static/img/pantalones/04.jpg', 34, 1000),
('Pantalón 05', 'Pantalón deportivo de tela ligera, ideal para hacer ejercicio o para un look urbano cómodo.', 'static/img/pantalones/05.jpg', 35, 1000);

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
(6000, 'fvdfvdfv', 1024, '2024-11-21 21:58:40', 11),
(3000, 'fvdfvdfv', 1024, '2024-11-21 22:04:07', 12),
(3000, 'fvdfvdfv', 1024, '2024-11-21 22:05:17', 13),
(2000, 'fvdfvdfv', 1024, '2024-11-21 23:16:25', 14),
(4000, 'fvdfvdfv', 1024, '2024-11-21 23:59:09', 15),
(2000, 'fvdfvdfv', 1024, '2024-11-22 00:01:12', 16);

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
  ADD KEY `id_transaccion_fk` (`id_transaccion_fk`),
  ADD KEY `id_producto` (`id_producto`);

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
  MODIFY `id_contactame` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_trans`
--
ALTER TABLE `detalle_trans`
  MODIFY `id_detalles_trans` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `transaccion`
--
ALTER TABLE `transaccion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  ADD CONSTRAINT `detalle_trans_ibfk_1` FOREIGN KEY (`id_transaccion_fk`) REFERENCES `transaccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
