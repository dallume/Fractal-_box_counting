function X=duscant(S,n,str)

    q=1;
    if n~=fix(n) || n<0
        disp('Numero iterazioni non intero non negativo')
    elseif n==0
        X=S;
    elseif strcmp(str,'Cantor')
        while q<=n
            S=ifsCantor(S);
            q=q+1;
        end
        X=S;
    elseif strcmp(str,'Koch')
       S=ifsKoch(S);
       q=q+1;
       while q<=n
           S=ifsKoch(S);
           q=q+1;
       end
       X=S;
    end    

end