function [ref]= reflectivity_modling(N, modle_name, trace)
    %N=1000;       Reflection coefficient sampling point
    % modle one : one_reflectivity
    if modle_name == 'one_ref'
        ref(N,1) = 0;
        ref(50,1) = 0.8;
    elseif modle_name == 'two_ref'
        ref(N,1) = 0;
        ref(50,1) = 0.8;
        ref(80,1) = -0.6;
    elseif modle_name == '500_ref'
        %Some parameter design
        num_ref=2;   %% Number of single model pulses
        num_refk=500;   %% Number of reflection coefficient models
        % reflectivity
        for k=1:num_refk
            reflect0=randi([8,12],1,2)/10 * randsrc; %% ????????
            for i=1:num_ref
                t(i)=randperm(N,1);
            end
            %%%%%%%%%%%%%%%%%%
            ref(t,k)=reflect0;
            ref(N,k)=0;
        end
    elseif modle_name == '1wedge1'
        %wedge model
        %trace = 30;
        ref = zeros(N,trace);
        ref(20,:)=0.3;
        for j=1:trace
            ref(20+round((j-1)*1),j)=0.3;
        end
    elseif modle_name == '1wedge2'
        %wedge model
       % trace = 30;
        ref = zeros(N,trace);
        ref(40,:)=0.3;
        for j=4:trace
            ref(40-3+round((j-1)*1),j)=0.3;
        end
    end
end