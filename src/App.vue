<style>
@font-face {
  font-family: FuturamaTitle;
  src: url(assets/fr-title.ttf);
}
@font-face {
  font-family: FuturamaText;
  src: url(assets/fr-bold.ttf);
}

html,
body {
  background-color: #008ea0;
  color: white;
}

a {
  color: #ade2d0;
}

.title-image {
  display: flex;
  justify-content: center;
}

.info {
  font-family: FuturamaText;
  font-size: 1em;
  padding: 10px;
  background-color: #1a5354;
  border-radius: 5px;
  margin: 10px;
}

.extra-info {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}

.years {
  text-align: center;
}

.creators {
  display: flex;
  gap: 10px;
  justify-content: center;
}

.title {
  font-family: FuturamaTitle;
  font-size: 4em;
  color: #ade2d0;
  text-align: center;
}

.list {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.list-item {
  width: 350px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.inside-info {
  border: 3px solid #5a9599;
  border-radius: 5px;
  padding: 10px;
  margin-top: 10px;
}

.character-image-container {
  text-align: center;
}

.character-image {
  height: 200px;
  max-width: 300px;
}

.character-quote {
  font-size: 0.75em;
}
</style>

<template>
  <main class="container">
    <div class="title-image">
      <img src="./assets/logo.png" />
    </div>
    <article v-if="info" class="info">
      {{ info.synopsis }}
      <div class="extra-info">
        <div class="years">{{ info.yearsAired }}</div>
        <div class="creators">
          Created By:
          <div v-for="creator in info.creators">
            <a :href="creator.url" target="_blank">{{ creator.name }}</a>
          </div>
        </div>
      </div>
    </article>
    <article v-if="characters">
      <h1 class="title">Characters</h1>
      <div class="list">
        <div v-for="character in characters" class="info list-item">
          <div class="character-image-container">
            <img class="character-image" :src="character.images?.main" />
          </div>
          <div class="inside-info">
            Name:
            <span>
              {{ character.name?.first }}
              {{ character.name?.middle }}
              {{ character.name?.last }} </span
            ><br />
            Age: {{ character.age }}<br />
            Species: {{ character.species }} ({{ character.gender }})<br />
            Home Planet: {{ character.homePlanet }}<br />
            Occupation: {{ character.occupation }}<br />
            <i class="character-quote">
              "{{
                character.sayings?.[
                  Math.floor(Math.random() * character.sayings?.length)
                ]
              }}"
            </i>
          </div>
        </div>
      </div>
    </article>
    <article v-if="episodes">
      <h1 class="title">Episodes</h1>
      <div class="list scrollable">
        <div v-for="episode in episodes" class="info list-item">
          {{ episode.title }}
          <div class="inside-info">
            {{ episode.desc }}<br /><br />
            Writers: {{ episode.writers }}<br />
            {{ episode.originalAirDate }}
          </div>
        </div>
      </div>
    </article>
  </main>
</template>

<script setup>
import { onMounted, watch, ref } from "vue";

const info = ref(null);
const characters = ref(null);
const episodes = ref(null);

onMounted(fetchData);

async function fetchData() {
  const [infoRes, characterRes, episodesRes] = await Promise.all([
    fetch("https://api.sampleapis.com/futurama/info"),
    fetch("https://api.sampleapis.com/futurama/characters"),
    fetch("https://api.sampleapis.com/futurama/episodes"),
  ]);

  if (infoRes.ok && characterRes.ok && episodesRes.ok) {
    const [infoJson, charactersJson, episodesJson] = await Promise.all([
      infoRes.json(),
      characterRes.json(),
      episodesRes.json(),
    ]);

    info.value = infoJson[0];
    characters.value = charactersJson;
    episodes.value = episodesJson;
  } else {
    console.log("error");
    // TODO: handle error
  }
}
</script>
