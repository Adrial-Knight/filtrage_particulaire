function errors = modif_data_radar(params, valspace)
    valspace.r.pts = length(valspace.r.values);
    valspace.theta.pts = length(valspace.theta.values);

    errors = NaN(valspace.r.pts, valspace.theta.pts);
    p = params;

    fprintf("calcul en cours... 00%%")
    for i_r = 1:valspace.r.pts
        for i_theta = 1:valspace.theta.pts
            p.sigma.r = valspace.r.values(i_r);
            p.sigma.theta = valspace.theta.values(i_theta);
            p.Z = params.Z + [p.sigma.r; p.sigma.theta] .* randn(size(params.Z));
            error = 0;
            num_valid = 0;
            for i_num = 1:valspace.num
                X = filtrage_particulaire(p.init, p.Z, p.N, p.Phi, p.G, p.sigma);
                if all(~isnan(X))
                    error = error + norm([X(1, :) - p.Xvrai(1, :), X(3, :) - p.Xvrai(3, :)]);
                    num_valid = num_valid + 1;
                end
            end
            if num_valid > 0
                errors(i_r, i_theta) = error / num_valid;
            end
            fprintf("\b\b\b%02d%%", min(99, round(100 * ((i_r-1) * valspace.theta.pts + i_theta)/(valspace.r.pts * valspace.theta.pts))))
        end
    end
    fprintf(repmat('\b', 1, 16) + " terminé\n")
end
