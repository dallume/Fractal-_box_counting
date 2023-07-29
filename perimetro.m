function p=perimetro(T)

p=0;
for i=2:length(T.X)
    if T.X(i)==T.X(i) && T.X(i-1)==T.X(i-1)
        p=p+sqrt((T.X(i)-T.X(i-1))^2+(T.Y(i)-T.Y(i-1))^2);
    end
end

end