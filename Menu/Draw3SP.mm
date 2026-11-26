#include "utils/module_tools.h"
#import "Draw3SP.h"
#include "utils/image_base64.h"
#import "Menu/XC6/OverlayView.h"
#import "ESP/mahoa.h"
#import "ESP/obfuscate.h"
#include <algorithm>
#include <map>

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define ImCalcTextSize(str) ImGui::CalcTextSize(std::string(str).c_str())

extern float weaponFontSize;
extern float nameFontSize;

extern ImColor visiblePlayerColor;
extern ImColor invisiblePlayerColor;
extern ImColor visibleBotColor;
extern ImColor invisibleBotColor;

extern ImVec4 visibleBoneColor;
extern ImVec4 invisibleBoneColor;

@implementation mao
ImDrawList *imDrawList;

CGSize screenSize;

std::vector<PlayerData> playerDataList;
std::vector<MaterialData> materialDataList;
int xWidth = 50;
int xtWidth = 10;
int hpWidth = 100;
int hpHeight = 14;
int hpHeight1 = 30;
int hpWidth1 = 110;
int hpHeight2 = 30;

int scWidth = 220;
int scHeight = 110;
int qtWidth = 220;
int qtHeight = 50;
int ZJWidth = 40;
int ZJHeight = 6;
int HPBest = 100;

extern ImFont* main_font;
extern ImFont* verdanFnt;
extern ImFont* pixelFont;

extern int colorMode;
extern bool useRainbow;
extern float rainbowSpeed;
extern ImColor BrandColor;

ImVec4 HSVtoRGB(float h, float s, float v) {
    float r, g, b;

    int i = int(h * 6.0f);
    float f = h * 6.0f - i;
    float p = v * (1.0f - s);
    float q = v * (1.0f - f * s);
    float t = v * (1.0f - (1.0f - f) * s);

    switch (i % 6) {
        case 0: r = v, g = t, b = p; break;
        case 1: r = q, g = v, b = p; break;
        case 2: r = p, g = v, b = t; break;
        case 3: r = p, g = q, b = v; break;
        case 4: r = t, g = p, b = v; break;
        case 5: r = v, g = p, b = q; break;
    }

    return ImVec4(r, g, b, 1.0f);
}

ImVec4 GetRainbowColor(float speed) {
    float hue = fmodf(ImGui::GetTime() * speed * 0.1f, 1.0f);
    return HSVtoRGB(hue, 1.0f, 1.0f);
}

std::map<std::string, float> lastHPMap;

float hp;
float distance;
bool visibility;
bool robot;
ImVec2 screen;
ImVec2 size;
std::string name;
std::string weaponName;
int team;

float lastHP = 0.0f;
float playerLastHP = 0.0f;

extern int selectedHpStyle;

namespace menu {
    namespace ESP {
        extern bool ESPBox;
        extern bool ESPLine;
        extern bool ESPSkeleton;
        extern bool skipAI;
        extern bool outoffov;
        extern bool boxOutline;
        extern bool textOutline;
        extern bool health;
        extern bool weapon;
        extern bool teamID;
        extern bool name;
        extern bool distance;

        extern bool NOUSECRASH;
        extern bool enemy_count;
        extern bool ESPMob;
        extern float items_scale;

        extern ImColor v_espcolor;
        extern ImColor nv_espcolor;
        extern ImColor nickcolor;
        extern ImColor hpcolor;
        extern ImColor itemcolor;
        extern ImColor distcolor;
        extern ImColor weapcolor;
        extern ImColor infocolor;
        extern ImColor linecolor;
        extern ImColor v_skelcolor;
        extern ImColor nv_skelcolor;
        extern ImColor v_hpcolor;
        extern ImColor nv_hpcolor;
        extern ImColor v_backcolor;
        extern ImColor nv_backvolor;
    }
    namespace aimbot {
        extern bool aimbot;
        extern bool silent;
        extern bool recoil;
        extern bool skipKnock;
        extern bool skipAI;
        extern bool visibleCheck;
        extern float iFov;
        extern float distance;
        extern float Recc;
        extern int target;
        extern int trigger;
        extern float smooth;
    }
}

id<MTLTexture> leizhaTexture;
id<MTLTexture> hongzhaTexture;
id<MTLTexture> shouleiTexture;
id<MTLTexture> sldTexture;
id<MTLTexture> ywdTexture;
id<MTLTexture> rspTexture;

id<MTLTexture> countTexture;
id<MTLTexture> count1Texture;
id<MTLTexture> count2Texture;
id<MTLTexture> count3Texture;
id<MTLTexture> count4Texture;
id<MTLTexture> count5Texture;
id<MTLTexture> quanTexture;
id<MTLTexture> playerTexture;
id<MTLTexture> robotTexture;

id<MTLTexture> M416Texture;
id<MTLTexture> M16Texture;
id<MTLTexture> GrozaTexture;
id<MTLTexture> AkmTexture;
id<MTLTexture> SCARTexture;
id<MTLTexture> MK47Texture;
id<MTLTexture> AUGTexture;
id<MTLTexture> M762Texture;
id<MTLTexture> QBZTexture;
id<MTLTexture> leiTexture;
id<MTLTexture> huoTexture;
id<MTLTexture> yanTexture;
id<MTLTexture> shanTexture;
id<MTLTexture> R1895Texture;
id<MTLTexture> P92Texture;
id<MTLTexture> P1911Texture;
id<MTLTexture> P18CTexture;
id<MTLTexture> R45Texture;
id<MTLTexture> SKSTexture;
id<MTLTexture> MINITexture;
id<MTLTexture> MK14Texture;
id<MTLTexture> VSSTexture;
id<MTLTexture> QBUTexture;
id<MTLTexture> SLRTexture;
id<MTLTexture> AWMTexture;
id<MTLTexture> M24Texture;
id<MTLTexture> K98Texture;
id<MTLTexture> MOTexture;
id<MTLTexture> LIANTexture;
id<MTLTexture> GUNTexture;
id<MTLTexture> DAOTexture;
id<MTLTexture> GUOTexture;
id<MTLTexture> UZITexture;
id<MTLTexture> TANGTexture;
id<MTLTexture> VKTTexture;
id<MTLTexture> MP5KTexture;
id<MTLTexture> UMP9Texture;
id<MTLTexture> YNTexture;
id<MTLTexture> DP28Texture;
id<MTLTexture> MG3Texture;
id<MTLTexture> M249Texture;
id<MTLTexture> DBSTexture;
id<MTLTexture> S686Texture;
id<MTLTexture> S12KTexture;

id<MTLTexture> JPTexture;
id<MTLTexture> BBTexture;
id<MTLTexture> jcTexture;
id<MTLTexture> mttTexture;
id<MTLTexture> mtTexture;
id<MTLTexture> myTexture;
id<MTLTexture> R8Texture;
id<MTLTexture> mt3Texture;

id<MTLTexture> m416Texture;
id<MTLTexture> akmTexture;
id<MTLTexture> augTexture;
id<MTLTexture> grozaTexture;
id<MTLTexture> m16Texture;
id<MTLTexture> m24Texture;
id<MTLTexture> m249Texture;
id<MTLTexture> m762Texture;
id<MTLTexture> mg3Texture;
id<MTLTexture> miniTexture;
id<MTLTexture> mk14Texture;
id<MTLTexture> mk47Texture;
id<MTLTexture> scarTexture;
id<MTLTexture> slrTexture;
id<MTLTexture> awmTexture;
id<MTLTexture> dp28Texture;
id<MTLTexture> k98Texture;
id<MTLTexture> vssTexture;
id<MTLTexture> sksTexture;
id<MTLTexture> hzTexture;

id<MTLTexture> ylTexture;
id<MTLTexture> jjbTexture;
id<MTLTexture> ztyTexture;
id<MTLTexture> ylxTexture;
id<MTLTexture> zhenTexture;

id<MTLTexture> b4Texture;
id<MTLTexture> b3Texture;
id<MTLTexture> b6Texture;
id<MTLTexture> b8Texture;

id<MTLTexture> ktTexture;
id<MTLTexture> t3Texture;
id<MTLTexture> j3Texture;
id<MTLTexture> bb3Texture;

id<MTLTexture> tleiTexture;
id<MTLTexture> tyanTexture;
id<MTLTexture> thuoTexture;

extern char customName[64];

void drawTextWithStroke(ImFont* font, float size, ImVec2 pos, ImColor color, ImColor stroke, const std::string& text, bool center = false) {
    ImDrawList* drawList = ImGui::GetBackgroundDrawList();

    if (center) {
        ImVec2 textSize = ImGui::CalcTextSize(text.c_str());
        pos.x -= textSize.x / 2.0f;
    }

    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            if (x != 0 || y != 0) {
                drawList->AddText(font, size, ImVec2(pos.x + x, pos.y + y), stroke, text.c_str());
            }
        }
    }

    drawList->AddText(font, size, pos, color, text.c_str());
}

