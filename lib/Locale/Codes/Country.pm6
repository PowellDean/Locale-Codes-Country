unit module Country::Code;
use v6;

constant LOCALE_CODE_ALPHA_2 is export = 'alpha-2';
constant LOCALE_CODE_ALPHA_3 is export = 'alpha-3';
constant LOCALE_CODE_NUMERIC is export = 'numeric';

# Local hashes. No need to export as values are sent via functions.
my %code2ToCountry;
my %code3ToCountry;
my %codeNumToCountry;
my %countryToCode2;
my %countryToCode3;
my %countryToCodeNum;

# Read the data supplied at the bottom of this module and populate our
# hashes.
for $=finish.lines {
    my ($code2, $code3, $codeNum, $country) = .split(":");
    my $isoNum = sprintf("%03d", $codeNum);
    %code2ToCountry{$code2.uc} = $country.uc;
    %code3ToCountry{$code3.uc} = $country.uc;
    %codeNumToCountry{$isoNum} = $country.uc;
}

%countryToCode2 = %code2ToCountry.invert;
%countryToCode3 = %code3ToCountry.invert;
%countryToCodeNum = %codeNumToCountry.invert;

sub VERSION() is export { v0.0.1; }

sub all-country-names() is export { return %countryToCode2.keys; }

# Given the country code, return one of the other formats according
# to the locale requested
sub codeToCode($code!, $codesetOut?=LOCALE_CODE_ALPHA_2) is export {
    my $country = codeToCountry($code);
    return Any if (!$country);
    return countryToCode($country, $codesetOut);
}

multi codeToCountry(Str $aCode) is export {
    given chars($aCode) {
        when 2 { return %code2ToCountry{$aCode.uc}; }
        when 3 { return %code3ToCountry{$aCode.uc}; }
        default { die "Code must be either 2 or 3 ASCII characters"; }
    }
    return Any;
}

multi codeToCountry(Int $aCode) is export {
    my $key = sprintf("%03d", $aCode);
    return %codeNumToCountry{$key};
}

sub countryToCode($country!, $codesetOut?=LOCALE_CODE_ALPHA_2) is export {
    given $codesetOut {
        when LOCALE_CODE_ALPHA_2 { return %countryToCode2{$country.uc}; }
        when LOCALE_CODE_ALPHA_3 { return %countryToCode3{$country.uc}; }
        when LOCALE_CODE_NUMERIC { return %countryToCodeNum{$country.uc}; }
    }
}

=finish
AD:AND:020:Andorra
AE:ARE:784:United Arab Empirates
AF:AFG:004:Afghanistan
AG:ATG:028:Antigua and Barbuda
AI:AIA:660:Anguilla
AL:ALB:008:Albania
AM:ARM:051:Armenia
AN:ANT:530:Netherlands Antilles
AO:AGO:024:Angola
AQ:ATA:010:Antarctica
AR:ARG:032:Argentina
AS:ASM:016:American Samoa
AT:AUT:040:Austria
AU:AUS:036:Australia
AW:ABW:533:Aruba
AX:ALA:248:Åland Islands
AZ:AZE:031:Azerbaijan
BA:BIH:070:Bosnia and Herzegovina
BB:BRB:052:Barbados
BD:BGD:050:Bangladesh
BE:BEL:056:Belgium
BF:BFA:854:Burkina Faso
BG:BGR:100:Bulgaria
BH:BHR:048:Bahrain
BI:BDI:108:Burundi
BJ:BEN:204:Benin
BL:BLM:652:Saint-Barthélemy
BM:BMU:060:Bermuda
BN:BRN:096:Brunei Darussalam
BO:BOL:068:Bolivia
BQ:BES:535:Bonaire
BR:BRA:076:Brazil
BS:BHS:044:Bahamas
BT:BTN:064:Bhutan
BV:BVT:074:Bouvet Island
BW:BWA:072:Botswana
BY:BLR:112:Belarus
BZ:BLZ:084:Belize
CA:CAN:124:Canada
CC:CCK:166:Cocos (Keeling) Islands
CD:COD:180:Democratic Republic of Congo
CF:CAF:140:Central African Republic
CG:COG:178:Congo
CH:CHE:756:Switzerland
CI:CIV:384:Côte d'Ivoire
CK:COK:184:Cook Islands
CL:CHL:152:Chile
CM:CMR:120:Cameroon
CN:CHN:156:China
CO:COL:170:Colombia
CR:CRI:188:Costa Rica
CU:CUB:192:Cuba
CV:CPV:132:Cape Verde
CX:CXR:162:Christmas Island
CY:CYP:196:Cyprus
CZ:CZE:203:Czech Republic
DE:DEU:276:Germany
DJ:DJI:262:Djibouti
DK:DNK:208:Denmark
DM:DMA:212:Dominica
DO:DOM:214:Dominican Republic
DZ:DZA:012:Algeria
EC:ECU:218:Ecuador
EE:EST:233:Estonia
EG:EGY:818:Egypt
EH:ESH:732:Western Sahara
ER:ERI:232:Eritrea
ES:ESP:724:Spain
ET:ETH:231:Ethiopia
FI:FIN:246:Finland
FJ:FJI:242:Fiji
FM:FSM:583:Federated States of Micronesia
FO:FRO:234:Faroe Islands
FR:FRA:250:France
GA:GAB:266:Gabon
GB:GBR:826:Great Britain
GD:GRD:308:Grenada
GE:GEO:268:Georgia
GF:GUF:254:French Guiana
GG:GGY:831:Guernsey
GH:GHA:288:Ghana
GI:GIB:292:Gibraltar
GL:GRL:304:Greenland
GM:GMB:270:Gambia
GN:GIN:324:Guinea
GP:GLP:312:Guadeloupe
GQ:GNQ:226:Equatorial Guinea
GR:GRC:300:Greece
GT:GTM:320:Guatemala
GU:GUM:316:Guam
GW:GNB:624:Guinea-Bissau
GY:GUY:328:Guyana