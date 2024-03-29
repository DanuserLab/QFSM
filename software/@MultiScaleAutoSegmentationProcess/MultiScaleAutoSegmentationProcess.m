classdef MultiScaleAutoSegmentationProcess < SegmentationProcess
    % A concrete process multi-scale automatic segmentation
    % Segment a single cell image by combining segmentations.
    % see multiScaleAutoSeg.m
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
    
    % Andrew R. Jamieson - Sep 2017
    
    methods
        function obj = MultiScaleAutoSegmentationProcess(owner,varargin)
            
            if nargin == 0
                super_args = {};
            else
                % Input check
                ip = inputParser;
                ip.addRequired('owner',@(x) isa(x,'MovieData'));
                ip.addOptional('outputDir',owner.outputDirectory_,@ischar);
                ip.addOptional('funParams',[],@isstruct);
                ip.parse(owner,varargin{:});
                outputDir = ip.Results.outputDir;
                funParams = ip.Results.funParams;
                
                % Define arguments for superclass constructor
                super_args{1} = owner;
                super_args{2} = MultiScaleAutoSegmentationProcess.getName;
                super_args{3} = @multiScaleAutoSeg;
                if isempty(funParams)
                    funParams=MultiScaleAutoSegmentationProcess.getDefaultParams(owner,outputDir);
                end
                super_args{4} = funParams;
            end
            
            obj = obj@SegmentationProcess(super_args{:});
        end
        
    end
    methods (Static)
        function name = getName()
            name = 'MSA Segmentation';
        end
        function h = GUI()
            h= @msaSegmentationProcessGUI;
        end
        
        function funParams = getDefaultParams(owner,varargin)
            % Input check
            ip=inputParser;
            ip.addRequired('owner', @(x) isa(x,'MovieData'));
            ip.addOptional('outputDir', owner.outputDirectory_, @ischar);
            ip.parse(owner, varargin{:})
            outputDir = ip.Results.outputDir;
            
            % Set default parameters
            funParams.ChannelIndex = 1:numel(owner.channels_);
            funParams.OutputDirectory = [outputDir  filesep 'MultiScaleAutoSeg_Masks'];
            funParams.ProcessIndex = []; %Default is to use raw images
            funParams.tightness = .5; 
            funParams.type = 'middle';
            funParams.diagnostics = false;

            %% extra parameters?
            % sigmas = [0 0.66 1 1.66 2.5 4];  % unit: pixel (common scales for xxx by xxx size confocal images)
            % p.MinimumSize = 100;        
            % p.ObjectNumber = 1;
            % p.FillHoles = 1;
        end
    end
end