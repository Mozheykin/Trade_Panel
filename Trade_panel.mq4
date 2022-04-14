//+------------------------------------------------------------------+
//|                                                  Trade_panel.mq4 |
//|                                                   Mozheikin Igor |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Mozheikin Igor"
#property link      ""
#property version   "1.00"
#property strict

    string Opisanie1="--------------Main window----------------";
    int x=0;
    int y=15;
    int width=170;
    int height=125;

    string Opisanie7="--------------Button SellBuy----------------";
    int x5=5;
    int y5=20;
    int width5=80;
    int height5=20;

    string Opisanie2="--------------Button Sell----------------";
    int x1=5;
    int y1=45;
    int width1=80;
    int height1=20;

    string Opisanie3="--------------Button Buy----------------";
    int x2=85;
    int y2=45;
    int width2=80;
    int height2=20;

    string Opisanie4="--------------Edit %----------------";
    int x3=5;
    int y3=70;
    int width3=160;
    int height3=20;

    extern string Opisanie8="--------------Reload Order----------------";
    extern int DayReload=10;
    int x7=85;
    int y7=20;
    int width7=80;
    int height7=20;

    string Opisanie5="--------------Alert----------------";
    int x4=5;
    int y4=95;
    int width4=80;
    int height4=20;

    string Opisanie11="--------------Visible Line----------------";
    int x11=85;
    int y11=95;
    int width11=80;
    int height11=20;

    extern string Opisanie6="--------------Alert----------------";
    extern bool SendAlert=true;
    extern bool SendAlertNotification=false;
    extern bool SendAlertMail=false;
    extern double MinLot=0.1;

    extern string Opisanie9="--------------ATR----------------";
    extern int ATRday=5;

    extern string Opisanie10="--------------Balans----------------";
    extern bool AutoBalans=false;
    extern double StartBalans=1000;

    double ATR;
    int ticket;
    double Lot;

