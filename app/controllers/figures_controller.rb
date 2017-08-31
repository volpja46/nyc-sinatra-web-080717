class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @figures = Figure.all
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end



  post '/figures' do
    figure = Figure.create(params[:figure])

    #landmark
    if params[:landmark_name]
      params[:landmark_name].each do |landmark_id|
        l = Landmark.find_by(id:landmark_id.to_i)
        l.figure_id = figure.id
        l.save
      end
    end

    if !params["landmark"]["name"].empty?
      l2 = Landmark.create(params[:landmark])
      l2.figure_id = figure.id
      l2.save
    end


    #title
    if params[:title_name]
      params[:title_name].each do |title_id|
        FigureTitle.create(title_id: title_id.to_i, figure_id: figure.id)
      end
    end

    if !params["title"]["name"].empty? #if there is a new title entered create a new title
      new_title = Title.create(params[:title])
      FigureTitle.create(title_id: new_title.id, figure_id: figure.id)
    end
  end

  get '/figures/:id/edit' do
    @landmarks = Landmark.all
    @titles = Title.all
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    #landmark
    @figure.update(params[:figure])

    Landmark.all.each do |landmark|
      if landmark.figure_id == figure.id
        landmark.figure_id = nil
      end
    end

    if params[:landmark_name]
      params[:landmark_name].each do |landmark_id|
        l = Landmark.find_by(id:landmark_id.to_i)
        l.figure_id = figure.id
        l.save
      end
    end

    if !params["landmark"]["name"].empty?
      l2 = Landmark.create(params[:landmark])
      l2.figure_id = figure.id
      l2.save
    end


    #title
    if params[:title_name]
      params[:title_name].each do |title_id|
        FigureTitle.create(title_id: title_id.to_i, figure_id: figure.id)
      end
    end

    if !params["title"]["name"].empty? #if there is a new title entered create a new title
      new_title = Title.create(params[:title])
      FigureTitle.create(title_id: new_title.id, figure_id: figure.id)
    end
  end

end
