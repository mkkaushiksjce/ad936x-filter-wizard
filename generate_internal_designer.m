% Example generation of code for internal_filter_designer_cg.m

addpath(genpath('test')); % Grab helper functions to manage structs
a = load('ad9361_settings.mat');
inputVar = a.ad9361_settings.tx.LTE5;
% Fill out necessary fields
input = process_input(inputVar);
args = '{input.Rdata, input.Fpass, input.Fstop, input.caldiv, input.FIR, input.HB1, input.PLL_mult, input.Apass, input.Astop, input.phEQ, input.HB2, input.HB3, input.Type, input.RxTx, input.RFbw, input.DAC_div, input.converter_rate, input.PLL_rate, input.Fcenter, input.wnom, input.FIRdBmin, input.int_FIR}';
functionName = 'internal_design_filter_cg';

%% Generate code
% This will generate code in the codegen folder which can be compiled into 
% a dll/so/dylib with the necessary headers
cfg = coder.config('dll');
cfg.TargetLang = 'C';
cfg.FilePartitionMethod = 'SingleFile';
cfg.GenCodeOnly = true;
outputLIBName = 'libinternal_filter_designer';
result = codegen('-config','cfg',functionName,'-O ','disable:openmp','-args', args,'-o',outputLIBName);

