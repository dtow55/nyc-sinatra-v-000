class FiguresController < ApplicationController

    get '/figures' do
        erb :'/figures/index'
    end

    get '/figures/new' do
        erb :'/figures/new'
    end

    get '/figures/:id' do
        @figure = Figure.find(params[:id])
        erb :'/figures/show'
    end

    get '/figures/:id/edit' do
        @figure = Figure.find(params[:id])
        erb :'/figures/edit'
    end

    post '/figures/:id/edit' do
        @figure = Figure.find(params[:id])

        @figure.name = params[:figure][:name]

        #TITLE
        #If new Title Name is supplied
        if !(params[:title][:name] == "")
            title = Title.new(name: params[:title][:name])
            @figure.titles << title
        end

        #If Title boxes were checked
        if params[:figure][:title_ids]
            params[:figure][:title_ids].each do |title_id|
                @figure.titles << Title.find(title_id)
            end
        end

        #LANDMARK
        #If new Landmark Name is supplied
        if !(params[:landmark][:name] == "")
            landmark = Landmark.new(name: params[:landmark][:name])
            @figure.landmarks << landmark
        end

        #If Landmark boxes were checked
        if params[:figure][:landmark_ids]
            params[:figure][:landmark_ids].each do |landmark_id|
                @figure.landmarks << Landmark.find(landmark_id)
            end
        end

        @figure.save

        redirect "/figures/#{@figure.id}"
    end

    post '/figures' do
        #PARAMS[] EXAMPLES:
        #{figure: {name: "xxx", title_ids: [], landmark_ids: [] }, figure: {name: "xxx"}, lanrmark: {name: "xxx"} }
        #{"figure"=>{"name"=>"Doctor Who", "title_ids"=>["on"]}, "title"=>{"name"=>""}, "landmark"=>{"name"=>""}}
        @figure = Figure.create(name: params[:figure][:name])

        #TITLE
        #If new Title Name is supplied
        if !(params[:title][:name] == "")
            title = Title.new(name: params[:title][:name])
            @figure.titles << title
        end

        #If Title boxes were checked
        if params[:figure][:title_ids]
            params[:figure][:title_ids].each do |title_id|
                @figure.titles << Title.find(title_id)
            end
        end

        #LANDMARK
        #If new Landmark Name is supplied
        if !(params[:landmark][:name] == "")
            landmark = Landmark.new(name: params[:landmark][:name])
            @figure.landmarks << landmark
        end

        #If Landmark boxes were checked
        if params[:figure][:landmark_ids]
            params[:figure][:landmark_ids].each do |landmark_id|
                @figure.landmarks << Landmark.find(landmark_id)
            end
        end

        @figure.save
    end

end
