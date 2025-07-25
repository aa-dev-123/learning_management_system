class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show]

  def index
    @courses = Course.all
    @user_started_courses = current_user&.lesson_users&.joins(:lesson)&.pluck(:course_id)&.uniq
    if @user_started_courses.present?
      @user_course_progresses = @user_started_courses.map do |course_id|
        course_lessons = Course.find(course_id).lessons.count
        completed_lessons = current_user&.lesson_users&.joins(:lesson)&.where(completed: true, lesson: { course: course_id })&.count
        { course_id: course_id, completed_percentage: (completed_lessons.to_f / course_lessons.to_f * 100).to_i }
      end
    end
  end

  def show
    @completed_lessons = current_user&.lesson_users&.joins(:lesson)&.where(completed: true, lesson: { course_id: @course.id })&.pluck(:lesson_id)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end

