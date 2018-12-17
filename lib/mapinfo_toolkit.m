classdef mapinfo_toolkit < handle
    %mapinfo_toolkit mapinfo的工具
    %   将matlab的数据，在mapinfo的mif和mid文件中输出
    
    properties % 基本属性
        mid_file = '.\mapinfo_toolkit_out\output.MID'
        mif_file = '.\mapinfo_toolkit_out\output.MIF'
        out_dir = '.\mapinfo_toolkit_out'
    end

    properties % 
        point_data
    end

    properties % 
        pline_data
    end
    properties
        mid_data
        mif_data
    end
    methods
        function obj = mapinfo_toolkit
            if ~isdir(obj.out_dir)
                mkdir(obj.out_dir);
            end
        end
        function Run_point(obj,point_data,mid,mif)
            disp('please updata mid_file,mif_filee');
            disp('请更新属性：mid_file,mif_file!');
            obj.mid_file = mid;
            obj.mif_file = mif;
            obj.point_data.properties = point_data{2};
            obj.point_data.graph = point_data{2}
            obj.Write_mid;
            obj.Write_mif;
        end
        function Run_pline(obj,pline_data,mid,mif)
            disp('please updata mid_file,mif_filee');
            disp('请更新属性：mid_file,mif_file!');
            obj.mid_file = mid;
            obj.mif_file = mif;
            obj.pline_data.properties = pline_data{1};
            obj.pline_data.graph = pline_data{2};
            obj.Write_mid;
            obj.Write_mif;
        end
        function Write_mid(obj)
            fid = fopen(obj.mid_file,'w');

        end
        function Write_mif(obj)
        end
    end
    
end

