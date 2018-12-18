classdef mapinfo_point_toolkit < handle
    %mapinfo_point_toolkit 将数据生成点的mif和mid文件
    %   此处显示详细说明
    
    properties % 基本属性
        mid_file
        mif_file
        out_dir = '.\output\'
    end
    properties % 点的数据
        point_data % 点的属性数据 mid 文件,table格式
        point_graph % 点的图形数据 mif 文件，table格式
        point_columns % 点各列数据的名称和类型， mif 文件, table格式
        mid_data_format % 点的各列数据输出类型
    end
    properties(Dependent) %
        mid_data
        mif_data
    end
    properties % 默认属性
        symbol = 'Symbol (35,0,12)' % Symbol(shape,color,size)
    end
    
    methods
        function obj = mapinfo_point_toolkit
            disp('please input out_dir/mid_file/mif_file!')
            disp('please input point_data & point_graph!')
            disp('please input mid_data_format & point_columns!')
        end
    end
    methods % get 方法
        function mid_data = get.mid_data(obj)
            mid_data = obj.point_data;
        end
        function mif_data = get.mif_data(obj)
            mif_data = obj.point_graph;
        end
    end
    methods % write 方法
        function Write_mid(obj)
            mid_data_cell = table2cell(obj.mid_data);
            num_point = numel(mid_data_cell(:,1));
            fid_mid = fopen([obj.out_dir,obj.mid_file],'w');
            for i = 1: num_point
                fprintf(fid_mid,[obj.mid_data_format,'\r\n'],mid_data_cell{i,1},mid_data_cell{i,2},mid_data_cell{i,3},mid_data_cell{i,4});
            end
            fclose(fid_mid);
        end
        function Write_mif(obj)
            n_columns = numel(obj.point_columns(:,1));
            n_point = numel(obj.mif_data(:,1));
            fid_mif = fopen([obj.out_dir,obj.mif_file],'w'); 
            fprintf(fid_mif,'Version 300\r\n');
            fprintf(fid_mif,'Charset "WindowsSimpChinese"\r\n');
            fprintf(fid_mif,'Delimiter ","\r\n');
            fprintf(fid_mif,'CoordSys Earth Projection 1, 0\r\n');
            fprintf(fid_mif,'Columns %d\r\n',n_columns);
            for i = 1:n_columns
                fprintf(fid_mif,'  %s %s\r\n',obj.point_columns.name{i,1},obj.point_columns.class{i,1});
            end
            fprintf(fid_mif,'Data\r\n\r\n');
            for j = 1:n_point
                fprintf(fid_mif,'Point %f %f\r\n',obj.mif_data.x(j,1),obj.mif_data.y(j,1));
                fprintf(fid_mif,'    %s\r\n',obj.symbol);
            end



            fclose(fid_mif);
        end
    end
end

