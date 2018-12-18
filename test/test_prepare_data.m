% test_prepare_data.m
clear;clc;close all;tic;
lib_name = 'EPANETx64PDD';
h_name = 'toolkit.h';
net_file = '..\materials\MOD.inp';
% process_1 load function lib
loadlibrary(['..\materials\',lib_name],['..\materials\',h_name]);
try 
    load EPA_F
catch
    path('..\lib',path);
    path('..\lib\readNet',path);%
    load  EPA_F
end
% process_2 read data from file
[t2_1,net_data] = read_net2_EPANETx64PDD(net_file,EPA_format);% from 'readNet\'
if t2_1
    keyboard
else
end
% process_3 output point data
junction_id = net_data{2,2}(:,1);
reservoirs_id = net_data{3,2}(:,1);
% tank_id = net_data{4,2}(:,1);
all_node_id = net_data{23,2}(:,1);
node_num = numel(all_node_id);
node_class = cell(node_num,1);
junction_loc = ismember(all_node_id,junction_id);
reservoirs_loc = ismember(all_node_id,reservoirs_id);
% tank_loc = ismember(tank_id,all_node_id);
node_class(junction_loc,1) = {'junction'};
node_class(reservoirs_loc,1) = {'reservoirs'};
% node_class(tank_loc,1) = {'tank'};
% node_data = [net_data{23,2},node_class];
node_data = [net_data{23,2}(:,1),num2cell(cell2mat(net_data{23,2}(:,2))/100000),num2cell(cell2mat(net_data{23,2}(:,3))/100000),node_class];
node_data_table = cell2table(node_data,'VariableNames',{'Id','x','y','type'});
node_data_graph = cell2table(node_data(:,1:3),'VariableNames',{'Id','x','y'});
point = mapinfo_point_toolkit;
point.out_dir = '.\output\'
%mkdir(point.out_dir);
point.mid_file = 'point.MID';
point.mif_file = 'point.MIF';
point.point_data = node_data_table;
point.point_graph = node_data_graph;
point.mid_data_format = '"%s",%f,%f,"%s"';
columns_name = {'Id','x','y','type'}';
columns_class = {'Char(10)';'Float';'Float';'Char(10)'};
point.point_columns = cell2table([columns_name,columns_class],'VariableNames',{'name','class'});
point.Write_mif;
point.Write_mid;
%
pipe_data = net_data{5,2};
p_columns_name = {'Id';'N1';'N2';'Lenght';'Diameter';'Roughness';'MinorLoss';'Status'};
p_columns_type = {'char(40)';'char(40)';'char(40)';'float';'float';'float';'float';'char(40)'};
pipe_data_table = cell2table(pipe_data,'VariableNames',p_columns_name');
pipeline = mapinfo_pline_toolkit;
pipeline.out_dir = '.\output\';
pipeline.mid_file = 'pipe.MID';
pipeline.mif_file = 'pipe.MIF';
pipeline.pline_data = pipe_data_table;
pipeline.mid_data_format = '"%s","%s","%s",%f,%f,%f,%f,"%s"';
pipeline.pline_columns = cell2table([p_columns_name,p_columns_type],'VariableNames',{'name','class'});
pipeline.Write_mid;
N1_id = net_data{5,2}(:,2);
N2_id = net_data{5,2}(:,3);
[~,N1_loc] = ismember(N1_id,net_data{23,2}(:,1));
[~,N2_loc] = ismember(N2_id,net_data{23,2}(:,1));
N1_x = num2cell(cell2mat(net_data{23,2}(N1_loc,2))/100000);
N2_x = num2cell(cell2mat(net_data{23,2}(N2_loc,2))/100000);
N1_y = num2cell(cell2mat(net_data{23,2}(N1_loc,3))/100000);
N2_y = num2cell(cell2mat(net_data{23,2}(N2_loc,3))/100000);
x = cell(numel(N1_x),1);
y = cell(numel(N1_x),1);
for i = 1:numel(N1_x)
    x{i,1}{1,1} = N1_x{i};
    x{i,1}{2,1} = N2_x{i};
    y{i,1}{1,1} = N1_y{i};
    y{i,1}{2,1} = N2_y{i};
end
pipeline.pline_graph = cell2table([x,y],'VariableNames',{'x','y'});
pipeline.Write_mif;

