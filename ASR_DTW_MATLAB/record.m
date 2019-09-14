
fs = 8000;
instruction = ('开卧室灯关卧室灯开厨房灯关厨房灯开客厅灯关客厅灯');
disp('即将录制参考模板语音,请做好准备。')
i=audiorecorder(fs,16,1);
help vad
help mfcc
clc
for i = 1 : 6
   	fprintf('请说出"%s%s%s%s"……', instruction(i*4-3),instruction(i*4-2),...
        instruction(i*4-1),instruction(i*4));
	voice = audiorecorder(fs,16,1);
    recordblocking(voice, 5);
    fprintf('正在计算%d的参数……',i-1)
	x = getaudiodata(voice);
    x = x(: , 1);
    x = x';
	[x1 x2] = vad(x);
	m = mfcc(x);
	m = m(x1-2:x2-2,:);
	ref(i).mfcc = m;
    clear voice x x1 x2
    fprintf('计算完成。\n')
end
clear i m x1 x2
save template.mat
clear