Rails.application.routes.draw do
  mount DeviseSessionable::Engine => "/devise_sessionable"
end
