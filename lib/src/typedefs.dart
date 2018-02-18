import 'package:flutter/widgets.dart';

typedef Widget FunctionalWidget<P>(P props);

/// [WidgetEnhancer] is function that given a [FunctionalComponent] that accepts [OutterP] props
/// and returns a [FunctionalComponent] that accepts [InnerP] props
typedef FunctionalWidget<OutterP> WidgetEnhancer<InnerP, OutterP>(
    FunctionalWidget<InnerP> baseComponent);

/// [Mapper] takes a props object of type [P] and returns a props object of type [T]
typedef B Mapper<A, B>(A props);
