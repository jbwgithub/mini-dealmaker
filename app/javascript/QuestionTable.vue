<template>
  <b-container fluid>
    <b-table
      striped hover
      :items="items"
      :fields="fields">

      <template #cell(name)="row">
        {{ row.value.first }} {{ row.value.last }}
      </template>

      <template #cell(actions)>
        <b-button size="me" @click="addQuestion" class="mr-1">
          Add to Template
        </b-button>
      </template>

      <template #cell(templates)>
        <b-form-select size="me" class="mr-1 rounded">
          <option v-for="template in templates" v-bind:key="template.id">
            {{ template.name }}
          </option>
        </b-form-select>
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
      templates: []
    };
  },
  created() {
    setCSRFToken(axios, document)
    axios.get('/questions.json').then(response => (this.items = response.data));
    axios.get('/templates.json').then(response => (this.templates = response.data));
  },
  props: [],
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
      let question = this.items[row.rowIndex - 1]

      axios.put('/questions/' + question.id, {
        question: {
          template_id: 1
        }
      });
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
