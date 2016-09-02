class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show, :update, :destroy]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @section = Section.new
    @lesson = Lesson.new
  end

  def update
    current_course.update_attributes(course_params)
    redirect_to instructor_course_path(current_course)
  end

  def destroy
    if current_course.enrollments.present?
      flash[:error] = "Course could not be deleted as there are students enrolled in it. Contact a site admin for assistance."
      redirect_to instructor_course_path(current_course)
    else
      current_course.destroy
      flash[:success] = "Course successfully deleted."
      redirect_to dashboard_path
    end
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image)
  end
end
