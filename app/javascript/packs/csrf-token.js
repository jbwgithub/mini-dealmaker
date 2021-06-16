function setCSRFToken(axios, document) {
  const csrfTokenQuery = document.querySelector("meta[name=csrf-token]")
  const csrfToken = csrfTokenQuery ? csrfTokenQuery.content : ''

  axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
}

export { setCSRFToken }
