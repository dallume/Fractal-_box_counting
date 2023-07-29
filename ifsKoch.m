function A=ifsKoch(S)

    A=S;
    A.X=S.X/3;
    A.Y=S.Y/3;
    A.X(length(A.X))=[];
    A.Y(length(A.Y))=[];
    
    A.X=[A.X (S.X-S.Y*sqrt(3))/6+(S.BoundingBox(2,1)-S.BoundingBox(1,1))/3];
    A.Y=[A.Y (S.X*sqrt(3)+S.Y)/6];
    A.X(length(A.X))=[];
    A.Y(length(A.Y))=[];
    
    A.X=[A.X (S.X+S.Y*sqrt(3)+3*(S.BoundingBox(2,1)-S.BoundingBox(1,1)))/6];
    A.Y=[A.Y (-S.X*sqrt(3)+S.Y+sqrt(3)*(S.BoundingBox(2,1)-S.BoundingBox(1,1)))/6];
    A.X(length(A.X))=[];
    A.Y(length(A.Y))=[];
    
    A.X=[A.X (S.X+2*(S.BoundingBox(2,1)-S.BoundingBox(1,1)))/3];
    A.Y=[A.Y S.Y/3];

end