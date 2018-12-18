classdef mapinfo_pline_toolkit < handle
    %mapinfo_pline_toolkit ��������������mif��mid�ļ�
    %   �˴���ʾ��ϸ˵��
    
    properties
    end
    
    methods
    end
    
    properties % ��������
        mid_file
        mif_file
        out_dir = '.\output\'
    end
    properties % �ߵ�����
        pline_data % �ߵ��������� mid �ļ�,table��ʽ
        pline_graph % �ߵ�ͼ������ mif �ļ���table��ʽ
        pline_columns % �߸������ݵ����ƺ����ͣ� mif �ļ�, table��ʽ
        mid_data_format % �ߵĸ��������������
    end
    properties(Dependent) %PEN(width,pattern,color)
        mid_data
        mif_data
    end
    properties % Ĭ������
        symbol = 'Pen (1,0,2)' % Pen(width,pattern,color)
    end
    
    methods
        function obj = mapinfo_pline_toolkit
            disp('please input out_dir/mid_file/mif_file!')
            disp('please input pline_data & point_graph!')
            disp('please input mid_data_format & pline_columns!')
        end
    end
    methods % get ����
        function mid_data = get.mid_data(obj)
            mid_data = obj.pline_data;
        end
        function mif_data = get.mif_data(obj)
            mif_data = obj.pline_graph;
        end
    end
    methods % write ����
        function Write_mid(obj)
            mid_data_cell = table2cell(obj.mid_data);
            num_pline = numel(mid_data_cell(:,1));
            fid_mid = fopen([obj.out_dir,obj.mid_file],'w');
            for i = 1: num_pline
                fprintf(fid_mid,[obj.mid_data_format,'\r\n'],mid_data_cell{i,:});
            end
            fclose(fid_mid);
        end
        function Write_mif(obj)
            n_columns = numel(obj.pline_columns(:,1));
            n_pline = numel(obj.mif_data(:,1));
            fid_mif = fopen([obj.out_dir,obj.mif_file],'w'); 
            fprintf(fid_mif,'Version 300\r\n');
            fprintf(fid_mif,'Charset "WindowsSimpChinese"\r\n');
            fprintf(fid_mif,'Delimiter ","\r\n');
            fprintf(fid_mif,'CoordSys Earth Projection 1, 0\r\n');
            fprintf(fid_mif,'Columns %d\r\n',n_columns);
            for i = 1:n_columns
                fprintf(fid_mif,'  %s %s\r\n',obj.pline_columns.name{i,1},obj.pline_columns.class{i,1});
            end
            fprintf(fid_mif,'Data\r\n\r\n');
            for j = 1:n_pline
                fprintf(fid_mif,'Pline %d\r\n',numel(obj.mif_data.x{j,1}));
                for k = 1:numel(obj.mif_data.x{j,1})
                    fprintf(fid_mif,'%f %f\r\n',obj.mif_data.x{j,1}{k,1},obj.mif_data.y{j,1}{k,1});
                end
                    fprintf(fid_mif,'    %s\r\n',obj.symbol);
            end



            fclose(fid_mif);
        end
    end
end

