function A= coeffbin(X,xp,j,yp,i,xs,v,ys,u,l)

m=(ys-yp)/(xs-xp);
r=yp-m*xp;
k=0;
n=0;
format long e;

if m>0

    while (i+k>=u && j+n<=v)&&(~(i+k==u && j+n==v))

        xv=l*(j+n);
        yv=l*(size(X,1)-i-k+1);
        mv=((yv-yp)/(xv-xp));

        if m<mv
            n=n+1;
            X(i+k,j+n)=1;
            %xp=(j+n-1)*l;
            xp=xv;
            yp=m*xp+r;
        elseif m>mv
            k=k-1;
            X(i+k,j+n)=1;
            %yp=(size(X)-i-k+2)*l;
            yp=yv;
            xp=(yp-r)/m;
        else
            k=k-1;
            n=n+1;
            X(i+k,j+n)=1;
            xp=xv;
            yp=yv;
        end
    end

else
    while (i+k>=u && j+n>=v)&&(~(i+k==u && j+n==v))
        
        xv=l*(j+n-1);
        yv=l*(size(X,1)-i-k+1);
        mv=(yp-yv)/(xp-xv);

        if m>mv
            n=n-1;
            if j+n>0
                X(i+k,j+n)=1;
            end
            xp=xv;
            yp=m*xp+r;
        elseif m<mv
            k=k-1;
            X(i+k,j+n)=1;
            yp=yv;
            xp=(yp-r)/m;
        else
            k=k-1;
            n=n-1;
            X(i+k,j+n)=1;
            xp=xv;
            yp=yv;
        end
    end
end
A=X;
end
