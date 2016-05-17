%{
Program Purpose: Take the Gross Pay and empoyee pay information to compute
deductions and net pay. Create Paycheck file with deductions, netpay, and
gross pay to date.
Edited By: runner15
%}
%% Initialize Values
clear, clc

% Payroll format:
% Pay Period(1-52), Employee ID, Pay Frequency (1 is weekly, 2 is biweekly),
% Married? (0 no, 1 yes), Gross Pay, Gross Pay to Date
load('Payroll.mat');
%Federal Tax Format: Gross Pay at least, Base Tax, Additional Tax Rate
load('FedTax.mat');
%NY State Tax Format: Gross pay to Date at least, Tax Rate
load('NYTax.mat');

FICA=.062; %Current Social Security Tax Rate
Medicare=.0145; %Current Medicare Taxe Rate

[records, fields]=size(Payroll); %Determine number of Payroll records
PayCheckInfo(records,9)=0;

%% Determine Net Pay
%this loop runs one by one through all employee records
for i=1:records
   %Initialixe values used inside for loop used for readability only
   PayPeriod=Payroll(i,1);
   EmpID=Payroll(i,2);
   PayF=Payroll(i,3);
   Married=Payroll(i,4);
   GrossPay=Payroll(i,5);
   GrossPayTD=Payroll(i,6);
   
   FICAD=GrossPay*FICA;
   MedicareD=GrossPay*Medicare;
   
   %Determine NY State Tax 
   StateTax=NYTax(1,2)*GrossPay.*(GrossPayTD<=NYTax(1,1));
   StateTax=StateTax+NYTax(2,2)*GrossPay.*(GrossPayTD>NYTax(1,1) & GrossPayTD<=NYTax(2,1));
   StateTax=StateTax+NYTax(3,2)*GrossPay.*(GrossPayTD>NYTax(2,1) & GrossPayTD<=NYTax(3,1));
   StateTax=StateTax+NYTax(4,2)*GrossPay.*(GrossPayTD>NYTax(3,1) & GrossPayTD<=NYTax(4,1));
   StateTax=StateTax+NYTax(5,2)*GrossPay.*(GrossPayTD>NYTax(4,1));
   
   FederalTax = fedtax(FedTax,PayF,Married,GrossPay);
     
   %prepare output to PayCheckInfo
   GrossPayTD=GrossPayTD+GrossPay;
   TotalDeductions=FederalTax+StateTax+FICAD+MedicareD;
   NetPay=GrossPay-TotalDeductions;
   PayCheckInfo(i,1)=PayPeriod;
   PayCheckInfo(i,2)=EmpID;
   PayCheckInfo(i,3)=GrossPay;
   PayCheckInfo(i,4)=GrossPayTD;
   PayCheckInfo(i,5)=FederalTax;
   PayCheckInfo(i,6)=StateTax;
   PayCheckInfo(i,7)=FICAD;
   PayCheckInfo(i,8)=MedicareD;
   PayCheckInfo(i,9)=NetPay;
end