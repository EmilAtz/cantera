classdef ThermoPhase
     properties (Access = protected)
         thermo
     end
     properties (Access = public)
         RP
         TP
         TV
         V
         R
         T
         P
     end
    methods %Constructor
        function obj = ThermoPhase(~ , phase_node)
            obj.thermo = calllib('canteraLib','thermo_newFromXML',phase_node);
        end
    end

    methods %Setting Methods
        function obj = set.RP(obj, valsin)
            rho = valsin{1};
            pres = valsin{2};
            if strcmp(rho,'None')
                rho = obj.R;
            end
            if strcmp(pres, 'None')
                pres = obj.P;
            end
            vals = [rho,pres];
            obj.RP = calllib('canteraLib', 'thermo_set_RP', obj.thermo, vals);
            obj.R = rho;
            obj.P = pres;
        end

        function obj = set.TV(obj, valsin)
            temp = valsin{1};
            vol = valsin{2};
            if strcmp(temp,'None')
                temp = obj.T;
            end
            if strcmp(vol, 'None')
                vol = obj.V;
            end
            vals = [temp,vol];
            obj.TV = calllib('canteraLib', 'thermo_set_TV', obj.thermo, vals);

        end

        function obj = set.TP(obj, valsin)
            temp = valsin{1};
            pres = valsin{2};
            if strcmp(temp,'None')
                temp = obj.T;
            end
            if strcmp(pres, 'None')
                pres = obj.P;
            end
            vals = [temp, pres];
            obj.TP = calllib('canteraLib','thermo_set_TP', obj.thermo, vals);
            obj.T = temp;
            obj.P = pres;
        end

        function obj = set.P(obj, pres)
            calllib('canteraLib','thermo_setPressure', obj.thermo, pres);
            obj.P = pres;
        end

        function obj = set.R(obj, rho)
            calllib('canteraLib', 'thermo_setDensity', obj.thermo, rho);
            obj.R = rho;
        end

    end

    methods %Getting Methods
        function T = get.T(obj)
            T = calllib('canteraLib','thermo_temperature', obj.thermo);
        end
        function P = get.P(obj)
            P = calllib('canteraLib','thermo_pressure', obj.thermo);
        end
        function R = get.R(obj)
            R = calllib('canteraLib','thermo_density', obj.thermo);
        end
%         function V = get.V(obj)
%             V = calllib('canteraLib', 'thermo_volume', obj.thermo);
%         end
    end
end
