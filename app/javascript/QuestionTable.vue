<template>
  <b-container fluid>
    <b-table
      striped hover
      :items="items"
      :fields="fields">

      <template #cell(name)="row">
        {{ row.value.first }} {{ row.value.last }}
      </template>

      <template #cell(no)>
        <select v-model="sorting" v-on:change="getSelectedItem" size="me" class="mr-1 rounded">
          <option v-for="template in templates" v-bind:key="template.id">
            {{ template.name }}
            {{ template.id }}
          </option>
        </select>
      </template>

      <template #cell(templates)>
        <b-form-select v-on:change.native="getSelectedItem"
        size="me" class="mr-1 rounded">

        <b-form-select-option v-for="template in templates" v-bind:key="template.id"
        v-bind:value="template.name">
          {{ template.id }}
          {{ template.name }}
        </b-form-select-option>

        </b-form-select>
      </template>

      <template #cell(actions)>
        <b-button size="me" @click="addQuestion" class="mr-1 btn-success">
          Add to Template
        </b-button>
        <b-button size="me" @click="deleteQuestion" class="mr-1 btn-danger">
          Delete Question
        </b-button>
      </template>

       <template v-slot:cell(ask)='row'>
        <b-form-input v-model='row.item.ask' v-on:change.native="dataChanged"/>
      </template>

      <template v-slot:cell(answer)='row'>
        <b-form-textarea v-model='row.item.answer' v-on:change.native="dataChanged"
        rows="3" placeholder="Answer here"/>
      </template>
    </b-table>
  </b-container>
</template>

<script>
import axios from 'axios'
import { setCSRFToken } from './packs/csrf-token.js'

export default {
  data() {
    return {
      fields: [{ key: 'id', label: 'ID'},
        { key: 'ask', label: 'Question' },
        { key: 'answer', label: 'Answer' },
        { key: 'templates', label: 'Templates' },
        { key: 'actions', label: 'Actions' }],
      items: [],
      templates: [],
      newTemplateQuestions: []
    };
  },
  created() {
    setCSRFToken(axios, document)
    axios.get('/questions.json').then(response => (this.items = response.data));
    axios.get('/templates.json').then(response => (this.templates = response.data));
    axios.get('/templates.json').then(response => (this.templates = response.data));
  },
  computed: {
    sortKey: {
      get() {
        return this.sorting.split(' ')[0];
      }
    }
  },
  methods: {
    dataChanged(e) {
      let row = e.target.closest('tr')
      let question = this.items[row.rowIndex - 1]

      axios.put('/questions/' + question.id, {
        question: {
          ask: row.children[1].children[0]._value,
          answer: row.children[2].children[0]._value
        }
      });
    },
    getSelectedItem(e) {
      let row = e.target.closest('tr')
      let currQuestion = this.items[row.rowIndex - 1]
      let tempName = e.target.value

      let currTempId = null
      for (let template of this.templates) {
        if (template.name === tempName) {
          currTempId = template.id;
        }
      }

      // Check and set for first time or reset new template-question match to be sent to db:
      let questionsWithNewTemplates = []
      for (let obj of this.newTemplateQuestions) {
        questionsWithNewTemplates.push(obj.question_id)
      }

      if (questionsWithNewTemplates.includes(currQuestion.id)) {
        for (let newTemplateQuestion of this.newTemplateQuestions) {
          if (newTemplateQuestion.question_id === currQuestion.id) {
            newTemplateQuestion.template_id = currTempId;
          }
        }
      } else {
        this.newTemplateQuestions.push({
          question_id: currQuestion.id,
          template_id: currTempId
        });
      }

      console.log(this.newTemplateQuestions)
      // console.log('TEMPLATE NAME:', tempName, 'TEMPLATE ID:', tempId, 'QUESTION:', currQuestion.title)
    },
    addQuestion(e) {
      let row = e.target.closest('tr')
      let question = this.items[row.rowIndex - 1]

      for (let newTemplateQuestion of this.newTemplateQuestions) {
        if (newTemplateQuestion.question_id === question.id) {
          axios.post('./template_questions', {
            template_question: {
              template_id: newTemplateQuestion.template_id,
              question_id: newTemplateQuestion.question_id
            }
          })
        }
      }
    },
    deleteQuestion(e) {
      let row = e.target.closest('tr')
      let question = this.items[row.rowIndex - 1]
      axios.delete('/questions/' + question.id);

      axios.delete('/questions/' + question.id)
      .then(response => {
        const index = this.questions.findIndex(question => question.id === id)
        if (~index)
          this.questions.splice(index, 1) // Delete the question, where it currently exists in props
        }
      );
    }
  }
}
</script>

<style scoped>
  body { padding: 1rem; }

.bootstrap-inside {
      @import '~bootstrap/scss/bootstrap.scss';
   }
</style>
