package main

import (
	"context"
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
)

type auth struct {
	clientID     string
	clientSecret string
	Username     string `json:"username"`
	Password     string `json:"password"`
}

func generateClientSecrets(username string, clientID string, clientSecret string) string {
	secretString := username + clientID
	h := hmac.New(sha256.New, []byte(clientSecret))
	h.Write([]byte(secretString))

	calculatedHMAC := base64.StdEncoding.EncodeToString(h.Sum(nil))
	return calculatedHMAC
}

func newDefaultCP(ctx context.Context) (*cognitoidentityprovider.Client, error) {
	cfg, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		return nil, err
	}
	client := cognitoidentityprovider.NewFromConfig(cfg)
	return client, nil
}

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {

	var authParams auth
	if err := json.Unmarshal([]byte(request.Body), &authParams); err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 400,
			Body:       err.Error(),
		}, nil
	}
	authParams.clientID = request.Headers["x-client-id"]
	authParams.clientSecret = request.Headers["x-client-secret"]

	ctx := context.Background()

	client, err := newDefaultCP(ctx)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 400,
			Body:       err.Error(),
		}, nil
	}

	authInput := &cognitoidentityprovider.InitiateAuthInput{
		AuthFlow: "USER_PASSWORD_AUTH",
		ClientId: &authParams.clientID,
		AuthParameters: map[string]string{
			"USERNAME":    authParams.Username,
			"PASSWORD":    authParams.Password,
			"SECRET_HASH": generateClientSecrets(authParams.Username, authParams.clientID, authParams.clientSecret),
		},
	}

	authOutput, err := client.InitiateAuth(ctx, authInput)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 400,
			Body:       err.Error(),
		}, nil
	}

	authRes := authOutput.AuthenticationResult

	return events.APIGatewayProxyResponse{
		Body:       fmt.Sprintf("{\"token\":\"%s\"}", *authRes.IdToken),
		StatusCode: 200,
	}, nil
}

func main() {
	lambda.Start(handler)
}
