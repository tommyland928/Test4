class ChipsController < ApplicationController
    def index
        logger.debug("二回目も通ってます")
        @member = Member.all
    end

    def store
        if params[:green] != "" && params[:blue] != "" && params[:red] != "" && params[:black] != "" && params[:name] != "" && params[:group] != "" && params[:bet] != "" && params[:first] != "" then
            tmp = 10 * params[:green].to_i + 30 * params[:blue].to_i + 50 * params[:red].to_i + 100 * params[:black].to_i
            score = (tmp.to_f * (params[:bet].to_f / params[:first].to_f)).to_i - params[:bet].to_i
            send = params[:bet].to_i + score
            theMember = Member.find_by(name: params[:name], group: params[:group])
            if Person.find_by(name: params[:name], group: params[:group]) == nil then
                person = Person.new({ "name" => params[:name], "group" => params[:group], "score" => score, "send" => send})
                person.update(id: theMember.id)
                if person.save
                    redirect_to :action => "rank"
                else
                    redirect_to :action => 'index'
                end
            else
                person = Person.find_by(name: params[:name], group: params[:group])
                person.update(score: score, send: send)
                if person.save
                    redirect_to :action => "rank"
                else
                    redirect_to :action => 'index'
                end
            end
            
        else
        end

    end

    def rank
        @person = Person.order('score DESC')
        
    end

    def save
        logger.debug("ここまで来てるよ")

        #person.allのデータを更新
        if Person.exists? then
            logger.debug("ここまで来てるよ1")

            person = Person.all
            person.each do |t|
                tmpMember = Member.find_by(name: t.name.to_s, group: t.group.to_s)
                if tmpMember != nil then
                    logger.debug("ここまで来てるよ2")

                    tmp = tmpMember.score + t.score
                    logger.debug(tmp)
                    tmpMember.update(score: tmp)
                    if tmpMember.save
                        redirect_to :action => "general"
                    end
                end

            end
            Person.destroy_all
        else
        end


    end

    def add
        @member = Member.new
    end

    def createm
        cmember = Member.new(params.require(:member).permit(:name,:group))
        cmember.update(score: 0)
        if cmember.save
            redirect_to :action => "add"
        else
        end
    end

    def general
        @member = Member.order('score DESC')
    end

end
