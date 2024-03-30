part of services;

@RestApi(baseUrl: '')
abstract class GptApiService {
  factory GptApiService(strng) => _GptApiService(Api(strng:strng).client);

  @POST('/completions')
  Future<ChatGptCompletionResponse> messageCompletion(
    @Body() ChatGPTCompletionRequest request,
  );
}
