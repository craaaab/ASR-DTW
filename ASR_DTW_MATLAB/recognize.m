load template.mat
a = arduino();
for j = 1 : 1
    fs = 8000;
    disp('�뷢��һ�����');
    x = audiorecorder(fs, 16, 1);
    recordblocking(x, 5);
    x = getaudiodata(x);
    x = x(: , 1);
    x = x';
    [x1 x2] = vad(x);
    m = mfcc(x);
    m = m(x1-2:x2-2,:);
    xparameter = m;
    disp('¼������');
    disp('���ڽ���ģ��ƥ��...');
    dist = zeros(1,6);
    for j = 1 : 6
    dist(1,j) = dtw(xparameter, ref(j).mfcc);
    end
    
    disp('���ڼ���ƥ����...')

    [d,j] = min(dist(1,:));

    fprintf('���������ʶ����Ϊ��%s%s%s%s\n',instruction(4 * j - 3),...
    instruction(4 * j - 2), instruction(4 * j - 1), instruction(4 * j));

if j == 1
    writeDigitalPin(a, 'D10', 1);
elseif j == 2
    writeDigitalPin(a, 'D10', 0);
elseif j == 3
    writeDigitalPin(a, 'D4', 1);
elseif j == 4
    writeDigitalPin(a, 'D4', 0);
elseif j == 5
    writeDigitalPin(a, 'D6', 1);
else 
    writeDigitalPin(a, 'D6', 0);
end

    fprintf('�����ѷ���\n');
    
end