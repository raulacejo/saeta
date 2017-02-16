* EXPLOTACIÓN DEMANDA GOLF 2014.


* Unimos todas las entregas en un archivo. Partimos de una copia de la primera entrega, le cambiamos el nombre a golf_2014.sav. Y le vamos anexando el resto de entregas.
* Entrega may: 163 obs. / Entrega sep: 180 obs. / Entrega oct: 489 obs. / Total muestra: 832 obs.
DATASET ACTIVATE Conjunto_de_datos1.
ADD FILES /FILE=*
  /FILE='Z:\SAETA\Segmentos\Sistema Actualizacion Anual\2014\Golf\demanda\trabajo de campo\entregas\Datos_Seg5_SPSS_Encuestas_Mes09.sav'.
EXECUTE.
ADD FILES /FILE=*
  /FILE='Z:\SAETA\Segmentos\Sistema Actualizacion Anual\2014\Golf\demanda\trabajo de campo\entregas\Datos_Seg5_SPSS_Encuestas_Mes10.sav'.
EXECUTE.


* Usamos una tabla para ver registros de encuesta y registros de conteo.
DATASET ACTIVATE Conjunto_de_datos1.
CTABLES
  /VLABELS VARIABLES=Enc_Conteo DISPLAY=LABEL
  /TABLE Enc_Conteo [C][COUNT F40.0]
  /CATEGORIES VARIABLES=Enc_Conteo ORDER=A KEY=VALUE EMPTY=INCLUDE.


*Filtramos para quedarnos solo con los encuestados, y dejar fuera el conteo.
DATASET ACTIVATE Conjunto_de_datos1.
USE ALL.
COMPUTE filter_$=(Enc_Conteo = 1).
VARIABLE LABELS filter_$ 'Enc_Conteo = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
DATASET ACTIVATE Conjunto_de_datos1.


* Usamos la misma tabla para ver registros de encuesta y registros de conteo. Comprobar que conteo = 0.
DATASET ACTIVATE Conjunto_de_datos1.
CTABLES
  /VLABELS VARIABLES=Enc_Conteo DISPLAY=LABEL
  /TABLE Enc_Conteo [C][COUNT F40.0]
  /CATEGORIES VARIABLES=Enc_Conteo ORDER=A KEY=VALUE EMPTY=INCLUDE.


*Creamos variable MES, para pasar de fechas a meses. Antes hay que comprobar/modificar el formato de la variable FECHA.
COMPUTE MES=XDATE.MONTH(FECHA).
EXECUTE.


* Distribución de cuestionarios por punto y mes, para comprobar distribución muestral.
CTABLES
  /VLABELS VARIABLES=CodPto DescPto MES DISPLAY=LABEL
  /TABLE CodPto > DescPto [C] BY MES [C][COUNT F40.0]
  /CATEGORIES VARIABLES=CodPto DescPto MES ORDER=A KEY=VALUE EMPTY=EXCLUDE.


