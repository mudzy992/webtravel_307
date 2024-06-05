export const StorageConfig = {
  article: {
    destination: '../storage/photos/article/',
    urlPrefix: '/assets/photos/article/',
    maxSize: 1024 * 1024 * 3, // u bajtovima = 3MB
    maxAge: 1000 * 60 * 60 * 24 * 7,
    resize: {
      thumb: {
        width: 120,
        height: 100,
        directory: 'thumb/',
      },
      small: {
        width: 320,
        height: 240,
        directory: 'small/',
      },
    },
  },
  services : {
    destination: '../storage/photos/services/',
    urlPrefix: '/assets/photos/services/',
    maxSize: 1024 * 1024 * 3, // u bajtovima = 3MB
    maxAge: 1000 * 60 * 60 * 24 * 7,
    thumb: {
      width: 120,
      height: 100,
      directory: 'thumb/',
    },
    small: {
      width: 320,
      height: 240,
      directory: 'small/',
    },
  },
  gallery : {
    destination: '../storage/photos/gallery/',
    urlPrefix: '/assets/photos/gallery/',
    maxSize: 1024 * 1024 * 3, // u bajtovima = 3MB
    maxAge: 1000 * 60 * 60 * 24 * 7,
    thumb: {
      width: 120,
      height: 100,
      directory: 'thumb/',
    },
    small: {
      width: 320,
      height: 240,
      directory: 'small/',
    },
  },
  image : {
    destination: '../storage/photos/img/',
    urlPrefix: '/assets/photos/img/',
    maxAge: 1000 * 60 * 60 * 24 * 7,
  },
};