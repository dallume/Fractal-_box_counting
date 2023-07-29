function X = gimbin3(S, dim)

    if dim~=fix(dim) || dim<=0
        disp('La dimensione della matrice non è intera positiva')
    elseif dim==1
        M=S.BoundingBox;
        E= S.X==S.X;
        P= S.Y==S.Y;
        if sum(E)==0 || sum(P)==0 || isempty(S.X) || isempty(S.Y)
            disp('La struttura non contiene forme')
        else
            X=1;
        end
    else   
        
        d=abs(S.BoundingBox(2,1)-S.BoundingBox(1,1));
        h=abs(S.BoundingBox(2,2)-S.BoundingBox(1,2));
        htot=1.8128*10^4;
        dtot=1.1719*10^4;
        g=max(dtot,htot);
        l=g/dim;
        format long e;

        m=dim;
        n=ceil(dtot*dim/g);

        X=zeros(m,n);
        q=1;
        lenv=length(S.X);
        
        S.X=S.X-S.BoundingBox(1,1)+(dtot-d)/2;
        S.Y=S.Y-S.BoundingBox(1,2)+(htot-h)/2;
        
        while q<=lenv-1

            if S.X(q)==S.X(q) && S.X(q+1)==S.X(q+1) && S.Y(q)==S.Y(q) && S.Y(q+1)==S.Y(q+1)
                
                xp=S.X(q);
                yp=S.Y(q);
                xs=S.X(q+1);
                ys=S.Y(q+1);
                
                if mod(yp,l)~=0
                    i=m-fix(yp*dim/g);
                    %i=m-ceil(yp*dim/g)+1;
                else
                    if yp<ys
                        i=m-fix(yp*dim/g);
                        %i=m-ceil(yp*dim/g);
                    elseif yp>ys
                        i=m-fix(yp*dim/g)+1;
                        %i=m-ceil(yp*dim/g)+1;
                    else 
                        i=m-fix(yp*dim/g);
                        u=i;
                    end
                end
                
                if mod(ys,l)~=0
                    u=m-fix(ys*dim/g);
                    %u=m-ceil(ys*dim/g)+1;
                else
                    if yp<ys
                        u=m-fix(ys*dim/g)+1;
                        %u=m-ceil(ys*dim/g)+1;
                    elseif yp>ys
                        u=m-fix(ys*dim/g);
                        %u=m-ceil(ys*dim/g);
                    end
                end
                
                if mod(xp,l)~=0
                    j=ceil(xp*dim/g);
                    %j=fix(xp*dim/g)+1;
                else
                    if xp<xs
                        j=ceil(xp*dim/g)+1;
                        %j=fix(xp*dim/g)+1;
                    elseif xp>xs
                        j=ceil(xp*dim/g);
                        %j=fix(xp*dim/g);
                    else
                        j=ceil(xp*dim/g);
                        v=j;
                    end
                end
                
                if mod(xs,l)~=0
                    v=ceil(xs*dim/g);
                    %v=fix(xs*dim/g)+1;
                else
                    if xp<xs
                        v=ceil(xs*dim/g);
                        %v=fix(xs*dim/g);
                    elseif xp>xs
                        v=ceil(xs*dim/g)+1;
                        %v=fix(xs*dim/g)+1;
                    end
                end
                
                if i==0
                    i=1;
                end
                
                if u==0
                    u=1;
                end
                
                if j==0
                    j=1;
                end
                
                if v==0
                    v=1;
                end
                
                X(i,j)=1;
                X(u,v)=1;

                if i==u && j==v
                    
                elseif i==u
                    if v>j
                        a=1;
                        while j+a<v
                            X(i,j+a)=1;
                            a=a+1;
                        end
                    else
                        b=-1;
                        while j+b>v
                            X(i,j+b)=1;
                            b=b-1;
                        end
                    end
                elseif j==v
                    if u>i
                        c=1;
                        while i+c<u
                            X(i+c,j)=1;
                            c=c+1;
                        end
                    else
                        d=-1;
                        while i+d>u
                            X(i+d,j)=1;
                            d=d-1;
                        end
                    end
                elseif i>u
                    X=interbin(X,xp,j,yp,i,xs,v,ys,u,l);
                elseif i<u
                    X=interbin(X,xs,v,ys,u,xp,j,yp,i,l);
                end
            end
        q=q+1;
        end
    end
end    