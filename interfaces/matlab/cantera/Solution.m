classdef Solution < ThermoPhase

    methods
        function obj = Solution4(xml,state)
            %This constructor function constructs the xml_file and phase_node
            %required for everything...

            cantera_root = '//';
            if libisloaded('canteraLib')
                unloadlibrary('canteraLib');
            end
            [notfound, warnings] = loadlibrary([cantera_root '/lib/libcantera_shared.dylib'],...
                'include/cantera/clib/ctmatlab.h', ...
                'includepath',[cantera_root '/include'], 'addheader', 'clib_defs',...
                'addheader','ct',...
                'addheader','ctfunc','addheader','ctmultiphase',...
                'addheader','ctonedim','addheader','ctreactor', ...
                'addheader','ctrpath','addheader','ctsurf','addheader','ctxml',...
                'alias','canteraLib');
            %Using the loaded library, the integer storage locations of xml_file and
            %phase_node are generated and then passed into the SuperClass
            %constructors
            xml_file = calllib('canteraLib','xml_get_XML_File',xml, 0);
            phase_node = calllib('canteraLib','xml_findID',xml_file, state);

            obj = obj@ThermoPhase(xml_file, phase_node);
        end
    end
end