static void DrawTextX(std::string text, ImVec2 pos, int color, bool outline, float fontSize) {
    const char *str = text.c_str();
    ImVec2 vec2 = pos;

    if (outline) {
        ImU32 outlineColor = 0xFF000000;
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x + 1, vec2.y + 1), outlineColor, fontSize, str);
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x - 1, vec2.y - 1), outlineColor, fontSize, str);
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x + 1, vec2.y - 1), outlineColor, fontSize, str);
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x - 1, vec2.y + 1), outlineColor, fontSize, str);
    }
    ImGui::GetWindowDrawList()->AddTextX(vec2, color, fontSize, str);
}

template<typename ... Args>
static std::string string_format(const std::string& format, Args ... args) {
    size_t size = 1 + snprintf(nullptr, 0, format.c_str(), args ...);
    char bytes[size];
    snprintf(bytes, size, format.c_str(), args ...);
    return std::string(bytes);
}

void DrawBox3D(ImDrawList *draw, Box3D box3d, ImColor col, float thickness) {
    Line(draw, box3d.s1, box3d.s2, col, thickness);
    Line(draw, box3d.s2, box3d.s3, col, thickness);
    Line(draw, box3d.s3, box3d.s4, col, thickness);
    Line(draw, box3d.s4, box3d.s1, col, thickness);

    Line(draw, box3d.s5, box3d.s6, col, thickness);
    Line(draw, box3d.s6, box3d.s7, col, thickness);
    Line(draw, box3d.s7, box3d.s8, col, thickness);
    Line(draw, box3d.s8, box3d.s5, col, thickness);

    Line(draw, box3d.s1, box3d.s5, col, thickness);
    Line(draw, box3d.s2, box3d.s6, col, thickness);
    Line(draw, box3d.s3, box3d.s7, col, thickness);
    Line(draw, box3d.s4, box3d.s8, col, thickness);
}

- (instancetype)initWithFrame:(ModuleControl*)control {
    self = [super init];
    if (self) {
        self.moduleControl = control;
        screenSize = [UIScreen mainScreen].bounds.size;
        screenSize.width *= [UIScreen mainScreen].nativeScale;
        screenSize.height *= [UIScreen mainScreen].nativeScale;
    }
    return self;
}