* País de residencia del entrevistado.
CTABLES
  /VLABELS VARIABLES=Resp03 DISPLAY=LABEL
  /TABLE Resp03 [C][COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=Resp03 ORDER=A KEY=VALUE EMPTY=INCLUDE.


 * Motivo principal de su viaje.
CTABLES
  /VLABELS VARIABLES=Resp02_1 DISPLAY=LABEL
  /TABLE Resp02_1 [COUNT F40.0]
  /CATEGORIES VARIABLES=Resp02_1 ORDER=A KEY=VALUE EMPTY=INCLUDE.


* Motivo secundario de su viaje.
CTABLES
  /VLABELS VARIABLES=Resp02_2 DISPLAY=LABEL
  /TABLE Resp02_2 [COUNT F40.0]
  /CATEGORIES VARIABLES=Resp02_2 ORDER=A KEY=VALUE EMPTY=INCLUDE.


* Estancia media.
CTABLES
  /VLABELS VARIABLES=Resp04 DISPLAY=LABEL
  /TABLE Resp04 [MEAN].


* Calificación.
CTABLES
  /VLABELS VARIABLES=Resp07
    DISPLAY=LABEL
  /TABLE Resp07 [S][MEAN].


*BLOQUE ESPECÍFICO TURISMO DE GOLF.


* Media de Campos de golf visitados.
CTABLES
  /VLABELS VARIABLES=Resp08_A1 DISPLAY=LABEL
  /TABLE Resp08_A1 [MEAN].


*Media de salidas a campo.
CTABLES
  /VLABELS VARIABLES=Resp08_A2 DISPLAY=LABEL
  /TABLE Resp08_A2 [MEAN].


* Socio algún campo.
CTABLES
  /VLABELS VARIABLES=Resp08_B DISPLAY=LABEL
  /TABLE Resp08_B [COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=Resp08_B ORDER=A KEY=VALUE EMPTY=INCLUDE.


* Usó Internet en algún momento en relación con este viaje.
CTABLES
  /VLABELS VARIABLES=P09_OpNo P09_Op2 P09_Op3 P09_Op4 P09_Op5 P09_Op6 P09_OpOtros 
    DISPLAY=LABEL
  /TABLE P09_OpNo [COUNT F40.0, COLPCT.COUNT PCT40.1] + P09_Op2 [C][COUNT F40.0, COLPCT.COUNT 
    PCT40.1] + P09_Op3 [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + P09_Op4 [C][COUNT F40.0, COLPCT.COUNT 
    PCT40.1] + P09_Op5 [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + P09_Op6 [C][COUNT F40.0, COLPCT.COUNT 
    PCT40.1] + P09_OpOtros [C][COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=P09_OpNo P09_Op2 P09_Op3 P09_Op4 P09_Op5 P09_Op6 P09_OpOtros ORDER=A 
    KEY=VALUE EMPTY=INCLUDE.


* Sexo del entrevistado.
CTABLES
  /VLABELS VARIABLES=Resp10 DISPLAY=LABEL
  /TABLE Resp10 [COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=Resp10 ORDER=A KEY=VALUE EMPTY=INCLUDE.


*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------.
*FILTROS. Se aplican cada año en función de las necesidades.
* Para conocer los valores extremos y atípicos: ordenamos la variable de menor a mayor. Analizar -- Estadísticos Descriptivos -- Explorar --
* Seleccionamos la variable a analizar. En estadísticos ponemos valores atípicos. Y en gráfico seleccionamos histograma (SPSS por defecto saca gráfico de cajas)

*Código para representar y detectar atípicos. Ojo: hay que ordenar la variable antes de ejecutar.
EXAMINE VARIABLES=Gasto_Cuestionario_SinPaquete
  /PLOT BOXPLOT HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS EXTREME
  /MISSING LISTWISE
  /NOTOTAL.


* Filtro de estancia media.
COMPUTE filter_$=(Resp04 < 30).
VARIABLE LABELS filter_$ 'Resp04 < 40 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


*Filtro de salidas a campo.
USE ALL.
COMPUTE filter_$=(Resp08_A2   <=   30).
VARIABLE LABELS filter_$ 'Resp08_A2   <=   30 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------.

*	CÁLCULOS PARA EL GASTO.

* Se calcula simultáneamente gasto con paquete y sin paquete. El paquete se ajusta restando el valor medio del transporte.

* Comprobamos que no hay duplicados en los conceptos de las preguntas P05 y P06.

* La partida de gasto en P05 "Transporte hasta su lugar de destino, solo hay que tomarlo para los andaluces. El resto es gasto en orígen.

*Variable nueva: Gasto de transporte hasta el destino por persona.
COMPUTE Resp05_GastoTransportexPersona=Resp05_CANT1 / Resp05_Personas.
VARIABLE LABELS  Resp05_GastoTransportexPersona 'Gasto de transporte hasta el destino por persona'.
EXECUTE.

* Tabla para el cálculo del precio medio de transporte, para restarlo de la partida de paquete turístico.
CTABLES
  /VLABELS VARIABLES=Resp03 Resp05_GastoTransportexPersona Resp05_Personas DISPLAY=LABEL
  /TABLE Resp03 [C] BY Resp05_GastoTransportexPersona [S][MEAN] + Resp05_Personas [S][COUNT F40.0, 
    SUM]
  /CATEGORIES VARIABLES=Resp03 ORDER=A KEY=VALUE EMPTY=INCLUDE.

* La partida de gasto en P05 "Paquete turístico" hay que quitarle el transporte. Para ello estimamos precio medio de transporte por procedencia y restamos.

*Creamos la variable Paquete Turístico sin transporte, restandole 112.76. Si es andaluz y viene con paquete, no se le resta.
IF  (Resp03 ~= "1" AND Resp05_CANT6 > 0) Resp05_CANT6_SINTTE=Resp05_CANT6 - 112.76.
IF  (Resp03 = "1" AND Resp05_CANT6 > 0) Resp05_CANT6_SINTTE=Resp05_CANT6.
IF  (Resp05_CANT6 = 0) Resp05_CANT6_SINTTE=Resp05_CANT6.
VARIABLE LABELS  Resp05_CANT6_SINTTE 'Paquete Turístico sin el transporte'.
EXECUTE.

*Creamos la variable Transporte hasta el lugar de destino, con valores solo para andaluces, porque el resto es en orígen (0). 
IF  (Resp03 = "1") Resp05_CANT1_Andaluces=Resp05_CANT1.
IF  (Resp03 ~= "1") Resp05_CANT1_Andaluces=0.
VARIABLE LABELS  Resp05_CANT1_Andaluces 'Transporte hasta el lugar de destino solo andaluces'.
EXECUTE.

*Creamos variable Gasto de la estancia sumando todas las partidas de la P05, cambiando las dos que hemos ajustado: Transporte solo de andaluces y Paquete sin Transporte.
COMPUTE Resp05_Corregida=Resp05_CANT1_Andaluces + Resp05_CANT2 + Resp05_CANT3 + Resp05_CANT4 + 
    Resp05_CANT5 + Resp05_CANT6_SINTTE + Resp05_CANT7.
VARIABLE LABELS  Resp05_Corregida 'Respuesta P05 sin transporte en paquete y quitando el '+
    'transporte hasta el destino en no andaluces'.
EXECUTE.

*Creamos variable Gasto de la estancia sin paquete, sumando todas las partidas de la P05, menos el paquete turístico.
COMPUTE Resp05_SinPaquete=Resp05_CANT1_Andaluces + Resp05_CANT2 + Resp05_CANT3 + Resp05_CANT4 + 
    Resp05_CANT5 + Resp05_CANT7.
VARIABLE LABELS  Resp05_SinPaquete 'Respuesta P05 sin paquete turístico '.
EXECUTE.

* Creamos variable Gasto de la estancia por persona y día.
COMPUTE Gasto_Estancia_Cuestionario=Resp05_Corregida / Resp05_Personas / Resp04.
VARIABLE LABELS  Gasto_Estancia_Cuestionario 'Gasto de la estancia por día y persona'.
EXECUTE.

* Creamos variable Gasto de la estancia sin paquete por persona y día.
COMPUTE Gasto_Estancia_Cuestionario_SinPaquete=Resp05_SinPaquete / Resp05_Personas / Resp04.
VARIABLE LABELS  Gasto_Estancia_Cuestionario 'Gasto de la estancia sin paquete por día y persona'.
EXECUTE.

* Creamos variable Gasto día de ayer por persona.
COMPUTE Gasto_Ayer_Cuestionario=Resp06 / Resp06_Personas.
VARIABLE LABELS  Gasto_Ayer_Cuestionario 'Gasto día de ayer por cuestionario y persona'.    
EXECUTE.

* Creamos variable Gasto diario por cuestionario y persona, sumando Gasto de la Estancia y Gasto día de ayer.
COMPUTE Gasto_Cuestionario=Gasto_Estancia_Cuestionario + Gasto_Ayer_Cuestionario.
VARIABLE LABELS  Gasto_Cuestionario 'Gasto por cuestionario (suma Gasto Estancia + Gasto Ayer)'.
EXECUTE.

* Creamos variable Gasto diario por cuestionario y persona sin paquete, sumando Gasto de la Estancia y Gasto día de ayer.
COMPUTE Gasto_Cuestionario_SinPaquete=Gasto_Estancia_Cuestionario_SinPaquete + Gasto_Ayer_Cuestionario.
VARIABLE LABELS  Gasto_Cuestionario_SinPaquete 'Gasto por cuestionario sin paquete (suma Gasto Estancia + Gasto Ayer)'.
EXECUTE.

*CALCULAMOS GASTO DE LA ESTANCIA POR DÍA.
COMPUTE Gasto_Estancia_Diario=Resp05_Corregida / Resp04.
EXECUTE.

*CALCULAMOS GASTO DE LA ESTANCIA SIN PAQUETE POR DÍA.
COMPUTE Gasto_Estancia_Diario_SinPaquete=Resp05_SinPaquete / Resp04.
EXECUTE.

* TABLA PARA EL CÁLCULO DEL GMD.
CTABLES
  /VLABELS VARIABLES=Gasto_Estancia_Diario Resp05_Personas Resp06 Resp06_Personas DISPLAY=LABEL
  /TABLE Gasto_Estancia_Diario [COUNT F40.0, SUM] + Resp05_Personas [COUNT F40.0, SUM] + Resp06 
    [COUNT F40.0, SUM] + Resp06_Personas [COUNT F40.0, SUM].

* TABLA PARA EL CÁLCULO DEL GMD SIN PAQUETE.
CTABLES
  /VLABELS VARIABLES=Gasto_Estancia_Diario_SinPaquete Resp05_Personas Resp06 Resp06_Personas DISPLAY=LABEL
  /TABLE Gasto_Estancia_Diario_SinPaquete [COUNT F40.0, SUM] + Resp05_Personas [COUNT F40.0, SUM] + Resp06 
    [COUNT F40.0, SUM] + Resp06_Personas [COUNT F40.0, SUM].

*FILTRO PARA GASTO_CUESTIONARIO. Quitamos extremos.
* Para conocer los valores extremos y atípicos: ordenamos la variable de menor a mayor. Analizar -- Estadísticos Descriptivos -- Explorar --
* Seleccionamos la variable a analizar. En estadísticos ponemos valores atípicos. Y en gráfico seleccionamos histograma (SPSS por defecto saca gráfico de cajas)

EXAMINE VARIABLES=Gasto_Cuestionario_SinPaquete
  /PLOT BOXPLOT HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*FILTRO PARA GASTO_CUESTIONARIO. Quitamos extremos.
DATASET ACTIVATE Conjunto_de_datos1.
USE ALL.
COMPUTE filter_$=(Gasto_Cuestionario >= 0 & Gasto_Cuestionario < 450).
VARIABLE LABELS filter_$ 'Gasto_Cuestionario >= 0 & Gasto_Cuestionario < 450 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*FILTRO PARA GASTO_CUESTIONARIO_SinPaquete. Quitamos extremos.
DATASET ACTIVATE Conjunto_de_datos1.
USE ALL.
COMPUTE filter_$=(Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300 & Resp04 < 30.).
VARIABLE LABELS filter_$ 'Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* CALCULO DE GASTO MEDIO DIARIO CON METODOLOGÍA ECTA.

* SIN PAQUETE.

DATASET ACTIVATE Conjunto_de_datos1.
COMPUTE ecta_gasto_estancia_dia_persona=(Resp05_SinPaquete / Resp04) / Resp05_Personas.
EXECUTE.

COMPUTE ecta_gasto_ayer_persona=Resp06 / Resp06_Personas.
EXECUTE.

COMPUTE ecta_numerador=((ecta_gasto_estancia_dia_persona + ecta_gasto_ayer_persona) * Resp04) * 
    Resp05_Personas.
EXECUTE.

COMPUTE ecta_denominador=Resp05_Personas * Resp04.
EXECUTE.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=ecta_numerador ecta_denominador DISPLAY=LABEL
  /TABLE ecta_numerador [S][COUNT F40.0, SUM] + ecta_denominador [S][COUNT F40.0, SUM].


* GASTO POR CONCEPTO.
* CALCULAMOS VARIABLES PARA PASAR LA P05 (GASTO EN LA ESTANCIA) A UN DATO DIARIO.

COMPUTE GASTO_TTE_DIA_P05_1_AND=Resp05_CANT1_Andaluces / Resp04.
VARIABLE LABELS  GASTO_TTE_DIA_P05_1_AND 'COMPUTE GASTO_TTE_DIA_P05_1_AND=Resp05_CANT1_Andaluces '+
    '/ Resp04'.
EXECUTE.

COMPUTE GASTO_ALOJ_DIA_P05_2=Resp05_CANT2 / Resp04.
VARIABLE LABELS  GASTO_ALOJ_DIA_P05_2 'COMPUTE GASTO_ALOJ_DIA_P05_2=Resp05_CANT2 / Resp04'.
EXECUTE.

COMPUTE GASTO_REST_DIA_P05_3=Resp05_CANT3 / Resp04.
VARIABLE LABELS  GASTO_REST_DIA_P05_3 'COMPUTE GASTO_REST_DIA_P05_3=Resp05_CANT3 / Resp04'.
EXECUTE.

COMPUTE GASTO_COMP_DIA_P05_4=Resp05_CANT4 / Resp04.
VARIABLE LABELS  GASTO_COMP_DIA_P05_4 'COMPUTE GASTO_COMP_DIA_P05_4=Resp05_CANT4 / Resp04'.
EXECUTE.

COMPUTE GASTO_GREEN_DIA_P05_5=Resp05_CANT5 / Resp04.
VARIABLE LABELS  GASTO_GREEN_DIA_P05_5 'COMPUTE GASTO_GREEN_DIA_P05_5=Resp05_CANT5 / Resp04'.
EXECUTE.


* TABLA PARA EL CÁLCULO DE GASTO DIARIO POR CONCEPTOS.

CTABLES
  /VLABELS VARIABLES=GASTO_TTE_DIA_P05_1_AND GASTO_ALOJ_DIA_P05_2 GASTO_REST_DIA_P05_3 
    GASTO_COMP_DIA_P05_4 GASTO_GREEN_DIA_P05_5 Resp06_CANT1 Resp06_CANT2 Resp06_CANT3 Resp06_CANT4 
    Resp06_CANT5 
    DISPLAY=LABEL
  /TABLE GASTO_TTE_DIA_P05_1_AND [S][SUM] + GASTO_ALOJ_DIA_P05_2 [S][SUM] + GASTO_REST_DIA_P05_3 
    [S][SUM] + GASTO_COMP_DIA_P05_4 [S][SUM] + GASTO_GREEN_DIA_P05_5 [S][SUM] + Resp06_CANT1 [S][SUM] + 
    Resp06_CANT2 [S][SUM] + Resp06_CANT3 [S][SUM] + Resp06_CANT4 [S][SUM] + Resp06_CANT5 [S][SUM].


*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------.

*PONDERACIONES PARA CORREGIR ESTRUCTURA DE PERSONAS DE GASTO.
WEIGHT OFF.

IF  (Resp05_Personas = 1) pond_persona_05	 = 0.5235.
IF  (Resp05_Personas = 2) pond_persona_05	 = 2.103.
IF  (Resp05_Personas > 2) pond_persona_05	 = 1.203.
EXECUTE.

WEIGHT BY pond_persona_05.

IF  (Resp06_Personas = 1) pond_persona_06	 = 0.4655.
IF  (Resp06_Personas = 2) pond_persona_06	 = 2.0300.
IF  (Resp06_Personas > 2) pond_persona_06	 = 1.0083.
EXECUTE.

WEIGHT BY pond_persona_06.

*. El procedimiento con ponderaciones no me sirve, porque ponderamos todo, no solo las pesonas.
*. Hay que crear nuevas variables personas.

IF  (Resp05_Personas = 1) Resp05_Personas_NEW=Resp05_Personas * 0.523793787.
IF  (Resp05_Personas = 2) Resp05_Personas_NEW=Resp05_Personas * 2.105614973.
IF  (Resp05_Personas = 3) Resp05_Personas_NEW=Resp05_Personas * 1.402714932.
IF  (Resp05_Personas = 4) Resp05_Personas_NEW=Resp05_Personas * 0.756302521.
IF  (Resp05_Personas >= 5) Resp05_Personas_NEW=Resp05_Personas * 0.588235294.
EXECUTE.

IF  (Resp06_Personas = 1) Resp06_Personas_NEW=Resp06_Personas * 0.46558198.
IF  (Resp06_Personas = 2) Resp06_Personas_NEW=Resp06_Personas * 2.02977487.
IF  (Resp06_Personas = 3) Resp06_Personas_NEW=Resp06_Personas * 1.16537181.
IF  (Resp06_Personas = 4) Resp06_Personas_NEW=Resp06_Personas * 0.83333333.
IF  (Resp06_Personas = 5) Resp06_Personas_NEW=Resp06_Personas * 1.76470588.
IF  (Resp06_Personas = 6) Resp06_Personas_NEW=Resp06_Personas * 0.75630252.
IF  (Resp06_Personas = 7) Resp06_Personas_NEW=Resp06_Personas * 0.44117647.
IF  (Resp06_Personas = 8) Resp06_Personas_NEW=Resp06_Personas * 0.44117647.
IF  (Resp06_Personas >= 9) Resp06_Personas_NEW=Resp06_Personas * 0.29411765.
EXECUTE.

*FILTRO PARA GASTO_CUESTIONARIO_SinPaquete. Quitamos extremos.
DATASET ACTIVATE Conjunto_de_datos1.
USE ALL.
COMPUTE filter_$=(Enc_Conteo = 1 & Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300).
VARIABLE LABELS filter_$ 'Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Calculamos gasto medio diario con las nuevas variables personas.

DATASET ACTIVATE Conjunto_de_datos1.
COMPUTE ecta_gasto_estancia_dia_persona=(Resp05_SinPaquete / Resp04) / Resp05_Personas_NEW.
EXECUTE.

COMPUTE ecta_gasto_ayer_persona=Resp06 / Resp06_Personas_NEW.
EXECUTE.

COMPUTE ecta_numerador=((ecta_gasto_estancia_dia_persona + ecta_gasto_ayer_persona) * Resp04) * 
    Resp05_Personas_NEW.
EXECUTE.

COMPUTE ecta_denominador=Resp05_Personas_NEW * Resp04.
EXECUTE.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=ecta_numerador ecta_denominador DISPLAY=LABEL
  /TABLE ecta_numerador [S][COUNT F40.0, SUM] + ecta_denominador [S][COUNT F40.0, SUM].


*.-------------------------------------------------.
*. Usando estructura de personas promedio de los años 2011, 2012 y 2013. Nuevos multiplicadores.

IF  (Resp05_Personas = 1) Resp05_Personas_NEW=Resp05_Personas * 0.562226675.
IF  (Resp05_Personas = 2) Resp05_Personas_NEW=Resp05_Personas * 1.882606017.
IF  (Resp05_Personas = 3) Resp05_Personas_NEW=Resp05_Personas * 1.58122055.
IF  (Resp05_Personas = 4) Resp05_Personas_NEW=Resp05_Personas * 2.15422172.
IF  (Resp05_Personas >= 5) Resp05_Personas_NEW=Resp05_Personas * 1.259624695.
EXECUTE.

IF  (Resp06_Personas = 1) Resp06_Personas_NEW=Resp06_Personas * 0.56720310.
IF  (Resp06_Personas = 2) Resp06_Personas_NEW=Resp06_Personas * 1.77217359.
IF  (Resp06_Personas = 3) Resp06_Personas_NEW=Resp06_Personas * 1.37592120.
IF  (Resp06_Personas = 4) Resp06_Personas_NEW=Resp06_Personas * 1.25988031.
IF  (Resp06_Personas = 5) Resp06_Personas_NEW=Resp06_Personas * 1.23720999.
IF  (Resp06_Personas = 6) Resp06_Personas_NEW=Resp06_Personas * 0.58655216.
IF  (Resp06_Personas = 7) Resp06_Personas_NEW=Resp06_Personas * 0.34215543.
IF  (Resp06_Personas = 8) Resp06_Personas_NEW=Resp06_Personas * 0.64154143.
IF  (Resp06_Personas >= 9) Resp06_Personas_NEW=Resp06_Personas * 0.34215543.
EXECUTE.

*FILTRO PARA GASTO_CUESTIONARIO_SinPaquete. Quitamos extremos.
DATASET ACTIVATE Conjunto_de_datos1.
USE ALL.
COMPUTE filter_$=(Enc_Conteo = 1 & Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300).
VARIABLE LABELS filter_$ 'Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Calculamos gasto medio diario con las nuevas variables personas.

DATASET ACTIVATE Conjunto_de_datos1.
COMPUTE ecta_gasto_estancia_dia_persona=(Resp05_SinPaquete / Resp04) / Resp05_Personas_NEW.
EXECUTE.

COMPUTE ecta_gasto_ayer_persona=Resp06 / Resp06_Personas_NEW.
EXECUTE.

COMPUTE ecta_numerador=((ecta_gasto_estancia_dia_persona + ecta_gasto_ayer_persona) * Resp04) * 
    Resp05_Personas_NEW.
EXECUTE.

COMPUTE ecta_denominador=Resp05_Personas_NEW * Resp04.
EXECUTE.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=ecta_numerador ecta_denominador DISPLAY=LABEL
  /TABLE ecta_numerador [S][COUNT F40.0, SUM] + ecta_denominador [S][COUNT F40.0, SUM].



*.-------------------------------------------------------------
*. Usando un solo multiplicador.

COMPUTE Resp05_Personas_MULT=Resp05_Personas * 1.2233.
COMPUTE Resp06_Personas_MULT=Resp06_Personas * 1.1568.
EXECUTE.

*FILTRO PARA GASTO_CUESTIONARIO_SinPaquete. Quitamos extremos.
DATASET ACTIVATE Conjunto_de_datos1.
USE ALL.
COMPUTE filter_$=(Enc_Conteo = 1 & Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300).
VARIABLE LABELS filter_$ 'Gasto_Cuestionario_SinPaquete >= 0 & Gasto_Cuestionario_SinPaquete <= 300 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Calculamos gasto medio diario con las nuevas variables personas.

DATASET ACTIVATE Conjunto_de_datos1.
COMPUTE ecta_gasto_estancia_dia_persona=(Resp05_SinPaquete / Resp04) / Resp05_Personas_MULT.
EXECUTE.

COMPUTE ecta_gasto_ayer_persona=Resp06 / Resp06_Personas_MULT.
EXECUTE.

COMPUTE ecta_numerador=((ecta_gasto_estancia_dia_persona + ecta_gasto_ayer_persona) * Resp04) * 
    Resp05_Personas_MULT.
EXECUTE.

COMPUTE ecta_denominador=Resp05_Personas_MULT * Resp04.
EXECUTE.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=ecta_numerador ecta_denominador DISPLAY=LABEL
  /TABLE ecta_numerador [S][COUNT F40.0, SUM] + ecta_denominador [S][COUNT F40.0, SUM].









