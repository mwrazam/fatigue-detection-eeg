% This function calculates the Sample entropy for a given signal
%
%   Input
%   **********************
%       @signal: L x 1 input signal
%       @m: embedding dimension
%       @tau: filtering/comparison parameter
%
%   Output
%   **********************
%       @SampEn: Sample entropy value
%
function SampEn = CalculateSampleEntropy(signal, m, tau)
    
    % Prepare variables
    A = 0.0;
    B = 0.0;
    signal = signal(:);
    N = length(signal);
    
    % Calculate filtering comparator
    r = std(signal)*tau;
        
    % create template vectors
    xmj = zeros(m, N-m+1);
    for i=1:m
        xmj(i,:) = signal(i:N-m+i);
    end
    xmi = xmj(:,1:end-1);

    % calculate number of vector pairs having a distance less than r
    for i=1:length(xmi)
       xmii = xmi(:,i);
       distance = abs(xmj - xmii);
       maximums = max(distance);
       B = B + sum(maximums<=r) - 1;
    end
    
    % increase m by 1 and calculate again
    m = m+1;
    
    % create template vectors for m + 1
    xm = zeros(m, N-m+1);
    for i=1:m
       xm(i,:) = signal(i:N-m+i); 
    end
    
    for i=1:length(xm)
        xmii = xm(:,i);
        distance = abs(xmii - xm);
        maximums = max(distance);
        A = A + sum(maximums<=r) - 1;
    end
    
    SampEn = -log(A/B);
end

