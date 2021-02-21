$(function(){
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    console.log(this)
    let formData = new FormData(this);
  })
})  