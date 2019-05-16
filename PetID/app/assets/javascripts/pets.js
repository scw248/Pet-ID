// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


window.addEventListener('DOMContentLoaded', (event) => {
  let id = document.querySelector('#pet-container').dataset.id
  fetch(`http://localhost:3000/users/${id}/pets.json`)
    .then(res => res.json())
    .then(pets => {
      pets.forEach(pet => {
        const { id, name, animal_type, breed, gender, birthdate, weight, image } = pet
        new Pet(id, name, animal_type, breed, gender, birthdate, weight, image)
      })
    })
})

class Pet {
  constructor(id, name, animal_type, breed, gender, birthdate, weight, image) {
    this.id = id
    this.name = name
    this.animal_type = animal_type
    this.breed = breed
    this.gender = gender
    this.birthdate = birthdate
    this.weight = weight
    this.image = image
    this.render()
  }

  petHTML() {
    return `
  <div>
    <ul class="image-list-small">
    <img src="${this.image}"/>
      <div class="details">
      <h3>${this.name}</h3>
        <div class="image-details">
          <p>Gender: ${this.gender}</p>
          <p>${this.animal_type} - ${this.breed}</p>
          <p>Weight: ${this.weight}</p>
          <p>Birthday: ${this.birthdate}</p>
        </div>
      </div>
    </ul>
  </div>
  <br>`
  }

  render() {
    const petContainer = document.getElementById('pet-container')
    const petCard = document.createElement('div')

    petCard.classList.add('pet-card')
    petCard.id = this.id
    petCard.innerHTML += this.petHTML()
    petContainer.appendChild(petCard)
  }

}

document.querySelector('.buttons').addEventListener('click', Pet.prototype.addPet())

Pet.prototype.addPet = function (e) {
  e.preventDefault()
  let data = {
    'name': e.target.name.value,
    'animal_type': e.target.animal_type.value,
    'breed': e.target.breed.value,
    'gender': e.target.gender.value,
    'birthdate': e.target.birthdate.value,
    'weight': e.target.weight.value,
    'image': e.target.image.value
  }
  fetch(`http://localhost:3000/users/${id}/pets`, {
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(res => res.json())
    .then(pets => {
      pets.forEach(pet => {
        const { id, name, animal_type, breed, gender, birthdate, weight, image } = pet
        new Pet(id, name, animal_type, breed, gender, birthdate, weight, image)
        document.getElementById('new_pet.new_pet').reset()
      })
    })
}