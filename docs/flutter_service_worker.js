'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "1e0996288348588bacf35f3da25b3fa2",
"version.json": "32e3953ee5fa8de0d60cbb5e2045f5cd",
"favicon.ico": "61c5afa859afc5b8e3289a70af35d8c8",
"index.html": "00897d9e434e3ac9c1ac0514d724bb1e",
"/": "00897d9e434e3ac9c1ac0514d724bb1e",
"main.dart.js": "e3ead1f2e42deb874329e7a8249c661f",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"manifest.json": "c408af59299e0a19a44e4138e9c4d009",
"assets/small_jpeg/308.jpeg": "4ec9e361575a399f250e276a5a04c24b",
"assets/small_jpeg/304.jpeg": "958bd4e2f999237172af880ed8d309a2",
"assets/small_jpeg/305.jpeg": "83456616e300227be79bd6e802e16c7f",
"assets/small_jpeg/309.jpeg": "753833933195c3ce6c070dc2a1bf16eb",
"assets/small_jpeg/302.jpeg": "ceee4b4a887a47caa2232bc0fd9a1d7a",
"assets/small_jpeg/303.jpeg": "6423b032e1e049a2cd9d93bde79e1ee9",
"assets/small_jpeg/301.jpeg": "f70f58bfe7e9b177e2cb1d29321169f7",
"assets/small_jpeg/306.jpeg": "af4cac4c48be4f84e46b71c6add7a76b",
"assets/small_jpeg/307.jpeg": "37c82d1d4833c7fe329c31164d8807b7",
"assets/AssetManifest.json": "8ab189f894513122f401f805e26dc086",
"assets/png/304.jpeg": "fb0a69a7b11fc1a268ace9a717b5ecc9",
"assets/png/303.png": "41ea99b191f042fa413a8dfacc49b140",
"assets/png/302.jpg": "27b500ddbdf511f48f50d3c430c2fb10",
"assets/png/301.jpg": "13a1b6b1a502b98fdaa67c9b953d7be8",
"assets/png/305.png": "7b29f2630badf5385a213635e3424f1c",
"assets/png/306.png": "2f08014eb15b6e807ad81a9cd3565691",
"assets/png/307.JPG": "151f9a239801c1522feb6e535c18b7c8",
"assets/png/309.png": "1e907a2c8896e0033cffe7c74fbc4812",
"assets/png/308.png": "ee59e393218cb81e01fa00675fa8723c",
"assets/NOTICES": "f08e02243f1b318d9db3568f158e9615",
"assets/FontManifest.json": "e23c4fcce508c2d8e84fb804dc4f008f",
"assets/AssetManifest.bin.json": "1ae838ff7cd0e75cb29d0a8a534230e2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/assets/img/303.png": "14fd282f2e651a402a179f03af49d9c7",
"assets/lib/assets/img/302.png": "cf6256b5a367be6a23e729eba012ac02",
"assets/lib/assets/img/301.png": "d8c6a74f9d9ca2885c7937e7456c8513",
"assets/lib/assets/img/305.png": "88a7589a066f37bc6d6ccfe7c4e67595",
"assets/lib/assets/img/304.png": "b0772e5935b297e349b140843e8ad32e",
"assets/lib/assets/img/306.png": "5d389850fa6aada4a1f1f1f55aae1780",
"assets/lib/assets/img/307.png": "17e3d091d210f881ce0e44e6a068b366",
"assets/lib/assets/img/309.png": "223ab89d86495aaf28cc0b0dda0c622d",
"assets/lib/assets/img/308.png": "b3a5cfa979ba73c62cc7a5d4049fd403",
"assets/lib/assets/fonts/NotoSansJP/NotoSansJP-Regular.otf": "ecfed48e463db4e31d1691c8af367730",
"assets/lib/assets/fonts/NotoSansJP/NotoSansJP-Medium.otf": "d6c74d39a44c519ff736ac55e5d28a46",
"assets/lib/assets/fonts/NotoSansJP/NotoSansJP-Light.otf": "137761c9e4b05edc375b06c256e9b65a",
"assets/lib/assets/fonts/NotoSansJP/NotoSansJP-Thin.otf": "e2b92248795c0cd02d9858aaf2a12ec2",
"assets/lib/assets/fonts/NotoSansJP/NotoSansJP-Bold.otf": "e463c4b3a2d7fbfb917831767da8c24f",
"assets/lib/assets/fonts/NotoSansJP/NotoSansJP-Black.otf": "5ce4631ec833cd0011936d5653fbd144",
"assets/AssetManifest.bin": "46c08d1afb1340842d5c38d1ea26bc81",
"assets/ticketData/307/1/rN3w8oYUrVSIOm5FmsNy%20.png": "b657ce9c4fe5471720e6083369bf90e7",
"assets/ticketData/307/2/VovxKgq6jxvpUR1Tt1IE.png": "d2f0048dc6ff8655241cda0e2a3a082c",
"assets/ticketData/309/1/xpFy9CFPYooNYyTM7BJR.png": "3e92686f8c3daf7033ef4d990ded8072",
"assets/ticketData/309/2/D8I1ft0gUJi7qEpExdXJ.png": "433a251fed6f584ce3a1ab4d923471c1",
"assets/ticketData/308/1/vFwQCzfxm2RtWSOtxUPf.png": "389a7125a125c3527fe3bcc9c39d5611",
"assets/ticketData/308/2/SCj9yLU6K0LHEG2Nz67C.png": "aaf96571cef16e21fb6ba90fb5beb21f",
"assets/ticketData/301/1/CcET4Ep0BticLNw7eMJW.png": "0503aec7f07d3b8c7be50d7b43f6524b",
"assets/ticketData/301/2/fqcZnq5lyZYgr8QYOQgq.png": "67b699dac4ec9db49f7b0209989708c4",
"assets/ticketData/306/1/eXxXbRriIVPJhKs32KCy.png": "9e18f9296f069919ebd528f6f10650d2",
"assets/ticketData/306/2/FzLWfkptonWt1CG11sQD.png": "94aa0e4e356184e8fe9ae878333f34da",
"assets/ticketData/303/1/O37qviL8cCZq9vvwqt3k.png": "7c5db1c043165811efe0d195d128d035",
"assets/ticketData/303/2/VTk3Mk6YSCJqAmfVBpbh.png": "55e0c7e915c6b318266eb3a8ef7b059d",
"assets/ticketData/304/1/a9gd6RO5Ep4f0wEtKFDv.png": "f2ce35c6f5ba9942b070a124ac185b69",
"assets/ticketData/304/2/0wwKhedzc0VOXxid28If.png": "cafbe41b726a73a1b220dd77daede1dc",
"assets/ticketData/305/1/bEa3u8aXud145ogZ2EJq%20.png": "ae47f52b1871d466f3c1acc8b9510451",
"assets/ticketData/305/2/87RF7jzOVT9AGhx7yY0R.png": "017e87ed5420959ae4157478945419c9",
"assets/ticketData/302/1/KZVtauHpVYb37hFGa8J6.png": "700037e299a509cff158a42384808add",
"assets/ticketData/302/2/4DLar8PvlmGIcB12XSDy.png": "f8a490717cf439391ea919915dedd6f7",
"assets/fonts/MaterialIcons-Regular.otf": "247d5baab0178996b4652760d6180a92",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
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
