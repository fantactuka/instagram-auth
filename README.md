# InstagramAuth

Simple wrapper for instagram app authorization and API requesting

### Usage

InstagramAuthViewController do all authorization and send messages to `instagramAuthDelegate` which should implement `<InstagramAuthDelegate>` protocol

It also wraps some of the API requests. See `InstagramClient.h` for more

### Misc
Instagram request wrapper by Stuart Hall, with fixes for ARC-compatibility (git://github.com/stuartkhall/Instagram.git)