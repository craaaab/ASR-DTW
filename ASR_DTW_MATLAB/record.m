
fs = 8000;
instruction = ('�����ҵƹ����ҵƿ������ƹس����ƿ������ƹؿ�����');
disp('����¼�Ʋο�ģ������,������׼����')
i=audiorecorder(fs,16,1);
help vad
help mfcc
clc
for i = 1 : 6
   	fprintf('��˵��"%s%s%s%s"����', instruction(i*4-3),instruction(i*4-2),...
        instruction(i*4-1),instruction(i*4));
	voice = audiorecorder(fs,16,1);
    recordblocking(voice, 5);
    fprintf('���ڼ���%d�Ĳ�������',i-1)
	x = getaudiodata(voice);
    x = x(: , 1);
    x = x';
	[x1 x2] = vad(x);
	m = mfcc(x);
	m = m(x1-2:x2-2,:);
	ref(i).mfcc = m;
    clear voice x x1 x2
    fprintf('������ɡ�\n')
end
clear i m x1 x2
save template.mat
clear