int EXPERT_MAGIC = 374634;   // MagicNumber of the expert
//+------------------------------------------------------------------+
//| Opening Sell position                                            |
//+------------------------------------------------------------------+
void Sell(string symbol,double lots)
  {
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =lots;                                  // volume 
   request.type     =ORDER_TYPE_SELL;                       // order type
   request.price    =SymbolInfoDouble(Symbol(),SYMBOL_BID); // price for opening
   request.deviation=5;                                     // allowed deviation from the price
   request.magic    =EXPERT_MAGIC;                          // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
  }
//+------------------------------------------------------------------+
