function y_interp = divided_difference(x,y,xq)

n=length(x);

DD=zeros(n,n);

DD(:,1)=y';

for j=2:n
    for i=1:n-j+1

        DD(i,j)=(DD(i+1,j-1)-DD(i,j-1))/...
            (x(i+j-1)-x(i));

    end
end

y_interp=zeros(size(xq));

for k=1:length(xq)

    value=DD(1,1);

    product=1;

    for j=2:n

        product=product*(xq(k)-x(j-1));

        value=value+DD(1,j)*product;

    end

    y_interp(k)=value;

end

end