package edu.mum.ea.demo;

import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;



@RestController
public class StudentServiceController {

    private static Map<String, List<Student>> schooDB = new HashMap<String, List<Student>>();

    static {
        schooDB = new HashMap<String, List<Student>>();

        List<Student> lst = new ArrayList<Student>();
        Student std = new Student("Sajal", "Class IV");
        lst.add(std);
        std = new Student("Lokesh", "Class V");
        lst.add(std);

        schooDB.put("abcschool", lst);

        lst = new ArrayList<Student>();
        std = new Student("Kajal", "Class III");
        lst.add(std);
        std = new Student("Sukesh", "Class VI");
        lst.add(std);

        schooDB.put("xyzschool", lst);

    }

    @RequestMapping(value = "/getStudentDetailsForSchool/{schoolname}", method = RequestMethod.GET)
    public List<Student> getStudents(@PathVariable String schoolname) {
        System.out.println("Getting Student details for " + schoolname);

        List<Student> studentList = schooDB.get(schoolname);
        if (studentList == null) {
            studentList = new ArrayList<Student>();
            Student std = new Student("Not Found", "N/A");
            studentList.add(std);
        }
        return studentList;
    }

    @RequestMapping(value = "/ping", method = RequestMethod.GET)
    public String ping(){
        return "OK";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(){
        try(final DatagramSocket socket = new DatagramSocket()){
            socket.connect(InetAddress.getByName("8.8.8.8"), 10002);
            String ip = socket.getLocalAddress().getHostAddress();
            return "welcome"+ip;
        }catch (Exception e){
            return "welcome"+ e;
        }


    }
}