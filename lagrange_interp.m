function y_interp = lagrange_interp(x,y,xq)

n=length(x);

y_interp=zeros(size(xq));

for k=1:length(xq)

    value=0;

    for i=1:n

        L=1;

        for j=1:n

            if i~=j

                L=L*((xq(k)-x(j))/...
                    (x(i)-x(j)));

            end

        end

        value=value+y(i)*L;

    end

    y_interp(k)=value;

end

end