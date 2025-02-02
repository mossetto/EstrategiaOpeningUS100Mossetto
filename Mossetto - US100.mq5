//Sharpe 2.21
//  2020.01.01
//  AL
//  2024.12.19





#include <Trade/Trade.mqh>
CTrade trade;

int arrowCounter = 0;
datetime lastArrowTime = 0; // Para recordar la última vez que se colocó una flecha
double openingPrice = 0; // Precio de apertura del día
bool arrowPlacedForPriceMove = false; // Indica si ya se colocó la flecha por el movimiento de precio

int OnInit()
{
   // Configuración inicial, enviar notificación al iniciar el código
   SendNotification("Codigo corriendo");
   return INIT_SUCCEEDED;
}

void OnTick()
{
   MqlDateTime currentTime;
   TimeToStruct(TimeCurrent(), currentTime);

   // Evitar operaciones los días lunes (currentTime.day_of_week == 1 es lunes)
   if (currentTime.day_of_week == 1)
      return; // Si es lunes, salir de la función sin hacer nada

   // Comprobar si es las 16:30:00 y si no se ha colocado una flecha ese día
   if (currentTime.hour == 16 && currentTime.min == 30 && currentTime.sec == 0)
   {
      // Si no se colocó una flecha hoy (compara la fecha)
      if (lastArrowTime != currentTime.day)
      {
         openingPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID); // Registrar el precio de apertura
         lastArrowTime = currentTime.day; // Actualizar la última vez que se colocó una flecha
         arrowPlacedForPriceMove = false; // Reiniciar el control de la flecha por el movimiento de precio
      }
   }

   // Verificar si el precio se ha movido más de 50 puntos desde el precio de apertura
   if (openingPrice > 0 && !arrowPlacedForPriceMove)
   {
      double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double priceDifference = currentPrice - openingPrice;

      // Si el precio se ha movido 50 puntos o más, tomar acción
      if (MathAbs(priceDifference) >= 50)
      {
         // Verificar si no hay ninguna operación abierta
         if (!PositionSelect(_Symbol)) // Si no hay una operación abierta en este símbolo
         {
            // Si el precio sube, abrir un Long (compra)
            if (priceDifference > 0)
            {
               double slLong = currentPrice - 80;  // Stop Loss de 50 puntos hacia abajo
               double tpLong = currentPrice + 150; // Take Profit de 150 puntos hacia arriba
               trade.Buy(1, _Symbol, currentPrice, slLong, tpLong); // Abrir orden de compra (long)
            }
            // Si el precio baja, abrir un Short (venta)
            else
            {
               double slShort = currentPrice + 80;  // Stop Loss de 50 puntos hacia arriba
               double tpShort = currentPrice - 150; // Take Profit de 150 puntos hacia abajo
               trade.Sell(1, _Symbol, currentPrice, slShort, tpShort); // Abrir orden de venta (short)
            }
         }
         arrowPlacedForPriceMove = true; // Marcar que se colocó la flecha por el movimiento de precio
      }
   }

   // Revisar si la posición ha alcanzado el beneficio de $100 (100 puntos)
   AdjustStopLossToBreakEven();
}

// Función para mover el Stop Loss a Break-Even cuando el beneficio es mayor a $100
void AdjustStopLossToBreakEven()
{
   // Comprobar si hay una posición abierta
   if (PositionSelect(_Symbol))
   {
      double profit = PositionGetDouble(POSITION_PROFIT); // Obtener el beneficio de la posición
      double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN); // Precio de apertura

      // Si el beneficio es mayor o igual a $100 (100 puntos)
      if (profit >= 100)
      {
         // Mover el Stop Loss a Break-Even (precio de entrada)
         double newStopLoss = entryPrice;

         // Verificar si la posición es de compra (Long)
        if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
{
    // Asegúrate de que newStopLoss y entryPrice+150 estén dentro de los límites del bróker.
    double slLong = newStopLoss;  // Asegúrate de que esta distancia sea válida
    double tpLong = entryPrice + 160;   // Asegúrate de que esta distancia sea válida
    trade.PositionModify(PositionGetInteger(POSITION_TICKET), slLong, tpLong);
}
else if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
{
    // Asegúrate de que newStopLoss y entryPrice-150 estén dentro de los límites del bróker.
    double slShort = newStopLoss;  // Asegúrate de que esta distancia sea válida
    double tpShort = entryPrice - 160;   // Asegúrate de que esta distancia sea válida
    trade.PositionModify(PositionGetInteger(POSITION_TICKET), slShort, tpShort);

         }
      }
   }
}
