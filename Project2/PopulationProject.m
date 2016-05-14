%{
Program Description: Create a table using the population formula, create 
a graph with the formula going from 1790 to 2000, one going far into the 
future to steady state, and then create a graph that has the actual data 
as well as the formula data from 1790 to 2010.
Author: Runner15
Assisted By: No one
%}
%{
Create array(s) with values from 1790 to 2150 counting by 10
Input actual population
Calculate projected population with formula
Initialize figure window
Subplot in the first quadrant
	Plot population formula every 10 years from 1790 to 2000
	Add labels and axis
Subplot in the second quadrant
	Plot population formula from 1790 to 2150
	Add labels and axis
Subplot in the second quadrant
	Plot population formula from 1790 to 2010
    Plot actual population from 1790 to 2010
	Add labels and axis
%}
%% Initialize Variables
clear; clc
%3 different time periods for the 3 graphs
t = 1790:10:2000;
t1 = 1790:10:2010;
t2 = 1790:10:2150;
%Actual Pop, typed in
actualPop=[3929214,5308483,7239881,9638453,12866020,17069453,23191876, ...
    31443321,38558371,50189209,62979766,76094000,92407000, ...
    106461000,123076741,132122446,152271417,180671158,205052174, ...
    227224681,249438712,282171957,310232863];
%% Calculate Projected Population
%3 different population formulas for the 3 different graph times
popForm = (197273000)./(1+exp(-.03134*(t-1913.25)));
popForm1 = (197273000)./(1+exp(-.03134*(t1-1913.25)));
popFormFuture = (197273000)./(1+exp(-.03134*(t2-1913.25)));
%% Create Graphs
%Create figure window
figure
%% Graph 1, Pop Formula 1790-2000
subplot(2,2,1) %Where in figure window to draw graph
plot(t,popForm) %x vs y graph
axis([1780 2010 0 inf]) %axis, set x, set min y, let max y be default
title('Past Projections'),xlabel('Year'),ylabel('Population')
%% Graph 2, Pop Formula 1790-2150
subplot(2,2,2)
plot(t2,popFormFuture)
axis([1780 2160 0 inf])
title('Future Projections'),xlabel('Year'),ylabel('Population')
%% Graph 3, Pop Formula and Pop Actual 1790-2010
subplot(2,2,3)
plot(t1,popForm1)
hold % Stops the plotting so you can plot 2 things
scatter(t1,actualPop) %Plot dots, not line
axis([1780 2020 0 inf])
title('Actual vs Projection'),xlabel('Year'),ylabel('Population')