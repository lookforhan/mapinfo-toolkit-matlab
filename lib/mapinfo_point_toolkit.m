classdef mapinfo_point_toolkit < handle
    %mapinfo_point_toolkit ���������ɵ��mif��mid�ļ�
    %   �˴���ʾ��ϸ˵��
    
    properties % ��������
        mid_file
        mif_file
        out_dir = '.\output\'
    end
    properties % �������
        point_data % ����������� mid �ļ�,table��ʽ
        point_graph % ���ͼ������ mif �ļ���table��ʽ
        point_columns % ��������ݵ����ƺ����ͣ� mif �ļ�, table��ʽ
        mid_data_format % ��ĸ��������������
    end
    properties(Dependent) %
        mid_data
        mif_data
    end
    properties % Ĭ������
        symbol = 'Symbol (35,0,12)' % Symbol(shape,color,size)
    end
    
    methods
        function obj = mapinfo_point_toolkit
            disp('please input out_dir/mid_file/mif_file!')
            disp('please input point_data & point_graph!')
            disp('please input mid_data_format & point_columns!')
        end
    end
    methods % get ����
        function mid_data = get.mid_data(obj)
            mid_data = obj.point_data;
        end
        function mif_data = get.mif_data(obj)
            mif_data = obj.point_graph;
        end
    end
    methods % write ����
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

