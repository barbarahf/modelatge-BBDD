-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 17-07-2020 a las 13:29:11
-- Versión del servidor: 5.7.30-0ubuntu0.18.04.1
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `optica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Cliente`
--

CREATE TABLE `Cliente` (
  `id_cli` int(11) NOT NULL,
  `cod_postal` int(11) NOT NULL,
  `telefono` int(11) NOT NULL,
  `correo_electronico` varchar(45) NOT NULL,
  `fecha-registro` date NOT NULL,
  `cli_recomendado` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Empleado`
--

CREATE TABLE `Empleado` (
  `NIE` varchar(9) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Gafas`
--

CREATE TABLE `Gafas` (
  `idGafas` int(11) NOT NULL,
  `Proveedora_NIF` varchar(9) NOT NULL,
  `marcas` varchar(45) NOT NULL,
  `graduacion` float NOT NULL,
  `tipo_montura` varchar(45) NOT NULL,
  `color_montura` varchar(45) NOT NULL,
  `color_cristal` varchar(45) NOT NULL,
  `precio` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `Gafas`
--

INSERT INTO `Gafas` (`idGafas`, `Proveedora_NIF`, `marcas`, `graduacion`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES
(0, '1234567T', 'DIOR', 2.5, 'Pasta', 'rojo', 'azul', 180),
(456789, 'y7894562', 'DIOR', 2.5, 'Pasta', 'rojo', 'azul', 180);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Proveedora`
--

CREATE TABLE `Proveedora` (
  `NIF` varchar(9) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `calle` varchar(45) NOT NULL,
  `numero_calle` int(11) NOT NULL,
  `piso` int(11) NOT NULL,
  `puerta` int(11) NOT NULL,
  `ciudad` varchar(45) NOT NULL,
  `codigo_postal` int(5) NOT NULL,
  `pais` varchar(45) NOT NULL,
  `telefono` int(11) NOT NULL,
  `fax` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `Proveedora`
--

INSERT INTO `Proveedora` (`NIF`, `nom`, `calle`, `numero_calle`, `piso`, `puerta`, `ciudad`, `codigo_postal`, `pais`, `telefono`, `fax`) VALUES
(' 1234567T', ' MOO', ' Ronda universidad', 2, 5, 88, ' Barcelona', 8290, ' Espana', 789456123, NULL),
(' y7894562', ' Universitaria', ' claris', 32, 15, 2, ' Barcelona', 8290, ' Espana', 789456123, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_nuevo_cli`
--

CREATE TABLE `registro_nuevo_cli` (
  `id_nuevo_cli` int(11) NOT NULL,
  `id_cli_recomendado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Venta`
--

CREATE TABLE `Venta` (
  `codigo_venta` varchar(45) NOT NULL,
  `idGafas` int(11) NOT NULL,
  `NIE_empleado` varchar(9) NOT NULL,
  `id_cli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Cliente`
--
ALTER TABLE `Cliente`
  ADD PRIMARY KEY (`id_cli`);

--
-- Indices de la tabla `Empleado`
--
ALTER TABLE `Empleado`
  ADD PRIMARY KEY (`NIE`);

--
-- Indices de la tabla `Gafas`
--
ALTER TABLE `Gafas`
  ADD PRIMARY KEY (`idGafas`),
  ADD KEY `fk_Gafas_Proveedora_idx` (`Proveedora_NIF`);

--
-- Indices de la tabla `Proveedora`
--
ALTER TABLE `Proveedora`
  ADD PRIMARY KEY (`NIF`);

--
-- Indices de la tabla `registro_nuevo_cli`
--
ALTER TABLE `registro_nuevo_cli`
  ADD KEY `fk_Cliente_has_Cliente_Cliente2_idx` (`id_cli_recomendado`),
  ADD KEY `fk_Cliente_has_Cliente_Cliente1_idx` (`id_nuevo_cli`);

--
-- Indices de la tabla `Venta`
--
ALTER TABLE `Venta`
  ADD PRIMARY KEY (`codigo_venta`),
  ADD KEY `idGafas_idx` (`idGafas`),
  ADD KEY `NIE_idx` (`NIE_empleado`),
  ADD KEY `id_cli_idx` (`id_cli`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Gafas`
--
ALTER TABLE `Gafas`
  ADD CONSTRAINT `fk_Gafas_Proveedora` FOREIGN KEY (`Proveedora_NIF`) REFERENCES `Proveedora` (`NIF`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `registro_nuevo_cli`
--
ALTER TABLE `registro_nuevo_cli`
  ADD CONSTRAINT `fk_Cliente_has_Cliente_Cliente1` FOREIGN KEY (`id_nuevo_cli`) REFERENCES `Cliente` (`id_cli`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cliente_has_Cliente_Cliente2` FOREIGN KEY (`id_cli_recomendado`) REFERENCES `Cliente` (`id_cli`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Venta`
--
ALTER TABLE `Venta`
  ADD CONSTRAINT `NIE` FOREIGN KEY (`NIE_empleado`) REFERENCES `Empleado` (`NIE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idGafas` FOREIGN KEY (`idGafas`) REFERENCES `Gafas` (`idGafas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_cli` FOREIGN KEY (`id_cli`) REFERENCES `Cliente` (`id_cli`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
