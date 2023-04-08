# Get that Home API

- API developed in Ruby on Rails 7.1.0.
- Ruby version: 3.1.2

![Landing page - Get that home](https://cdn.discordapp.com/attachments/1072664951749099633/1094309150437154977/image.png)

## Endpoints

### Sessions

- `POST /login`: Logs in with the user's credentials.
- `GET /logout`: Logs out the user.

### Users

- `POST /users`: Creates a new user.
- `GET /users/:id`: Returns the information of a specific user.
- `PATCH /users/:id`: Updates the information of a specific user.

### Properties

- `GET /properties`: Returns a list of all properties.
- `POST /properties`: Creates a new property.
- `GET /properties/:id`: Returns the information of a specific property.
- `PATCH /properties/:id`: Updates the information of a specific property.
- `DELETE /properties/:id`: Deletes a specific property.

### Favorites

- `GET /users/:id/favorites`: Returns a list of the properties marked as favorites by a specific user.
- `PATCH /users/:user_id/favorites/:property_id`: Update or change the favorite status that a user has for a specific property.

### Contacted

- `GET /users/:id/contacted`: Returns a list of properties contacted by a specific user.

## Authors

- [Cristoper Yarleque](https://github.com/CristoperYarleque)
- [Heberth Lopez](https://github.com/heblopez)

## License

- This work is licensed under a [Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License](https://creativecommons.org/licenses/by-nc-nd/3.0/). See the [LICENSE.md](https://github.com/heblopez/get-that-home-api/blob/main/LICENSE.md) file for details.
