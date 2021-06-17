<template>
  <ul class='questions'>
    <li v-for="question in questions" :key="question.id" class='question-item'>
      {{question.ask}}: {{question.answer}}
    </li>
  </ul>
</template>

<script>
  import axios from 'axios'

  export default {
    data () {
        return {
        questions: []
        }
    },
    created () {
        axios
        .get('/questions.json')
        .then(response => (this.questions = response.data))
    }
  }
</script>

<style scoped>
ul { padding-left: 0; }

li {
  list-style: none;
  text-align: center;
}
</style>