int OnInit()
  {
    EventSetTimer(1);
    ResetLastError(); 

    if(!ObjectCreate(0,"Panel",OBJ_RECTANGLE_LABEL,0,0,0)) 
      { 
        Print("������ �������� �������: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"Panel",OBJPROP_XDISTANCE,x); 
    ObjectSetInteger(0,"Panel",OBJPROP_YDISTANCE,y); 
    ObjectSetInteger(0,"Panel",OBJPROP_XSIZE,width); 
    ObjectSetInteger(0,"Panel",OBJPROP_YSIZE,height);
    ResetLastError(); 


    if(!ObjectCreate(0,"SellBuy",OBJ_BUTTON,0,0,0)) 
      { 
        Print(__FUNCTION__, "������ �������� ������: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"SellBuy",OBJPROP_XDISTANCE,x5); 
    ObjectSetInteger(0,"SellBuy",OBJPROP_YDISTANCE,y5); 
    ObjectSetInteger(0,"SellBuy",OBJPROP_XSIZE,width5); 
    ObjectSetInteger(0,"SellBuy",OBJPROP_YSIZE,height5); 
    ObjectSetInteger(0,"SellBuy",OBJPROP_CORNER,CORNER_LEFT_UPPER); 
    ObjectSetString(0,"SellBuy",OBJPROP_TEXT,"Limit");
    ResetLastError(); 

    if(!ObjectCreate(0,"Reload",OBJ_EDIT,0,0,0)) 
      { 
        Print(__FUNCTION__, "������ �������� ���������� ����: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"Reload",OBJPROP_XDISTANCE,x7); 
    ObjectSetInteger(0,"Reload",OBJPROP_YDISTANCE,y7); 
    ObjectSetInteger(0,"Reload",OBJPROP_XSIZE,width7); 
    ObjectSetInteger(0,"Reload",OBJPROP_YSIZE,height7); 
    ObjectSetString(0,"Reload",OBJPROP_TEXT,"1");  
    ResetLastError(); 

    if(!ObjectCreate(0,"Sell",OBJ_BUTTON,0,0,0)) 
      { 
        Print(__FUNCTION__, "������ �������� ������: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"Sell",OBJPROP_XDISTANCE,x1); 
    ObjectSetInteger(0,"Sell",OBJPROP_YDISTANCE,y1); 
    ObjectSetInteger(0,"Sell",OBJPROP_XSIZE,width1); 
    ObjectSetInteger(0,"Sell",OBJPROP_YSIZE,height1); 
    ObjectSetInteger(0,"Sell",OBJPROP_CORNER,CORNER_LEFT_UPPER); 
    ObjectSetString(0,"Sell",OBJPROP_TEXT,"Sell"); 
    ResetLastError(); 

    if(!ObjectCreate(0,"Buy",OBJ_BUTTON,0,0,0)) 
      { 
        Print(__FUNCTION__, "������ �������� ������: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"Buy",OBJPROP_XDISTANCE,x2); 
    ObjectSetInteger(0,"Buy",OBJPROP_YDISTANCE,y2); 
    ObjectSetInteger(0,"Buy",OBJPROP_XSIZE,width2); 
    ObjectSetInteger(0,"Buy",OBJPROP_YSIZE,height2); 
    ObjectSetInteger(0,"Buy",OBJPROP_CORNER,CORNER_LEFT_UPPER); 
    ObjectSetString(0,"Buy",OBJPROP_TEXT,"Buy"); 
    ResetLastError(); 

    if(!ObjectCreate(0,"Edit",OBJ_EDIT,0,0,0)) 
      { 
        Print(__FUNCTION__, "������ �������� ���������� ����: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"Edit",OBJPROP_XDISTANCE,x3); 
    ObjectSetInteger(0,"Edit",OBJPROP_YDISTANCE,y3); 
    ObjectSetInteger(0,"Edit",OBJPROP_XSIZE,width3); 
    ObjectSetInteger(0,"Edit",OBJPROP_YSIZE,height3); 
    ObjectSetString(0,"Edit",OBJPROP_TEXT,"1"); 
    ResetLastError();
  
    if(!ObjectCreate(0,"Alert",OBJ_BUTTON,0,0,0)) 
      { 
        Print(__FUNCTION__, "������ �������� ������: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"Alert",OBJPROP_XDISTANCE,x4); 
    ObjectSetInteger(0,"Alert",OBJPROP_YDISTANCE,y4); 
    ObjectSetInteger(0,"Alert",OBJPROP_XSIZE,width4); 
    ObjectSetInteger(0,"Alert",OBJPROP_YSIZE,height4); 
    ObjectSetInteger(0,"Alert",OBJPROP_CORNER,CORNER_LEFT_UPPER); 
    ObjectSetString(0,"Alert",OBJPROP_TEXT,"Alert"); 
  
    ResetLastError();
    
    if(!ObjectCreate(0,"Visible",OBJ_BUTTON,0,0,0)) 
      { 
        Print(__FUNCTION__, "������ �������� ������: code #",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"Visible",OBJPROP_XDISTANCE,x11); 
    ObjectSetInteger(0,"Visible",OBJPROP_YDISTANCE,y11); 
    ObjectSetInteger(0,"Visible",OBJPROP_XSIZE,width11); 
    ObjectSetInteger(0,"Visible",OBJPROP_YSIZE,height11); 
    ObjectSetInteger(0,"Visible",OBJPROP_CORNER,CORNER_LEFT_UPPER); 
    ObjectSetInteger(0,"Visible",OBJPROP_STATE,true);
    ObjectSetString(0,"Visible",OBJPROP_TEXT,"Visible"); 
  
    ResetLastError(); 
    if(!ObjectCreate(0,"ATR",OBJ_LABEL,0,0,0)) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� ��������� �����! ��� ������ = ",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"ATR",OBJPROP_FONTSIZE,7);  
    ObjectSetInteger(0,"ATR",OBJPROP_XDISTANCE,5); 
    ObjectSetInteger(0,"ATR",OBJPROP_YDISTANCE,120); 
    ObjectSetString(0,"ATR",OBJPROP_TEXT,"ATR = ");
    ObjectSetInteger(0,"ATR",OBJPROP_SELECTABLE,false); 
    ObjectSetInteger(0,"ATR",OBJPROP_SELECTED,false); 

    ResetLastError(); 
    if(!ObjectCreate(0,"SLLine",OBJ_HLINE,0,0,Bid-30*Point)) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� �������������� �����! ��� ������ = ",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"SLLine",OBJPROP_COLOR,clrRed); 
    ObjectSetInteger(0,"SLLine",OBJPROP_STYLE,STYLE_DASH); 
    ObjectSetInteger(0,"SLLine",OBJPROP_WIDTH,1); 

    ResetLastError(); 
    if(!ObjectCreate(0,"TPLine",OBJ_HLINE,0,0,Ask+30*Point)) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� �������������� �����! ��� ������ = ",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"TPLine",OBJPROP_COLOR,clrBlue); 
    ObjectSetInteger(0,"TPLine",OBJPROP_STYLE,STYLE_DASH); 
    ObjectSetInteger(0,"TPLine",OBJPROP_WIDTH,1); 
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"ORDLine",OBJ_HLINE,0,0,(Ask+Bid)/2)) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� �������������� �����! ��� ������ = ",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"ORDLine",OBJPROP_COLOR,clrGreen); 
    ObjectSetInteger(0,"ORDLine",OBJPROP_STYLE,STYLE_DASH); 
    ObjectSetInteger(0,"ORDLine",OBJPROP_WIDTH,1); 
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"SL%",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("SLLine",OBJPROP_PRICE1)+5*Point,Digits))) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"SL%",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
    ObjectSetInteger(0,"SL%",OBJPROP_SELECTABLE,false); 
    ObjectSetInteger(0,"SL%",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"SL%",OBJPROP_COLOR,clrBlack); 
    ObjectSetString(0,"SL%",OBJPROP_TEXT,ObjectGetString(0,"Edit",OBJPROP_TEXT)+" %"+ " | "+ DoubleToStr(AccountBalance()*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))/100,2)+" $");
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"LT%",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1)+5*Point,Digits))) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"LT%",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
    ObjectSetInteger(0,"LT%",OBJPROP_SELECTABLE,false); 
    ObjectSetInteger(0,"LT%",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"LT%",OBJPROP_COLOR,clrBlack); 
    ObjectSetString(0,"LT%",OBJPROP_TEXT,"���: ");
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"TP%",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("TPLine",OBJPROP_PRICE1)+5*Point,Digits))) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
        return(false); 
      } 
    ObjectSetInteger(0,"TP%",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
    ObjectSetInteger(0,"TP%",OBJPROP_SELECTABLE,false); 
    ObjectSetInteger(0,"TP%",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"TP%",OBJPROP_COLOR,clrBlack); 
    if (ObjectGet("SLLine",OBJPROP_PRICE1)<ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
    if (ObjectGet("SLLine",OBJPROP_PRICE1)>ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
    
    return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
    ObjectDelete("Panel");
    ObjectDelete("SellBuy");
    ObjectDelete("Reload");
    ObjectDelete("Sell");
    ObjectDelete("Buy");
    ObjectDelete("Edit");
    ObjectDelete("Alert");
    ObjectDelete("Visible");
    ObjectDelete("ATR");
    ObjectDelete("SLLine");
    ObjectDelete("TPLine");
    ObjectDelete("ORDLine");
    ObjectDelete("SL%");
    ObjectDelete("TP%");
    ObjectDelete("LT%");
    EventKillTimer();
    Comment("");
  }

double OnTester()
  {

    double ret=0.0;
    if (ObjectGet("SellBuy",OBJPROP_STATE)==false){
    ObjectMove(0,"ORDLine",0,0,(Ask+Bid)/2);
          }
      if (AutoBalans)    
      Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*AccountBalance())/100)/((ObjectGet("ORDLine",OBJPROP_PRICE1)+10*Point-ObjectGet("SLLine",OBJPROP_PRICE1))/Point);
      if (AutoBalans==false)
      Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*StartBalans)/100)/(OrdLot()/Point);
      
    if (Lot<MinLot) { Lot=MinLot;Comment(Lot);  }
    
    ObjectMove(0,"LT%",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1)+15*Point,Digits));
    ObjectSetString(0,"LT%",OBJPROP_TEXT,"���: "+DoubleToStr(Lot,2) );
    
    ObjectMove(0,"SL%",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("SLLine",OBJPROP_PRICE1)+15*Point,Digits));
    ObjectSetString(0,"SL%",OBJPROP_TEXT,ObjectGetString(0,"Edit",OBJPROP_TEXT)+" %"+ " | "+ DoubleToStr(AccountBalance()*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))/100,2)+" $");
    ObjectMove(0,"TP%",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("TPLine",OBJPROP_PRICE1)+15*Point,Digits)); 
    if (ObjectGet("SLLine",OBJPROP_PRICE1)<ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
    if (ObjectGet("SLLine",OBJPROP_PRICE1)>ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
  
    ATR=iATR(NULL,PERIOD_D1,ATRday,0);
    ObjectSetString(0,"ATR",OBJPROP_TEXT,"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,Digits),2) + " % | "+DoubleToStr(ATR/Point,1)+" �� | "+DoubleToStr((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))/Point,2)+" ��");
    
    OrdersLabel();
    return(ret);
  }


void OnTimer()
{
  if (ObjectGet("SellBuy",OBJPROP_STATE)==false){
    ObjectMove(0,"ORDLine",0,0,(Ask+Bid)/2);
          }
          
      if (AutoBalans)    
      Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*AccountBalance())/100)/((ObjectGet("ORDLine",OBJPROP_PRICE1)+10*Point-ObjectGet("SLLine",OBJPROP_PRICE1))/Point);
      if (AutoBalans==false)
      Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*StartBalans)/100)/((ObjectGet("ORDLine",OBJPROP_PRICE1)+10*Point-ObjectGet("SLLine",OBJPROP_PRICE1))/Point);   
      if (Lot<MinLot) { Lot=MinLot;  }
    
    ObjectMove(0,"LT%",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1)+15*Point,Digits));
    ObjectSetString(0,"LT%",OBJPROP_TEXT,"���: "+DoubleToStr(Lot,2) );
        
    ObjectMove(0,"SL%",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("SLLine",OBJPROP_PRICE1)+15*Point,Digits));
    ObjectSetString(0,"SL%",OBJPROP_TEXT,ObjectGetString(0,"Edit",OBJPROP_TEXT)+" %"+ " | "+ DoubleToStr(AccountBalance()*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))/100,2)+" $");
    
    ObjectMove(0,"TP%",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("TPLine",OBJPROP_PRICE1)+15*Point,Digits)); 
    if (ObjectGet("SLLine",OBJPROP_PRICE1)<ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
    if (ObjectGet("SLLine",OBJPROP_PRICE1)>ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
  
    ATR=iATR(NULL,PERIOD_D1,ATRday,0);
    ObjectSetString(0,"ATR",OBJPROP_TEXT,"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,Digits),2) + " % | "+DoubleToStr(ATR/Point,1)+" �� | "+DoubleToStr((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))/Point,2)+" ��");
    
    if (ObjectGetInteger(0,"Visible",OBJPROP_STATE)){
    
    ResetLastError(); 
    if(!ObjectCreate(0,"SLLine",OBJ_HLINE,0,0,Bid-30*Point)) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� �������������� �����! ��� ������ = ",GetLastError()); 
      
      } 
    ObjectSetInteger(0,"SLLine",OBJPROP_COLOR,clrRed); 
    ObjectSetInteger(0,"SLLine",OBJPROP_STYLE,STYLE_DASH); 
    ObjectSetInteger(0,"SLLine",OBJPROP_WIDTH,1); 

    ResetLastError(); 
    if(!ObjectCreate(0,"TPLine",OBJ_HLINE,0,0,Ask+30*Point)) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� �������������� �����! ��� ������ = ",GetLastError()); 
        
      } 
    ObjectSetInteger(0,"TPLine",OBJPROP_COLOR,clrBlue); 
    ObjectSetInteger(0,"TPLine",OBJPROP_STYLE,STYLE_DASH); 
    ObjectSetInteger(0,"TPLine",OBJPROP_WIDTH,1); 
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"ORDLine",OBJ_HLINE,0,0,(Ask+Bid)/2)) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� �������������� �����! ��� ������ = ",GetLastError()); 
        
      } 
    ObjectSetInteger(0,"ORDLine",OBJPROP_COLOR,clrGreen); 
    ObjectSetInteger(0,"ORDLine",OBJPROP_STYLE,STYLE_DASH); 
    ObjectSetInteger(0,"ORDLine",OBJPROP_WIDTH,1); 
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"SL%",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("SLLine",OBJPROP_PRICE1)+5*Point,Digits))) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
      
      } 
    ObjectSetInteger(0,"SL%",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
    ObjectSetInteger(0,"SL%",OBJPROP_SELECTABLE,false); 
    ObjectSetInteger(0,"SL%",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"SL%",OBJPROP_COLOR,clrBlack); 
    ObjectSetString(0,"SL%",OBJPROP_TEXT,ObjectGetString(0,"Edit",OBJPROP_TEXT)+" %"+ " | "+ DoubleToStr(AccountBalance()*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))/100,2)+" $");
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"LT%",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1)+5*Point,Digits))) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
        
      } 
    ObjectSetInteger(0,"LT%",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
    ObjectSetInteger(0,"LT%",OBJPROP_SELECTABLE,false); 
    ObjectSetInteger(0,"LT%",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"LT%",OBJPROP_COLOR,clrBlack); 
    ObjectSetString(0,"LT%",OBJPROP_TEXT,"���: ");
    
    ResetLastError(); 
    
    if(!ObjectCreate(0,"TP%",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(ObjectGet("TPLine",OBJPROP_PRICE1)+5*Point,Digits))) 
      { 
        Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
        
      } 
    ObjectSetInteger(0,"TP%",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
    ObjectSetInteger(0,"TP%",OBJPROP_SELECTABLE,false); 
    ObjectSetInteger(0,"TP%",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"TP%",OBJPROP_COLOR,clrBlack); 
    if (ObjectGet("SLLine",OBJPROP_PRICE1)<ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("TPLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("SLLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
    if (ObjectGet("SLLine",OBJPROP_PRICE1)>ObjectGet("ORDLine",OBJPROP_PRICE1))ObjectSetString(0,"TP%",OBJPROP_TEXT,DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1)),Digits),2)+" % | "+DoubleToStr(NormalizeDouble(((ObjectGet("ORDLine",OBJPROP_PRICE1)-ObjectGet("TPLine",OBJPROP_PRICE1))*StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT)))/(ObjectGet("SLLine",OBJPROP_PRICE1)-ObjectGet("ORDLine",OBJPROP_PRICE1))*AccountBalance()/100,Digits),2)+" $");
    
    
    }
    
    if (ObjectGetInteger(0,"Visible",OBJPROP_STATE)==false){
    ObjectDelete("SLLine");
    ObjectDelete("TPLine");
    ObjectDelete("ORDLine");
    ObjectDelete("SL%");
    ObjectDelete("TP%");
    ObjectDelete("LT%");
    }
    
    OrdersLabel();
}

