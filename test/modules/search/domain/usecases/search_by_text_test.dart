import 'package:clean_code/modules/search/domain/entities/result_search.dart';
import 'package:clean_code/modules/search/domain/errors/errors.dart';
import 'package:clean_code/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_code/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_by_text_test.mocks.dart';

// class SearchRepositoryMock extends Mock implements SearchRepository {}
@GenerateMocks([SearchRepository])
main() {
  final repository = MockSearchRepository();
  final usecase = SearchByTextImpl(repository);

  test('deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await usecase("ruth");

    expect(result.getOrElse(() => null), isA<List<ResultSearch>>());
  });

  test('deve retornar um InvalidTextError caso o texto seja inválido',
      () async {
    when(repository.search(any))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase("");
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
