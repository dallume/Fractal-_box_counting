function A= interbin(X,xp,j,yp,i,xs,v,ys,u,l)

m=(ys-yp)/(xs-xp);
r=yp-m*xp;
k=0;
n=0;
format long e;

if m>0

    while (i+k>=u && j+n<=v)&&(~(i+k==u && j+n==v))

        xn=l*(j+n);
        yn=m*xn+r;
        yk=l*(size(X,1)-i+1-k);
        xk=(yk-r)/m;
        dx=sqrt((yp-yn)^2+(xp-xn)^2);
        dy=sqrt((yp-yk)^2+(xp-xk)^2);

        if dx<dy
            %xx=1
            n=n+1;
            X(i+k,j+n)=1;
            xp=xn;
            yp=yn;
        elseif dy<dx
            %xx=2
            k=k-1;
            X(i+k,j+n)=1;
            xp=xk;
            yp=yk;
        else
            %xx=3
            k=k-1;
            n=n+1;
            X(i+k,j+n)=1;
            xp=xn;
            yp=yk;
        end
    end

else
    while (i+k>=u && j+n>=v)&&(~(i+k==u && j+n==v))

        xn=l*(j+n-1);
        yn=m*xn+r;
        yk=l*(size(X,1)-i-k+1);
        xk=(yk-r)/m;
        dx=sqrt((yp-yn)^2+(xp-xn)^2);
        dy=sqrt((yp-yk)^2+(xp-xk)^2);

        if dx<dy
            n=n-1;
            if j+n>0
                X(i+k,j+n)=1;
            end
            xp=xn;
            yp=yn;
        elseif dy<dx
            k=k-1;
            X(i+k,j+n)=1;
            xp=xk;
            yp=yk;
        else
            k=k-1;
            n=n-1;
            X(i+k,j+n)=1;
            xp=xn;
            yp=yk;
        end
    end
end
A=X;
end
