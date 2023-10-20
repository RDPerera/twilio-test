import ballerina/http;
import ballerina/log;
import ballerinax/twilioremote;
import ballerinax/twilioresource;
import ballerinax/twilio;

string accountSid = "AC5cd0a8be91f091f37f9b40bc68c26e55";
string authToken = "f0d66587d88a03e651a0e20d5c43e3e2";
string toPhoneNumber = "+94712479175";
string fromPhoneNumber = "+16513215786";
string messageBody = "Hello from Ballerina!";
string recordingURL = "http://demo.twilio.com/docs/voice.xml";


twilioresource:ConnectionConfig conf_resource =
{
    auth: {
    username: accountSid,
    password: authToken
    }
};
twilioremote:ConnectionConfig conf_remote =
{
    auth: {
    username: accountSid,
    password: authToken
    }
};
twilio:ConnectionConfig twilioConfig = {
        twilioAuth: {
            accountSId: accountSid,
            authToken: authToken
        }
};

twilio:Client twilioClient = check new (twilioConfig);
twilioresource:Client twilioClientResource = check new (conf_resource);
twilioremote:Client twilioClientRemote = check new (conf_remote);

public function listAccountsResource() returns error? {
    log:printInfo("Twilio client created.");
    twilioresource:ListAccountResponse? responce = check twilioClientResource->/Accounts;
    if (responce is twilioresource:ListAccountResponse) {
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

public function listAccountsRemote() returns error? {
    twilioremote:ListAccountResponse? responce = check twilioClientRemote->listAccount();
    if (responce is twilioremote:ListAccountResponse) {
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}
//Resource Function Based
public function sendMessageResource() returns error? {
    twilioresource:CreateMessageRequest message = {
        To: toPhoneNumber,
        Body: messageBody,
        From: fromPhoneNumber
    };
    twilioresource:ApiV2010AccountMessage? responce = check twilioClientResource->/Accounts/[accountSid]/Messages.post(message);
    if (responce is twilioresource:ApiV2010AccountMessage) {
        log:printInfo("Message sent successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}
//Remote Function Based
public function sendMessageRemote() returns error? {
    twilioremote:CreateMessageRequest message = {
        To: toPhoneNumber,
        Body: messageBody,
        From: fromPhoneNumber
    };
    twilioremote:ApiV2010AccountMessage? responce = check twilioClientRemote->createMessage(accountSid, message);
    if (responce is twilioremote:ApiV2010AccountMessage) {
        log:printInfo("Message sent successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}
//Existing Function
public function sendMessage() returns error? {
    twilio:SmsResponse responce = check twilioClient->sendSms(fromPhoneNumber,toPhoneNumber,messageBody);
    if (responce is twilio:SmsResponse) {
        log:printInfo("Message sent successfully");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

//Resource Function Based
public function createCallResource() returns error? {
    twilioresource:CreateCallRequest call = {
        To: toPhoneNumber,
        From: fromPhoneNumber,
        Url: recordingURL
    };
    twilioresource:ApiV2010AccountCall? responce = check twilioClientResource->/Accounts/[accountSid]/Calls.post(call);
    if (responce is twilioresource:ApiV2010AccountCall) {
        log:printInfo("Called successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}
//Remote Function Based
public function createCallRemote() returns error? {
    twilioremote:CreateCallRequest call = {
        To: toPhoneNumber,
        From: fromPhoneNumber,
        Url: recordingURL
    };
    twilioremote:ApiV2010AccountCall? responce = check twilioClientRemote->createCall(accountSid, call);
    if (responce is twilioremote:ApiV2010AccountCall) {
        log:printInfo("Called successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}
//Existing Function
public function createCall() returns error? {
    twilio:VoiceCallInput voiceInput = {
        userInput: recordingURL,
        userInputType: twilio:MESSAGE_IN_TEXT
    };
    twilio:VoiceCallResponse? responce = check twilioClient->makeVoiceCall(fromPhoneNumber,toPhoneNumber,voiceInput)
    if (responce is twilio:VoiceCallResponse) {
        log:printInfo("Called successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

public function listSipIPAddressesResource() returns error? {
    string sip = "TKa91eff2f86181ed4a60f2000d7b2f833";
    twilioresource:ListSipIpAddressResponse? responce = check twilioClientResource->/Accounts/[accountSid]/SIP/IpAccessControlLists/[sip]/IpAddresses;
    if (responce is twilioresource:ListSipIpAddressResponse) {
        log:printInfo("Called successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

public function listSipIPAddressesRemote() returns error? {
    string sip = "TKa91eff2f86181ed4a60f2000d7b2f833";
    twilioremote:ListSipIpAddressResponse? responce = check twilioClientRemote->listSipIpAddress(accountSid, sip);
    if (responce is twilioremote:ListSipIpAddressResponse) {
        log:printInfo("Called successfully.");
        log:printInfo(responce.toString());
    } else {
        log:printError(responce.toString());
    }
}

public function main() returns error? {
    //check listSipIPAddressesResource();
    //check listSipIPAddressesRemote();
    //check listAccountsResource();
    //check listAccountsRemote();
    //check sendMessageResource();
    //check sendMessageRemote();
    //check createCallResource();
    //check createCallRemote();
}
