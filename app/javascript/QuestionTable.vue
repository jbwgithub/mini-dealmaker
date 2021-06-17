<template>
  <b-container fluid>
    <b-table
      striped hover
      :items="items"
      :fields="fields">

      <template #cell(name)="row">
        {{ row.value.first }} {{ row.value.last }}
      </template>

      <template #cell(templates)>
        <b-form-select size="me" class="mr-1 rounded">
          <option v-for="template in templates" v-bind:key="template.id">
            {{ template.name }}
            {{ template.id }}
          </option>
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

       <template v-slot:cell(title)='row'>
        <b-form-input v-model='row.item.title' v-on:change.native="dataChanged"/>
      </template>

      <template v-slot:cell(description)='row'>
        <b-form-input v-model='row.item.description' v-on:change.native="dataChanged"/>
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
        { key: 'title', lable: 'Title' },
        { key: 'description', lable: 'Description' },
        { key: 'templates', label: 'Templates' },
        { key: 'actions', label: 'Actions' }],
      items: [],
      selected: null,
      templates: [],
      form: {
        option: '',
      }
    };
  },
  created() {
    setCSRFToken(axios, document)
    axios.get('/questions.json').then(response => (this.items = response.data));
    axios.get('/templates.json').then(response => (this.templates = response.data));
  },
  computed: {
    // selectedOption: function() {
    //   const report = this.templates.find(option => option.name === this.form.option);
    //     return report;
    // }
  },
  methods: {
    dataChanged(e) {
      let row = e.target.closest('tr')
      let question = this.items[row.rowIndex - 1]

      axios.put('/questions/' + question.id, {
        question: {
          title: row.children[1].children[0]._value,
          description: row.children[2].children[0]._value
        }
      });
    },
    addQuestion(e) {
      let row = e.target.closest('tr')
      // let template = this.templates[row.rowIndex - 1]

      console.log("REACHED", this.form)
      // axios.put('/questions/' + question.id, {
      //   question: {
      //     template_ids: template_ids.push()
      //   }
      // });
    },
    deleteQuestion(e) {
      let row = e.target.closest('tr')
      let question = this.items[row.rowIndex - 1]
      axios.delete('/questions/' + question.id);
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
