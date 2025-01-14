<style></style>

<template>
  <div class="container">
    <div class="title">
      <img src="./assets/logo.png" />
    </div>
    <div v-if="info" class="info">
      {{ info.synopsis }}
      {{ info.yearsAired }}
      <div class="extra-info">
        Created By:
        <div v-for="creator in info.creators">
          <a :href="creator.url" target="_blank">{{ creator.name }}</a>
        </div>
      </div>
    </div>
    <div v-if="characters">
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
    </div>
    <div v-if="episodes">
      <div v-for="episode in episodes">
        {{ episode.title }}
        {{ episode.desc }}
        {{ episode.number }}
        {{ episode.originalAirDate }}
        {{ episode.writers }}
      </div>
    </div>
  </div>
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