-(void)drawDrawWindow {
    ImGui::SetNextWindowSize(ImVec2(screenSize.width, screenSize.height));
    ImGui::SetNextWindowPos(ImVec2(0, 0));
    ImGui::Begin("alpha", nullptr, ImGuiWindowFlags_NoBackground | ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoInputs | ImGuiWindowFlags_NoMove);

    NSString *customNameNSString = [NSString stringWithUTF8String:customName];
    const char* ryder = [customNameNSString cStringUsingEncoding:NSUTF8StringEncoding];
    std::string str3 = ryder ? ryder : "";

    ImVec4 finalColor = (colorMode == 1)
        ? (ImVec4)GetRainbowColor(rainbowSpeed)
        : (ImVec4)BrandColor;

    ImColor drawColor = ImColor(finalColor);

    float countTexH = countTexture ? (float)countTexture.height : 0.0f;
    DrawTextX(
        str3,
        ImVec2((screenSize.width / 2) - calcTextSize(str3.c_str(), 45 / 2), 101.5f + countTexH / 2 + 35),
        drawColor,
        false,
        45
    );

    imDrawList = ImGui::GetWindowDrawList();
    std::string str = OBFUSCATE("https://instagram.com/errormvpx");

    ImVec2 textPos(screenSize.width * 0.03f, screenSize.height * 0.82f);
    float fontSize = 45.0f;
    float paddingX = 16.0f;
    float paddingY = 12.0f;

    ImVec2 textSize = ImGui::CalcTextSize(str.c_str(), nullptr, false, fontSize);
    ImVec2 bgMin(textPos.x - paddingX, textPos.y - paddingY);
    ImVec2 bgMax(textPos.x + textSize.x + paddingX, textPos.y + fontSize + paddingY);
    imDrawList->AddRectFilled(bgMin, bgMax, ImColor(0, 0, 0, 150), 8.0f);
    imDrawList->AddTextX(textPos, ImColor(255, 60, 60, 255), fontSize, str.c_str());

    readFrameData(ImVec2(screenSize.width / 2, screenSize.height / 2), playerDataList, materialDataList);

    for (MaterialData materialData : materialDataList) {
        if (self.moduleControl->playerSwitch.WZWZStatus) {
            if (materialData.name == "[Warning]Grenade") {
                imDrawList->AddImage((__bridge ImTextureID) leizhaTexture, ImVec2(screenSize.width / 2 - leizhaTexture.width / 2, 230), ImVec2(screenSize.width / 2 + leizhaTexture.width / 2, 230 + leizhaTexture.height), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
            }
            if (materialData.name == "[Warning]Bomb Waning") {
                imDrawList->AddImage((__bridge ImTextureID) hongzhaTexture, ImVec2(screenSize.width / 2 - hongzhaTexture.width / 2, 180), ImVec2(screenSize.width / 2 + hongzhaTexture.width / 2, 180 + hongzhaTexture.height), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
            }
            if (materialData.name == "[Warning]Grenade") {
                imDrawList->AddImage((__bridge ImTextureID) sldTexture, ImVec2(materialData.screen.x + 190 - qtWidth + 1, materialData.screen.y - 5 - qtHeight + 1), ImVec2(materialData.screen.x + 190 - qtWidth + 1 + qtHeight - 2, materialData.screen.y - 5 - qtHeight + qtHeight - 1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
            }
            if (materialData.name == "[Warning]Smoke") {
                imDrawList->AddImage((__bridge ImTextureID) ywdTexture, ImVec2(materialData.screen.x + 190 - qtWidth + 1, materialData.screen.y - 5 - qtHeight + 1), ImVec2(materialData.screen.x + 190 - qtWidth + 1 + qtHeight - 2, materialData.screen.y - 5 - qtHeight + qtHeight - 1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
            }
            if (materialData.name == "[Warning]Molto") {
                imDrawList->AddImage((__bridge ImTextureID) rspTexture, ImVec2(materialData.screen.x + 190 - qtWidth + 1, materialData.screen.y - 5 - qtHeight + 1), ImVec2(materialData.screen.x + 190 - qtWidth + 1 + qtHeight - 2, materialData.screen.y - 5 - qtHeight + qtHeight - 1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
            }

            if (materialData.distance != -100) {
                if (materialData.name == "motorcycle" ||
                    materialData.name == "3 Wheel Bike" ||
                    materialData.name == "Little Lamb" ||
                    materialData.name == "bouncing" ||
                    materialData.name == "Coupe" ||
                    materialData.name == "Car" ||
                    materialData.name == "UAZ" ||
                    materialData.name == "Ofuna" ||
                    materialData.name == "Motorboat" ||
                    materialData.name == "宝宝巴士" ||
                    materialData.name == "装甲车" ||
                    materialData.name == "UAZ车" ||
                    materialData.name == "雪地摩托" ||
                    materialData.name == "Snowmobile" ||
                    materialData.name == "皮卡" ||
                    materialData.name == "双人Coupe") {
                    std::string vStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(vStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, vStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(vStr.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, vStr.c_str());
                }

                if (self.moduleControl->playerSwitch.Vehiclebox) {
                    DrawBox3D(imDrawList, materialData.objbox3d, ImColor(255, 165, 0), 2.0f);
                }

                if (self.moduleControl->playerSwitch.Vehiclehf) {
                    if (materialData.distance > 10 && materialData.VehicleHP > 0) {
                        imDrawList->AddRectFilled({materialData.screen.x - 6 - ZJWidth, materialData.screen.y + 28 - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleHP / 100, materialData.screen.y + 28}, ImColor(220, 20, 60, 150), 10.0f);
                        imDrawList->AddRectFilled({materialData.screen.x - 6 - ZJWidth, materialData.screen.y + 37 - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleFuel / 100, materialData.screen.y + 37}, ImColor(30, 144, 255, 180), 10.0f);
                        imDrawList->AddRect({materialData.screen.x - 6 - ZJWidth, materialData.screen.y + 28 - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleHP / 100, materialData.screen.y + 28}, ImColor(255, 255, 255, 150), 10.0f, 0, 1.0f);
                        imDrawList->AddRect({materialData.screen.x - 6 - ZJWidth, materialData.screen.y + 37 - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleFuel / 100, materialData.screen.y + 37}, ImColor(255, 255, 255, 150), 10.0f, 0, 1.0f);
                    }
                }

                if (materialData.name == "[Box]") {
                    std::string bStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(bStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, bStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(bStr.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, bStr.c_str());
                }

                if (self.moduleControl->playerSwitch.Airdropbox) {
                    DrawBox3D(imDrawList, materialData.objbox3d, ImColor(91, 206, 200), 2.0f);
                }

                if (materialData.name == "Box") {
                    std::string mStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(mStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, mStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(mStr.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, mStr.c_str());
                }
                if (materialData.name == "[Throwable]" || materialData.name == "Throwable" || materialData.name == "信号AR") {
                    std::string tStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(tStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, tStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(tStr.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 20, 147), 21, tStr.c_str());
                }

                if ((self.moduleControl->playerSwitch.QBU && materialData.name == "QBU") ||
                    (self.moduleControl->playerSwitch.SLR && materialData.name == "SLR") ||
                    (self.moduleControl->playerSwitch.SKS && materialData.name == "SKS") ||
                    (self.moduleControl->playerSwitch.Mini14 && materialData.name == "Mini14") ||
                    (self.moduleControl->playerSwitch.M24 && materialData.name == "M24") ||
                    (self.moduleControl->playerSwitch.Kar98k && materialData.name == "Kar98k") ||
                    (self.moduleControl->playerSwitch.Mk14 && materialData.name == "Mk14") ||
                    (self.moduleControl->playerSwitch.MosinNagant && materialData.name == "Mosin Nagant") ||
                    (self.moduleControl->playerSwitch.MK12 && materialData.name == "MK12") ||
                    (self.moduleControl->playerSwitch.AMR && materialData.name == "AMR") ||
                    (self.moduleControl->playerSwitch.AWM && materialData.name == "AWM")) {
                    std::string sStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(sStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, sStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(sStr.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, sStr.c_str());
                }

                if ((self.moduleControl->playerSwitch.M762 && materialData.name == "M762") ||
                    (self.moduleControl->playerSwitch.SCARL && materialData.name == "SCAR-L") ||
                    (self.moduleControl->playerSwitch.M416 && materialData.name == "M416") ||
                    (self.moduleControl->playerSwitch.M16A4 && materialData.name == "M16A4") ||
                    (self.moduleControl->playerSwitch.Mk47 && materialData.name == "Mk47") ||
                    (self.moduleControl->playerSwitch.G36C && materialData.name == "G36C") ||
                    (self.moduleControl->playerSwitch.QBZ && materialData.name == "QBZ") ||
                    (self.moduleControl->playerSwitch.Groza && materialData.name == "Groza") ||
                    (self.moduleControl->playerSwitch.AUG && materialData.name == "AUG") ||
                    (self.moduleControl->playerSwitch.AKM && materialData.name == "AKM") ||
                    (self.moduleControl->playerSwitch.DP28 && materialData.name == "DP-28") ||
                    (self.moduleControl->playerSwitch.M249 && materialData.name == "M249") ||
                    (self.moduleControl->playerSwitch.MG3 && materialData.name == "MG3")) {
                    std::string rStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(rStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, rStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(rStr.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, rStr.c_str());
                }

                if ((self.moduleControl->playerSwitch.Grenade && materialData.name == "Grenade") ||
                    (self.moduleControl->playerSwitch.Smoke && materialData.name == "Smoke") ||
                    (self.moduleControl->playerSwitch.Molto && materialData.name == "Molto")) {
                    std::string gStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(gStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, gStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(gStr.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, gStr.c_str());
                }

                if ((self.moduleControl->playerSwitch.Level2 && (materialData.name == "Defend" || materialData.name == "2 Level")) ||
                    (self.moduleControl->playerSwitch.Level3Vest && materialData.name == "Level 3 Vest") ||
                    (self.moduleControl->playerSwitch.二级包 && materialData.name == "二级包") ||
                    (self.moduleControl->playerSwitch.Level3Bag && materialData.name == "Level 3 Bag") ||
                    (self.moduleControl->playerSwitch.Level3 && materialData.name == "Level 3")) {
                    std::string dStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(dStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, dStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(dStr.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, dStr.c_str());
                }

                if ((self.moduleControl->playerSwitch.PainKiller && materialData.name == "PainKiller") ||
                    (self.moduleControl->playerSwitch.Epinephrine && materialData.name == "Epinephrine") ||
                    (self.moduleControl->playerSwitch.Drink && materialData.name == "Drink") ||
                    (self.moduleControl->playerSwitch.FirstAid && materialData.name == "FirstAid") ||
                    (self.moduleControl->playerSwitch.MedicalKit && materialData.name == "Medical Kit") ||
                    materialData.name == "Oil drum") {
                    std::string medStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(medStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, medStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(medStr.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, medStr.c_str());
                }

                if ((self.moduleControl->playerSwitch.RedDot && materialData.name == "Red Dot") ||
                    (self.moduleControl->playerSwitch.holographic && materialData.name == "holographic") ||
                    (self.moduleControl->playerSwitch.倍Scope3 && materialData.name == "3X") ||
                    (self.moduleControl->playerSwitch.倍Scope4 && materialData.name == "4X") ||
                    (self.moduleControl->playerSwitch.倍Scope6 && materialData.name == "6X") ||
                    (self.moduleControl->playerSwitch.倍Scope8 && materialData.name == "8X")) {
                    std::string scStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(scStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, scStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(scStr.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, scStr.c_str());
                }

                if (materialData.name == "[Warning]Molto" ||
                    materialData.name == "[Warning]Smoke" ||
                    materialData.name == "[Warning]Grenade" ||
                    materialData.name == "[Warning]Bomb Waning") {
                    std::string wStr = "[" + materialData.name + ":" + std::to_string(materialData.distance) + "M]";
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(wStr.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, wStr.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(wStr.c_str(), 21) / 2, materialData.screen.y), ImColor(178, 34, 34), 21, wStr.c_str());
                }
            } else {
                if (materialData.name == "[Med]PainKiller" ||
                    materialData.name == "[Med]Epinephrine" ||
                    materialData.name == "[Med]Drink" ||
                    materialData.name == "[Med]FirstAid" ||
                    materialData.name == "[Med]Medical Kit") {
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, materialData.name.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, materialData.name.c_str());
                }

                if (materialData.name == "[Defend]Level 3 Vest" ||
                    materialData.name == "[包]Level 3 Bag" ||
                    materialData.name == "[头]Level 3" ||
                    materialData.name == "[Defend]Level 2" ||
                    materialData.name == "[包]二级包" ||
                    materialData.name == "[头]2 Level" ||
                    materialData.name == "[spy]QBU" ||
                    materialData.name == "[spy]SLR" ||
                    materialData.name == "[spy]SKS" ||
                    materialData.name == "[spy]Mini14" ||
                    materialData.name == "[spy]M24" ||
                    materialData.name == "[spy]Kar98k" ||
                    materialData.name == "[spy]Mk14" ||
                    materialData.name == "[spy]Mosin Nagant" ||
                    materialData.name == "[spy]MK12" ||
                    materialData.name == "[spy]AMR" ||
                    materialData.name == "[spy]AWM") {
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, materialData.name.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, materialData.name.c_str());
                }

                if (materialData.name == "[AR]M762" ||
                    materialData.name == "[AR]SCAR-L" ||
                    materialData.name == "[AR]M416" ||
                    materialData.name == "[AR]M16A4" ||
                    materialData.name == "[AR]Mk47" ||
                    materialData.name == "[AR]G36C" ||
                    materialData.name == "[AR]QBZ" ||
                    materialData.name == "[AR]Groza" ||
                    materialData.name == "[AR]AUG" ||
                    materialData.name == "[AR]AKM" ||
                    materialData.name == "[LMG]DP-28" ||
                    materialData.name == "[LMG]M249" ||
                    materialData.name == "[LMG]MG3") {
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, materialData.name.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, materialData.name.c_str());
                }

                if (materialData.name == "[Bomb]5.56mm" ||
                    materialData.name == "[Bomb]7.62mm" ||
                    materialData.name == "[Bomb]马格南" ||
                    materialData.name == "[Bomb]Signal Bomb") {
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, materialData.name.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, materialData.name.c_str());
                }

                if (materialData.name == "[Scope]Red Dot" ||
                    materialData.name == "[Scope]holographic" ||
                    materialData.name == "[Scope]3X" ||
                    materialData.name == "[Scope]4X" ||
                    materialData.name == "[Scope]6X" ||
                    materialData.name == "[Scope]8X") {
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, materialData.name.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, materialData.name.c_str());
                }

                if (materialData.name == "[Throwable]Grenade" ||
                    materialData.name == "[Throwable]Smoke" ||
                    materialData.name == "[Throwable]Molto") {
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, materialData.name.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, materialData.name.c_str());
                }

                if (materialData.name == "[Sniper Accessories]Cheek pad" ||
                    materialData.name == "[Sniper Accessories]Child Bomb Bag" ||
                    materialData.name == "[Sniper Accessories]Flash Hider" ||
                    materialData.name == "[Sniper Accessories]Compensator" ||
                    materialData.name == "[Sniper Accessories]Muzzle" ||
                    materialData.name == "[Sniper Accessories]Extended Quick" ||
                    materialData.name == "[Sniper Accessories]Extended" ||
                    materialData.name == "[Grip]Thumb Grip" ||
                    materialData.name == "[Grip]Vertial Grip" ||
                    materialData.name == "[Grip]Half Grip" ||
                    materialData.name == "[Accessories]Compensator" ||
                    materialData.name == "[Accessories]Tactical AR holder" ||
                    materialData.name == "[Accessories]Flash Hider" ||
                    materialData.name == "[Accessories]Muzzle" ||
                    materialData.name == "[Accessories]Extended Quick" ||
                    materialData.name == "[Accessories]Extended") {
                    imDrawList->AddTextX(ImVec2(materialData.screen.x + 1 - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y + 1), ImColor(0, 0, 0, 255), 21, materialData.name.c_str());
                    imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, materialData.name.c_str());
                }
            }
        }

        if (self.moduleControl->playerSwitch.WZStatus) {
            id<MTLTexture> tex = nil;
            float yOffset = 10.0f;

            if (materialData.name == "[Warning]Grenade") tex = shouleiTexture;
            else if (materialData.name == "UAZ") tex = JPTexture;
            else if (materialData.name == "bouncing") tex = BBTexture;
            else if (materialData.name == "Car") tex = jcTexture;
            else if (materialData.name == "Motorboat") tex = mttTexture;
            else if (materialData.name == "motorcycle") tex = mtTexture;
            else if (materialData.name == "Little Lamb") tex = myTexture;
            else if (materialData.name == "CoupeRB") tex = R8Texture;
            else if (materialData.name == "3 Wheel Bike") tex = mt3Texture;
            else if (materialData.name == "M416") { tex = m416Texture; yOffset = 17.0f; }
            else if (materialData.name == "AKM") { tex = akmTexture; yOffset = 17.0f; }
            else if (materialData.name == "AUG") { tex = augTexture; yOffset = 17.0f; }
            else if (materialData.name == "Groza") { tex = grozaTexture; yOffset = 17.0f; }
            else if (materialData.name == "M16A4") { tex = m16Texture; yOffset = 17.0f; }
            else if (materialData.name == "M24") { tex = m24Texture; yOffset = 17.0f; }
            else if (materialData.name == "M249") { tex = m249Texture; yOffset = 17.0f; }
            else if (materialData.name == "M762") { tex = m762Texture; yOffset = 17.0f; }
            else if (materialData.name == "MG3") { tex = mg3Texture; yOffset = 17.0f; }
            else if (materialData.name == "Mini14") { tex = miniTexture; yOffset = 17.0f; }
            else if (materialData.name == "Mk14") { tex = mk14Texture; yOffset = 17.0f; }
            else if (materialData.name == "Mk47") { tex = mk47Texture; yOffset = 17.0f; }
            else if (materialData.name == "SCAR-L") { tex = scarTexture; yOffset = 17.0f; }
            else if (materialData.name == "SLR") { tex = slrTexture; yOffset = 17.0f; }
            else if (materialData.name == "AWM") { tex = awmTexture; yOffset = 17.0f; }
            else if (materialData.name == "DP-28") { tex = dp28Texture; yOffset = 17.0f; }
            else if (materialData.name == "Kar98k") { tex = k98Texture; yOffset = 17.0f; }
            else if (materialData.name == "SKS") { tex = sksTexture; yOffset = 17.0f; }
            else if (materialData.name == "[Box]") { tex = hzTexture; yOffset = 17.0f; }
            else if (materialData.name == "Box") { tex = ktTexture; yOffset = 17.0f; }
            else if (materialData.name == "Drink") tex = ylTexture;
            else if (materialData.name == "PainKiller") tex = ztyTexture;
            else if (materialData.name == "FirstAid") tex = jjbTexture;
            else if (materialData.name == "Medical Kit") tex = ylxTexture;
            else if (materialData.name == "Epinephrine") tex = zhenTexture;
            else if (materialData.name == "4X") tex = b4Texture;
            else if (materialData.name == "3X") tex = b3Texture;
            else if (materialData.name == "6X") tex = b6Texture;
            else if (materialData.name == "8X") tex = b8Texture;
            else if (materialData.name == "[Throwable]" || materialData.name == "Throwable") tex = ktTexture;
            else if (materialData.name == "Level 3") tex = t3Texture;
            else if (materialData.name == "Level 3 Vest") tex = j3Texture;
            else if (materialData.name == "Level 3 Bag") tex = bb3Texture;
            else if (materialData.name == "Grenade") tex = tleiTexture;
            else if (materialData.name == "Smoke") tex = tyanTexture;
            else if (materialData.name == "Molto") tex = thuoTexture;

            if (tex) {
                imDrawList->AddImage(
                    (__bridge ImTextureID) tex,
                    ImVec2(materialData.screen.x + 165 - scWidth + 1, materialData.screen.y + yOffset - scHeight + 1),
                    ImVec2(materialData.screen.x + 165 - scWidth + 1 + scHeight - 2, materialData.screen.y + yOffset - scHeight + scHeight - 1),
                    ImVec2(0.0f, 0.0f),
                    ImVec2(1.0f, 1.0f)
                );
            }

            if (materialData.distance != -100) {
                std::string dStr = std::to_string(materialData.distance) + "M";
                imDrawList->AddTextX(ImVec2(materialData.screen.x - 14 - calcTextSize(std::to_string(materialData.distance).c_str(), 22) / 2, materialData.screen.y - 4), ImColor(255, 255, 0), 22, dStr.c_str());
            } else {
                imDrawList->AddRectFilled({materialData.screen.x - calcTextSize(materialData.name.c_str(), 22) / 2, materialData.screen.y}, {materialData.screen.x + calcTextSize(materialData.name.c_str(), 22) / 2, materialData.screen.y + 22}, ImColor(0, 0, 0, 80), 10.0f);
                imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 22) / 2, materialData.screen.y), ImColor(255, 255, 255), 22, materialData.name.c_str());
            }
        }
    }

    int playerCount = 0, robotCount = 0;

    if (self.moduleControl->mainSwitch.playerStatus) {
        if (self.moduleControl->playerSwitch.radarStatus) {
            float rScale = self.moduleControl->playerSwitch.radarSize / 100.0f;
            ImVec2 topLeft = ImVec2(
                self.moduleControl->playerSwitch.radarCoord.x - 225 * rScale,
                self.moduleControl->playerSwitch.radarCoord.y - 225 * rScale
            );
            ImVec2 bottomRight = ImVec2(
                self.moduleControl->playerSwitch.radarCoord.x + 225 * rScale,
                self.moduleControl->playerSwitch.radarCoord.y + 225 * rScale
            );

            imDrawList->AddRectFilled(topLeft, bottomRight, ImColor(0, 0, 0, 0));
            imDrawList->AddRect(topLeft, bottomRight, ImColor(0, 0, 0), 0, ImDrawFlags_None, 1.0f);

            imDrawList->AddLine(
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y - 225 * rScale),
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y + 225 * rScale),
                ImColor(0, 0, 0), 1.0f
            );
            imDrawList->AddLine(
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x - 225 * rScale, self.moduleControl->playerSwitch.radarCoord.y),
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x + 225 * rScale, self.moduleControl->playerSwitch.radarCoord.y),
                ImColor(0, 0, 0), 1.0f
            );

            ImVec2 rotation = rotateCoord(130, ImVec2(0, 255 * rScale));
            imDrawList->AddLine(
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y),
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x + rotation.x, self.moduleControl->playerSwitch.radarCoord.y + rotation.y),
                ImColor(0, 0, 0), 1.0f
            );

            rotation = rotateCoord(-130, ImVec2(0, 225 * rScale));
            imDrawList->AddLine(
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y),
                ImVec2(self.moduleControl->playerSwitch.radarCoord.x + rotation.x, self.moduleControl->playerSwitch.radarCoord.y + rotation.y),
                ImColor(0, 0, 0), 1.0f
            );
        }

        for (PlayerData playerData : playerDataList) {
            ImColor color;
            if (!playerData.robot) {
                color = playerData.visibility ? ImColor(0, 255, 0) : ImColor(255, 0, 0);
                playerCount += 1;
            } else {
                color = playerData.visibility ? ImColor(255, 165, 0) : ImColor(0, 255, 255);
                robotCount += 1;
            }

            if (self.moduleControl->playerSwitch.radarStatus) {
                float rScale = self.moduleControl->playerSwitch.radarSize / 100.0f;
                float rx = (float)(self.moduleControl->playerSwitch.radarCoord.x + playerData.radar.x * rScale);
                float ry = (float)(self.moduleControl->playerSwitch.radarCoord.y + playerData.radar.y * rScale);
                imDrawList->AddCircleFilled({rx, ry}, 8, color);
                std::string strDist = std::to_string(playerData.distance) + "M";
                imDrawList->AddTextX(ImVec2(rx + 12, ry - 12), color, 24, strDist.c_str());
            }

            if (self.moduleControl->playerSwitch.infoStatus) {
                float maxHP = 100.f;
                float curHP = fminf(fmaxf(playerData.hp, 0.f), maxHP);

                ImVec2 head = ImVec2(playerData.screen.x, playerData.screen.y - playerData.size.y);
                ImVec2 foot = ImVec2(playerData.screen.x, playerData.screen.y + playerData.size.y);
                float height = foot.y - head.y;
                float width = height * 0.45f;

                float filledHeight = (curHP / maxHP) * height;
                ImColor hpColor = playerData.visibility ? ImColor(0, 255, 0) : ImColor(255, 0, 0);
                ImVec2 hpStart = ImVec2(head.x - width / 2 - 6, head.y);
                ImVec2 hpEnd   = ImVec2(head.x - width / 2 - 2, foot.y);
                imDrawList->AddRectFilled(hpStart, hpEnd, IM_COL32(0, 0, 0, 100), 2.0f);
                imDrawList->AddRectFilled(ImVec2(hpStart.x, foot.y - filledHeight), hpEnd, hpColor, 2.0f);

                if (!playerData.weaponName.empty()) {
                    ImVec2 weaponPos = ImVec2(head.x, head.y - 38);
                    drawTextWithStroke(nullptr, weaponFontSize, weaponPos, IM_COL32(255, 255, 0, 255), IM_COL32(0, 0, 0, 255), playerData.weaponName.c_str(), true);
                }

                std::string nameStr = playerData.name.empty() ? "BOT" : playerData.name;
                ImVec2 namePos = ImVec2(playerData.screen.x, playerData.screen.y + playerData.size.y - 12);
                drawTextWithStroke(nullptr, nameFontSize, namePos, IM_COL32(255, 255, 0, 255), IM_COL32(0, 0, 0, 255), nameStr.c_str(), true);

                std::string distStr = std::to_string(playerData.distance) + "M";
                ImVec2 distPos = ImVec2(foot.x, foot.y - 2);
                drawTextWithStroke(nullptr, 18, distPos, IM_COL32(255, 255, 255, 255), IM_COL32(0, 0, 0, 255), distStr.c_str(), true);

                ImVec2 boxStart = ImVec2(head.x - width / 2, head.y);
                ImVec2 boxEnd   = ImVec2(head.x + width / 2, foot.y);
                imDrawList->AddRect(boxStart, boxEnd, IM_COL32(255, 255, 255, 255), 2.0f, 0, 2.0f);
            }

            if (self.moduleControl->playerSwitch.SCWZStatus) {
                imDrawList->AddTextX(ImVec2(playerData.screen.x + 4 - calcTextSize(playerData.weaponName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y - 19 - hpHeight - 32), ImColor(0, 0, 0, 255), 20, playerData.weaponName.c_str());
                imDrawList->AddTextX(ImVec2(playerData.screen.x + 3 - calcTextSize(playerData.weaponName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y - 20 - hpHeight - 32), ImColor(255, 255, 255), 20, playerData.weaponName.c_str());

                imDrawList->AddTextX(ImVec2(playerData.screen.x + 4 - calcTextSize(playerData.statusName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y - 39 - hpHeight - 32), ImColor(0, 0, 0, 255), 20, playerData.statusName.c_str());
                imDrawList->AddTextX(ImVec2(playerData.screen.x + 3 - calcTextSize(playerData.statusName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y - 40 - hpHeight - 32), ImColor(0, 191, 255), 20, playerData.statusName.c_str());
            }

            if (self.moduleControl->playerSwitch.SCStatus) {
                id<MTLTexture> wTex = nil;
                float xOff = 160.0f;
                float yOff = 2.0f;
                float boxW = (float)scWidth;
                float boxH = (float)scHeight;

                if (playerData.weaponName == "Fist") { wTex = quanTexture; xOff = 200.0f; yOff = -30.0f; boxW = (float)qtWidth; boxH = (float)qtHeight; }
                else if (playerData.weaponName == "[LMG]DP-28") wTex = DP28Texture;
                else if (playerData.weaponName == "[LMG]M249") wTex = M249Texture;
                else if (playerData.weaponName == "[LMG]MG3") wTex = MG3Texture;
                else if (playerData.weaponName == "[SG]S686") wTex = S686Texture;
                else if (playerData.weaponName == "[SG]DBS") wTex = DBSTexture;
                else if (playerData.weaponName == "[SG]S12K") wTex = S12KTexture;
                else if (playerData.weaponName == "[SMG]Bison") wTex = YNTexture;
                else if (playerData.weaponName == "[Rifle]QBZ") wTex = QBZTexture;
                else if (playerData.weaponName == "[Rifle]M416") wTex = M416Texture;
                else if (playerData.weaponName == "[SR]QBU") wTex = QBUTexture;
                else if (playerData.weaponName == "[SR]SLR") wTex = SLRTexture;
                else if (playerData.weaponName == "[SR]SKS") wTex = SKSTexture;
                else if (playerData.weaponName == "[SR]Mini14") wTex = MINITexture;
                else if (playerData.weaponName == "[SR]M24") wTex = M24Texture;
                else if (playerData.weaponName == "[SR]Kar98k") wTex = K98Texture;
                else if (playerData.weaponName == "[SR]AWM") wTex = AWMTexture;
                else if (playerData.weaponName == "[SR]Mk14") wTex = MK14Texture;
                else if (playerData.weaponName == "[SR]Mosin Nagant") wTex = MOTexture;
                else if (playerData.weaponName == "[SR]VSS") wTex = VSSTexture;
                else if (playerData.weaponName == "[Rifle]M762") wTex = M762Texture;
                else if (playerData.weaponName == "[Rifle]SCAR-L") wTex = SCARTexture;
                else if (playerData.weaponName == "[Rifle]M16A4") wTex = M16Texture;
                else if (playerData.weaponName == "[Rifle]Mk47") wTex = MK47Texture;
                else if (playerData.weaponName == "[Rifle]Groza") wTex = GrozaTexture;
                else if (playerData.weaponName == "[Rifle]AUG") wTex = AUGTexture;
                else if (playerData.weaponName == "[Rifle]AKM") wTex = AkmTexture;
                else if (playerData.weaponName == "[Throwable]Grenade") wTex = leiTexture;
                else if (playerData.weaponName == "[Throwable]Smoke") wTex = yanTexture;
                else if (playerData.weaponName == "[Throwable]Molto") wTex = huoTexture;
                else if (playerData.weaponName == "[Melee]Pan") wTex = GUOTexture;
                else if (playerData.weaponName == "[Melee]Sickle") wTex = LIANTexture;
                else if (playerData.weaponName == "[Melee]Machete") wTex = DAOTexture;
                else if (playerData.weaponName == "[Melee]Crowbar") wTex = GUNTexture;
                else if (playerData.weaponName == "[SMG]MP5K") wTex = MP5KTexture;
                else if (playerData.weaponName == "[SMG]TommyGun") wTex = TANGTexture;
                else if (playerData.weaponName == "[SMG]UMP9") wTex = UMP9Texture;
                else if (playerData.weaponName == "[SMG]Uzi") wTex = UZITexture;
                else if (playerData.weaponName == "[SMG]Vector") wTex = VKTTexture;
                else if (playerData.weaponName == "[Pistol]P92") wTex = P92Texture;
                else if (playerData.weaponName == "[Pistol]P1911") wTex = P1911Texture;
                else if (playerData.weaponName == "[Pistol]R1895") wTex = R1895Texture;
                else if (playerData.weaponName == "[Pistol]P18C") wTex = P18CTexture;
                else if (playerData.weaponName == "[Pistol]R45") wTex = R45Texture;

                if (wTex) {
                    imDrawList->AddImage(
                        (__bridge ImTextureID) wTex,
                        ImVec2(playerData.screen.x + xOff - boxW + 1, playerData.screen.y + yOff - playerData.size.y - 5 - boxH + 1),
                        ImVec2(playerData.screen.x + xOff - boxW + 1 + boxH - 2, playerData.screen.y + yOff - playerData.size.y - 5 - boxH + boxH - 1),
                        ImVec2(0.0f, 0.0f),
                        ImVec2(1.0f, 1.0f)
                    );
                }
            }

            if (self.moduleControl->playerSwitch.boxStatus) {
                ImColor boxCol = (playerData.hp <= 1) ? ImColor(255, 165, 0) : color;
                if (self.moduleControl->mainSwitch.Drawbox == 1) {
                    drawUnclosedRect2(playerData.screen.x, playerData.screen.y, playerData.size.x + playerData.size.x, playerData.size.y + playerData.size.y, boxCol, 1.0f);
                } else if (self.moduleControl->mainSwitch.Drawbox == 2) {
                    DrawBox3D(imDrawList, playerData.objbox3d, boxCol, 2.0f);
                } else if (self.moduleControl->mainSwitch.Drawbox == 3) {
                    imDrawList->AddRect({playerData.screen.x - playerData.size.x, playerData.screen.y - playerData.size.y}, {playerData.screen.x + playerData.size.x, playerData.screen.y + playerData.size.y}, boxCol, 10.0f, 0, 2.0f);
                }
            }

            if (self.moduleControl->playerSwitch.lineStatus) {
                ImColor lineCol = (playerData.hp <= 1) ? ImColor(255, 165, 0) : color;
                imDrawList->AddLine(ImVec2(screenSize.width / 2, 0), ImVec2(playerData.screen.x, playerData.screen.y - playerData.size.y - 80), lineCol, 1.0f);
            }

            if (self.moduleControl->playerSwitch.boneStatus) {
                ImColor boneCol = playerData.visibility ? ImColor(visibleBoneColor) : ImColor(invisibleBoneColor);

                imDrawList->AddLine({playerData.bonesData.head.x, playerData.bonesData.head.y}, {playerData.bonesData.pit.x, playerData.bonesData.pit.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.pit.x, playerData.bonesData.pit.y}, {playerData.bonesData.pelvis.x, playerData.bonesData.pelvis.y}, boneCol, 1.7f);

                imDrawList->AddLine({playerData.bonesData.pit.x, playerData.bonesData.pit.y}, {playerData.bonesData.lcollar.x, playerData.bonesData.lcollar.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.lcollar.x, playerData.bonesData.lcollar.y}, {playerData.bonesData.lelbow.x, playerData.bonesData.lelbow.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.lelbow.x, playerData.bonesData.lelbow.y}, {playerData.bonesData.lwrist.x, playerData.bonesData.lwrist.y}, boneCol, 1.7f);

                imDrawList->AddLine({playerData.bonesData.pit.x, playerData.bonesData.pit.y}, {playerData.bonesData.rcollar.x, playerData.bonesData.rcollar.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.rcollar.x, playerData.bonesData.rcollar.y}, {playerData.bonesData.relbow.x, playerData.bonesData.relbow.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.relbow.x, playerData.bonesData.relbow.y}, {playerData.bonesData.rwrist.x, playerData.bonesData.rwrist.y}, boneCol, 1.7f);

                imDrawList->AddLine({playerData.bonesData.pelvis.x, playerData.bonesData.pelvis.y}, {playerData.bonesData.lthigh.x, playerData.bonesData.lthigh.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.lthigh.x, playerData.bonesData.lthigh.y}, {playerData.bonesData.lknee.x, playerData.bonesData.lknee.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.lknee.x, playerData.bonesData.lknee.y}, {playerData.bonesData.lankle.x, playerData.bonesData.lankle.y}, boneCol, 1.7f);

                imDrawList->AddLine({playerData.bonesData.pelvis.x, playerData.bonesData.pelvis.y}, {playerData.bonesData.rthigh.x, playerData.bonesData.rthigh.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.rthigh.x, playerData.bonesData.rthigh.y}, {playerData.bonesData.rknee.x, playerData.bonesData.rknee.y}, boneCol, 1.7f);
                imDrawList->AddLine({playerData.bonesData.rknee.x, playerData.bonesData.rknee.y}, {playerData.bonesData.rankle.x, playerData.bonesData.rankle.y}, boneCol, 1.7f);
            }
        }
    }

    if (menu::ESP::enemy_count) {
        if (playerCount != 0 || robotCount != 0) {
            int totalplayers = playerCount + robotCount;
            std::string totalEnemiesStr = "Total enemy around you : " + std::to_string(totalplayers);

            int fontSize = 30;
            float textWidth = ImGui::CalcTextSize(totalEnemiesStr.c_str()).x;
            float countTexH = countTexture ? (float)countTexture.height : 0.0f;
            ImVec2 pos = ImVec2((screenSize.width / 2.0f) - (textWidth / 2.0f), 101.5f + countTexH / 2.0f - 20.0f);

            float paddingX = 20.0f;
            float paddingY = 14.0f;

            ImVec2 rectMin = ImVec2(pos.x - paddingX, pos.y - paddingY);
            ImVec2 rectMax = ImVec2(pos.x + textWidth + paddingX, pos.y + fontSize + paddingY);

            ImDrawList* bgDrawList = ImGui::GetBackgroundDrawList();
            bgDrawList->AddRectFilled(rectMin, rectMax, ImColor(0, 0, 0, 230), 10.0f);
            bgDrawList->AddRect(rectMin, rectMax, ImColor(0, 255, 0, 255), 10.0f, 0, 2.0f);
            bgDrawList->AddText(pos, IM_COL32(255, 255, 255, 255), totalEnemiesStr.c_str());
        }
    }

    if (self.moduleControl->mainSwitch.aimbotStatus) {
        if (self.moduleControl->aimbotController.showAimbotRadius) {
            imDrawList->AddCircle(
                ImVec2(screenSize.width / 2, screenSize.height / 2),
                self.moduleControl->aimbotController.aimbotRadius,
                ImColor(0, 255, 255, 255),
                0,
                1.0f
            );
        }
    }

    ImGui::End();
}

void Line(ImDrawList *draw, ImVec2 origin, ImVec2 dest, ImColor color, float thickness) {
    draw->AddLine({origin.x, origin.y}, {dest.x, dest.y}, color, thickness);
}

void drawUnclosedRect2(float center_x, float center_y, float center_w, float center_h, ImVec4 rgb, float thickness) {
    ImU32 col = ImGui::ColorConvertFloat4ToU32(rgb);
    imDrawList->AddLine(ImVec2{center_x - (center_w / 2), center_y - (center_h / 2)}, ImVec2{center_x - (center_w / 4), center_y - (center_h / 2)}, col, thickness);
    imDrawList->AddLine(ImVec2{center_x + (center_w / 2), center_y - (center_h / 2)}, ImVec2{center_x + (center_w / 4), center_y - (center_h / 2)}, col, thickness);
    imDrawList->AddLine(ImVec2{center_x - (center_w / 2), center_y + (center_h / 2)}, ImVec2{center_x - (center_w / 4), center_y + (center_h / 2)}, col, thickness);
    imDrawList->AddLine(ImVec2{center_x + (center_w / 2), center_y + (center_h / 2)}, ImVec2{center_x + (center_w / 4), center_y + (center_h / 2)}, col, thickness);

    imDrawList->AddLine(ImVec2{center_x - (center_w / 2), center_y - (center_h / 2)}, ImVec2{center_x - (center_w / 2), center_y - (center_h / 4)}, col, thickness);
    imDrawList->AddLine(ImVec2{center_x + (center_w / 2), center_y - (center_h / 2)}, ImVec2{center_x + (center_w / 2), center_y - (center_h / 4)}, col, thickness);
    imDrawList->AddLine(ImVec2{center_x - (center_w / 2), center_y + (center_h / 2)}, ImVec2{center_x - (center_w / 2), center_y + (center_h / 4)}, col, thickness);
    imDrawList->AddLine(ImVec2{center_x + (center_w / 2), center_y + (center_h / 2)}, ImVec2{center_x + (center_w / 2), center_y + (center_h / 4)}, col, thickness);
}

-(void)initImageTexture:(id<MTLDevice>)device {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSData *countData = [[NSData alloc] initWithBase64EncodedString:countDataBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        countTexture = [self loadImageTexture:device : (void*)[countData bytes] : [countData length]];

        NSData *countData1 = [[NSData alloc] initWithBase64EncodedString:countData1Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        count1Texture = [self loadImageTexture:device : (void*)[countData1 bytes] : [countData1 length]];

        NSData *countData2 = [[NSData alloc] initWithBase64EncodedString:countData2Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        count2Texture = [self loadImageTexture:device : (void*)[countData2 bytes] : [countData2 length]];

        NSData *countData3 = [[NSData alloc] initWithBase64EncodedString:countData3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        count3Texture = [self loadImageTexture:device : (void*)[countData3 bytes] : [countData3 length]];

        NSData *countData4 = [[NSData alloc] initWithBase64EncodedString:countData4Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        count4Texture = [self loadImageTexture:device : (void*)[countData4 bytes] : [countData4 length]];

        NSData *countData5 = [[NSData alloc] initWithBase64EncodedString:countData5Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        count5Texture = [self loadImageTexture:device : (void*)[countData5 bytes] : [countData5 length]];

        NSData *quan = [[NSData alloc] initWithBase64EncodedString:quanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        quanTexture = [self loadImageTexture:device : (void*)[quan bytes] : [quan length]];

        NSData *shoulei = [[NSData alloc] initWithBase64EncodedString:shouleiBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        shouleiTexture = [self loadImageTexture:device : (void*)[shoulei bytes] : [shoulei length]];

        NSData *playerData = [[NSData alloc] initWithBase64EncodedString:playerDataBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        playerTexture = [self loadImageTexture:device : (void*)[playerData bytes] : [playerData length]];

        NSData *robotData = [[NSData alloc] initWithBase64EncodedString:robotDataBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        robotTexture = [self loadImageTexture:device : (void*)[robotData bytes] : [robotData length]];

        NSData *M416 = [[NSData alloc] initWithBase64EncodedString:M416Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        M416Texture = [self loadImageTexture:device : (void*)[M416 bytes] : [M416 length]];

        NSData *M16 = [[NSData alloc] initWithBase64EncodedString:M16Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        M16Texture = [self loadImageTexture:device : (void*)[M16 bytes] : [M16 length]];

        NSData *Groza = [[NSData alloc] initWithBase64EncodedString:GrozaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        GrozaTexture = [self loadImageTexture:device : (void*)[Groza bytes] : [Groza length]];

        NSData *Akm = [[NSData alloc] initWithBase64EncodedString:AkmBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        AkmTexture = [self loadImageTexture:device : (void*)[Akm bytes] : [Akm length]];

        NSData *SCAR = [[NSData alloc] initWithBase64EncodedString:SCARBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        SCARTexture = [self loadImageTexture:device : (void*)[SCAR bytes] : [SCAR length]];

        NSData *MK47 = [[NSData alloc] initWithBase64EncodedString:MK47Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        MK47Texture = [self loadImageTexture:device : (void*)[MK47 bytes] : [MK47 length]];

        NSData *AUG = [[NSData alloc] initWithBase64EncodedString:AUGBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        AUGTexture = [self loadImageTexture:device : (void*)[AUG bytes] : [AUG length]];

        NSData *M762 = [[NSData alloc] initWithBase64EncodedString:M762Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        M762Texture = [self loadImageTexture:device : (void*)[M762 bytes] : [M762 length]];

        NSData *QBZ = [[NSData alloc] initWithBase64EncodedString:QBZBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        QBZTexture = [self loadImageTexture:device : (void*)[QBZ bytes] : [QBZ length]];

        NSData *lei = [[NSData alloc] initWithBase64EncodedString:leiBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        leiTexture = [self loadImageTexture:device : (void*)[lei bytes] : [lei length]];

        NSData *huo = [[NSData alloc] initWithBase64EncodedString:huoBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        huoTexture = [self loadImageTexture:device : (void*)[huo bytes] : [huo length]];

        NSData *yan = [[NSData alloc] initWithBase64EncodedString:yanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        yanTexture = [self loadImageTexture:device : (void*)[yan bytes] : [yan length]];

        NSData *shan = [[NSData alloc] initWithBase64EncodedString:shanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        shanTexture = [self loadImageTexture:device : (void*)[shan bytes] : [shan length]];

        NSData *R1895 = [[NSData alloc] initWithBase64EncodedString:R1895Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        R1895Texture = [self loadImageTexture:device : (void*)[R1895 bytes] : [R1895 length]];

        NSData *P92 = [[NSData alloc] initWithBase64EncodedString:P92Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        P92Texture = [self loadImageTexture:device : (void*)[P92 bytes] : [P92 length]];

        NSData *P1911 = [[NSData alloc] initWithBase64EncodedString:P1911Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        P1911Texture = [self loadImageTexture:device : (void*)[P1911 bytes] : [P1911 length]];

        NSData *P18C = [[NSData alloc] initWithBase64EncodedString:P18CBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        P18CTexture = [self loadImageTexture:device : (void*)[P18C bytes] : [P18C length]];

        NSData *R45 = [[NSData alloc] initWithBase64EncodedString:R45Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        R45Texture = [self loadImageTexture:device : (void*)[R45 bytes] : [R45 length]];

        NSData *SKS = [[NSData alloc] initWithBase64EncodedString:SKSBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        SKSTexture = [self loadImageTexture:device : (void*)[SKS bytes] : [SKS length]];

        NSData *MINI = [[NSData alloc] initWithBase64EncodedString:MINIBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        MINITexture = [self loadImageTexture:device : (void*)[MINI bytes] : [MINI length]];

        NSData *MK14 = [[NSData alloc] initWithBase64EncodedString:MK14Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        MK14Texture = [self loadImageTexture:device : (void*)[MK14 bytes] : [MK14 length]];

        NSData *VSS = [[NSData alloc] initWithBase64EncodedString:VSSBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        VSSTexture = [self loadImageTexture:device : (void*)[VSS bytes] : [VSS length]];

        NSData *QBU = [[NSData alloc] initWithBase64EncodedString:QBUBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        QBUTexture = [self loadImageTexture:device : (void*)[QBU bytes] : [QBU length]];

        NSData *SLR = [[NSData alloc] initWithBase64EncodedString:SLRBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        SLRTexture = [self loadImageTexture:device : (void*)[SLR bytes] : [SLR length]];

        NSData *AWM = [[NSData alloc] initWithBase64EncodedString:AWMBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        AWMTexture = [self loadImageTexture:device : (void*)[AWM bytes] : [AWM length]];

        NSData *K98 = [[NSData alloc] initWithBase64EncodedString:K98Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        K98Texture = [self loadImageTexture:device : (void*)[K98 bytes] : [K98 length]];

        NSData *MO = [[NSData alloc] initWithBase64EncodedString:MOBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        MOTexture = [self loadImageTexture:device : (void*)[MO bytes] : [MO length]];

        NSData *LIAN = [[NSData alloc] initWithBase64EncodedString:LIANBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        LIANTexture = [self loadImageTexture:device : (void*)[LIAN bytes] : [LIAN length]];

        NSData *GUN = [[NSData alloc] initWithBase64EncodedString:GUNBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        GUNTexture = [self loadImageTexture:device : (void*)[GUN bytes] : [GUN length]];

        NSData *DAO = [[NSData alloc] initWithBase64EncodedString:DAOBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        DAOTexture = [self loadImageTexture:device : (void*)[DAO bytes] : [DAO length]];

        NSData *GUO = [[NSData alloc] initWithBase64EncodedString:GUOBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        GUOTexture = [self loadImageTexture:device : (void*)[GUO bytes] : [GUO length]];

        NSData *UZI = [[NSData alloc] initWithBase64EncodedString:UZIBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UZITexture = [self loadImageTexture:device : (void*)[UZI bytes] : [UZI length]];

        NSData *TANG = [[NSData alloc] initWithBase64EncodedString:TANGBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        TANGTexture = [self loadImageTexture:device : (void*)[TANG bytes] : [TANG length]];

        NSData *VKT = [[NSData alloc] initWithBase64EncodedString:VKTBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        VKTTexture = [self loadImageTexture:device : (void*)[VKT bytes] : [VKT length]];

        NSData *MP5K = [[NSData alloc] initWithBase64EncodedString:MP5KBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        MP5KTexture = [self loadImageTexture:device : (void*)[MP5K bytes] : [MP5K length]];

        NSData *UMP9 = [[NSData alloc] initWithBase64EncodedString:UMP9Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UMP9Texture = [self loadImageTexture:device : (void*)[UMP9 bytes] : [UMP9 length]];

        NSData *YN = [[NSData alloc] initWithBase64EncodedString:YNBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        YNTexture = [self loadImageTexture:device : (void*)[YN bytes] : [YN length]];

        NSData *M24 = [[NSData alloc] initWithBase64EncodedString:M24Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        M24Texture = [self loadImageTexture:device : (void*)[M24 bytes] : [M24 length]];

        NSData *DP28 = [[NSData alloc] initWithBase64EncodedString:DP28Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        DP28Texture = [self loadImageTexture:device : (void*)[DP28 bytes] : [DP28 length]];

        NSData *MG3 = [[NSData alloc] initWithBase64EncodedString:MG3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        MG3Texture = [self loadImageTexture:device : (void*)[MG3 bytes] : [MG3 length]];

        NSData *M249 = [[NSData alloc] initWithBase64EncodedString:M249Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        M249Texture = [self loadImageTexture:device : (void*)[M249 bytes] : [M249 length]];

        NSData *DBS = [[NSData alloc] initWithBase64EncodedString:DBSBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        DBSTexture = [self loadImageTexture:device : (void*)[DBS bytes] : [DBS length]];

        NSData *S686 = [[NSData alloc] initWithBase64EncodedString:S686Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        S686Texture = [self loadImageTexture:device : (void*)[S686 bytes] : [S686 length]];

        NSData *S12K = [[NSData alloc] initWithBase64EncodedString:S12KBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        S12KTexture = [self loadImageTexture:device : (void*)[S12K bytes] : [S12K length]];

        NSData *JP = [[NSData alloc] initWithBase64EncodedString:JPBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        JPTexture = [self loadImageTexture:device : (void*)[JP bytes] : [JP length]];

        NSData *BB = [[NSData alloc] initWithBase64EncodedString:BBBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        BBTexture = [self loadImageTexture:device : (void*)[BB bytes] : [BB length]];

        NSData *jc = [[NSData alloc] initWithBase64EncodedString:jcBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        jcTexture = [self loadImageTexture:device : (void*)[jc bytes] : [jc length]];

        NSData *mtt = [[NSData alloc] initWithBase64EncodedString:mttBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        mttTexture = [self loadImageTexture:device : (void*)[mtt bytes] : [mtt length]];

        NSData *mt = [[NSData alloc] initWithBase64EncodedString:mtBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        mtTexture = [self loadImageTexture:device : (void*)[mt bytes] : [mt length]];

        NSData *my = [[NSData alloc] initWithBase64EncodedString:myBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        myTexture = [self loadImageTexture:device : (void*)[my bytes] : [my length]];

        NSData *R8 = [[NSData alloc] initWithBase64EncodedString:R8Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        R8Texture = [self loadImageTexture:device : (void*)[R8 bytes] : [R8 length]];

        NSData *mt3 = [[NSData alloc] initWithBase64EncodedString:mt3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        mt3Texture = [self loadImageTexture:device : (void*)[mt3 bytes] : [mt3 length]];

        NSData *m416 = [[NSData alloc] initWithBase64EncodedString:m416Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        m416Texture = [self loadImageTexture:device : (void*)[m416 bytes] : [m416 length]];

        NSData *akm = [[NSData alloc] initWithBase64EncodedString:akmBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        akmTexture = [self loadImageTexture:device : (void*)[akm bytes] : [akm length]];

        NSData *aug = [[NSData alloc] initWithBase64EncodedString:augBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        augTexture = [self loadImageTexture:device : (void*)[aug bytes] : [aug length]];

        NSData *groza = [[NSData alloc] initWithBase64EncodedString:grozaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        grozaTexture = [self loadImageTexture:device : (void*)[groza bytes] : [groza length]];

        NSData *m16 = [[NSData alloc] initWithBase64EncodedString:m16Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        m16Texture = [self loadImageTexture:device : (void*)[m16 bytes] : [m16 length]];

        NSData *m24 = [[NSData alloc] initWithBase64EncodedString:m24Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        m24Texture = [self loadImageTexture:device : (void*)[m24 bytes] : [m24 length]];

        NSData *m249 = [[NSData alloc] initWithBase64EncodedString:m249Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        m249Texture = [self loadImageTexture:device : (void*)[m249 bytes] : [m249 length]];

        NSData *m762 = [[NSData alloc] initWithBase64EncodedString:m762Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        m762Texture = [self loadImageTexture:device : (void*)[m762 bytes] : [m762 length]];

        NSData *mg3 = [[NSData alloc] initWithBase64EncodedString:mg3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        mg3Texture = [self loadImageTexture:device : (void*)[mg3 bytes] : [mg3 length]];

        NSData *mini = [[NSData alloc] initWithBase64EncodedString:miniBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        miniTexture = [self loadImageTexture:device : (void*)[mini bytes] : [mini length]];

        NSData *mk14 = [[NSData alloc] initWithBase64EncodedString:mk14Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        mk14Texture = [self loadImageTexture:device : (void*)[mk14 bytes] : [mk14 length]];

        NSData *mk47 = [[NSData alloc] initWithBase64EncodedString:mk47Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        mk47Texture = [self loadImageTexture:device : (void*)[mk47 bytes] : [mk47 length]];

        NSData *scar = [[NSData alloc] initWithBase64EncodedString:scarBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        scarTexture = [self loadImageTexture:device : (void*)[scar bytes] : [scar length]];

        NSData *slr = [[NSData alloc] initWithBase64EncodedString:slrBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        slrTexture = [self loadImageTexture:device : (void*)[slr bytes] : [slr length]];

        NSData *awm = [[NSData alloc] initWithBase64EncodedString:awmBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        awmTexture = [self loadImageTexture:device : (void*)[awm bytes] : [awm length]];

        NSData *dp28 = [[NSData alloc] initWithBase64EncodedString:dp28Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        dp28Texture = [self loadImageTexture:device : (void*)[dp28 bytes] : [dp28 length]];

        NSData *k98 = [[NSData alloc] initWithBase64EncodedString:k98Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        k98Texture = [self loadImageTexture:device : (void*)[k98 bytes] : [k98 length]];

        NSData *vss = [[NSData alloc] initWithBase64EncodedString:vssBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        vssTexture = [self loadImageTexture:device : (void*)[vss bytes] : [vss length]];

        NSData *sks = [[NSData alloc] initWithBase64EncodedString:sksBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        sksTexture = [self loadImageTexture:device : (void*)[sks bytes] : [sks length]];

        NSData *hz = [[NSData alloc] initWithBase64EncodedString:hzBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        hzTexture = [self loadImageTexture:device : (void*)[hz bytes] : [hz length]];

        NSData *yl = [[NSData alloc] initWithBase64EncodedString:ylBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        ylTexture = [self loadImageTexture:device : (void*)[yl bytes] : [yl length]];

        NSData *jjb = [[NSData alloc] initWithBase64EncodedString:jjbBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        jjbTexture = [self loadImageTexture:device : (void*)[jjb bytes] : [jjb length]];

        NSData *zty = [[NSData alloc] initWithBase64EncodedString:ztyBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        ztyTexture = [self loadImageTexture:device : (void*)[zty bytes] : [zty length]];

        NSData *zhen = [[NSData alloc] initWithBase64EncodedString:zhenBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        zhenTexture = [self loadImageTexture:device : (void*)[zhen bytes] : [zhen length]];

        NSData *ylx = [[NSData alloc] initWithBase64EncodedString:ylxBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        ylxTexture = [self loadImageTexture:device : (void*)[ylx bytes] : [ylx length]];

        NSData *b4 = [[NSData alloc] initWithBase64EncodedString:b4Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        b4Texture = [self loadImageTexture:device : (void*)[b4 bytes] : [b4 length]];

        NSData *b3 = [[NSData alloc] initWithBase64EncodedString:b3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        b3Texture = [self loadImageTexture:device : (void*)[b3 bytes] : [b3 length]];

        NSData *b6 = [[NSData alloc] initWithBase64EncodedString:b6Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        b6Texture = [self loadImageTexture:device : (void*)[b6 bytes] : [b6 length]];

        NSData *b8 = [[NSData alloc] initWithBase64EncodedString:b8Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        b8Texture = [self loadImageTexture:device : (void*)[b8 bytes] : [b8 length]];

        NSData *kt = [[NSData alloc] initWithBase64EncodedString:ktBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        ktTexture = [self loadImageTexture:device : (void*)[kt bytes] : [kt length]];

        NSData *t3 = [[NSData alloc] initWithBase64EncodedString:t3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        t3Texture = [self loadImageTexture:device : (void*)[t3 bytes] : [t3 length]];

        NSData *j3 = [[NSData alloc] initWithBase64EncodedString:j3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        j3Texture = [self loadImageTexture:device : (void*)[j3 bytes] : [j3 length]];

        NSData *bb3 = [[NSData alloc] initWithBase64EncodedString:bb3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        bb3Texture = [self loadImageTexture:device : (void*)[bb3 bytes] : [bb3 length]];

        NSData *tlei = [[NSData alloc] initWithBase64EncodedString:tleiBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        tleiTexture = [self loadImageTexture:device : (void*)[tlei bytes] : [tlei length]];

        NSData *tyan = [[NSData alloc] initWithBase64EncodedString:tyanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        tyanTexture = [self loadImageTexture:device : (void*)[tyan bytes] : [tyan length]];

        NSData *thuo = [[NSData alloc] initWithBase64EncodedString:thuoBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        thuoTexture = [self loadImageTexture:device : (void*)[thuo bytes] : [thuo length]];

        NSData *leizha = [[NSData alloc] initWithBase64EncodedString:leizhaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        leizhaTexture = [self loadImageTexture:device : (void*)[leizha bytes] : [leizha length]];

        NSData *hongzha = [[NSData alloc] initWithBase64EncodedString:hongzhaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        hongzhaTexture = [self loadImageTexture:device : (void*)[hongzha bytes] : [hongzha length]];

        NSData *sld = [[NSData alloc] initWithBase64EncodedString:sldBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        sldTexture = [self loadImageTexture:device : (void*)[sld bytes] : [sld length]];

        NSData *ywd = [[NSData alloc] initWithBase64EncodedString:ywdBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        ywdTexture = [self loadImageTexture:device : (void*)[ywd bytes] : [ywd length]];

        NSData *rsp = [[NSData alloc] initWithBase64EncodedString:rspBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        rspTexture = [self loadImageTexture:device : (void*)[rsp bytes] : [rsp length]];
    });
}

-(id<MTLTexture>)loadImageTexture:(id<MTLDevice>)device :(void*) imageData :(size_t) fileDataSize {
    int width, height;
    unsigned char *pixels = stbi_load_from_memory((stbi_uc const *)imageData, (int)fileDataSize, &width, &height, NULL, 4);
    if (!pixels || width <= 0 || height <= 0) {
        if (pixels) stbi_image_free(pixels);
        return nil;
    }

    MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
                                                                                                 width:(NSUInteger)width
                                                                                                height:(NSUInteger)height
                                                                                             mipmapped:NO];
    textureDescriptor.usage = MTLTextureUsageShaderRead;
    textureDescriptor.storageMode = MTLStorageModeShared;
    id<MTLTexture> texture = [device newTextureWithDescriptor:textureDescriptor];
    if (texture) {
        [texture replaceRegion:MTLRegionMake2D(0, 0, (NSUInteger)width, (NSUInteger)height) mipmapLevel:0 withBytes:pixels bytesPerRow:(NSUInteger)width * 4];
    }

    stbi_image_free(pixels);
    return texture;
}

@end
