
function [resu,v,ai,bi,ci,di,Range_Input,Range_Output] = FNN_To_Equation(net)
% using a standard FNN with the Levenberg-Marquardt backpropagation algorithm
% 2 neurons in the input layer & one output neuron

%Get all parameters needed for the equation
IW = net.IW{1,1} ; 
b1 = net.b{1};
b2 = net.b{2};
LW = net.LW{2,1};
InputsParam=net.inputs{1};
PS_Input=InputsParam.processSettings{1,1};
Range_Input=net.inputs{1}.range;
 % | h | g |
 % | l | k |
 % e = 1, f = -1;
OutputParam = net.outputs{2};
 % | o (x_min) | n (x_max) |
 % m= -1 (y_min), p=1 (y_max) 
PS_Output = OutputParam.processSettings{1,1};
Range_Output=net.outputs{2}.range;
v = num2str(b2);
%Construction of the equation
%All equation coefficient are  : 
% v ai(i=1..39) bi(i=1..39) ci(i=1..39) di(i=1..39) 
% e f g h k l m n o p 

resu = ['OUTPUT = (v'] ; ai=''; bi=''; ci=''; di='';

for i=1:size(IW,1)
 resu = [resu,' + a',num2str(i),' * tansig(b',num2str(i),' * ( (e-f)*(INPUT1-h)/(g-h) + f) + c',num2str(i),' * ( (e-f)*(INPUT2-l)/(k-l) + f) + d',num2str(i),')']; 
   ai = [ai,'a',num2str(i),'=',num2str(LW(i)),'; '];
   bi = [bi,'b',num2str(i),'=',num2str(IW(i,1)),'; '];
   ci = [ci,'c',num2str(i),'=',num2str(IW(i,2)),'; '];
   di = [di,'d',num2str(i),'=',num2str(b1(i)),'; '];
end
resu = [resu,' - m)*(n-o)/(p-m) + o'];

end