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
        end
    end
    methods % get ����
        function mid_data = get.mid_data(obj)
            mid_data = obj.point_data;
        end
        function mif_data = get.mif_data(obj)
        end
    end
    methods % write ����
        function Write_mid(obj)
            mid_data_cell = table2cell(obj.mid_data);
            num_point = numel(mid_data_cell(:,1));
            fid_mid = fopen([obj.out_dir,obj.mid_file],'w');
            for i = 1: num_point
                fprintf(fid_mid,'"%s",%f,%f,"%s"\r\n',mid_data_cell{i,1},mid_data_cell{i,2},mid_data_cell{i,3},mid_data_cell{i,4});
            end
            fclose(fid_mid);
        end
        function Write_mif(obj)
            fid_mif = fopen([obj.out_dir,obj.mif_file],'w'); 

            fclose(fid_mif);
        end
    end
end