void OnTick()
  {
 
    OnTester(); 
    Reload();
    if (ObjectGet("Alert",OBJPROP_STATE)) {
        for (int i=ObjectsTotal();i>=0;i--)      
            if (ObjectGet(ObjectName(i),OBJPROP_ARROWCODE)==6)  
            if (ObjectGet(ObjectName(i),OBJPROP_COLOR)==clrRed)
              if (ObjectGet(ObjectName(i),OBJPROP_PRICE1)<Bid) {if (SendAlert) Alert("������: "+Symbol()+" ������� �������: "+DoubleToStr(ObjectGet(ObjectName(i),OBJPROP_PRICE1)));
              if (SendAlertNotification) Alert("������: "+Symbol()+" ������� �������: "+DoubleToStr(ObjectGet(ObjectName(i),OBJPROP_PRICE1)));
              if (SendAlertMail) Alert("������: "+Symbol()+" ������� �������: "+DoubleToStr(ObjectGet(ObjectName(i),OBJPROP_PRICE1)));
                ObjectSet(ObjectName(i),OBJPROP_COLOR,clrBlue);ObjectSet(ObjectName(i),OBJPROP_TYPE,OBJ_ARROW_LEFT_PRICE);}
                
      for (int i=ObjectsTotal();i>=0;i--)
            if (ObjectGet(ObjectName(i),OBJPROP_ARROWCODE)==5)
            if (ObjectGet(ObjectName(i),OBJPROP_COLOR)==clrRed)
              if (ObjectGet(ObjectName(i),OBJPROP_PRICE1)>Ask) {if (SendAlert) Alert("������: "+Symbol()+" ������� �������: "+DoubleToStr(ObjectGet(ObjectName(i),OBJPROP_PRICE1)));
              if (SendAlertNotification) Alert("������: "+Symbol()+" ������� �������: "+DoubleToStr(ObjectGet(ObjectName(i),OBJPROP_PRICE1)));
              if (SendAlertMail) Alert("������: "+Symbol()+" ������� �������: "+DoubleToStr(ObjectGet(ObjectName(i),OBJPROP_PRICE1)));
                ObjectSet(ObjectName(i),OBJPROP_COLOR,clrBlue);ObjectSet(ObjectName(i),OBJPROP_TYPE,OBJ_ARROW_RIGHT_PRICE);
                }
    }
    
    if (ObjectGet("Sell",OBJPROP_STATE)) 
      if (ObjectGet("SLLine",OBJPROP_PRICE1)>ObjectGet("ORDLine",OBJPROP_PRICE1)){
        if (AutoBalans)    
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*AccountBalance())/100)/(OrdLot()/Point);
        if (AutoBalans==false)
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*StartBalans)/100)/(OrdLot()/Point);
        
        if (Lot<MinLot) { Lot=MinLot;}
        
        if (ObjectGet("SellBuy",OBJPROP_STATE))
          if (ObjectGet("ORDLine",OBJPROP_PRICE1)>Ask) {
        ticket=OrderSend(Symbol(),OP_SELLLIMIT,Lot,NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1),Digits),3,ObjectGet("SLLine",OBJPROP_PRICE1),ObjectGet("TPLine",OBJPROP_PRICE1),"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,2)) + " %",5555,0,clrRed);
            if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError()); }
        if (ObjectGet("SellBuy",OBJPROP_STATE))                
          if (ObjectGet("ORDLine",OBJPROP_PRICE1)<Bid) {
        ticket=OrderSend(Symbol(),OP_SELLSTOP,Lot,NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1),Digits),3,ObjectGet("SLLine",OBJPROP_PRICE1),ObjectGet("TPLine",OBJPROP_PRICE1),"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,2)) + " %",5555,0,clrRed);
            if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}
        
          if (ObjectGet("SellBuy",OBJPROP_STATE)==false){
          if (AutoBalans)    
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*AccountBalance())/100)/(OrdLot()/Point);
        if (AutoBalans==false)
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*StartBalans)/100)/(OrdLot()/Point);
        if (Lot<MinLot) {Comment("Lot "+DoubleToString(Lot)+" ---> 0.1"); Lot=MinLot;}
          ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,3,ObjectGet("SLLine",OBJPROP_PRICE1),ObjectGet("TPLine",OBJPROP_PRICE1),"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,2)) + " %",5555,0,clrRed);
            if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}   
            
              
            
        ObjectSet("Sell",OBJPROP_STATE,false);
        }
    
    if (ObjectGet("Buy",OBJPROP_STATE)) 
      if (ObjectGet("SLLine",OBJPROP_PRICE1)<ObjectGet("ORDLine",OBJPROP_PRICE1)){
        if (AutoBalans)    
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*AccountBalance())/100)/(OrdLot()/Point);
        if (AutoBalans==false)
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*StartBalans)/100)/(OrdLot()/Point);
        if (Lot<MinLot) { Lot=MinLot;} 
        
        if (ObjectGet("SellBuy",OBJPROP_STATE))
        if (ObjectGet("ORDLine",OBJPROP_PRICE1)<Bid){
        ticket=OrderSend(Symbol(),OP_BUYLIMIT,Lot,NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1),Digits),3,ObjectGet("SLLine",OBJPROP_PRICE1),ObjectGet("TPLine",OBJPROP_PRICE1),"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,2)) + " %",5555,0,clrBlue);
            if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());} 
        if (ObjectGet("SellBuy",OBJPROP_STATE))                
        if (ObjectGet("ORDLine",OBJPROP_PRICE1)>Ask){
        ticket=OrderSend(Symbol(),OP_BUYSTOP,Lot,NormalizeDouble(ObjectGet("ORDLine",OBJPROP_PRICE1),Digits),3,ObjectGet("SLLine",OBJPROP_PRICE1),ObjectGet("TPLine",OBJPROP_PRICE1),"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,2)) + " %",5555,0,clrBlue);
            if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}
            
        if (ObjectGet("SellBuy",OBJPROP_STATE)==false){
          if (AutoBalans)    
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*AccountBalance())/100)/(OrdLot()/Point);
        if (AutoBalans==false)
          Lot=((StrToDouble(ObjectGetString(0,"Edit",OBJPROP_TEXT))*StartBalans)/100)/(OrdLot()/Point);
        if (Lot<MinLot) { Lot=MinLot;} 
          if (Lot<MinLot) {Comment("Lot "+DoubleToString(Lot)+" ---> 0.1"); Lot=MinLot;}
          ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,3,ObjectGet("SLLine",OBJPROP_PRICE1),ObjectGet("TPLine",OBJPROP_PRICE1),"ATR = "+DoubleToStr(NormalizeDouble((iHigh(Symbol(),PERIOD_D1,0)-iLow(Symbol(),PERIOD_D1,0))*100/ATR,2)) + " %",5555,0,clrBlue);
            if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}    
              
        ObjectSet("Buy",OBJPROP_STATE,false);
        }
        
    }
  
