function c_return = c_bar(Y, Phi)
% c_return This function receives a vector, Y, where Y = [y_1, y_2,...,y_n],
% which is the outputs of a collection of 'n' functions. This function also
% receives a matrix, Phi, which is a collection of inputs. A function, y_i
% has the form, y = c1x1 + c2x2 + ... + cmxm. Given these inputs, this
% function estimates the parameters, C.

c_return = inv((Phi')*Phi)*(Phi')*Y;

end