require! {
  \node-fetch : fetch
  jsonschema: { Validator }
  \./schemas
}
v = new Validator!

class Karios
  # constructor
  (@app_id, @app_key) ->

  # private funcs
  post = (url, headers, params) ->
    fetch do
      url
      {
        method: \POST
        headers: {
          'Content-Type': \application/json
          ...headers
        }
        ...do ->
          if params then body: JSON.stringify params else {}
      }
    .then (res) ->
      return Promise.reject res.statusText if res.status is 403
      res.json!

  # public funcs
  enroll: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.ENROLL
    return reject valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/enroll
    resolve post url, { @app_id, @app_key }, params

  recognize: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.RECOGNIZE
    return resolve valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/recognize
    resolve post url, { @app_id, @app_key }, params

  detect: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.DETECT
    return resolve valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/detect
    resolve post url, { @app_id, @app_key }, params

  galleryListAll: ->
    (resolve, reject) <~ new Promise _
    # post
    url = \https://api.kairos.com/gallery/list_all
    resolve post url, { @app_id, @app_key }

  galleryView: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.GALLERY_VIEW
    return resolve valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/gallery/view
    resolve post url, { @app_id, @app_key }, params

  galleryRemove: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.GALLERY_REMOVE
    return resolve valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/gallery/remove
    resolve post url, { @app_id, @app_key }, params

  galleryRemoveSubject: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.GALLERY_REMOVE_SUBJECT
    return resolve valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/gallery/remove_subject
    resolve post url, { @app_id, @app_key }, params

module.exports = Karios