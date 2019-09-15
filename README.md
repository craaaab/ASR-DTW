# ASR-DTW
ASR based on DTW and MATLAB(Arduino used)

文件说明：  
scm.m ---------------Arduino测试文件  
record.m-------------录音文件  
recognition.m--------模式匹配与识别  
stop.m---------------关闭单片机  
vad.m----------------语音端点检测，包含短时能量与过零率双门限检测  
dtw.m----------------DTW算法  
mfcc.m---------------提取MFCC系数与一阶差分参数  

环境说明：  
MATLAB R2019a Academic  
需要配置voicebox工具箱与MATLAB Arduino Support Package
