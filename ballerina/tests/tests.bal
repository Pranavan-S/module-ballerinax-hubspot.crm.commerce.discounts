import ballerina/test;
import ballerina/oauth2;
// import ballerina/io;



configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?; 

// for testRead
configurable string discountId= ? ;
configurable string hs_value= ? ;
configurable string hs_label= ? ;
configurable string hs_type= ? ;

configurable boolean isServerLocal = false;

OAuth2RefreshTokenGrantConfig auth = {
       clientId: clientId,
       clientSecret: clientSecret,
       refreshToken: refreshToken,
       credentialBearer: oauth2:POST_BODY_BEARER // this line should be added in to when you are going to create auth object.
   };

ConnectionConfig config = {auth : auth};
final string serviceURL = isServerLocal ? "localhost:8080" : "https://api.hubapi.com";
final Client hubspotClient = check new Client(config, serviceURL);

@test:Config{
  enable:true
}
isolated function testList() returns error?{

    GetCrmV3ObjectsDiscountsQueries params = {
        'limit: 10,
        archived: false,
        properties: ["hs_label", "hs_value", "hs_type"]
    };

    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error response = check hubspotClient->/crm/v3/objects/discounts.get({}, params);
    if response is CollectionResponseSimplePublicObjectWithAssociationsForwardPaging{
        test:assertNotEquals(response.results,[], "No discounts found");
        test:assertTrue(response.results.length() > 0, "No discounts found");
        test:assertNotEquals(response.results[0].id, (), "Discount id is not found");
        test:assertNotEquals(response.results[0].properties, (), "Discount properties are not found");
        test:assertNotEquals(response.results[0].properties["hs_type"], (), "Discount label is not found");
        test:assertNotEquals(response.results[0].properties["hs_value"], (), "Discount value is not found");
        test:assertNotEquals(response.results[0].properties["hs_label"], (), "Discount type is not found");
    }else {
        test:assertFail("Error occurred while fetching discounts");
    }
}

@test:Config{
    enable: true
}
isolated function testRead() returns error?{
    GetCrmV3ObjectsDiscountsDiscountidQueries params = {
        properties: ["hs_label", "hs_value", "hs_type"]
    };
    
    SimplePublicObjectWithAssociations|error response = check hubspotClient->/crm/v3/objects/discounts/[discountId].get({},params);
    
    if response is SimplePublicObjectWithAssociations{
        test:assertNotEquals(response.id, (), "Discount id is not found");
        test:assertNotEquals(response.properties, (), "Discount properties are not found");
        test:assertEquals(response.properties["hs_type"], hs_type, "Discount type is not correct");
        test:assertEquals(response.properties["hs_value"], hs_value, "Discount value is not correct");
        test:assertEquals(response.properties["hs_label"], hs_label, "Discount label is not correct");


    }else {
        test:assertFail("Error occurred while fetching this discount");
    }
}
