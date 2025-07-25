class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show]

  def index
    @courses = Course.all
  end

  def show
    @completed_lessons = current_user&.lesson_users&.joins(:lesson)&.where(completed: true, lesson: { course_id: @course.id })&.pluck(:lesson_id)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end