int OrdersLabel()
{
    
       for (int i=0;i<OrdersTotal();i++)
        if (OrderSelect(i,SELECT_BY_POS)){
        
          
          
          if (ObjectFind(IntegerToString(OrderTicket())+"T")==-1){
               // TP
               ResetLastError(); 
               
               if(!ObjectCreate(0,IntegerToString(OrderTicket())+"T",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(OrderTakeProfit()+5*Point,Digits))) 
                             { 
                                Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
                              } 
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"T",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"T",OBJPROP_SELECTABLE,false); 
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"T",OBJPROP_SELECTED,false);
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"T",OBJPROP_COLOR,clrRed); 
               double OrderProfitTP= (OrderTakeProfit()-OrderOpenPrice())/Point;
               if (OrderProfitTP<0) OrderProfitTP=OrderProfitTP*(-1);
               ObjectSetString(0,IntegerToString(OrderTicket())+"T",OBJPROP_TEXT,DoubleToStr(OrderProfitTP*OrderLots()*100/AccountBalance(),2)+" %"+ " | "+ DoubleToStr(OrderProfitTP*OrderLots()-OrderCommission(),2) +" $");
               
               // SL
               ResetLastError(); 
               if(!ObjectCreate(0,IntegerToString(OrderTicket())+"S",OBJ_TEXT,0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(OrderStopLoss()+5*Point,Digits))) 
                             { 
                                Print(__FUNCTION__, ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError()); 
                              } 
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"S",OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"S",OBJPROP_SELECTABLE,false); 
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"S",OBJPROP_SELECTED,false);
               ObjectSetInteger(0,IntegerToString(OrderTicket())+"S",OBJPROP_COLOR,clrRed); 
               double OrderProfitSL= (OrderStopLoss()-OrderOpenPrice())/Point;
               if (OrderProfitSL<0) OrderProfitSL=OrderProfitSL*(-1);
               ObjectSetString(0,IntegerToString(OrderTicket())+"S",OBJPROP_TEXT,DoubleToStr(OrderProfitSL*OrderLots()*100/AccountBalance(),2)+" %"+ " | -"+ DoubleToStr(OrderProfitSL*OrderLots()-OrderCommission(),2) +" $");
          }
          
          if (ObjectFind(IntegerToString(OrderTicket())+"T")==0) {
                 ObjectMove(0,IntegerToString(OrderTicket())+"T",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(OrderTakeProfit()+5*Point,Digits));
                 double OrderProfitTP= (OrderTakeProfit()-OrderOpenPrice())/Point;
                 if (OrderProfitTP<0) OrderProfitTP=OrderProfitTP*(-1);
                 ObjectSetString(0,IntegerToString(OrderTicket())+"T",OBJPROP_TEXT,DoubleToStr(OrderProfitTP*OrderLots()*100/AccountBalance(),2)+" %"+ " | "+ DoubleToStr(OrderProfitTP*OrderLots()-OrderCommission(),2) +" $");

                 ObjectMove(0,IntegerToString(OrderTicket())+"S",0,TimeCurrent()+Time[0]-Time[3],NormalizeDouble(OrderStopLoss()+5*Point,Digits));
                 double OrderProfitSL= (OrderStopLoss()-OrderOpenPrice())/Point;
                 if (OrderProfitSL<0) OrderProfitSL=OrderProfitSL*(-1);
                 ObjectSetString(0,IntegerToString(OrderTicket())+"S",OBJPROP_TEXT,DoubleToStr(OrderProfitSL*OrderLots()*100/AccountBalance(),2)+" %"+ " | -"+ DoubleToStr(OrderProfitSL*OrderLots()-OrderCommission(),2) +" $");
          
          }
          }
          
           for (int i=0;i<OrdersHistoryTotal();i++)
           
               if (OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
                     if (ObjectFind(IntegerToString(OrderTicket())+"T")==0){
                       ObjectDelete(IntegerToString(OrderTicket())+"S");
                       ObjectDelete(IntegerToString(OrderTicket())+"T");     
                        }

 return(0);
}

