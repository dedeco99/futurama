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

.title {
  display: flex;
  justify-content: center;
}

.info {
  font-family: FuturamaText;
  font-size: 1em;
  text-align: justify;
  padding: 10px;
  background-color: #1a5354;
  border-radius: 5px;
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
</style>

<template>
  <main class="container">
    <div class="title">
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
      <div v-for="character in characters">
        <span>
          {{ character.name?.first }}
          {{ character.name?.middle }}
          {{ character.name?.last }}
        </span>
        {{ character.age }}
        <img :src="character.images?.main" />
        {{ character.gender }}
        {{ character.species }}
        {{ character.homePlanet }}
        {{ character.occupation }}
        {{
          character.sayings?.[
            Math.floor(Math.random() * character.sayings?.length)
          ]
        }}
      </div>
    </article>
    <article v-if="episodes">
      <div v-for="episode in episodes">
        {{ episode.title }}
        {{ episode.desc }}
        {{ episode.number }}
        {{ episode.originalAirDate }}
        {{ episode.writers }}
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
