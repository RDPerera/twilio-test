import ballerina/http;
import ballerina/log;
import ballerinax/twilioresource as twilio;

string accountSid = "AC5cd0a8be91f091f37f9b40bc68c26e55";
string authToken = "f0d66587d88a03e651a0e20d5c43e3e2";
string toPhoneNumber = "+94712479175";
string fromPhoneNumber = "+16513215786";
string messageBody = "Hello from Ballerina!";
string recordingURL = "http://demo.twilio.com/docs/voice.xml";

http:CredentialsConfig authcred =
{
    username: accountSid,
    password: authToken
};

twilio:ConnectionConfig conf =
{
    auth: authcred
};

public function listAccounts() returns error? {
    twilio:Client twilioClient = check new (conf);
    log:printInfo("Twilio client created.");
    twilio:ListAccountResponse? responce = check twilioClient->/Accounts;
    if (responce is twilio:ListAccountResponse) {
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

public function sendMessage() returns error? {
    twilio:Client twilioClient = check new (conf);
    log:printInfo("Twilio client created.");
    twilio:CreateMessageRequest message = {
        To: toPhoneNumber,
        Body: messageBody,
        From: fromPhoneNumber
    };
    twilio:ApiV2010AccountMessage? responce = check twilioClient->/Accounts/[accountSid]/Messages.post(message);
    if (responce is twilio:ApiV2010AccountMessage) {
        log:printInfo("Message sent successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

public function createCall() returns error? {
    twilio:Client twilioClient = check new (conf);
    log:printInfo("Twilio client created.");
    twilio:CreateCallRequest call = {
        To: toPhoneNumber,
        From: fromPhoneNumber,
        Url: recordingURL
    };
    twilio:ApiV2010AccountCall? responce = check twilioClient->/Accounts/[accountSid]/Calls.post(call);
    if (responce is twilio:ApiV2010AccountCall) {
        log:printInfo("Called successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

public function main() returns error? {
    check listAccounts();
    check sendMessage();
    check createCall();
}
