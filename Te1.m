%作为主函数，其他的函数加上function
clear;close all;clc;
dirpath = '111.png';
img=imread(dirpath);
s = rgb2gray(img);
s  = s>128;
imshow(s);
[m n]=size(s);
tmp=zeros(m,n,3);%标记图像
label=[rand(255),rand(255),rand(255)];
queue_head=1;%队列头
queue_tail=1;%队列尾
neighbour=[-1 -1;
    -1 0;
    -1 1;
    0 -1;
    0 1;
    1 -1;
    1 0;
    1 1];  %和当前像素坐标相加得到八个邻域坐标

for i=2:m-1
    for j=2:n-1
        
        if s(i,j)==1 && tmp(i,j) ==0           
            tmp(i,j,1)=label(1);
            tmp(i,j,2)=label(2);
            tmp(i,j,3)=label(3);
            q{queue_tail}=[i j];%存储元素的队列，当前坐标入列
            queue_tail=queue_tail+1;
            
            while queue_head~=queue_tail
                pix=q{queue_head};                
                for k=1:8%8邻域搜索
                    pix1=pix+neighbour(k,:);
                        if pix1(1)>=2 && pix1(1)<=m-1 && pix1(2) >=2 &&pix1(2)<=n-1
                        if s(pix1(1),pix1(2)) == 1 && tmp(pix1(1),pix1(2)) ==0  %如果当前像素邻域像素为1并且标记图像的这个邻域像素没有被标记，那么标记
                            tmp(pix1(1),pix1(2),1)=label(1);
                            tmp(pix1(1),pix1(2),2)=label(2);
                            tmp(pix1(1),pix1(2),3)=label(3);
                            q{queue_tail}=[pix1(1) pix1(2)];
                            queue_tail=queue_tail+1;
                        end  
                     end              
                end
                queue_head=queue_head+1;
            end
            
            clear q;%清空队列，为新的标记做准备
            label=[rand(255),rand(255),rand(255)];
            queue_head=1;
            queue_tail=1;            
        end
    
    end
end
figure,imshow(mat2gray(tmp));