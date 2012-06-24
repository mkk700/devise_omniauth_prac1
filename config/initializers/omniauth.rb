Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  # provider :facebook, '296654880418892', 'c6f2402c43825eadf4208c82a2948608',:scope => 'publish_stream,email' 
  provider :facebook, '296654880418892', 'c6f2402c43825eadf4208c82a2948608', {:client_options => {:ssl => {:verify => false}},:scope => 'publish_stream,email' }
  provider :twitter, 'UAGH7ajkBts4FnGGLwyJMw','1cYconxzqDTtaBt20XFetn0uuAqFryK2d3xzuB11MP4'
end