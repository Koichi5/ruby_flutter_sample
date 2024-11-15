class BooksController < ApplicationController
  def register
    book = Book.new(book_params)
    if book.save
      render json: { book: book }, status: 201
    else
      render json: { message: 'Failed to register book' }, status: 400
    end
  end

  def index
    books = Book.all
    if books.empty?
      render json: { message: 'No books found' }, status: 400
    else
      render json: { books: books }, status: 200
    end
  end

  def update
    book = Book.find_by(id: params[:id])
    if book.nil?
      book = Book.new(book_params)
      if book.save
        render json: { book: book }, status: 201
      else
        render json: { message: 'Failed to update book' }, status: 400
      end
    else
      # DBにレコードがある場合
      if book.update(book_params)
        render json: { book: book }, status: 200
      else
        render json: { message: 'Failed to update book' }, status: 400
      end
    end
  end

  def delete
    book = Book.find_by(id: params[:id])
    if book.nil?
      render json: { message: 'No book found' }, status: 400
    else
      # DBにレコードがある場合
      if book.destroy
      render status: 204
      else
        render json: { message: 'Failed to delete book' }, status: 400
      end
    end
  end

  private

  def book_params
    params.permit(:title, :publisher, :description, :page_count, :image_url)
  end
end
