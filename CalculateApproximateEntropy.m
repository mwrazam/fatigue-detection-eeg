% This function calculates Approximate Entropy of a given signal
%
%   Input
%   **********************
%       @signal: L x 1 input signal
%       @dim: embedding dimension for creating vector arrays
%       @tau: filtering parameter
%
%   Output
%   **********************
%       @ApEn: Approximate entropy value
%
function ApEn = CalculateApproximateEntropy(signal,dim, tau)

N = length(signal);

% Determine difference of phi values to calculate approximate entropy
ApEn = abs(abs(phi(dim+1)) - abs(phi(dim)));

    % Phi value for a given dimension parameter m
    function phi = phi(m)
        
        x = zeros(m, N-m+1);
        
        % Create vector arrays
        for i=1:m
           x(i,:) = signal(i:N-m+i);
        end

        % Holder for calculating ratio of values meeting criteria
        C = zeros(1,length(x));

        % Calculate ratio C
        % TODO OPTIMIZATION NEEDED, THIS PART IS TOO SLOW
        for j=1:length(x)

            s = zeros(1, length(x));

            for i=1:length(x)
                v = [x(:,j), x(:,i)];
                s(i) = max(range(v,2));
            end

            C(j) = sum(s<tau)/(N-m+1);

        end
        
        % Calculate phi value
        phi = sum(log(C))/(N - m + 1);
        
    end

end

