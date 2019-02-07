#property description "Example of placing pending orders"
#property script_show_inputs
#define EXPERT_MAGIC 123456                             // MagicNumber of the expert
input ENUM_ORDER_TYPE orderType=ORDER_TYPE_BUY_LIMIT;   // order type
//+------------------------------------------------------------------+
//| Placing pending orders                                           |
//+------------------------------------------------------------------+
void OnStart()
  {
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters to place a pending order
   request.action   =TRADE_ACTION_PENDING;                             // type of trade operation
   request.symbol   =Symbol();                                         // symbol
   request.volume   =0.1;                                              // volume of 0.1 lot
   request.deviation=2;                                                // allowed deviation from the price
   request.magic    =EXPERT_MAGIC;                                     // MagicNumber of the order
   int offset = 50;                                                    // offset from the current price to place the order, in points
   double price;                                                       // order triggering price
   double point=SymbolInfoDouble(_Symbol,SYMBOL_POINT);                // value of point
   int digits=SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);                // number of decimal places (precision)
   //--- checking the type of operation
   if(orderType==ORDER_TYPE_BUY_LIMIT)
     {
      request.type     =ORDER_TYPE_BUY_LIMIT;                          // order type
      price=SymbolInfoDouble(Symbol(),SYMBOL_ASK)-offset*point;        // price for opening 
      request.price    =NormalizeDouble(price,digits);                 // normalized opening price 
     }
   else if(orderType==ORDER_TYPE_SELL_LIMIT)
     {
      request.type     =ORDER_TYPE_SELL_LIMIT;                          // order type
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID)+offset*point;         // price for opening 
      request.price    =NormalizeDouble(price,digits);                  // normalized opening price 
     }
   else if(orderType==ORDER_TYPE_BUY_STOP)
     {
      request.type =ORDER_TYPE_BUY_STOP;                                // order type
      price        =SymbolInfoDouble(Symbol(),SYMBOL_ASK)+offset*point; // price for opening 
      request.price=NormalizeDouble(price,digits);                      // normalized opening price 
     }
   else if(orderType==ORDER_TYPE_SELL_STOP)
     {
      request.type     =ORDER_TYPE_SELL_STOP;                           // order type
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID)-offset*point;         // price for opening 
      request.price    =NormalizeDouble(price,digits);                  // normalized opening price 
     }
   else Alert("This example is only for placing pending orders");   // if not pending order is selected
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());                 // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
  }
//+------------------------------------------------------------------+
