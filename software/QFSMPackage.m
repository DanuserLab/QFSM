classdef QFSMPackage < Package
    % The main class of the QFSM package
    %
    % Sebastien Besson, 5/2011
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
    
    methods
        function obj = QFSMPackage(owner,varargin)
            % Constructor of class QFSMPackage
            
            if nargin == 0
                super_args = {};
            else
                % Check input
                ip =inputParser;
                ip.addRequired('owner',@(x) isa(x,'MovieObject'));
                ip.addOptional('outputDir',owner.outputDirectory_,@ischar);
                ip.parse(owner,varargin{:});
                outputDir = ip.Results.outputDir;
                
                super_args{1} = owner;
                super_args{2} = [outputDir  filesep 'QFSMPackage'];
            end
            
            % Call the superclass constructor
            obj = obj@Package(super_args{:});
        end

        function [status processExceptions] = sanityCheck(obj,varargin) 
            
            % Check that the channels have a value for the spsf sigma
            psfSigmaCheck =arrayfun(@(x) ~isempty(x.psfSigma_),obj.owner_.channels_);
            assert(any(psfSigmaCheck),...
                ['Missing standard deviation of the theoretical point-spread function! '...
                'Please fill the numerical aperture, pixel size and'...
                ' emission wavelengths of all channels!']);
            
            % Check that the time interval is correctly setup
            assert(~isempty(obj.owner_.timeInterval_),...
                'Missing frame rate! Please fill the time interval!');
            
            % Check that the camera bit depth is correctly setup
            assert(~isempty(obj.owner_.camBitdepth_),...
                'Missing camera bit depth! Please fill the camera bit depth!');

            % Input check
            nProc = length(obj.getProcessClassNames);
            ip = inputParser;
            ip.CaseSensitive = false;
            ip.addOptional('full',true, @(x) islogical(x));
            ip.addOptional('procID',1:nProc,@(x) all(ismember(x,1:nProc)) || strcmp(x,'all'));
            ip.parse(varargin{:});
            full = ip.Results.full;
            procID = ip.Results.procID;
            if strcmp(procID,'all'), procID = 1:nProc;end
            
            [status processExceptions] = sanityCheck@Package(obj,full,procID);
            
            if ~full, return; end
            
            validProc = procID(~cellfun(@isempty,obj.processes_(procID)));
            % Set the segProcessIndex of the mask refinement
            if ismember(3,validProc)
                if ~isempty(obj.processes_{2})
                    segPI = find(cellfun(@(x)isequal(x, obj.processes_{2}), obj.owner_.processes_));
                    if length(segPI) > 1
                        error('User-defined: More than one identical Threshold processes exists in movie data''s process list.')
                    end
                    funParams.SegProcessIndex = segPI;
                    parseProcessParams(obj.processes_{3},funParams);
                end
            end
        end

    end
    
    methods (Static)
        
        function m = getDependencyMatrix(i,j)
            
            %    1 2 3 4 5 6 7 8 
            m = [0 0 0 0 0 0 0 0;   %1 NoiseEstimationProcess
                 0 0 0 0 0 0 0 0;   %2 ThresholdProcess
                 0 1 0 0 0 0 0 0;   %3 MaskRefinementProcess
                 2 0 1 0 0 0 0 0;   %4 SpeckleDetectionProcess
                 0 0 1 1 0 0 0 0;   %5 FlowTrackingProcess
                 0 0 0 1 2 0 0 0;   %6 SpeckleTrackingProcess
                 2 0 1 1 0 1 0 0;   %7 KineticAnalysisProcess
                 0 0 1 1 2 2 0 0;]; %8 FlowAnalysisProcess
            if nargin<2, j=1:size(m,2); end
            if nargin<1, i=1:size(m,1); end
            m=m(i,j);
        end
        
        function name = getName()
            name = 'Quantitative Fluorescent Speckle Microscopy';
        end
        
        function varargout = GUI(varargin)
            % Start the package GUI
            varargout{1} = qfsmPackageGUI(varargin{:});
        end
        
        function funParams = getDefaultThresholdParams(owner,outputDir)
            funParams = ThresholdProcess.getDefaultParams(owner,outputDir);
            funParams.GaussFilterSigma = 1;
        end
        
        function funParams = getDefaultMaskRefinementParams(owner,outputDir)
            funParams = MaskRefinementProcess.getDefaultParams(owner,outputDir);
            funParams.ClosureRadius = 5;
        end
        
        function procConstr = getDefaultProcessConstructors(index)
            QFSMProcConstr = {
                @NoiseEstimationProcess,...
                @(x,y)ThresholdProcess(x,y,QFSMPackage.getDefaultThresholdParams(x,y)),...
                @(x,y)MaskRefinementProcess(x,y,QFSMPackage.getDefaultMaskRefinementParams(x,y)),... 
                @SpeckleDetectionProcess,...
                @FlowTrackingProcess,...
                @SpeckleTrackingProcess,...
                @KineticAnalysisProcess,...
                @FlowAnalysisProcess};
              
            if nargin==0, index=1:numel(QFSMProcConstr); end
            procConstr=QFSMProcConstr(index);
        end
        function classes = getProcessClassNames(index)
            QFSMClasses = {
                'NoiseEstimationProcess',...
                'ThresholdProcess',...
                'MaskRefinementProcess',...
                'SpeckleDetectionProcess',...
                'FlowTrackingProcess',...
                'SpeckleTrackingProcess',...
                'KineticAnalysisProcess',...
                'FlowAnalysisProcess'};         
            if nargin==0, index=1:numel(QFSMClasses); end
            classes=QFSMClasses(index);
        end
    end

    
end

