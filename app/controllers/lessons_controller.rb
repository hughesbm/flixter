class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_section
    unless current_user && (current_user.enrolled_in?(current_lesson.section.course) || current_lesson.section.course.user == current_user)
      flash[:alert] = "Lessons are only available to enrolled students. Click the \"Enroll in Course\" button below."
      redirect_to course_path(current_lesson.section.course)
    end
  end

end
