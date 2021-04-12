class TweetsController < ApplicationController
    get "/tweets" do 
        if logged_in?
            @tweets = Tweet.all
            erb :"tweets/index"
        else 
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :"tweets/create_tweets"
        else 
            redirect "/login"
        end
    end

    post "/tweets" do 
        if logged_in?
            if params[:content] != ""
                @tweet = current_user.tweets.new(content: params[:content])
                @tweet.save 
                if @tweet.save
                    redirect "/tweets/#{@tweet.id}"
                else 
                    redirect "tweets/create_tweets"
                end
            else 
                redirect "/tweets/create_tweets"
            end
        else
            redirect "/login"
        end
    end

end
