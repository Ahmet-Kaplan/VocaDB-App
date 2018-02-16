import React from 'react'
import { View, Text, Button, ScrollView } from 'react-native'
import Album from './../Album'
import PropTypes from 'prop-types';
import images from './../../assets/images'
import style from './style'

class AlbumList extends React.Component {

    renderVertical () {
        const Header = () => (
            <View style={style.header}>
                <View style={style.headerLeft}>
                    <Text style={style.title}>{this.props.title}</Text>
                </View>
                <View style={style.headerRight}>
                    {!this.props.hideMoreButton && <Button style={style.button} title='More' onPress={() => this.props.onPressMore()} />}
                </View>
            </View>
        )

        const albums = this.props.albums.slice(0, this.props.max)

        const renderItem = album => {
            return  (
                <Album
                    key={album.id}
                    image={images.getAlbumUri(album.id)}
                    name={album.name}
                    artist={album.artistString}
                    onPress={() => this.props.onPressItem(album.id)}
                />
            )
        }

        return (
            <View style={{ }}>
                {this.props.showHeader && <Header />}
                <View>
                    {albums.map(renderItem)}
                </View>
            </View>
        )
    }

    renderHorizontal () {

        const albums = this.props.albums.slice(0, this.props.max)

        const renderItem = album => {
            return  (
                <Album
                    key={album.id}
                    image={images.getAlbumUri(album.id)}
                    name={album.name}
                    artist={album.artistString}
                    display='box'
                    onPress={() => this.props.onPressItem(album.id)}
                />
            )
        }

        if(!albums.length) {
            return (<View></View>)
        }

        const Header = () => (
            <View style={{ height: 40, flexDirection: 'row', alignItems: 'center', paddingHorizontal: 4 }}>
                <View style={{ flex: 1 }}>
                    <Text>{this.props.title}</Text>
                </View>
                <View style={{ flex: 1 }}>
                    {!this.props.hideMoreButton && <Button title='More' onPress={() => this.props.onPressMore()} />}
                </View>
            </View>
        )

        return (
            <View style={{ height: 300 }}>

                {this.props.showHeader && <Header />}

                <ScrollView horizontal={true} style={{ flex: 1 }}>
                    {albums.map(renderItem)}
                </ScrollView>

            </View>
        )
    }

    render () {
        return (this.props.horizontal) ? this.renderHorizontal() : this.renderVertical()
    }
}

AlbumList.propTypes = {
    albums: PropTypes.array,
    max: PropTypes.number,
    onPressItem: PropTypes.func,
    onPressMore: PropTypes.func,
    showHeader: PropTypes.bool,
    horizontal: PropTypes.bool,
    hideMoreButton: PropTypes.bool
};

AlbumList.defaultProps = {
    title: 'Album list',
    max: 10,
    showHeader: false,
    horizontal: false,
    hideMoreButton: false,
    albums: [],
    onPressItem: () => {},
    onPressMore: () => {}
};

export default AlbumList;