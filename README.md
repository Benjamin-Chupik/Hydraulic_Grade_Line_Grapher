# Hydraulic_Grade_Line_Grapher
For EWB. Graph hydraulic grade lines for a number of paths from a csv

Discription:

This is the MATLAB code used to create hydraulic grade lines.

This code needs a csv file of data to construct the hydraulic grade line. The csv shall be formatted as follows:  Index,	Track Name,	Latitude,	Longitude,	Elevation,	Meters from Last Node, others after wont affect code. 

The code creates a hydraulic grade line sketch for each path with a new name in the list. It sorts the data by row name to make sure they are together.

The output of the code is  a graph for each path that is displayed in a figure as well as if line ~(68) is uncommented, a .eps for each figure named (*PathName*_HydraulicGradeLine). 
Each figure has the hydraulic grade line as well as every node circled. The code to change this or the graphs looks is around line 59.


The csv is an example that sould make the code run as is. Change the file name on line 19.
