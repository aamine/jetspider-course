var obj = new Object();
function obj_m() { return 77; };
obj.m = obj_m;
p(obj.m());
