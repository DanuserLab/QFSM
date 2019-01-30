classdef NameableProcess < Process
    %NameableProcess A process whose name can be set
%
% Copyright (C) 2019, Danuser Lab - UTSouthwestern 
%
% This file is part of QFSM_Package.
% 
% QFSM_Package is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% QFSM_Package is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with QFSM_Package.  If not, see <http://www.gnu.org/licenses/>.
% 
% 
    
    properties (Access = protected)
    end
    
    methods
        function setName(obj,name)
            obj.name_ = name;
        end
        function name = getConcreteName(obj)
            if(isempty(obj) || isempty(obj.name_))
                name =  obj.getName();
                return;
            end
            name = obj.name_;
        end
    end
    
end
