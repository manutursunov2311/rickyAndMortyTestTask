// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteSchemaCollection on Isar {
  IsarCollection<FavoriteSchema> get favoriteSchemas => this.collection();
}

const FavoriteSchemaSchema = CollectionSchema(
  name: r'FavoriteSchema',
  id: -8819909118080824498,
  properties: {
    r'characterId': PropertySchema(
      id: 0,
      name: r'characterId',
      type: IsarType.long,
    )
  },
  estimateSize: _favoriteSchemaEstimateSize,
  serialize: _favoriteSchemaSerialize,
  deserialize: _favoriteSchemaDeserialize,
  deserializeProp: _favoriteSchemaDeserializeProp,
  idName: r'id',
  indexes: {
    r'characterId': IndexSchema(
      id: 8442520835599207285,
      name: r'characterId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'characterId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _favoriteSchemaGetId,
  getLinks: _favoriteSchemaGetLinks,
  attach: _favoriteSchemaAttach,
  version: '3.1.0',
);

int _favoriteSchemaEstimateSize(
  FavoriteSchema object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _favoriteSchemaSerialize(
  FavoriteSchema object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.characterId);
}

FavoriteSchema _favoriteSchemaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteSchema();
  object.characterId = reader.readLong(offsets[0]);
  object.id = id;
  return object;
}

P _favoriteSchemaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteSchemaGetId(FavoriteSchema object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteSchemaGetLinks(FavoriteSchema object) {
  return [];
}

void _favoriteSchemaAttach(
    IsarCollection<dynamic> col, Id id, FavoriteSchema object) {
  object.id = id;
}

extension FavoriteSchemaByIndex on IsarCollection<FavoriteSchema> {
  Future<FavoriteSchema?> getByCharacterId(int characterId) {
    return getByIndex(r'characterId', [characterId]);
  }

  FavoriteSchema? getByCharacterIdSync(int characterId) {
    return getByIndexSync(r'characterId', [characterId]);
  }

  Future<bool> deleteByCharacterId(int characterId) {
    return deleteByIndex(r'characterId', [characterId]);
  }

  bool deleteByCharacterIdSync(int characterId) {
    return deleteByIndexSync(r'characterId', [characterId]);
  }

  Future<List<FavoriteSchema?>> getAllByCharacterId(
      List<int> characterIdValues) {
    final values = characterIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'characterId', values);
  }

  List<FavoriteSchema?> getAllByCharacterIdSync(List<int> characterIdValues) {
    final values = characterIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'characterId', values);
  }

  Future<int> deleteAllByCharacterId(List<int> characterIdValues) {
    final values = characterIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'characterId', values);
  }

  int deleteAllByCharacterIdSync(List<int> characterIdValues) {
    final values = characterIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'characterId', values);
  }

  Future<Id> putByCharacterId(FavoriteSchema object) {
    return putByIndex(r'characterId', object);
  }

  Id putByCharacterIdSync(FavoriteSchema object, {bool saveLinks = true}) {
    return putByIndexSync(r'characterId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCharacterId(List<FavoriteSchema> objects) {
    return putAllByIndex(r'characterId', objects);
  }

  List<Id> putAllByCharacterIdSync(List<FavoriteSchema> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'characterId', objects, saveLinks: saveLinks);
  }
}

extension FavoriteSchemaQueryWhereSort
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QWhere> {
  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhere> anyCharacterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'characterId'),
      );
    });
  }
}

extension FavoriteSchemaQueryWhere
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QWhereClause> {
  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause>
      characterIdEqualTo(int characterId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'characterId',
        value: [characterId],
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause>
      characterIdNotEqualTo(int characterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'characterId',
              lower: [],
              upper: [characterId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'characterId',
              lower: [characterId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'characterId',
              lower: [characterId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'characterId',
              lower: [],
              upper: [characterId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause>
      characterIdGreaterThan(
    int characterId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'characterId',
        lower: [characterId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause>
      characterIdLessThan(
    int characterId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'characterId',
        lower: [],
        upper: [characterId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterWhereClause>
      characterIdBetween(
    int lowerCharacterId,
    int upperCharacterId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'characterId',
        lower: [lowerCharacterId],
        includeLower: includeLower,
        upper: [upperCharacterId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavoriteSchemaQueryFilter
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QFilterCondition> {
  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition>
      characterIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'characterId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition>
      characterIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'characterId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition>
      characterIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'characterId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition>
      characterIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'characterId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavoriteSchemaQueryObject
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QFilterCondition> {}

extension FavoriteSchemaQueryLinks
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QFilterCondition> {}

extension FavoriteSchemaQuerySortBy
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QSortBy> {
  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterSortBy>
      sortByCharacterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterSortBy>
      sortByCharacterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.desc);
    });
  }
}

extension FavoriteSchemaQuerySortThenBy
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QSortThenBy> {
  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterSortBy>
      thenByCharacterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterSortBy>
      thenByCharacterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.desc);
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavoriteSchema, FavoriteSchema, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension FavoriteSchemaQueryWhereDistinct
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QDistinct> {
  QueryBuilder<FavoriteSchema, FavoriteSchema, QDistinct>
      distinctByCharacterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'characterId');
    });
  }
}

extension FavoriteSchemaQueryProperty
    on QueryBuilder<FavoriteSchema, FavoriteSchema, QQueryProperty> {
  QueryBuilder<FavoriteSchema, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavoriteSchema, int, QQueryOperations> characterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'characterId');
    });
  }
}
