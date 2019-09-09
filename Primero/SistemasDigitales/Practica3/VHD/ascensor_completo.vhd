----------------------------------------------------------------------------------------
--� Este dise�o es propietario el autor y puede ser utilizado con fines de estudio
----------------------------------------------------------------------------------------
-- Proyecto: Pr�ctica de Sistemas Digitales
-- Dise�o: M�quinas de estados finitos (FSM)
-- Nombre del fichero: ascensor_completo.vhd
-- Autor: Mark Dervishaj Memi, David Labrado Hernandez
-- Fecha: 20/05/2018 -- Versi�n: 1.0
-- Resumen: Contiene una entidad y una arquitectura
-- en estilo de comportamiento de un modelo de ascensor de 3 pisos -- Act�a por flanco de subida de reloj
-- Se utilizan el tipo de datos STD_LOGIC para todas las se�ales
-- Excepto para la se�al piso_donde_va que ser� INTEGER --
-- Modificaciones:
--
-- Fecha Autor Versi�n Descripci�n del cambio
--========================================================================================
-- -- ========================================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY ascensor_completo IS

 PORT(clk : IN STD_LOGIC; -- activo por flanco de subida

    piso_donde_va : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- seleccion tipo
    sube, baja : OUT STD_LOGIC; -- direcci�n movimiento del motor
    piso_donde_esta : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) -- c�digo binario del piso donde se encuentra el ascensor
   );

END ascensor_completo;

ARCHITECTURE arquitectura_ascensor_completo OF ascensor_completo IS
COMPONENT FSM_ascensor IS
PORT(clk : IN STD_LOGIC; -- activo por flanco de subida

    codigo_piso : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- c�digo binario del N� de piso pulsado
    sube, baja : OUT STD_LOGIC; -- direcci�n movimiento del motor
    piso_donde_esta : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) -- c�digo binario del piso donde se encuentra el ascensor
   );
END COMPONENT;
COMPONENT codifica_boton IS
PORT (piso_donde_va : IN STD_LOGIC_VECTOR (2 DOWNTO 0); --seleccion piso--
codigo_piso : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --codigo generado--

END COMPONENT;
SIGNAL codigo_entrada_FSM : STD_LOGIC_VECTOR (1 DOWNTO 0); --codigo binario del piso donde va--
BEGIN
boton : codifica_boton PORT MAP (piso_donde_va => piso_donde_va,
                                 codigo_piso => codigo_entrada_FSM);

FSM : FSM_ascensor PORT MAP (clk => clk, 
                             codigo_piso => codigo_entrada_FSM,
                             sube => sube,
                             baja => baja,
                             piso_donde_esta => piso_donde_esta);

END arquitectura_ascensor_completo;