---
title: Java Programming Masterclass
author: Purbayan Chowdhury(@shivishbrahma)
created_ts: 2024-07-07 15:48:58
modified_ts: 2024-07-08 01:22:24
---

## Table of Contents

- Control Flow Statements
- Object Oriented Programming
  - Classes and Objects
  - Polymorphism
  - Inheritance
- Abstract Class
- Package
- Exception
- Collections
  - HashSet
  - ArrayList
  - HashMap
  - TreeMap
- Generics
- Functional Programming
- Multithreading
- Regular Expression
- Database Connectivity

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

## Generic Class - Not completed

```java
public class StudentClass {
    public String getQuery(String studentData,String query){
      String[] queryParams = query.split(",");
      return null;
    }
}

public class ScoreList<Type extends Number> {
    //Write your code
     ArrayList<Type> list = new ArrayList<>();

    void addElement(Type t){
        list.add(t);
    }

    void removeElement(Type t) {
        list.remove(t);
    }

    Type getElement(int i) {
        return list.get(i);
    }
}

public class StudentList<Type> {
    //Write your code
    ArrayList<Type> list = new ArrayList<>();

    void addElement(Type t){
        list.add(t);
    }

    void removeElement(Type t) {
        list.remove(t);
    }

    Type getElement(int index) {
        return list.get(index);
    }

    StudentList<Type> beginsWith(String prefix) {
        StudentList<Type> res = new StudentList<>();
        for(int i=0; i<list.size(); i++) {
            if(String.valueOf(list.get(i)).startsWith(prefix)){
                res.addElement(list.get(i));
            }
        }
        return res;
    }

    StudentList<Type> bloodGroupOf(String[] bloodGroups, String bloodGroup) {
        StudentList<Type> res = new StudentList<>();
        for(int i=0; i<bloodGroups.length; i++) {
            if(bloodGroup.equalsIgnoreCase(bloodGroups[i])){
                res.addElement(list.get(i));
            }
        }
        return res;
    }

    int thresholdScore(int score) {
        int count;
        for(int i=0; i<list.size(); i++) {
            if(list.get(i) >= score) {
                count++;
            }
        }
        return count;
    }
}
```
