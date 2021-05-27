module Intro

export plot_data, render_grid, PlotMetadata

import Gen
using Plots

struct PlotMetadata
    title::AbstractString
    trace::Gen.DynamicDSLTrace
    plot_xs::Vector
    plot_ys::Vector
    data_xs::Vector
    data_ys::Vector
    overlay::Bool
    xlims::Vector
    ylims::Vector
    
    function PlotMetadata(
            title, trace, xs, ys;
            show_points=false, overlay=false, xlims=[], ylims=[]
        )
        trace_xs = Gen.get_args(trace)[1]
        
        if length(xlims) == 0
            xlims = [minimum(trace_xs), maximum(trace_xs)]
        end
        
        if length(ylims) == 0
            ylims = xlims  # make the plot square
        end
        
        scale = [0.9, 1.1]
        xlims = xlims .* scale
        ylims = ylims .* scale
        
        @assert isa(show_points, Vector) || isa(show_points, Bool)
        data_xs = trace_xs
        data_ys = isa(show_points, Bool) && show_points ? [] : show_points
        
        if isa(show_points, Bool)
            try
                data_ys = [trace[:y => idx] for idx=1:length(trace_xs)]
            catch e
                data_ys = [trace[(:y, idx)] for idx=1:length(trace_xs)]
            end
        end
        
        new(title, trace, xs, ys, data_xs, data_ys, overlay, xlims, ylims)
    end
end

# function plot_data(
#         title::AbstractString,
#         trace::Gen.DynamicDSLTrace,
#         plot_xs::Vector,
#         plot_ys::Vector,
#         with_points::Bool,
#         overlay::Bool=false,
#         ylims::Vector=[],
#         xlims::Vector=[],
#     )
#     trace_xs = Gen.get_args(trace)[1]
    
#     try
#         points = [trace[:y => idx] for idx=1:length(trace_xs)]
#     catch e
#         points = [trace[(:y, idx)] for idx=1:length(trace_xs)]
#     end
    
#     points = with_points ? points : Vector[]

#     return plot_data(
#         trace, plot_xs, plot_ys;
#         ylims=ylims, xlims=xlims, title=title, wiht_points=points, overlay=overlay
#     )
# end


function plot_data(meta::PlotMetadata)
    plotfn = meta.overlay ? Plots.plot! : Plots.plot
    p = plotfn(meta.plot_xs, meta.plot_ys, color=:purple, label="$(meta.title)-line")
    xlims!(meta.xlims...)
    ylims!(meta.ylims...)
    title!(meta.title)
    
    if length(meta.data_ys) > 0
        scatter!(meta.data_xs, meta.data_ys, color=:blue, label="$(meta.title)-data")
    end
    
    p
end

function render_grid(renderer::Function, traces; title="sim", ncols=4, nrows=3)
    plots = map(enumerate(traces)) do (idx, trace)
#         plot(size=(600, 600))
        renderer(trace, "$title-$idx", overlay=false)
    end
    
    plot(
        plots...,
        legend=false,
        layout=(nrows, ncols),
        size=(ncols * 200, nrows * 200),
        # size=(800, 800),
    )
end

function render_overlay(renderer::Function, traces; title="sim")
    (xs, ) = Gen.get_args(traces[1])
    prev_xs = zeros(size(xs))
    
    plot(size=(600, 600), legend=false, layout=(1, 1))
    
    map(traces) do trace
        (curr_xs, ) = Gen.get_args(trace)
        renderer(trace, title; show_points=(prev_xs != curr_xs), overlay=true)
        (prev_xs, ) = Gen.get_args(trace)
    end
    
    return plot!()
end

end