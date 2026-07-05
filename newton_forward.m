function y_interp = newton_forward(x,y,xq)

n = length(x);

h = x(2)-x(1);

D = zeros(n,n);

D(:,1)=y';

for j=2:n
    for i=1:n-j+1
        D(i,j)=D(i+1,j-1)-D(i,j-1);
    end
end

y_interp=zeros(size(xq));

for k=1:length(xq)

    p=(xq(k)-x(1))/h;

    value=D(1,1);

    fact=1;
    term=1;

    for j=1:n-1

        term=term*(p-(j-1));
        fact=fact*j;

        value=value+(term/fact)*D(1,j+1);

    end

    y_interp(k)=value;

end

end