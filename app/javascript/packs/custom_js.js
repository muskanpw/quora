jQuery(document).ready(function(){
  jQuery(document).on('click', '.show-hide-answer', function(){
  	console.log(jQuery(this).parent().find('div.ans-block'))
    jQuery(this).parent().find('div.ans-block').toggle()
  })
  
})
