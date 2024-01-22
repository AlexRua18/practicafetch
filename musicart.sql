-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-12-2023 a las 22:45:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `musicart`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `identificacion` int(12) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `numero_factura` int(15) NOT NULL,
  `fecha` date NOT NULL,
  `nombre_vendedor` varchar(50) NOT NULL,
  `identificacion` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturaxserial`
--

CREATE TABLE `facturaxserial` (
  `numero_factura` int(15) NOT NULL,
  `id_serial` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_prooducto` int(15) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `valor` int(10) NOT NULL,
  `ruta` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_prooducto`, `tipo`, `descripcion`, `marca`, `nombre`, `valor`, `ruta`) VALUES
(1, 'guitarra', 'guitarra eletrica', 'yamaha', 'yamaha pacifica guitarra eléctrica', 5000000, 'fotos/yamaha pacifica guitarra eléctrica_yamaha_'),
(2, 'violin', 'violin eletrico purpura', 'yamaha', 'violin eletrico yamaha purple', 7000000, 'fotos/violin eletrico yamaha purple_yamaha_.png'),
(3, 'violin', 'puple violin escandinavo', 'chalenger', 'chalenger violin', 8000000, 'fotos/chalenger violin_chalenger_.png'),
(4, 'bateria', 'bateria yamaha', 'yamaha', 'yamaha bateria', 9000000, 'fotos/yamaha bateria_yamaha_.png'),
(5, 'piano', 'piano de cola ', 'yamaha', 'yamaha piano de cola', 15000000, 'fotos/yamaha piano de cola_yamaha_.png'),
(6, 'bajo', 'bajo marmolizado gris ', 'yamaha', 'bajo yamaha', 6000000, 'fotos/bajo yamaha_yamaha_.png'),
(7, 'bajo', 'bajo marmolizado gris ', 'yamaha', 'bajo yamaha', 6000000, 'fotos/bajo yamaha_yamaha_.png'),
(8, 'bajo', 'bajo chalenger marmolizado ', 'chalenguer', 'bajo chalenger', 7000000, 'fotos/bajo chalenger_chalenguer_.png'),
(9, 'sasofon', 'sasofon yamaha blak', 'yamaha', 'sosofon yamaha', 7500000, 'fotos/sosofon yamaha_yamaha_.png'),
(10, 'sasofon', 'sesofon chalenguer', 'chalenger', 'sasofon', 8000000, 'fotos/sasofon_chalenger_.png'),
(11, 'sasofon', 'sasofon', 'sasofon', 'sasofon', 10000, 'fotos/sasofon_sasofon_.png'),
(12, 'teclado', 'teclado eletrico', 'yamaha', 'teclado eletrico', 2500000, 'fotos/teclado eletrico_yamaha_.png'),
(13, 'piano ', 'piano de cola', 'yamaha', 'piano de cola', 17000000, 'fotos/piano de cola_yamaha_.png'),
(14, 'blanco', 'blanco', 'blanco', 'blanco', 1, 'fotos/blanco_blanco_.png'),
(15, 'blanco', 'blanco', 'blanco', 'blanco', 1, 'fotos/blanco_blanco_.png'),
(16, 'negro', 'negro', 'negro', 'negro', 45, 'fotos/negro_negro_.png'),
(17, 'gordo', 'gordo', 'gordo', 'gordo', 48, 'fotos/gordo_gordo_.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seriales`
--

CREATE TABLE `seriales` (
  `id_serial` int(15) NOT NULL,
  `id_prooducto` int(15) NOT NULL,
  `serial` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seriales`
--

INSERT INTO `seriales` (`id_serial`, `id_prooducto`, `serial`) VALUES
(1, 8, '09876'),
(2, 9, '52369'),
(3, 9, '96325'),
(4, 9, '47852'),
(5, 10, '654'),
(6, 10, '987'),
(7, 11, '963'),
(8, 11, '852'),
(9, 12, '452'),
(11, 13, '968'),
(12, 13, '869'),
(13, 14, '357'),
(14, 15, '357'),
(15, 16, '962'),
(16, 17, '159');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(20) NOT NULL,
  `contraseña` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `contraseña`) VALUES
(0, 'Admin', '123456');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`identificacion`),
  ADD KEY `identificacion` (`identificacion`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`numero_factura`),
  ADD KEY `numero_factura` (`numero_factura`),
  ADD KEY `identificacion` (`identificacion`);

--
-- Indices de la tabla `facturaxserial`
--
ALTER TABLE `facturaxserial`
  ADD KEY `numero_factura` (`numero_factura`),
  ADD KEY `id_serial` (`id_serial`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_prooducto`),
  ADD KEY `id_prooducto` (`id_prooducto`);

--
-- Indices de la tabla `seriales`
--
ALTER TABLE `seriales`
  ADD PRIMARY KEY (`id_serial`),
  ADD KEY `id_serial` (`id_serial`),
  ADD KEY `id_prooducto` (`id_prooducto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_prooducto` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `seriales`
--
ALTER TABLE `seriales`
  MODIFY `id_serial` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`identificacion`) REFERENCES `cliente` (`identificacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `facturaxserial`
--
ALTER TABLE `facturaxserial`
  ADD CONSTRAINT `facturaxserial_ibfk_1` FOREIGN KEY (`numero_factura`) REFERENCES `facturas` (`numero_factura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `facturaxserial_ibfk_2` FOREIGN KEY (`id_serial`) REFERENCES `seriales` (`id_serial`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `seriales`
--
ALTER TABLE `seriales`
  ADD CONSTRAINT `seriales_ibfk_1` FOREIGN KEY (`id_prooducto`) REFERENCES `producto` (`id_prooducto`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
