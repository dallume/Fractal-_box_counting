function X=ifsCantor(S)

    Y=S/3;
    Z=(S+2*(max(S)-min(S)))/3;
    X=[Y NaN Z];

end