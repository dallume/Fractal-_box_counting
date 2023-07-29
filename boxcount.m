function C= boxcount(S,dim)

    d=abs(S.BoundingBox(2,1)-S.BoundingBox(1,1));
    h=abs(S.BoundingBox(2,2)-S.BoundingBox(1,2));
    g=max(d,h);
    l=g/dim;
    format long e;
    
    if g==h %mod(h,l)==0
        m=dim;
        %n=ceil(d/l);
    else
        %n=dim;
        m=ceil(h/l);
    end
    
    lenv=length(S.X);
    S.X=S.X-S.BoundingBox(1,1);
    S.Y=S.Y-S.BoundingBox(1,2);
    q=1;
    C=0;
    
    while q<=lenv-1
        
        if S.X(q)==S.X(q) && S.X(q+1)==S.X(q+1)
            
            xf=S.X(q-1);
            yf=S.Y(q-1);
            xp=S.X(q);
            yp=S.Y(q);
            xs=S.X(q+1);
            ys=S.Y(q+1);
            n=(ys-yp)/(xs-xp);
            r=yp-n*xp;
            o=m-ceil(yf/l)+1;
            p=ceil(xf/l);
            i=m-ceil(yp/l)+1;
            j=ceil(xp/l);
            u=m-ceil(ys/l)+1;
            v=ceil(xs/l);
            C=C+abs(u-i)+abs(v-j);
            
            if yp/l==ceil(yp/l)
                
                if (p-j)*(v-j)>0
                    C=C-1;
                end
                
            elseif xp/l==ceil(xp/l)
                
                if (o-i)*(u-i)>0
                    C=C-1;
                end
                
            end
            
            if i~=u && j~=v
                if i<u
                    while i<u
                        yv=n*i*l+r;
                        if mod(yv,l)==0
                            C=C-1;
                        end
                        i=i+1;
                    end
                else
                    while i>=u
                        yv=n*i*l+r;
                        if mod(yv,l)==0
                            C=C-1;
                        end
                        i=i-1;
                    end
                end
            end
            
        end
       q=q+1; 
    end
end