# EstrategiaOpeningUS100Mossetto

Código publicado por primera vez en este repositorio, codigo enteramente de mi autoría. Libre de uso para cualquier interesado.

El archivo con la extension .mq5 es para abrir el codigo en algun editor de código y ver como funciona. 
El archivo .ex5 es para poner en ejecución el codigo en tu gráfico con el instrumento US500


Esta estrategia se ejecuta de forma automática de martes a viernes, toma el precio de apertura de la primera vela en la apertura del mercado NY instrumento: US100 (CFD de nazdaq puede usarse con cualquiera de nazdaq) , apartir de esa precio, se coloca una orden en dirección a donde se haya alcanzado 100pts, se coloca un SL de 80pts y un take profit de 160pts, se mueve a breakeven cuando se llega a los 100pts 
Resultados de metricas corrido en Strategy tester de metatrtader 5

Expert:	detectarPico_v2
Symbol:	US100
Period:	M15 (2020.01.01 - 2024.12.09)
Inputs:	CCI_Period=14
CCI_Level=100.0
Company:	BridgeMarkets Ltd
Currency:	USD
Initial Deposit:	25 000.00
Leverage:	1:100
Results
History Quality:	99%
Bars:	116049	Ticks:	191524415	Symbols:	1
Total Net Profit:	2 977.06	Balance Drawdown Absolute:	1 147.58	Equity Drawdown Absolute:	1 171.08
Gross Profit:	28 392.94	Balance Drawdown Maximal:	1 184.70 (4.64%)	Equity Drawdown Maximal:	1 241.70 (4.85%)
Gross Loss:	-25 415.88	Balance Drawdown Relative:	4.64% (1 184.70)	Equity Drawdown Relative:	4.85% (1 241.70)
Profit Factor:	1.12	Expected Payoff:	3.93	Margin Level:	788.05%
Recovery Factor:	2.40	Sharpe Ratio:	2.47	Z-Score:	-0.13 (10.34%)
AHPR:	1.0002 (0.02%)	LR Correlation:	0.83	OnTester result:	0
GHPR:	1.0001 (0.01%)	LR Standard Error:	436.94		
Total Trades:	758	Short Trades (won %):	383 (36.03%)	Long Trades (won %):	375 (39.47%)
Total Deals:	1516	Profit Trades (% of total):	286 (37.73%)	Loss Trades (% of total):	472 (62.27%)
Largest profit trade:	102.80	Largest loss trade:	-93.58
Average profit trade:	99.28	Average loss trade:	-50.64
Maximum consecutive wins ($):	6 (600.36)	Maximum consecutive losses ($):	13 (-664.22)
Maximal consecutive profit (count):	600.36 (6)	Maximal consecutive loss (count):	-664.22 (13)
Average consecutive wins:	2	Average consecutive losses:	3
