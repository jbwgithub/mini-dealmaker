import Vue from 'vue'
import App from '../App.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()

  document.body.insertBefore(app.$el, document.body.firstChild);
})
