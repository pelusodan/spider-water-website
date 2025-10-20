'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "66576a6551b009ef13c865d6e1354378",
"favicon.png": "43dd60f5c52f93039c904c26c6a135e3",
"manifest.json": "e3082c77e93b607789bc34191be669a5",
"assets/fonts/MaterialIcons-Regular.otf": "0f3e1a74a73a66901a4fc42d58810081",
"assets/fonts/Blockstepped.ttf": "894bfc18e8fd1529415d43a891d78b31",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "f1126486ccebd15d203af7169b536fc2",
"assets/FontManifest.json": "f70b616c7b5b970d1dd1ecca38d00818",
"assets/assets/img/tidal.png": "9184be03c50fd62340f025f695ffd485",
"assets/assets/img/stew4.jpg": "35e26cef15ca6bde66788a5382475ca5",
"assets/assets/img/apple-music.png": "c15d8dd7c4cdfc07eb65d5ff66914e16",
"assets/assets/img/stew1.jpg": "fbf03930b9ed7956749c4ed39e44b54b",
"assets/assets/img/spotify.png": "44777f01984853b137cf07ffe34b9251",
"assets/assets/img/stew2.jpg": "4a1ddda2856029c4a2f51ea060ccd757",
"assets/assets/img/damn-attempt.gif": "d3f4c07676283368597f17980aa19ef3",
"assets/assets/img/emma-union.jpg": "f589cd1ff5eb27af6cceff749fd69268",
"assets/assets/img/youtube.png": "e38880227781d88fef57abfec84577f9",
"assets/assets/img/stin.png": "e07c622540e27d5ef3337d4a0be9098b",
"assets/assets/img/emma.png": "9c131bd5e3da0e9892c48ffaa7e949a2",
"assets/assets/img/youtube-music.png": "2e0d16455e0517047c2623343258e641",
"assets/assets/img/amazon-music.png": "f2fb98ff2c48cdac0624fdbc2b04710d",
"assets/assets/img/stew3.jpg": "7973c618c3b27e10ef558aa924d7a0f9",
"assets/assets/img/dan-union.jpg": "f3506f71b69c22c6b81e4014650e027d",
"assets/assets/img/album.jpg": "8993f483cb04e55264622a574c4addcb",
"assets/assets/img/bandcamp.png": "1645dd4f713379ae1a0d58d8b7f97496",
"assets/assets/img/stew5.jpg": "ec272319fc0a996203198b6be4bb593b",
"assets/assets/img/chuck.png": "3fa9c60fe6b2f3da4d203e9191537102",
"assets/assets/img/dan.png": "83d6801e0ac54750072575ab5591257d",
"assets/assets/audio/raining-beat.wav": "736a7af359e9979a66bd594d5fc02fd5",
"assets/AssetManifest.bin": "f25f26281885b274b4909b033a08a7dc",
"assets/AssetManifest.json": "8412b0e3c7f09ac8dd097478c2b9a7be",
"assets/NOTICES": "d2efeaf589e1a367a523bf837f992a16",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "8642bc7a8a859a2f3f2bbfdeb6ef290b",
"main.dart.js": "f824efe166492030c572fb240a1dc0e8",
"index.html": "f9d9041b9c8d64c2f6c708cfa7f84ae5",
"/": "f9d9041b9c8d64c2f6c708cfa7f84ae5",
"flutter_bootstrap.js": "2827d9cc1dd00afd70b1503c274ba9b4",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"icons/Icon-maskable-192.png": "bdd8d5fa30ffbd7f484e1cc087e1d271",
"icons/Icon-192.png": "bdd8d5fa30ffbd7f484e1cc087e1d271",
"icons/Icon-maskable-512.png": "3c01096eea8284b2517da10d803123d1",
"icons/Icon-512.png": "3c01096eea8284b2517da10d803123d1"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
