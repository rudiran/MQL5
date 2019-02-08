
// Direction:

//+------------------------------------------------------------------+
//| From Zero to the Last bar:
//+------------------------------------------------------------------+
int OnCalculate (const int rates_total,      // size of input time series
                 const int prev_calculated,  // bars handled in previous call
                 const datetime& time[],     // Time
                 const double& open[],       // Open
                 const double& high[],       // High
                 const double& low[],        // Low
                 const double& close[],      // Close
                 const long& tick_volume[],  // Tick Volume
                 const long& volume[],       // Real Volume
                 const int &spread[])        // Spread

  {
   //---- check for possible errors
   if(prev_calculated<0) return(-1);
   //---- the last counted bar will be recounted, the oldest bar will never be counted because of close[i+1]
   int limit=rates_total-prev_calculated+prev_calculated<1?-1:1;
   for(int i=0; i<limit; i++)    // Zero to last bar data
   {
        buffer[i] = close[i];     // Current data or start from "0"
        buffer2[i] = close[i+1];  // Previous data or 1 day ago
   }
   return(rates_total);
  }
  
//+------------------------------------------------------------------+
//| From the Last bar to Zero:
//+------------------------------------------------------------------+
int OnCalculate (const int rates_total,      // size of input time series
                 const int prev_calculated,  // bars handled in previous call
                 const datetime& time[],     // Time
                 const double& open[],       // Open
                 const double& high[],       // High
                 const double& low[],        // Low
                 const double& close[],      // Close
                 const long& tick_volume[],  // Tick Volume
                 const long& volume[],       // Real Volume
                 const int &spread[])        // Spread

  {
   //---- check for possible errors
   if(prev_calculated<0) return(-1);
   //---- the last counted bar will be recounted, the oldest bar will never be counted because of close[i+1]
   int limit=rates_total-prev_calculated-prev_calculated<1?2:0;
   for(int i=limit; i>-1; i--)    // From the last bar to Zero
   {
        buffer[i] = close[i];     // Current data or start from "0"
        buffer2[i] = close[i+1];  // Previous data or 1 day ago
   }
   return(rates_total);
  }
