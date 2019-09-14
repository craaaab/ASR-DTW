function [x1,x2] = vad(x)

%���ȹ�һ��
x = double(x);
x = x / max(abs(x));

%��������
FrameLen = 240;
FrameInc = 80;

amp1 = 10;
amp2 = 2;
zrc1 = 10;
zrc2 = 5;

maxsilence = 8; % 3*10ms = 30ms
minlen = 15; % 15*10ms = 150ms
status = 0;
count = 0;
silence = 0;

%�����ʼ���
tmp1 = enframe(x(1 : length(x) - 1), FrameLen, FrameInc);
tmp2 = enframe(x(2 : length(x)), FrameLen, FrameInc);
signs = (tmp1 .* tmp2) < 0;
diffs = (tmp1 - tmp2) > 0.02;
zrc = sum(signs .* diffs, 2);

%��ʱ��������
amp = sum(abs(enframe(filter([1 - 0.9375], 1, x), FrameLen, FrameInc)), 2);

%������������
amp1 = min(amp1, max(amp) / 4);
amp2 = min(amp2, max(amp) / 8);

%�˵���
x1 = 0;
x2 = 0;
for n = 1 : length(zrc)
    goto = 0;
    switch status
        case {0, 1}          % 0 = ������ 1 = ���ܿ�ʼ
            if amp(n) > amp1       %ȷ�Ž���������
                x1 = max(n - count - 1, 1);
                status = 2;
                silence = 0;
                count = count + 1;
            elseif amp(n) > amp2 || zrc(n) > zrc2    %���ܴ���������
                    status = 1;
                    count = count + 1;
            else status = 0;
                count = 0;
            end
        case 2,
            if amp(n) > amp2 || zrc(n) > zrc2   %������������
                count = count + 1;
            else 
                silence = silence + 1;
                if silence < maxsilence   %������������δ����
                    count = count + 1;
                elseif count < minlen     %����̫�̣���������
                    status = 0;
                    silence = 0;
                    count = 0;
                else 
                    status = 3;           %��������
                end
            end
        case 3,
            break;
    end
end

count = count - silence / 2;
x2 = x1 + count - 1;

subplot(311)
plot(x)
axis([1, length(x) -1 1])
ylabel('Speech')
line([x1 * FrameInc x1 * FrameInc], [-1 1], 'Color', 'red');
line([x2 * FrameInc x2 * FrameInc], [-1 1], 'Color', 'red');

subplot(312)
plot(amp);
axis([1 length(amp) 0 max(amp)])
ylabel('Energy');
line([x1 x1], [min(amp), max(amp)], 'Color', 'red');
line([x2 x2], [min(amp), max(amp)], 'Color', 'red');

subplot(313)
plot(zrc);
axis([1 length(zrc) 0 max(zrc)])
ylabel('ZRC');
line([x1 x1], [min(zrc), max(zrc)], 'Color', 'red');
line([x2 x2], [min(zrc), max(zrc)], 'Color', 'red');
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                
                    
                











