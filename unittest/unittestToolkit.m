classdef unittestToolkit < matlab.unittest.TestCase
    %unittestToolkit 单元测试文件
    %   测试mapinfo_toolkit.m

    properties
        obj_greedy_isolation % 
    end
    methods(Test)% 
        function test_break_pipe_id_num(testCase)
            testCase.verifyEqual(testCase.obj_greedy_isolation.n_break_pipe,5);
            testCase.verifyEqual(roundn(testCase.obj_greedy_isolation.current_system_serviceablity,-4),0.4376);
        end
        function test_input(testCase)
            testCase.verifyTrue(testCase.obj_greedy_isolation.input_check.break_pipe_id_with_pipe_relative);
            testCase.verifyTrue(testCase.obj_greedy_isolation.input_check.pipe_relative_with_pipe_id);

        end
    end
    methods(TestClassSetup) % 
        function creatGreedyIsolation(testCase)
            load('test_greedy_data');
            isolation_time_mat = ones(sum(damage_pipe_info{3}==2),1)*0.5;
            break_pipe_id = damage_pipe_info{5}(damage_pipe_info{3}==2,1);
           testCase.obj_greedy_isolation = greedy_pipe_isolation_priority(temp_inp_file,net_data,break_pipe_id,isolation_time_mat,pipe_relative); 
        end
    end
    methods(TestClassTeardown) % 
    end
    methods(TestMethodSetup) % 

    end
    methods(TestMethodTeardown) % 
    end
end

