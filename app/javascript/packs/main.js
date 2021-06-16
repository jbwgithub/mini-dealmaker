import Vue from 'vue'
import App from './App'
import VueRouter from 'vue-router'
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import QuestionList from './components/QuestionList'

Vue.use(VueRouter);

export const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: QuestionList },
    { path: '/questions' },
  ]
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    render: h => h(App)
  }).$mount()

  document.body.insertBefore(app.$el, document.body.firstChild);
})
