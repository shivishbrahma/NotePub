---
title: Java Programming Masterclass
author: Purbayan Chowdhury(@shivishbrahma)
type: draft
created_ts: 2024-07-07 15:48:58
edited_ts: 2024-07-13 20:09:19
---

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Conditional Statements](#conditional-statements)
- [Object Oriented Programming](#object-oriented-programming)
    - [Classes and Objects](#classes-and-objects)
    - [Polymorphism](#polymorphism)
    - [Multiple Inheritance](#multiple-inheritance)
- [Abstract Class](#abstract-class)
- [Generic Class](#generic-class)
- [Packages](#packages)
- [Exceptions](#exceptions)
- [Collections](#collections)
    - [HashMap](#hashmap)
    - [TreeMap](#treemap)
    - [ArrayList](#arraylist)
    - [HashSet](#hashset)
- [Functional Programming : Lambda, Streams](#functional-programming--lambda-streams)
- [Multithreading](#multithreading)
- [Regular Expression](#regular-expression)
- [Database Connectivity](#database-connectivity)

## Conditional Statements

```java
public static String[] calculateGrade(int[][] students_marks) {
      String[] result = new String[students_marks.length];
      
      int avg = 0;
      for(int i=0; i<students_marks.length; i++) {
          avg = 0;
          for(int j=0; j<students_marks[i].length; j++) {
              avg += students_marks[i][j];
          }
          avg /= students_marks[i].length;
          
          if(avg >= 90) result[i] = "A+";
          else if(avg >= 80) result[i] = "A";
          else if(avg >= 70) result[i] = "B";
          else if(avg >= 60) result[i] = "C";
          else if(avg >= 50) result[i] = "D";
          else result[i] = "F";
      }
      
      return result;
  }
```

## Object Oriented Programming

### Classes and Objects

<!-- ### Singleton Pattern -->

```java
class Register {
    
    private static Register register = null;
     
    /*
     * Complete the 'getTotalBill' function below.
     *
     * The function is expected to return a STRING.
     * The function accepts MAP itemDetails as parameter.
     */

    public String getTotalBill(Map<String,Integer> itemDetails) {
        Map<String,Double> itemPrice = new HashMap<>();
        itemPrice.put("apple", 2.0);
        itemPrice.put("orange", 1.5);
        itemPrice.put("mango", 1.2);
        itemPrice.put("grape", 1.0);
        
        // Write your code here
        double total = 0;
        for (String item : itemDetails.keySet()) {
            total += itemDetails.get(item) * itemPrice.get(item);
        }
        return String.format("%.1f",total);
    }
    
    public static Register getInstance() {
        register = new Register();
        return register;
    }

}
```

### Polymorphism

```java
class Parent {
    public int startElement, endElement;
    
    Parent(int start, int end) {
        this.startElement = start;
        this.endElement = end;
    }
    
    public String filter() {
        return null;
    }
}

class ChildOne extends Parent {
    ChildOne(int start, int end) {
        super(start, end);
    }
    
    boolean isPrime(int n) {
        if (n <= 1) return false;
        if (n <= 3) return true;
        if (n % 2 == 0) return false;
        if (n % 3 == 0) return false;
        
        for (int i = 5; i <= Math.sqrt(n); i+=2) {
            if (n % i == 0) return false;
        }
        return true;
    }
    @Override public String filter() {
        int i = startElement;     
        String res = "";
        while(i<=endElement){
            if(isPrime(i))
                res += String.valueOf(i) +" ";
            i++;
        }   
        return res.trim();
    }
}

class ChildTwo extends Parent {
    ChildTwo(int start, int end) {
        super(start, end);
    }
    
    int numSquareSum(int n) {
        int squareSum = 0;
        while (n != 0) {
            int digit = n % 10;
            squareSum += digit * digit;
            n /= 10;
        }
        return squareSum;
    }
    
    boolean isHappy(int n) {
        int slow = n, fast = n;
        do {
            slow = numSquareSum(slow); 
            fast = numSquareSum(numSquareSum(fast));
        } while (slow != fast);

        return slow == 1;
    }
    
    @Override public String filter() {
        int i = startElement;     
        String res = "";
        while(i<=endElement){
            if(isHappy(i))
                res += String.valueOf(i) + " ";
            i++;
        }   
        return res.trim();
    }
}
```

### Multiple Inheritance

```java
interface HockeyTeam {
    int calculateHockeyScore();
    
    int findHighestGoalByIndividualInHockey();
}

interface FootballTeam {
    int calculateFootballScore();
    
    int findHighestGoalByIndividualInFootball();
}

class Sport implements HockeyTeam, FootballTeam {
    private int[] hockeyPlayers, footballPlayers;
    Sport(int[] paramHockeyPlayers, int[] paramFootballPlayers) {
        this.hockeyPlayers = paramHockeyPlayers;
        this.footballPlayers = paramFootballPlayers;
    }
    
    public int calculateHockeyScore() {
        return Arrays.stream(this.hockeyPlayers).sum();
    }
    
    public int findHighestGoalByIndividualInHockey() {
        return Arrays.stream(this.hockeyPlayers).max().getAsInt();
    }
    
    public int calculateFootballScore() {
        return Arrays.stream(this.footballPlayers).sum();
    }
    
    public int findHighestGoalByIndividualInFootball() {
        return Arrays.stream(this.footballPlayers).max().getAsInt();
    }
}
```

## Abstract Class

```java
public abstract class Student {

    //Write your code. Use this class as abstract class.
    public abstract String result(String MarksOfStudent);

    public double calcGradePoint(int grade) {
        // double res=0;
        if (grade >= 75) {
            return Float.valueOf(String.format("%.1f", 9 + (grade - 75) / 25.0f));
        } else if (grade >= 60) {
            return Float.valueOf(String.format("%.1f", 8 + (9.0f / 140 * (grade - 60))));
        } else if (grade >= 50) {
            return 7 + (0.1f * (grade - 50));
        } else if (grade >= 40) {
            return 6 + (0.1f * (grade - 40));
        }
        return 0f;
    }
}


public class SelfFinance extends  Student {
    @Override public String result(String allMarks) {
        String[] marks= allMarks.split("\\|");
        String[] subjMarks = marks[0].split(","),
        sportsMarks = marks[1].split(",");

        int maxCred = 0, cred, grade;
        double totalGrade = 0, cgpa;
        for(String subjMark: subjMarks) {
            grade = Integer.parseInt(subjMark.split(" ")[0]);
            cred = Integer.parseInt(subjMark.split(" ")[1]);
            totalGrade += cred * calcGradePoint(grade);
            maxCred += 5;
        }

        if(sportsMarks[0].equals("1")) {
            grade = Integer.parseInt(sportsMarks[1]);
            cred = Integer.parseInt(sportsMarks[2]);
            totalGrade += cred * calcGradePoint(grade);
            maxCred += 5;
        }

        cgpa = totalGrade/maxCred;
        return String.format("%.2f", cgpa);
    }
}

public class Aided extends  Student {
    @Override public String result(String allMarks) {
        String[] marks= allMarks.split("\\|");
        String[] subjMarks = marks[0].split(","),
        nccMarks = marks[1].split(","),
        sportsMarks = marks[2].split(",");

        int maxCred = 0, cred, grade;
        double totalGrade = 0, cgpa;
        for(String subjMark: subjMarks) {
            grade = Integer.parseInt(subjMark.split(" ")[0]);
            cred = Integer.parseInt(subjMark.split(" ")[1]);
            totalGrade += cred * calcGradePoint(grade);
            maxCred += 5;
        }

        if(nccMarks[0].equals("1")) {
            grade = Integer.parseInt(nccMarks[1]);
            cred = Integer.parseInt(nccMarks[2]);
            totalGrade += cred * calcGradePoint(grade);
            maxCred += 5;
        }

        if(sportsMarks[0].equals("1")) {
            grade = Integer.parseInt(sportsMarks[1]);
            cred = Integer.parseInt(sportsMarks[2]);
            totalGrade += cred * calcGradePoint(grade);
            maxCred += 5;
        }

        cgpa = totalGrade/maxCred;
        return String.format("%.2f", cgpa);
    }
}
```

## Generic Class

```java
public class StudentClass {

    public String getQuery(String studentData, String query) {
        String[] queryParams = query.split(",");
        String[] studentArr = studentData.split(" ");
        int queryType = Integer.parseInt(queryParams[0]);
        if (queryType == 1) {
            StudentList<String> studentList = new StudentList<>();
            for (int i = 0; i < studentArr.length; i++) {
                studentList.addElement(studentArr[i]);
            }
            return studentList.beginsWith(queryParams[1]);
        } else if (queryType == 2) {
            StudentList<String> studentList = new StudentList<>();
            for (int i = 0; i < studentArr.length; i++) {
                studentList.addElement(studentArr[i]);
            }
            String bloodGroups[] = queryParams[1].split(" ");
            return studentList.bloodGroupOf(bloodGroups, queryParams[2]);
        } else if (queryType == 3) {
            StudentList<Integer> studentList = new StudentList<>();
            for (int i = 0; i < studentArr.length; i++) {
                studentList.addElement(Integer.parseInt(studentArr[i]));
            }
            int count = studentList.thresholdScore(Integer.parseInt(queryParams[1]));
            return String.format("%d students scored %d above", count, Integer.parseInt(queryParams[1]));
        } else if (queryType == 4) {
            ScoreList<Double> scoreList = new ScoreList<>();
            for (int i = 0; i < studentArr.length; i++) {
                scoreList.addElement(Double.parseDouble(studentArr[i]));
            }
            return String.format("%.2f", scoreList.averageValues());
        } else if (queryType == 5) {
            ScoreList<Double> scoreList = new ScoreList<>();
            for (int i = 0; i < studentArr.length; i++) {
                scoreList.addElement(Double.parseDouble(studentArr[i]));
            }
            return String.format("%.2f", scoreList.averageValues());
        }
        return "Not a valid query";
    }

}

public class ScoreList<Type> {
    //Write your code
     ArrayList<Type> list = new ArrayList<>();

    public void addElement(Type t){
        list.add(t);
    }

    public void removeElement(Type t) {
        list.remove(t);
    }

    public Type getElement(int i) {
        return list.get(i);
    }

    public double averageValues() {
        double avg = 0;
        for(int i=0; i<list.size(); i++) {
            avg += (Double)list.get(i);
        }
        avg /= list.size();
        return Double.parseDouble(String.format("%.2f",avg));
    }
}

public class StudentList<Type> {
    //Write your code
    ArrayList<Type> list = new ArrayList<>();

    public void addElement(Type t){
        list.add(t);
    }

    public void removeElement(Type t) {
        list.remove(t);
    }

    public Type getElement(int index) {
        return list.get(index);
    }

    public String beginsWith(String prefix) {
        String res = "";
        for(int i=0; i<list.size(); i++) {
            if(String.valueOf(list.get(i)).toLowerCase().startsWith(prefix.toLowerCase())){
                res += list.get(i).toString() + "\n";
            }
        }
        return res;
    }

    public String bloodGroupOf(String[] bloodGroups, String bloodGroup) {
        String res = "";
        for(int i=0; i<bloodGroups.length; i++) {
            if(bloodGroup.equalsIgnoreCase(bloodGroups[i])){
                res += list.get(i).toString() + "\n";
            }
        }
        return res;
    }

    public int thresholdScore(int score) {
        int count = 0;
        for(int i=0; i<list.size(); i++) {
            if((Integer)list.get(i) >= score) {
                count++;
            }
        }
        return count;
    }
}
```

## Packages

```java
public class NumberFinder {
  public static boolean isKeith(int n) {
    ArrayList<Integer> l = new ArrayList<>();

    int temp = n;
    while (temp > 0) {
      l.add(temp % 10);
      temp /= 10;
    }
    Collections.reverse(l);
    int i, len, nextTerm = 0;
    i=len = l.size();
    while(nextTerm < n) {
      nextTerm = 0;
      for (int j = 1; j <= len; j++) {
        nextTerm += l.get(i - j);
      }
      l.add(nextTerm);
      i++;
    }
    return nextTerm == n;
  }

  public static boolean isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0) return false;
    if (n % 3 == 0) return false;

    for (int i = 5; i <= Math.sqrt(n); i+=2) {
      if (n % i == 0) return false;
    }
    return true;
  }
}

public class ExtractString {
  public static int[] extractNumericNumbers(String s){
    ArrayList<Integer> nums = new ArrayList<>();
    String temp = "";
    for(int i = 0; i < s.length(); i++) {
      if((i==0|| !Character.isAlphabetic(s.charAt(i-1))) && Character.isDigit(s.charAt(i))) {
        temp += s.charAt(i);
      } else {
        if(!temp.trim().equals("") && !Character.isAlphabetic(s.charAt(i))) {
          nums.add(Integer.parseInt(temp));
        }
        temp = "";
      }
    }
    if (!temp.equals("")) nums.add(Integer.parseInt(temp));
    int arr[] = nums.stream().mapToInt(Integer::intValue).toArray();
    return arr;
  }

  public static int[] extractTextNumbers(String s){
    String words[] = s.split(" ");
    ArrayList<Integer> nums = new ArrayList<>();
    for(int i = 0; i < words.length; i++) {
        if(words[i].equalsIgnoreCase("one"))
            nums.add(1);
        else if(words[i].equalsIgnoreCase("two"))
            nums.add(2);
        else if(words[i].equalsIgnoreCase("three"))
            nums.add(3);
        else if(words[i].equalsIgnoreCase("four"))
            nums.add(4);
        else if(words[i].equalsIgnoreCase("five"))
            nums.add(5);
        else if(words[i].equalsIgnoreCase("six"))
            nums.add(6);
        else if(words[i].equalsIgnoreCase("seven"))
            nums.add(7);
        else if(words[i].equalsIgnoreCase("eight"))
            nums.add(8);
        else if(words[i].equalsIgnoreCase("nine"))
            nums.add(9);
        else if(words[i].equalsIgnoreCase("zero"))
            nums.add(0);
    }

    int numsArr[] = nums.stream().mapToInt(Integer::intValue).toArray();
    
    return numsArr;
  }
}

public class KeithClass {
    public String getInput(String conversation) {
        int[] numericNumbers = ExtractString.extractNumericNumbers(conversation);
        int[] textNumbers = ExtractString.extractTextNumbers(conversation);
        int sum = 0;
        String res = "";
        for(int i = 0; i < numericNumbers.length; i++) {
            if(NumberFinder.isKeith(numericNumbers[i]) && !NumberFinder.isPrime(numericNumbers[i])) {
                res+= Integer.toString(numericNumbers[i]);
            }
        }
        for(int i = 0; i < textNumbers.length; i++) {
            sum+=textNumbers[i];
        }
        res+= Integer.toString(sum);
        return res;
    }
 
}
```

## Exceptions

`Solution.java`

```java
class InvalidMessageException extends Exception {
    InvalidMessageException(String message){
        super(message);
    }
}

class Encrypter {
    public static String encryptMessage(String message) throws InvalidMessageException{
        if(!Validator.validate(message)) {
            throw new InvalidMessageException("Try again with valid message");
        }
        String res = (new StringBuilder(message)).reverse().toString().toLowerCase();
        return res;
    }
}

class Validator {
    public static boolean validate(String message) {
        return message.matches("[A-Za-z0-9 ]+");
    }
}

public class Solution {
    private static final Scanner INPUT_READER = new Scanner(System.in);
    
    public static void main(String[] args) {
        String message = INPUT_READER.nextLine();
        
        try {
            String encrypted_message = Encrypter.encryptMessage(message);
            if(! encrypted_message.startsWith("InvalidMessageException"))
                System.out.println(encrypted_message);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
```

## Collections

### HashMap

```java
class Library
{
    
    String bookName;
    String author;
    Library()
    {
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 83 * hash + Objects.hashCode(this.bookName);
        hash = 83 * hash + Objects.hashCode(this.author);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Library other = (Library) obj;
        if (!Objects.equals(this.bookName, other.bookName)) {
            return false;
        }
        if (!Objects.equals(this.author, other.author)) {
            return false;
        }
        return true;
    }
    
    
    Library(String bookName,String author)
    {
        this.bookName=bookName;
        this.author=author;
    }
    public HashMap<Integer,Library> createLibraryMap(String booksInLibrary)
    {
        HashMap<Integer,Library> map = new HashMap<>();
        String books[] = booksInLibrary.split("\\|");
        for(String book: books) {
            String bookParams[] = book.split(",");
            Library lib = new Library(bookParams[1], bookParams[2]);
            map.put(Integer.parseInt(bookParams[0]), lib);
        }
        return map;
    }
    public HashMap<Integer,Integer> createUserMap(String borrowedUsers)
    {
        HashMap<Integer,Integer> map = new HashMap<>();
        String users[] = borrowedUsers.split("\\|");
        for(String user: users) {
            String userParams[] = user.split(",");
            map.put(Integer.parseInt(userParams[0]), Integer.parseInt(userParams[1]));
        }
        return map;
    }

    
    public String getQuery(String booksInLibrary,String borrowedUsers,String query)
    {
        HashMap<Integer,Library> libraryMap = createLibraryMap(booksInLibrary);
        HashMap<Integer,Integer> userMap = createUserMap(borrowedUsers);
        String queryParams[] = query.split(",");
        int queryType = Integer.parseInt(queryParams[0]), userId, inCnt = 0, outCnt = 0;
        String res = "";
        Library lib;
        switch(queryType) {
            case 1: 
            if(userMap.containsKey(Integer.parseInt(queryParams[1]))){
                userId = userMap.get(Integer.parseInt(queryParams[1]));
                res = String.format("No Stock\nIt is owned by %d\n", userId);
            } else {
                lib = libraryMap.get(Integer.parseInt(queryParams[1]));
                res = String.format("It is available\nAuthor is %s\n", lib.author);
            }
            break;
            case 2: 
            for(int bookId: userMap.keySet()) {
                if(userMap.get(bookId) == Integer.parseInt(queryParams[1])) {
                    lib = libraryMap.get(bookId);
                    res+=String.format("%d %s\n", bookId, lib.bookName);
                }
            }
            break;
            case 3: inCnt = outCnt = 0;
            for(int bookId: libraryMap.keySet()) {
                if(libraryMap.get(bookId).bookName.equals(queryParams[1])) {
                    if(userMap.containsKey(bookId)) outCnt++;
                    else inCnt++;
                }
            }
            res = String.format("%d out\n%d in\n", outCnt, inCnt);
            break;
            case 4:
            for(int bookId: libraryMap.keySet()) {
                if(libraryMap.get(bookId).author.equals(queryParams[1])) {
                    res +=libraryMap.get(bookId).bookName+"\n";
                }
            }
            break;
            case 5: 
            for(int bookId: libraryMap.keySet()) {
                if(libraryMap.get(bookId).bookName.toLowerCase().contains(queryParams[1].toLowerCase())) {
                    res +=String.format("%d %s\n", bookId,libraryMap.get(bookId).bookName);
                }
            }
            break;
            default: return "Invalid Query Type";
        }

        return res;
    }
}
```

### TreeMap

```java
public class TreemapHandson {
    public TreeMap<Integer, String> createPlayerPositionMap(String cricketDataset) {
        TreeMap<Integer, String> map = new TreeMap<>();
        String players[] = cricketDataset.split("\\|");
        for (String player : players) {
            String playerParams[] = player.split(",");
            map.put(Integer.parseInt(playerParams[0]), playerParams[1]);
        }
        return map;
    }

    public TreeMap<String, Integer> createPlayerScoreMap(String cricketDataset) {
        TreeMap<String, Integer> map = new TreeMap<>();
        String players[] = cricketDataset.split("\\|");
        for (String player : players) {
            String playerParams[] = player.split(",");
            map.put(playerParams[1], Integer.parseInt(playerParams[2]));
        }
        return map;
    }

    public TreeMap<String, double[]> createMatchesMap(String cricketDataset) {
        String matches[] = cricketDataset.split("\\n");
        TreeMap<String, double[]> map = new TreeMap<>();
        for (String match : matches) {
            for (String player : match.split("\\|")) {
                String playerParams[] = player.split(",");
                if (playerParams[0].equals("1") || playerParams[0].equals("2")) {
                    if (map.containsKey(playerParams[1])) {
                        double[] arr = map.get(playerParams[1]);
                        arr[0] += 1;
                        arr[1] += Integer.parseInt(playerParams[2]);
                        map.put(playerParams[1], arr);
                    } else {
                        map.put(playerParams[1], new double[]{1, Integer.parseInt(playerParams[2])});
                    }
                }
            }
        }
        return map;
    }

    public String getQuery(String cricketDataset, String query) {
        String queryParams[] = query.split(" ");
        TreeMap<Integer, String> playerPositionMap;
        TreeMap<String, Integer> playerScoreMap;
        TreeMap<String, double[]> matchesMap;
        String res = "", maxPlayer = "";
        double maxScore = 0;
        switch (queryParams[0]) {
            case "1":
                playerPositionMap = createPlayerPositionMap(cricketDataset);
                for (int playerPosition : playerPositionMap.keySet()) {
                    if (playerPosition >= Integer.parseInt(queryParams[1]) && playerPosition <= Integer.parseInt(queryParams[2])) {
                        res += String.format("%d %s\n", playerPosition, playerPositionMap.get(playerPosition));
                    }
                }
                break;
            case "2":
                playerPositionMap = createPlayerPositionMap(cricketDataset);
                playerScoreMap = createPlayerScoreMap(cricketDataset);
                for (int playerPosition : playerPositionMap.keySet()) {
                    if (playerScoreMap.get(playerPositionMap.get(playerPosition)) > Integer.parseInt(queryParams[1])) {
                        res += String.format("%d %s\n", playerPosition, playerPositionMap.get(playerPosition));
                    }
                }
                break;
            case "3":
                matchesMap = createMatchesMap(cricketDataset);
                for (String playerName : matchesMap.keySet()) {
                    double[] params = matchesMap.get(playerName);
                    if ((params[1] / params[0]) > maxScore) {
                        maxPlayer = playerName;
                        maxScore = (params[1] / params[0]);
                    }
                }
                res = String.format("The Efficient Opener is %s", maxPlayer);
                break;
            default:
                return "Invalid Query Type";
        }
        return res;
    }
}
```

### ArrayList

```java
import java.util.List;
import java.util.ArrayList;

class Passanger {
    int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getFare() {
        return fare;
    }

    public void setFare(float fare) {
        this.fare = fare;
    }

    float fare;

    public Passanger(int id, float fare) {
        this.id = id;
        this.fare = fare;
    }

    public static float calculateFare(int capacity, int currentCapacity) {
        if (currentCapacity <= Math.ceil(capacity / 4.0)) {
            return capacity * 1.6f;
        }
        if (currentCapacity <= Math.ceil(capacity / 2.0)) {
            return capacity * 1.3f;
        }
        return capacity;
    }
}

public class BusProb {

    public String output(int capacity, int stops, List<String> listOfInputStrings, String query) {
        String[] queryParams = query.split(", ");
        int queryType = Integer.parseInt(queryParams[0]);
        List<Integer> busQueue = new ArrayList<>();
        List<Passanger> passengerList = new ArrayList<>();
        int onCnt = 0, offCnt = 0, cnt = 0, i;
        float fare;
        float[] fares = { 0, 0, 0 };
        int[] farePass = { 0, 0, 0 };

        for (i = 0; i < stops; i++) {
            onCnt = offCnt = 0;
            for (String p : listOfInputStrings.get(i).split(" ")) {
                if (p.startsWith("+")) {
                    onCnt++;
                }
                if (p.startsWith("-")) {
                    offCnt++;
                }
            }
            cnt += onCnt - offCnt;

            for (String p : listOfInputStrings.get(i).split(" ")) {
                if (p.startsWith("+")) {
                    busQueue.add(Integer.parseInt(p.substring(1)));
                    passengerList.add(new Passanger(Integer.parseInt(p.substring(1)), Passanger.calculateFare(capacity, cnt)));
                } 
                if(p.startsWith("-")) {
                    busQueue.removeIf(p1 -> p1 == Integer.parseInt(p.substring(1)));
                }
            }
        }

        switch (queryType) {
            case 1:
                onCnt = offCnt = 0;
                for (i = 0; i < stops; i++) {
                    for (String p : listOfInputStrings.get(i).split(" ")) {
                        if (p.startsWith("+")) {
                            onCnt++;
                        } else {
                            offCnt++;
                        }
                    }
                }
                return String.format("%d passengers got on the bus and %d passengers got out of the bus", onCnt,
                        offCnt);

            case 2:
                fares[0] = capacity * 1.6f;
                fares[1] = capacity * 1.3f;
                fares[2] = capacity;
                farePass[0] = (int) passengerList.stream().filter(p -> p.getFare() == fares[0]).count();
                farePass[1] = (int) passengerList.stream().filter(p -> p.getFare() == fares[1]).count();
                farePass[2] = (int) passengerList.stream().filter(p -> p.getFare() == fares[2]).count();

                return String.format(
                        "%d passengers traveled with a fare of %.1f, %d passengers traveled with a fare of %.1f and %d passengers traveled with a fare of %.1f",
                        farePass[0], fares[0], farePass[1], fares[1], farePass[2], fares[2]);

            case 3:
                fare = passengerList.stream()
                        .filter(p -> p.getId() == Integer.parseInt(queryParams[1]))
                        .map(p -> p.getFare())
                        .reduce(0.0f, Float::sum);
                return String.format("Passenger %s spent a total fare of %.1f", queryParams[1], fare);

            case 4:
                cnt = (int) passengerList.stream().filter(p -> p.getId() == Integer.parseInt(queryParams[1])).count();
                return String.format("Passenger %s has got on the bus for %d times",
                        queryParams[1], cnt);

            case 5:
                // Check if passenger exists
                if (busQueue.removeIf(p1 -> p1 == Integer.parseInt(queryParams[1]))) {
                    return String.format("Passenger %s was inside the bus at the end of the trip",
                            queryParams[1]);
                }
                return String.format("Passenger %s was not inside the bus at the end of the trip",
                        queryParams[1]);
            default:
                return "Invalid Query Type";
        }
    }
}
```

### HashSet

`Hashset.java`

```java
import java.util.HashSet;

public class Hashset {

    public static String getOut(int numberOfMatches, String squads, int squad1, int squad2) {
        // write your code here
        String res = "";
        String[] matchSet = squads.split("#");
        String[] players;
        HashSet<String> intersectionSet = new HashSet<String>(),
                unionSet = new HashSet<String>(),
                inMatchSet = new HashSet<String>(),
                notInMatchSet = new HashSet<String>();

        for (int i = 0; i < matchSet.length; i++) {
            players = matchSet[i].split(" ");
            HashSet<String> curSet = new HashSet<String>();
            for (String playerName : players) {
                curSet.add(playerName);
            }
            if (i == 0) {
                intersectionSet.addAll(curSet);
            } else {
                intersectionSet.retainAll(curSet);
            }
            unionSet.addAll(curSet);
            if (i == squad1 - 1) {
                notInMatchSet.addAll(curSet);
            }
            if (i == squad2 - 1) {
                inMatchSet.addAll(curSet);
            }
        }
        unionSet.removeAll(notInMatchSet);
        inMatchSet.retainAll(unionSet);
        res = String.format("%s, %s", String.join(" ", intersectionSet), String.join(" ", inMatchSet));
        return res;
    }
}
```

## Functional Programming : Lambda, Streams

`LambdaFn.java`

```java
import java.util.*;
import java.util.stream.Collectors;

public class LambdaFn {

    public boolean isNarcissisticNumber(String s) {
        long r = 0;
        for (int i = 0; i < s.length(); i++) {
            long l = Long.parseLong(s.charAt(i) + "");
            r += Math.pow(l, s.length());
        }
        return r == Long.parseLong(s);
    }

    public List<Long> functionalProgramming(List<String> listOfIntegers) {
        //Write your code here
        List<Long> outputList = Collections.emptyList();
        outputList = listOfIntegers.stream()
                .filter(s -> isNarcissisticNumber(s))
                .map(s -> Long.valueOf(s))
                .collect(Collectors.toList());
        return outputList;
    }
}
```

## Multithreading

`Solution.java`

```java
class Task1 extends Thread {
    public static int beg, a;

    public void run() {
        try {
            for (int i = beg; i < a + beg; i++) {
                synchronized (Solution.i) {
                    int index = Integer.parseInt(Solution.i);
                    Solution.threadArray[index++] = i;
                    Solution.i = Integer.toString(index);
                    System.err.printf("1: %d\n",index);
                    Thread.sleep(3);
                }
            }
        } catch (Exception e) {
            Thread.currentThread().interrupt();
        }
    }
}

class Task2 extends Thread {
    public static int beg, a;

    public void run() {
        try {
            for (int i = beg; i < a + beg; i++) {
                synchronized (Solution.i) {
                    Thread.sleep(6);
                    int index = Integer.parseInt(Solution.i);
                    Solution.threadArray[index++] = i;
                    Solution.i = Integer.toString(index);
                    System.err.printf("2: %d\n",index);
                }
            }
        } catch (Exception e) {
            Thread.currentThread().interrupt();
        }
    }
}

class Task3 extends Thread {
    public static int beg, a;

    public void run() {

        try {
            for (int i = beg; i < a + beg; i++) {
                synchronized (Solution.threadArray) {
                int index = Integer.parseInt(Solution.i);
                Solution.threadArray[index++] = i;
                Solution.i = Integer.toString(index);
                }
            }
        } catch (Exception e) {
            Thread.currentThread().interrupt();
        }
    }
}
public class Solution {
    public static final int[] threadArray = new int[300];
    public static volatile String i = 0 + "";

    public boolean test() throws InterruptedException {
        Task1 task1 = new Task1();
        Task2 task2 = new Task2();
        Task3 task3 = new Task3();
        Thread task2Thread = new Thread(task2);
        Thread task3Thread = new Thread(task3);
        task1.start();
        task2Thread.start();
        task1.join();
        task2Thread.join();
        task3Thread.start();
        int first = Task1.a + Task2.a;
        int containsSecondThread = Task1.a;
        String oneAndTwo = "";
        String sizeOfTask1 = "";
        for (int i = 0; i < first; i++) {
            oneAndTwo += threadArray[i] + " ";
        }
        for (int i = 0; i < containsSecondThread; i++) {
            sizeOfTask1 += threadArray[i] + " ";
        }
        int begOfTask3 = Task3.beg;
        String checkingString = "";
        for (int i = begOfTask3; i < threadArray.length; i++) {
            checkingString += i + " ";
        }
        String task3String = "";
        for (int j = begOfTask3; j < threadArray.length; j++) {
            task3String += threadArray[j] + " ";
        }
        if ((!oneAndTwo.contains(begOfTask3 + "") && sizeOfTask1.contains(Task2.beg + ""))
                && task3String.equals(checkingString)) {
            return true;
        }
        return false;
    }

    public static void main(String[] args) throws InterruptedException {
        Scanner sc = new Scanner(System.in);
        Solution solution = new Solution();
        int one = sc.nextInt();
        Task1.a = one;
        Task1.beg = 0;
        int two = sc.nextInt();
        Task2.a = two;
        Task2.beg = one;
        int three = sc.nextInt();
        Task3.a = three;
        Task3.beg = one + two;
        System.out.print(solution.test());
        sc.close();
    }
}
```

## Regular Expression

`RegEx.java`

```java
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegEx {

    public String findCardTypeNumbers(String conversation, String cardType) {
        // Write your code here
        StringBuilder res = new StringBuilder();
        Pattern pattern;
        Matcher matcher;

        switch (cardType) {
            case "Visa":
                pattern = Pattern.compile("\\b4(\\d{15}|\\d{12})\\b");
                break;

            case "American Express":
                pattern = Pattern.compile("\\b(34|37)\\d{13}\\b");
                break;

            case "Discover":
                pattern = Pattern.compile("\\b(65\\d{14})|(6011\\d{12})\\b");
                break;

            case "JCB":
                pattern = Pattern.compile("\\b((2131|1800)\\d{11})|(35\\d{14})\\b");
                break;
            default:
                return "Not a valid card type";
        }

        matcher = pattern.matcher(conversation);
        while (matcher.find()) {
            res.append(matcher.group() + " ");
        }

        return res.toString().trim();
    }
}
```

## Database Connectivity

`RunningScripts.java`

```java
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import org.apache.ibatis.jdbc.ScriptRunner;

public class RunningScripts {

    public void runDbScript() throws Exception {
        Connection conn = DbUtil.getConnection();
        ScriptRunner runner = new ScriptRunner(conn);
        InputStreamReader reader = new InputStreamReader(new FileInputStream("db.sql"));
        runner.runScript(reader);
        reader.close();
        DbUtil.closeConnection(conn);
    }
}
```

`DBUtil.java`

```java
import java.sql.*;

public class DbUtil {
	private static String DB_URL = "jdbc:mysql://localhost:3306/grocery";
	private static String USERNAME = "user1";
	private static String PASSWORD = "MySQL123$";

	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}

	public static void closeConnection(Connection con) {
		try {
			con.close();
		} catch (Exception e) {

		}
	}
}
```

`DbOperations.java`

```java
import DbUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DbOperations {

    public boolean insertCategory(String type) throws SQLException {
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO category(type) values (?)");
            stmt.setString(1, type);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
        }
        return false;
    }

    public ArrayList getCategoryById(int id) throws SQLException {
        ArrayList res = new ArrayList();
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT id, type FROM category where id = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                res.add(rs.getInt("id"));
                res.add(rs.getString("type"));
            }
            return res;
        } catch (Exception e) {
        }
        return null;
    }

    public ResultSet getAllCategory() throws SQLException {
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT id, type FROM category");
            ResultSet rs = stmt.executeQuery();
            return rs;
        } catch (Exception e) {
        }
        return null;
    }

    public boolean insertProduct(String name, float price, String type) throws SQLException {
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt1 = conn.prepareStatement("SELECT id FROM category where type = ?");
            stmt1.setString(1, type);
            ResultSet rs = stmt1.executeQuery();

            int categoryId = -1;
            while (rs.next()) {
                categoryId = rs.getInt("id");
            }
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO product(name, price, category_id) values (?,?,?)");
            stmt.setString(1, name);
            stmt.setFloat(2, price);
            stmt.setInt(3, categoryId);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
        }
        return false;
    }

    public ArrayList getProductById(int id) throws SQLException {
        ArrayList res = new ArrayList();
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement("select id, name, price, category_id from product where id = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                res.add(rs.getInt("id"));
                res.add(rs.getString("name"));
                res.add(rs.getFloat("price"));
                res.add(rs.getInt("category_id"));
            }
            return res;
        } catch (Exception e) {
        }
        return null;
    }

    public ResultSet getAllProduct() throws SQLException {
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement("select id, name, price, category_id from product");
            ResultSet rs = stmt.executeQuery();
            return rs;
        } catch (Exception e) {
        }
        return null;
    }

    public boolean insertOrder(String product_name, Date date) throws SQLException {
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt1 = conn.prepareStatement("SELECT id FROM product where name = ?");
            stmt1.setString(1, product_name);
            ResultSet rs = stmt1.executeQuery();
            int productId = -1;
            while (rs.next()) {
                productId = rs.getInt("id");
            }
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO product(product_id, order_date) values (?,?)");
            stmt.setInt(1, productId);
            stmt.setDate(2, date);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
        }
        return false;
    }

    public ArrayList getOrderById(int id) throws SQLException {
        ArrayList res = new ArrayList();
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT id, product_id, order_date FROM orders where id = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                res.add(rs.getInt("id"));
                res.add(rs.getInt("product_id"));
                res.add(rs.getDate("order_date"));
            }
            return res;
        } catch (Exception e) {
        }
        return null;
    }

    public ResultSet getAllOrder() throws SQLException {
        try {
            Connection conn = DbUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement("select id, product_id, order_date from orders");
            ResultSet rs = stmt.executeQuery();
            return rs;
        } catch (Exception e) {
        }
        return null;
    }
}
```
