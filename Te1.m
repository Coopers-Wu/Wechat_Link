%��Ϊ�������������ĺ�������function
clear;close all;clc;
dirpath = '111.png';
img=imread(dirpath);
s = rgb2gray(img);
s  = s>128;
imshow(s);
[m n]=size(s);
tmp=zeros(m,n,3);%���ͼ��
label=[rand(255),rand(255),rand(255)];
queue_head=1;%����ͷ
queue_tail=1;%����β
neighbour=[-1 -1;
    -1 0;
    -1 1;
    0 -1;
    0 1;
    1 -1;
    1 0;
    1 1];  %�͵�ǰ����������ӵõ��˸���������

for i=2:m-1
    for j=2:n-1
        
        if s(i,j)==1 && tmp(i,j) ==0           
            tmp(i,j,1)=label(1);
            tmp(i,j,2)=label(2);
            tmp(i,j,3)=label(3);
            q{queue_tail}=[i j];%�洢Ԫ�صĶ��У���ǰ��������
            queue_tail=queue_tail+1;
            
            while queue_head~=queue_tail
                pix=q{queue_head};                
                for k=1:8%8��������
                    pix1=pix+neighbour(k,:);
                        if pix1(1)>=2 && pix1(1)<=m-1 && pix1(2) >=2 &&pix1(2)<=n-1
                        if s(pix1(1),pix1(2)) == 1 && tmp(pix1(1),pix1(2)) ==0  %�����ǰ������������Ϊ1���ұ��ͼ��������������û�б���ǣ���ô���
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
            
            clear q;%��ն��У�Ϊ�µı����׼��
            label=[rand(255),rand(255),rand(255)];
            queue_head=1;
            queue_tail=1;            
        end
    
    end
end
figure,imshow(mat2gray(tmp));