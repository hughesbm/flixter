class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: :create
  before_action :require_authorized_for_current_lesson, only: [:update, :destroy]

  def create
    @lesson = current_section.lessons.create(lesson_params)
    if @lesson.valid?
      redirect_to instructor_course_path(current_section.course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    current_lesson.update_attributes(lesson_params)
    respond_to do |format|
      format.html { redirect_to instructor_course_path(current_lesson.section.course) }
      format.json { render plain: 'updated!' }
    end
  end

  def destroy
    @course = current_lesson.section.course
    current_lesson.destroy
    flash[:success] = "Lesson successfully deleted."
    redirect_to instructor_course_path(@course)
  end

  private

  def require_authorized_for_current_section
    if current_section.course.user != current_user
      return render plain: 'Unauthorized', status: :unauthorized
    end
  end

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      return render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :additional_notes, :row_order_position)
  end
end