int Reload()
{
  
  for (int i=OrdersHistoryTotal()+1;i>=0;i--)
     if (OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
       if ((OrderType()==OP_BUY)||(OrderType()==OP_SELL))
         if (OrderSymbol()==Symbol())
         if (OrderProfit()<0)
         if (OrderOpenTime()>TimeCurrent()-86400*DayReload)
         { 
         
         int OrderTicketSelect=OrderTicket();double SelectPrice=OrderOpenPrice();int OrderTypeSelect=OrderType(); int OpenSelectPrice=0; datetime OrderNoSelect= OrderOpenTime();
         for (int a=0;a<OrdersHistoryTotal()+1;a++)
             if (OrderSelect(a,SELECT_BY_POS,MODE_HISTORY))
               if (OrderOpenPrice()==SelectPrice)
                if (OrderSymbol()==Symbol())
                 if (OrderOpenTime()!=OrderNoSelect)
                   OpenSelectPrice++;
                   
         for (int a=0;a<OrdersTotal()+1;a++)
             if (OrderSelect(a,SELECT_BY_POS))
               if (OrderOpenPrice()==SelectPrice)
                if (OrderSymbol()==Symbol())
                 if (OrderOpenTime()!=OrderNoSelect)
                   OpenSelectPrice=100;;
        
        
         if (StrToInteger(ObjectGetString(0,"Reload",OBJPROP_TEXT))>OpenSelectPrice) 
            if (OrderSelect(OrderTicketSelect,SELECT_BY_TICKET,MODE_HISTORY))  {
            if (OrderType()==OP_BUY) 
              if (OrderSerch()==0){
              if (OrderOpenPrice()>Ask){ ticket=OrderSend(Symbol(),OP_BUYSTOP,OrderLots(),OrderOpenPrice(),3,OrderStopLoss(),OrderTakeProfit(),"Reload",5555,0,clrGold); if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}
              if (OrderOpenPrice()<Bid){ ticket=OrderSend(Symbol(),OP_BUYLIMIT,OrderLots(),OrderOpenPrice(),3,OrderStopLoss(),OrderTakeProfit(),"Reload",5555,0,clrGold); if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}}
             
            if (OrderType()==OP_SELL) 
            if (OrderSerch()==0) {
              if (OrderOpenPrice()>Ask) {ticket=OrderSend(Symbol(),OP_SELLLIMIT,OrderLots(),OrderOpenPrice(),3,OrderStopLoss(),OrderTakeProfit(),"Reload",5555,0,clrGold); if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}
              if (OrderOpenPrice()<Bid){ ticket=OrderSend(Symbol(),OP_SELLSTOP,OrderLots(),OrderOpenPrice(),3,OrderStopLoss(),OrderTakeProfit(),"Reload",5555,0,clrGold); if(ticket<0) Print("OrderSend ����������� � ������� #",GetLastError());}}
                 
               }
               }
  return(0);
}

int OrderSerch()
{
 for (int i=0;i<OrdersTotal();i++)
    if (OrderSelect(i,SELECT_BY_POS))
      if (OrderSymbol()==Symbol())return(1);
 return(0);
}

double OrdLot()
{
 if (ObjectGet("ORDLine",OBJPROP_PRICE1)>ObjectGet("SLLine",OBJPROP_PRICE1)) return (ObjectGet("ORDLine",OBJPROP_PRICE1)+10*Point-ObjectGet("SLLine",OBJPROP_PRICE1));
 if (ObjectGet("ORDLine",OBJPROP_PRICE1)<ObjectGet("SLLine",OBJPROP_PRICE1)) return (-ObjectGet("ORDLine",OBJPROP_PRICE1)-10*Point+ObjectGet("SLLine",OBJPROP_PRICE1));
 return(0);
}