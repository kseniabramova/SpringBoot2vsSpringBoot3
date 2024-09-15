package com.example.graalvm

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import java.util.*

@RestController
class PingController {

    @GetMapping("/ping")
    fun ping(): String {
        return "pong"
    }

    @GetMapping("/performance")
    fun testPerformance(): ResponseEntity<String> {
        val startTime = System.currentTimeMillis()

        // Example of working with memory: sorting a large array
        val largeArray = generateLargeArray(1000000)
        Arrays.sort(largeArray)

        val endTime = System.currentTimeMillis()
        val duration = endTime - startTime

        return ResponseEntity.ok("Execution time: $duration ms")
    }

    private fun generateLargeArray(size: Int): IntArray {
        val random: Random = Random()
        val array = IntArray(size)
        for (i in 0 until size) {
            array[i] = random.nextInt()
        }
        return array
    }

}
