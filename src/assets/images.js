const images = {
    logo: require('./img/logo.png'),
    unknownSong: require('./img/unknow_song.png'),
    unknownAlbum: require('./img/unknow_album.png'),
    unknownArtist: require('./img/unknow_artist.png'),
    placeholderUri: 'http://via.placeholder.com/90x90?text=NO_IMAGE',
    getArtistUri: id => 'http://vocadb.net/Artist/Picture/' + id,
    getAlbumUri: id => 'http://vocadb.net/Album/CoverPicture/' + id
};

export default images;