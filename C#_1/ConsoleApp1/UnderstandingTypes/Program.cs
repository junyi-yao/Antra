// See https://aka.ms/new-console-template for more information
//Console.WriteLine("Hello, World!");

sbyte var_sbyte = 10;
int size_of_sbyte = System.Runtime.InteropServices.Marshal.SizeOf(var_sbyte);
int max_of_sbyte = (int)sbyte.MaxValue;
int min_of_sbyte = (int)sbyte.MinValue;

Console.WriteLine($"The size of sbyte is: {size_of_sbyte}, " +
    $"the max value of sbyte is {max_of_sbyte}," +
    $"the min value of sbyte is {min_of_sbyte}");



