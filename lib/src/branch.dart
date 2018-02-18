import 'typedefs.dart';

/// [BranchTest] is a function that decides given the props which [FunctionalWidget] to return
/// return true to take the left branch or false to take the right branch
typedef bool BranchTest<P>(P props);

/// [branch] returns the [left] or [right] [FunctionalWidget] depending on the outcome of [test]
FunctionalWidget<P> branch<P>(BranchTest<P> test, FunctionalWidget<P> left,
        FunctionalWidget<P> right) =>
    (P props) => test(props) ? left(props) : right(props);
