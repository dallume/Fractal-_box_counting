function X = gimbin(S, dim)

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
        g=max(d,h);
        l=g/dim;
        format long e;

        if g==h 
            m=dim+1;
            n=ceil(d/l)+1;
            %{
            m=dim;
            if d==0
                n=1;
            else
                n=ceil(d/l);
            end
            %}
        else
            n=dim+1;
            m=ceil(h/l)+1;
            %{
            n=dim;
            if h==0
                m=1;
            else
                m=ceil(h/l);
            end
            %}
        end

        X=zeros(m,n);
        q=1;
        lenv=length(S.X);
        
        Or=zeros(1,lenv);
        Ver=zeros(1,lenv);
        for k=1:lenv
            if S.X(k)==S.X(k) && S.Y(k)==S.Y(k)
                Or(k)=abs(ceil(S.X(k)/l)*l-S.X(k))/2;
                Ver(k)=abs(ceil(S.Y(k)/l)*l-S.Y(k))/2;
            end
        end
        M= Or~=0;
        N= Ver~=0;
        O=Or(M);
        V=Ver(N);
        if isempty(O)
            S.X=S.X-S.BoundingBox(1,1)+l;
        else
            dor=min(O);
            S.X=S.X-S.BoundingBox(1,1)+dor;
        end
        
        if isempty(V)
            S.Y=S.Y-S.BoundingBox(1,2)+l;
        else
            dver=min(V);
            S.Y=S.Y-S.BoundingBox(1,2)+dver;
        end
        
        %S.X=S.X-S.BoundingBox(1,1);
        %S.Y=S.Y-S.BoundingBox(1,2);
        
        while q<=lenv-1

            if S.X(q)==S.X(q) && S.X(q+1)==S.X(q+1) && S.Y(q)==S.Y(q) && S.Y(q+1)==S.Y(q+1)
                
                xp=S.X(q);
                yp=S.Y(q);
                xs=S.X(q+1);
                ys=S.Y(q+1);
                
                %{
                if mod(yp,l)~=0
                    %i=m-fix(yp/l);
                    i=m-ceil(yp/l)+1;
                else
                    if yp<ys
                        %i=m-fix(yp/l);
                        i=m-ceil(yp/l);
                    elseif yp>ys
                        %i=m-fix(yp/l)+1;
                        i=m-ceil(yp/l)+1;
                    else 
                        i=m-ceil(yp/l)+1;
                        u=i;
                    end
                end
                
                if mod(ys,l)~=0
                    %u=m-fix(ys/l);
                    u=m-ceil(ys/l)+1;
                else
                    if yp<ys
                        %u=m-fix(ys/l)+1;
                        u=m-ceil(ys/l)+1;
                    elseif yp>ys
                        %u=m-fix(ys/l);
                        u=m-ceil(ys/l);
                    end
                end
                
                if mod(xp,l)~=0
                    %j=ceil(xp/l);
                    j=fix(xp/l)+1;
                else
                    if xp<xs
                        %j=ceil(xp/l)+1;
                        j=fix(xp/l)+1;
                    elseif xp>xs
                        %j=ceil(xp/l);
                        j=fix(xp/l);
                    else
                        j=fix(xp/l)+1;
                        v=j;
                    end
                end
                
                if mod(xs,l)~=0
                    %v=ceil(xs/l);
                    v=fix(xs/l)+1;
                else
                    if xp<xs
                        %v=ceil(xs/l);
                        v=fix(xs/l);
                    elseif xp>xs
                        %v=ceil(xs/l)+1;
                        v=fix(xs/l)+1;
                    end
                end
                %}
                i=m-fix(yp/l);
                j=ceil(xp/l);
                u=m-fix(ys/l);
                v=ceil(xs/l);
                
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
