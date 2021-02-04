package model

import (
	"github.com/asaskevich/govalidator"
	uuid "github.com/satori/go.uuid"
	"time"
)

const regexpEmail = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")

type User struct {
	Email string
	Name  string
}

type User struct {
	ID			string  `json:"id" valid:"uuid"`
	Name 		string	`json:"name" valid:"notnull"`
	Email 		string   `json:"email" valid:"notnull"`
	CreatedAt 	time.Time `json:"created_at" valid:"-"`
	UpdatedAt 	time.Time `json:"updated_at" valid:"-"`
}

func (user *User) isValid() error {
	_, err := govalidator.ValidateStruct(user) 

	if len(user.Name) < 3 && user.Name == nil {
		return err.New("not a valid Name")
	}

	if !regexpEmail.MAtch(user.Email){
		err.New("email", "The email field should be a valid email address!")
	}

	if err != nil {
		return err
	}
	return nil
}


func NewUser(name string, email string)(*User error){
	user := User{
		Name: name
		Email: email
	}

	user.ID = uuid.NewV4().String()
	user.CreatedAt = time.Now()

	err := user.isValid

	if err != nil{
		return nil, err
	}

	return &user, nil
}