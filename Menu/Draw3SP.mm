#include "utils/module_tools.h"
#import "Draw3SP.h"
#include "utils/image_base64.h"
#import "Menu/XC6/OverlayView.h"
#import "ESP/mahoa.h"
#import "ESP/obfuscate.h"
//#import "FontManager.h"
#include <algorithm>
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define ImCalcTextSize(str) ImGui::CalcTextSize(std::string(str).c_str())
#include <map>

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
int xWidth =50;
int xtWidth =10;
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

//int xWidth =50;
//int xtWidth =10;
//int hpWidth = 110;
//int hpHeight = 4;
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
        //extern bool HideESP:
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

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

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



static void DrawTextX(std::string text, ImVec2 pos,  int color, bool outline, float fontSize)
{
    const char *str = text.c_str();
    ImVec2 vec2 = pos;
    
    if (outline)
    {
        ImU32 outlineColor = 0xFF000000;
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x + 1, vec2.y + 1), outlineColor, fontSize, str);
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x - 1, vec2.y - 1), outlineColor, fontSize, str);
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x + 1, vec2.y - 1), outlineColor, fontSize, str);
        ImGui::GetWindowDrawList()->AddTextX(ImVec2(vec2.x - 1, vec2.y + 1), outlineColor, fontSize, str);
    }
    ImGui::GetWindowDrawList()->AddTextX(vec2, color, fontSize, str);
}

template<typename ... Args>
static std::string string_format(const std::string& format, Args ... args){
    
    size_t size = 1 + snprintf(nullptr, 0, format.c_str(), args ...); // 计算格式化后的字符串长度
    char bytes[size]; // 用于存储格式化后的字符串
    snprintf(bytes, size, format.c_str(), args ...); // 格式化字符串并存储到 bytes 中
    return std::string(bytes); // 将 bytes 转换成 string 类型并返回
}
void DrawBox3D(ImDrawList *draw,Box3D box3d, ImColor col, float thickness) {
  
    Line(draw,box3d.s1, box3d.s2, col,2.0f);
    Line(draw,box3d.s2, box3d.s3, col,2.0f);
    Line(draw,box3d.s3, box3d.s4, col,2.0f);
    Line(draw,box3d.s4, box3d.s1, col,2.0f);
 
    Line(draw,box3d.s5, box3d.s6, col,2.0f);
    Line(draw,box3d.s6, box3d.s7, col,2.0f);
    Line(draw,box3d.s7, box3d.s8, col,2.0f);
    Line(draw,box3d.s8, box3d.s5, col,2.0f);
 
    Line(draw,box3d.s1, box3d.s5, col,2.0f);
    Line(draw,box3d.s2, box3d.s6, col,2.0f);
    Line(draw,box3d.s3, box3d.s7, col,2.0f);
    Line(draw,box3d.s4, box3d.s8, col,2.0f);

}
- (instancetype)initWithFrame:(ModuleControl*)control {
    self = [super init];
    
    self.moduleControl = control;
    
    screenSize = [UIScreen mainScreen].bounds.size;
    screenSize.width *= [UIScreen mainScreen].nativeScale;
    screenSize.height *= [UIScreen mainScreen].nativeScale;
    
    return self;
}

-(void)drawDrawWindow {
    ImGui::SetNextWindowSize(ImVec2(screenSize.width,screenSize.height));
    ImGui::SetNextWindowPos(ImVec2(0, 0));
    ImGui::Begin("alpha", nullptr, ImGuiWindowFlags_NoBackground | ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoInputs | ImGuiWindowFlags_NoMove);

NSString *customNameNSString = [NSString stringWithUTF8String:customName];
char* ryder = (char*)[customNameNSString cStringUsingEncoding:NSUTF8StringEncoding];
std::string str3 = ryder;

ImVec4 finalColor = (colorMode == 1) 
    ? (ImVec4)GetRainbowColor(rainbowSpeed) 
    : (ImVec4)BrandColor;

ImColor drawColor = ImColor(finalColor);

DrawTextX(
    str3,
    ImVec2((screenSize.width / 2) - calcTextSize(str3.c_str(), 45 / 2), 101.5 + countTexture.height / 2 + 35),
    drawColor,
    false,
    45
);
       
  
    
    imDrawList = ImGui::GetWindowDrawList();
std::string str = OBFUSCATE("https://instagram.com/errormvpx");

// 📍 Position: Left-bottom (above joystick), moved slightly up
ImVec2 textPos(screenSize.width * 0.03f, screenSize.height * 0.82f);

// 🔠 Font size
float fontSize = 45.0f;

// 🔲 Padding for background
float paddingX = 16.0f;
float paddingY = 12.0f;

// 🧮 Accurate text size
ImVec2 textSize = ImGui::CalcTextSize(str.c_str(), nullptr, false, fontSize);

// 🔳 Background box (fully covers whole text)
ImVec2 bgMin = ImVec2(textPos.x - paddingX, textPos.y - paddingY);
ImVec2 bgMax = ImVec2(textPos.x + textSize.x + paddingX, textPos.y + fontSize + paddingY);
imDrawList->AddRectFilled(bgMin, bgMax, ImColor(0, 0, 0, 150), 8.0f); // Smooth rounded background

// 📝 Slightly lighter red color (more visible but soft)
imDrawList->AddTextX(textPos, ImColor(255, 60, 60, 255), fontSize, str.c_str());



    readFrameData(ImVec2(screenSize.width / 2,screenSize.height / 2),playerDataList, materialDataList);
    for (MaterialData materialData:materialDataList) {
         
        if (self.moduleControl->playerSwitch.WZWZStatus) {
                    if (materialData.name=="[Warning]Grenade") {//警告贴图
                        imDrawList->AddImage((__bridge ImTextureID) leizhaTexture, ImVec2(screenSize.width / 2 - leizhaTexture.width / 2, 230), ImVec2(screenSize.width / 2 + leizhaTexture.width / 2, 230 + leizhaTexture.height), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                    }
                    if (materialData.name=="[Warning]Bomb Waning") {
                        imDrawList->AddImage((__bridge ImTextureID) hongzhaTexture, ImVec2(screenSize.width / 2 - hongzhaTexture.width / 2, 180), ImVec2(screenSize.width / 2 + hongzhaTexture.width / 2, 180 + hongzhaTexture.height), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                    }
                    if (materialData.name=="[Warning]Grenade") {
                        imDrawList->AddImage((__bridge ImTextureID) sldTexture, ImVec2(materialData.screen.x+190 - qtWidth+1, materialData.screen.y-5 -  qtHeight+1), ImVec2(materialData.screen.x+190 - qtWidth+1 + qtHeight-2 , materialData.screen.y-5 - qtHeight + qtHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                    }
                    if (materialData.name=="[Warning]Smoke") {
                        imDrawList->AddImage((__bridge ImTextureID) ywdTexture, ImVec2(materialData.screen.x+190 - qtWidth+1, materialData.screen.y-5 -  qtHeight+1), ImVec2(materialData.screen.x+190 - qtWidth+1 + qtHeight-2 , materialData.screen.y-5 - qtHeight + qtHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                    }
                    if (materialData.name=="[Warning]Molto") {
                        imDrawList->AddImage((__bridge ImTextureID) rspTexture, ImVec2(materialData.screen.x+190 - qtWidth+1, materialData.screen.y-5 -  qtHeight+1), ImVec2(materialData.screen.x+190 - qtWidth+1 + qtHeight-2 , materialData.screen.y-5 - qtHeight + qtHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                    }
            //物品文字
            if (materialData.distance != -100){
                //载具
            if (materialData.name=="motorcycle") {
                std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
                imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());

             }
            if (materialData.name=="3 Wheel Bike") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
               imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="Little Lamb") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
               imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="bouncing") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
               imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="Coupe") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="Car") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="UAZ") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="Ofuna") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="Motorboat") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="宝宝巴士") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="装甲车") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="UAZ车") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="雪地摩托") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="Snowmobile") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="皮卡") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }
            if (materialData.name=="双人Coupe") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 206, 209), 21, str.c_str());
            }//车辆文字显示
         //载具方框
        if (self.moduleControl->playerSwitch.Vehiclebox) {
DrawBox3D(imDrawList, materialData.objbox3d,ImColor(255,165,0),2.0f);
}
        //车辆耐久血条
          if (self.moduleControl->playerSwitch.Vehiclehf) {
                        //载具
                        if (materialData.distance > 10 && materialData.VehicleHP >0){

                            imDrawList->AddRectFilled({materialData.screen.x - 6 - ZJWidth, materialData.screen.y+28   - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleHP / 100, materialData.screen.y+28 }, ImColor(220, 20, 60, 150), 10.0f);
                            imDrawList->AddRectFilled({materialData.screen.x - 6 - ZJWidth, materialData.screen.y+37   - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleFuel / 100, materialData.screen.y+37 }, ImColor(30, 144, 255, 180), 10.0f);
                            imDrawList->AddRect({materialData.screen.x - 6 - ZJWidth, materialData.screen.y+28   - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleHP / 100, materialData.screen.y+28 }, ImColor(255, 255, 255, 150), 10.0f, 0, 1.0f);
                            imDrawList->AddRect({materialData.screen.x - 6 - ZJWidth, materialData.screen.y+37   - ZJHeight}, {materialData.screen.x - ZJWidth + (ZJWidth * 2) * materialData.VehicleFuel / 100, materialData.screen.y+37 }, ImColor(255, 255, 255, 150), 10.0f, 0, 1.0f);
}
}
            //ThrowableBox
            if (materialData.name=="[Box]") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, str.c_str());
        //Box3D
          if (self.moduleControl->playerSwitch.Airdropbox) {
DrawBox3D(imDrawList, materialData.objbox3d,ImColor(91,206,200),2.0f);
}
            }
        //Box3D
          if (self.moduleControl->playerSwitch.Airdropbox) {
DrawBox3D(imDrawList, materialData.objbox3d,ImColor(91,206,200),2.0f);
}
            if (materialData.name=="Box") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, str.c_str());
            }
            if (materialData.name=="[Throwable]") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 20, 147), 21, str.c_str());
            }
            if (materialData.name=="Throwable") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 20, 147), 21, str.c_str());
            }
            if (materialData.name=="信号AR") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 20, 147), 21, str.c_str());
            }
            //SR
        if (self.moduleControl->playerSwitch.QBU) {
            if (materialData.name=="QBU") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.SLR) {
            if (materialData.name=="SLR") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.SKS) {
            if (materialData.name=="SKS") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Mini14) {
            if (materialData.name=="Mini14") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.M24) {
            if (materialData.name=="M24") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Kar98k) {
            if (materialData.name=="Kar98k") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Mk14) {
            if (materialData.name=="Mk14") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.MosinNagant) {
            if (materialData.name=="Mosin Nagant") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.MK12) {
            if (materialData.name=="MK12") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.AMR) {
            if (materialData.name=="AMR") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.AWM) {
            if (materialData.name=="AWM") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
            //Rifle
        if (self.moduleControl->playerSwitch.M762) {
            if (materialData.name=="M762") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.SCARL) {
            if (materialData.name=="SCAR-L") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.M416) {
            if (materialData.name=="M416") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.M16A4) {
            if (materialData.name=="M16A4") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Mk47) {
            if (materialData.name=="Mk47") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.G36C) {
            if (materialData.name=="G36C") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.QBZ) {
            if (materialData.name=="QBZ") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Groza) {
            if (materialData.name=="Groza") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.AUG) {
            if (materialData.name=="AUG") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.AKM) {
            if (materialData.name=="AKM") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.DP-28) {
            if (materialData.name=="DP-28") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.M249) {
            if (materialData.name=="M249") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.MG3) {
            if (materialData.name=="MG3") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Grenade) {
            if (materialData.name=="Grenade") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Smoke) {
            if (materialData.name=="Smoke") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Molto) {
            if (materialData.name=="Molto") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Level2) {
            if (materialData.name=="Defend") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Level3Vest) {
            if (materialData.name=="Level 3 Vest") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.二级包) {
            if (materialData.name=="二级包") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Level3Bag) {
            if (materialData.name=="Level 3 Bag") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Level2) {
            if (materialData.name=="2 Level") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Level3) {
            if (materialData.name=="Level 3") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.PainKiller) {
            if (materialData.name=="PainKiller") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Epinephrine) {
            if (materialData.name=="Epinephrine") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.Drink) {
            if (materialData.name=="Drink") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.FirstAid) {
            if (materialData.name=="FirstAid") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.MedicalKit) {
            if (materialData.name=="Medical Kit") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
            }
}
            if (materialData.name=="Oil drum") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
            }
        if (self.moduleControl->playerSwitch.RedDot) {
            if (materialData.name=="Red Dot") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
               imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.holographic) {
            if (materialData.name=="holographic") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.倍Scope3) {
            if (materialData.name=="3X") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.倍Scope4) {
            if (materialData.name=="4X") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.倍Scope6) {
            if (materialData.name=="6X") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
}
        if (self.moduleControl->playerSwitch.倍Scope8) {
            if (materialData.name=="8X") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
}
            if (materialData.name=="[Warning]Molto") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(178, 34, 34), 21, str.c_str());
            }
            if (materialData.name=="[Warning]Smoke") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(178, 34, 34), 21, str.c_str());
            }
            if (materialData.name=="[Warning]Grenade") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(178, 34, 34), 21, str.c_str());
            }
            if (materialData.name=="[Warning]Bomb Waning") {
               std::string str =  "["+ materialData.name +":" + std::to_string(materialData.distance) + "M]";
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(178, 34, 34), 21, str.c_str());
            }
            } else {
                if (materialData.name=="[Med]PainKiller") {
                   std::string str = materialData.name;
                    imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
                   imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
                }
                if (materialData.name=="[Med]Epinephrine") {
                   std::string str = materialData.name;
                    imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
                   imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
                }
                if (materialData.name=="[Med]Drink") {
                   std::string str = materialData.name;
                    imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
                   imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
                }
                if (materialData.name=="[Med]FirstAid") {
                   std::string str = materialData.name;
                    imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
                   imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
                }
                if (materialData.name=="[Med]Medical Kit") {
                   std::string str = materialData.name;
                    imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
                   imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 210, 0), 21, str.c_str());
                }
            if (materialData.name=="[Defend]Level 3 Vest") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[包]Level 3 Bag") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[头]Level 3") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[Defend]Level 2") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[包]二级包") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[头]2 Level") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            
            if (materialData.name=="[spy]QBU") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]SLR") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]SKS") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]Mini14") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]M24") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]Kar98k") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]Mk14") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]Mosin Nagant") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]MK12") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]AMR") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[spy]AWM") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 0, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]M762") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]SCAR-L") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]M416") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]M16A4") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]Mk47") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]G36C") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]QBZ") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]Groza") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]AUG") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[AR]AKM") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[LMG]DP-28") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[LMG]M249") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[LMG]MG3") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 69, 0), 21, str.c_str());
            }
            if (materialData.name=="[Bomb]5.56mm") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, str.c_str());
            }
            if (materialData.name=="[Bomb]7.62mm") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, str.c_str());
            }
            if (materialData.name=="[Bomb]马格南") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, str.c_str());
            }
            if (materialData.name=="[Bomb]Signal Bomb") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(0, 255, 0), 21, str.c_str());
            }
            if (materialData.name=="[Scope]Red Dot") {
               std::string str = materialData.name;
               imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
            if (materialData.name=="[Scope]holographic") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
            if (materialData.name=="[Scope]3X") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
            if (materialData.name=="[Scope]4X") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
            if (materialData.name=="[Scope]6X") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
            if (materialData.name=="[Scope]8X") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(70, 130, 180), 21, str.c_str());
            }
            if (materialData.name=="[Throwable]Grenade") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, str.c_str());
            }
            if (materialData.name=="[Throwable]Smoke") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, str.c_str());
            }
            if (materialData.name=="[Throwable]Molto") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 127, 80), 21, str.c_str());
            }




            if (materialData.name=="[Sniper Accessories]Cheek pad") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Sniper Accessories]Child Bomb Bag") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Sniper Accessories]Child Bomb Bag") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Sniper Accessories]Flash Hider") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Sniper Accessories]Compensator") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Sniper Accessories]Muzzle") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Sniper Accessories]Extended Quick") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Sniper Accessories]Extended") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Grip]Thumb Grip") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Grip]Vertial Grip") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Grip]Half Grip") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Accessories]Compensator") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Accessories]Tactical AR holder") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Accessories]Flash Hider") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Accessories]Muzzle") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Accessories]Extended Quick") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }
            if (materialData.name=="[Accessories]Extended") {
               std::string str = materialData.name;
                imDrawList->AddTextX(ImVec2(materialData.screen.x+1 - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y+1), ImColor(0, 0, 0, 255), 21, str.c_str());
               imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(str.c_str(), 21) / 2, materialData.screen.y), ImColor(255, 255, 80), 21, str.c_str());
            }                
          }
        }
//物品贴图
if (self.moduleControl->playerSwitch.WZStatus) {
if (materialData.name=="[Warning]Grenade") {
imDrawList->AddImage((__bridge ImTextureID) shouleiTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}

if (materialData.name=="UAZ") {
imDrawList->AddImage((__bridge ImTextureID) JPTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="bouncing") {
imDrawList->AddImage((__bridge ImTextureID) BBTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Car") {
imDrawList->AddImage((__bridge ImTextureID) jcTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Motorboat") {
imDrawList->AddImage((__bridge ImTextureID) mttTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="motorcycle") {
imDrawList->AddImage((__bridge ImTextureID) mtTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Little Lamb") {
imDrawList->AddImage((__bridge ImTextureID) myTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="CoupeRB") {
imDrawList->AddImage((__bridge ImTextureID) R8Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="3 Wheel Bike") {
imDrawList->AddImage((__bridge ImTextureID) mt3Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="M416") {
imDrawList->AddImage((__bridge ImTextureID) m416Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="AKM") {
imDrawList->AddImage((__bridge ImTextureID) akmTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="AUG") {
imDrawList->AddImage((__bridge ImTextureID) augTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Groza") {
imDrawList->AddImage((__bridge ImTextureID) grozaTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="M16A4") {
imDrawList->AddImage((__bridge ImTextureID) m16Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="M24") {
imDrawList->AddImage((__bridge ImTextureID) m24Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="M249") {
imDrawList->AddImage((__bridge ImTextureID) m249Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="M762") {
imDrawList->AddImage((__bridge ImTextureID) m762Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="MG3") {
imDrawList->AddImage((__bridge ImTextureID) mg3Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Mini14") {
imDrawList->AddImage((__bridge ImTextureID) miniTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Mk14") {
imDrawList->AddImage((__bridge ImTextureID) mk14Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Mk47") {
imDrawList->AddImage((__bridge ImTextureID) mk47Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="SCAR-L") {
imDrawList->AddImage((__bridge ImTextureID) scarTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="SLR") {
imDrawList->AddImage((__bridge ImTextureID) slrTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="AWM") {
imDrawList->AddImage((__bridge ImTextureID) awmTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="DP-28") {
imDrawList->AddImage((__bridge ImTextureID) dp28Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Kar98k") {
imDrawList->AddImage((__bridge ImTextureID) k98Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="SKS") {
imDrawList->AddImage((__bridge ImTextureID) sksTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="[Box]") {
imDrawList->AddImage((__bridge ImTextureID) hzTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Box") {
imDrawList->AddImage((__bridge ImTextureID) ktTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+17 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+17 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}

if (materialData.name=="Drink") {
imDrawList->AddImage((__bridge ImTextureID) ylTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="PainKiller") {
imDrawList->AddImage((__bridge ImTextureID) ztyTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="FirstAid") {
imDrawList->AddImage((__bridge ImTextureID) jjbTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Medical Kit") {
imDrawList->AddImage((__bridge ImTextureID) ylxTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Epinephrine") {
imDrawList->AddImage((__bridge ImTextureID) zhenTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}

if (materialData.name=="4X") {
imDrawList->AddImage((__bridge ImTextureID) b4Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="3X") {
imDrawList->AddImage((__bridge ImTextureID) b3Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="6X") {
imDrawList->AddImage((__bridge ImTextureID) b6Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="8X") {
imDrawList->AddImage((__bridge ImTextureID) b8Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="[Throwable]") {
imDrawList->AddImage((__bridge ImTextureID) ktTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Throwable") {
imDrawList->AddImage((__bridge ImTextureID) ktTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Level 3") {
imDrawList->AddImage((__bridge ImTextureID) t3Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Level 3 Vest") {
imDrawList->AddImage((__bridge ImTextureID) j3Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Level 3 Bag") {
imDrawList->AddImage((__bridge ImTextureID) bb3Texture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Grenade") {
imDrawList->AddImage((__bridge ImTextureID) tleiTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Smoke") {
imDrawList->AddImage((__bridge ImTextureID) tyanTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
if (materialData.name=="Molto") {
imDrawList->AddImage((__bridge ImTextureID) thuoTexture, ImVec2(materialData.screen.x+165 - scWidth+1, materialData.screen.y+10 -  scHeight+1), ImVec2(materialData.screen.x+165 - scWidth+1 + scHeight-2 , materialData.screen.y+10 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
}
//物品距离——贴图
if (materialData.distance != -100) {
std::string str = std::to_string(materialData.distance) + "M";
imDrawList->AddTextX(ImVec2(materialData.screen.x-14 - calcTextSize(std::to_string(materialData.distance).c_str(), 22) / 2, materialData.screen.y-4 ), ImColor(255, 255,0), 22, str.c_str());
} else {
std::string str = materialData.name + ":";//Box内物资
imDrawList->AddRectFilled({materialData.screen.x - calcTextSize(materialData.name.c_str(), 22) / 2, materialData.screen.y }, {materialData.screen.x + calcTextSize(materialData.name.c_str(), 22) / 2, materialData.screen.y + 22}, ImColor(0, 0, 0, 80), 10.0f);
imDrawList->AddTextX(ImVec2(materialData.screen.x - calcTextSize(materialData.name.c_str(), 22) / 2, materialData.screen.y + (22 / 2 - 22 / 2)), ImColor(255, 255, 255), 22, materialData.name.c_str());
}
      }
}
    
    if (self.moduleControl->mainSwitch.playerStatus) {
      
    if (self.moduleControl->playerSwitch.radarStatus) {

    ImVec2 topLeft = ImVec2(
        self.moduleControl->playerSwitch.radarCoord.x - 225 * (self.moduleControl->playerSwitch.radarSize / 100),
        self.moduleControl->playerSwitch.radarCoord.y - 225 * (self.moduleControl->playerSwitch.radarSize / 100)
    );
    ImVec2 bottomRight = ImVec2(
        self.moduleControl->playerSwitch.radarCoord.x + 225 * (self.moduleControl->playerSwitch.radarSize / 100),
        self.moduleControl->playerSwitch.radarCoord.y + 225 * (self.moduleControl->playerSwitch.radarSize / 100)
    );

    // 底色
    imDrawList->AddRectFilled(topLeft, bottomRight, ImColor(0, 0, 0, 0));

    //// 外形
    imDrawList->AddRect(topLeft, bottomRight, ImColor(0, 0, 0), 0, ImDrawFlags_None, 1.0f);

    // T
    imDrawList->AddLine(ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y - 225 * (self.moduleControl->playerSwitch.radarSize / 100)),
                        ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y + 225 * (self.moduleControl->playerSwitch.radarSize / 100)),
                        ImColor(0, 0, 0), 1.0f);

    // |
    imDrawList->AddLine(ImVec2(self.moduleControl->playerSwitch.radarCoord.x - 225 * (self.moduleControl->playerSwitch.radarSize / 100), self.moduleControl->playerSwitch.radarCoord.y),
                        ImVec2(self.moduleControl->playerSwitch.radarCoord.x + 225 * (self.moduleControl->playerSwitch.radarSize / 100), self.moduleControl->playerSwitch.radarCoord.y),
                        ImColor(0, 0, 0), 1.0f);

    // \/
    ImVec2 rotation = rotateCoord(130, ImVec2(0, 255 * (self.moduleControl->playerSwitch.radarSize / 100)));
    imDrawList->AddLine(ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y),
                        ImVec2(self.moduleControl->playerSwitch.radarCoord.x + rotation.x, self.moduleControl->playerSwitch.radarCoord.y + rotation.y),
                        ImColor(0, 0, 0), 1.0f);

    /// ---
    rotation = rotateCoord(-130, ImVec2(0, 225 * (self.moduleControl->playerSwitch.radarSize / 100)));
    imDrawList->AddLine(ImVec2(self.moduleControl->playerSwitch.radarCoord.x, self.moduleControl->playerSwitch.radarCoord.y),
                        ImVec2(self.moduleControl->playerSwitch.radarCoord.x + rotation.x, self.moduleControl->playerSwitch.radarCoord.y + rotation.y),
                        ImColor(0, 0, 0), 1.0f);
         }


        //清空人数
        int playerCount = 0, robotCount = 0;
        for (PlayerData playerData:playerDataList) {
            //人LMG数量和真人数量
            ImColor color, color150;
            if (!playerData.robot) {//真人
                if (playerData.visibility) {
                    color = ImColor(0, 255, 0);//可见
                } else {
                    color = ImColor(255, 0, 0);//不可见
                }
                playerCount += 1;
            } else {
                if (playerData.visibility) {
                    color = ImColor(255, 165, 0);//可见
                } else {
                    color = ImColor(0, 255, 255);//不可见
                }
                robotCount += 1;
            }

         
            if (self.moduleControl->playerSwitch.radarStatus) {//圆点
                imDrawList->AddCircleFilled({(float) (self.moduleControl->playerSwitch.radarCoord.x + playerData.radar.x * (self.moduleControl->playerSwitch.radarSize / 100)), (float) (self.moduleControl->playerSwitch.radarCoord.y + playerData.radar.y * (self.moduleControl->playerSwitch.radarSize / 100))}, 8, color);
                std::string str = std::to_string(playerData.distance) + "M";//距离
                imDrawList->AddTextX(ImVec2((float) (self.moduleControl->playerSwitch.radarCoord.x + playerData.radar.x * (self.moduleControl->playerSwitch.radarSize / 100) + 12), (float) (self.moduleControl->playerSwitch.radarCoord.y + playerData.radar.y * (self.moduleControl->playerSwitch.radarSize / 100) - 12)), color, 24, str.c_str());
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
        drawTextWithStroke(
            /* font */ nullptr,
            weaponFontSize,
            weaponPos,
            IM_COL32(255, 255, 0, 255),
            IM_COL32(0, 0, 0, 255),
            playerData.weaponName.c_str(),
            true
        );
    }

    std::string nameStr = playerData.name.empty() ? "BOT" : playerData.name;

    
    ImVec2 namePos = ImVec2(
        playerData.screen.x,
        playerData.screen.y + playerData.size.y - 12
    );

    drawTextWithStroke(
        /* font */ nullptr,
        nameFontSize,
        namePos,
        IM_COL32(255, 255, 0, 255),
        IM_COL32(0, 0, 0, 255),
        nameStr.c_str(),
        true
    );

    
    std::string distStr = std::to_string(playerData.distance) + "M";
    ImVec2 distPos = ImVec2(foot.x, foot.y - 2);
    drawTextWithStroke(
        /* font */ nullptr,
        18,
        distPos,
        IM_COL32(255, 255, 255, 255),
        IM_COL32(0, 0, 0, 255),
        distStr.c_str(),
        true
    );

  
    ImVec2 boxStart = ImVec2(head.x - width / 2, head.y);
    ImVec2 boxEnd   = ImVec2(head.x + width / 2, foot.y);
    imDrawList->AddRect(boxStart, boxEnd, IM_COL32(255, 255, 255, 255), 2.0f, 0, 2.0f);
    }

     
                   //手持武器文字
           if (self.moduleControl->playerSwitch.SCWZStatus) {
                    imDrawList->AddTextX(ImVec2(playerData.screen.x+4 - calcTextSize(playerData.weaponName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y-19  - hpHeight- 32), ImColor(0, 0, 0, 255), 20, playerData.weaponName.c_str());
                    imDrawList->AddTextX(ImVec2(playerData.screen.x+3 - calcTextSize(playerData.weaponName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y-20  - hpHeight- 32), ImColor(255, 255, 255), 20, playerData.weaponName.c_str());
                    
                    imDrawList->AddTextX(ImVec2(playerData.screen.x+4 - calcTextSize(playerData.statusName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y-39  - hpHeight- 32), ImColor(0, 0, 0, 255), 20, playerData.statusName.c_str());
                    imDrawList->AddTextX(ImVec2(playerData.screen.x+3 - calcTextSize(playerData.statusName.c_str(), 20) / 2, playerData.screen.y - playerData.size.y-40  - hpHeight- 32), ImColor(0, 191, 255), 20, playerData.statusName.c_str());                                 
           }
                    //手持武器贴图
            if (self.moduleControl->playerSwitch.SCStatus) {
                if (playerData.weaponName=="Fist") {
                   imDrawList->AddImage((__bridge ImTextureID) quanTexture, ImVec2(playerData.screen.x+200 - qtWidth+1, playerData.screen.y-30 - playerData.size.y -5 - qtHeight+1), ImVec2(playerData.screen.x+200 - qtWidth+1 + qtHeight-2 , playerData.screen.y-30 - playerData.size.y -5 - qtHeight + qtHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                   }
                if (playerData.weaponName=="[LMG]DP-28") {
                   imDrawList->AddImage((__bridge ImTextureID) DP28Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[LMG]M249") {
                   imDrawList->AddImage((__bridge ImTextureID) M249Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[LMG]MG3") {
                   imDrawList->AddImage((__bridge ImTextureID) MG3Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SG]S686") {
                   imDrawList->AddImage((__bridge ImTextureID) S686Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SG]DBS") {
                   imDrawList->AddImage((__bridge ImTextureID) DBSTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SG]S12K") {
                   imDrawList->AddImage((__bridge ImTextureID) S12KTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                     }
                if (playerData.weaponName=="[SMG]Bison") {
                   imDrawList->AddImage((__bridge ImTextureID) YNTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]QBZ") {
                   imDrawList->AddImage((__bridge ImTextureID) QBZTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]M416") {
                   imDrawList->AddImage((__bridge ImTextureID) M416Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]QBU") {
                   imDrawList->AddImage((__bridge ImTextureID) QBUTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]SLR") {
                   imDrawList->AddImage((__bridge ImTextureID) SLRTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]SKS") {
                   imDrawList->AddImage((__bridge ImTextureID) SKSTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]Mini14") {
                   imDrawList->AddImage((__bridge ImTextureID) MINITexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]M24") {
                   imDrawList->AddImage((__bridge ImTextureID) M24Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]Kar98k") {
                   imDrawList->AddImage((__bridge ImTextureID) K98Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]AWM") {
                   imDrawList->AddImage((__bridge ImTextureID) AWMTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]Mk14") {
                   imDrawList->AddImage((__bridge ImTextureID) MK14Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]Mosin Nagant") {
                   imDrawList->AddImage((__bridge ImTextureID) MOTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SR]VSS") {
                   imDrawList->AddImage((__bridge ImTextureID) VSSTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                
                if (playerData.weaponName=="[Rifle]M762") {
                   imDrawList->AddImage((__bridge ImTextureID) M762Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]SCAR-L") {
                   imDrawList->AddImage((__bridge ImTextureID) SCARTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]M16A4") {
                   imDrawList->AddImage((__bridge ImTextureID) M16Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]Mk47") {
                   imDrawList->AddImage((__bridge ImTextureID) MK47Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]Groza") {
                   imDrawList->AddImage((__bridge ImTextureID) GrozaTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]AUG") {
                   imDrawList->AddImage((__bridge ImTextureID) AUGTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Rifle]AKM") {
                   imDrawList->AddImage((__bridge ImTextureID) AkmTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                
                if (playerData.weaponName=="[Throwable]Grenade") {
                   imDrawList->AddImage((__bridge ImTextureID) leiTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Throwable]Smoke") {
                   imDrawList->AddImage((__bridge ImTextureID) yanTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Throwable]Molto") {
                   imDrawList->AddImage((__bridge ImTextureID) huoTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                
                if (playerData.weaponName=="[Melee]Pan") {
                   imDrawList->AddImage((__bridge ImTextureID) GUOTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                
                if (playerData.weaponName=="[Melee]Sickle") {
                   imDrawList->AddImage((__bridge ImTextureID) LIANTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                
                if (playerData.weaponName=="[Melee]Machete") {
                   imDrawList->AddImage((__bridge ImTextureID) DAOTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Melee]Crowbar") {
                   imDrawList->AddImage((__bridge ImTextureID) GUNTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SMG]MP5K") {
                   imDrawList->AddImage((__bridge ImTextureID) MP5KTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SMG]TommyGun") {
                   imDrawList->AddImage((__bridge ImTextureID) TANGTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SMG]UMP9") {
                   imDrawList->AddImage((__bridge ImTextureID) UMP9Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                
                if (playerData.weaponName=="[SMG]Uzi") {
                   imDrawList->AddImage((__bridge ImTextureID) UZITexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[SMG]Vector") {
                   imDrawList->AddImage((__bridge ImTextureID) VKTTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                
                if (playerData.weaponName=="[Pistol]P92") {
                   imDrawList->AddImage((__bridge ImTextureID) P92Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Pistol]P1911") {
                   imDrawList->AddImage((__bridge ImTextureID) P1911Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Pistol]R1895") {
                   imDrawList->AddImage((__bridge ImTextureID) R1895Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Pistol]P18C") {
                   imDrawList->AddImage((__bridge ImTextureID) P18CTexture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }
                if (playerData.weaponName=="[Pistol]R45") {
                   imDrawList->AddImage((__bridge ImTextureID) R45Texture, ImVec2(playerData.screen.x+160 - scWidth+1, playerData.screen.y+2 - playerData.size.y -5 - scHeight+1), ImVec2(playerData.screen.x+160 - scWidth+1 + scHeight-2 , playerData.screen.y+2 - playerData.size.y -5 - scHeight + scHeight-1), ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f));
                }

                //}
              
                //}

//绘制方框                          
                if (self.moduleControl->playerSwitch.boxStatus) {
                    if (self.moduleControl->mainSwitch.Drawbox == 1) {//对角方框
if (playerData.hp<=1){
drawUnclosedRect2(playerData.screen.x, playerData.screen.y,playerData.size.x + playerData.size.x, playerData.size.y + playerData.size.y ,ImColor(255,165,0), 1.0f);
}else{
drawUnclosedRect2(playerData.screen.x, playerData.screen.y,playerData.size.x + playerData.size.x, playerData.size.y + playerData.size.y , color, 1.0f);
                }
          }
                    if (self.moduleControl->mainSwitch.Drawbox == 2) {//3D方框
if (playerData.hp<=1){
DrawBox3D(imDrawList, playerData.objbox3d,ImColor(255,165,0),2.0f);
}else{
DrawBox3D(imDrawList, playerData.objbox3d,color,2.0f);
                } 
           }
                    if (self.moduleControl->mainSwitch.Drawbox == 3) {//原版方框 
                    if (playerData.hp<=1){
                    imDrawList->AddRect({playerData.screen.x - playerData.size.x, playerData.screen.y - playerData.size.y}, {playerData.screen.x + playerData.size.x, playerData.screen.y + playerData.size.y}, ImColor(255,165,0), 10.0f, 0, 2.0f);
                }else{
                    imDrawList->AddRect({playerData.screen.x - playerData.size.x, playerData.screen.y - playerData.size.y}, {playerData.screen.x + playerData.size.x, playerData.screen.y + playerData.size.y}, color, 10.0f, 0, 2.0f);
                }
              }
          }
  
              
                //绘制射线
                if (self.moduleControl->playerSwitch.lineStatus) {
                    if (playerData.hp<=1){
                    imDrawList->AddLine(ImVec2(screenSize.width / 2, 0), ImVec2(playerData.screen.x, playerData.screen.y - playerData.size.y-80), ImColor(255,165,0), 1.0f);
                }else{
                    imDrawList->AddLine(ImVec2(screenSize.width / 2, 0), ImVec2(playerData.screen.x, playerData.screen.y - playerData.size.y-80), color, 1.0f);
                }
                }
                //绘制骨骼
                if (self.moduleControl->playerSwitch.boneStatus) {

        ImColor color;
        if (playerData.visibility) {
            color = ImColor(visibleBoneColor);
        } else {
            color = ImColor(invisibleBoneColor);
        }

        imDrawList->AddLine({playerData.bonesData.head.x, playerData.bonesData.head.y}, {playerData.bonesData.pit.x, playerData.bonesData.pit.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.pit.x, playerData.bonesData.pit.y}, {playerData.bonesData.pelvis.x, playerData.bonesData.pelvis.y}, color, 1.7f);

        imDrawList->AddLine({playerData.bonesData.pit.x, playerData.bonesData.pit.y}, {playerData.bonesData.lcollar.x, playerData.bonesData.lcollar.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.lcollar.x, playerData.bonesData.lcollar.y}, {playerData.bonesData.lelbow.x, playerData.bonesData.lelbow.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.lelbow.x, playerData.bonesData.lelbow.y}, {playerData.bonesData.lwrist.x, playerData.bonesData.lwrist.y}, color, 1.7f);

        imDrawList->AddLine({playerData.bonesData.pit.x, playerData.bonesData.pit.y}, {playerData.bonesData.rcollar.x, playerData.bonesData.rcollar.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.rcollar.x, playerData.bonesData.rcollar.y}, {playerData.bonesData.relbow.x, playerData.bonesData.relbow.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.relbow.x, playerData.bonesData.relbow.y}, {playerData.bonesData.rwrist.x, playerData.bonesData.rwrist.y}, color, 1.7f);

        imDrawList->AddLine({playerData.bonesData.pelvis.x, playerData.bonesData.pelvis.y}, {playerData.bonesData.lthigh.x, playerData.bonesData.lthigh.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.lthigh.x, playerData.bonesData.lthigh.y}, {playerData.bonesData.lknee.x, playerData.bonesData.lknee.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.lknee.x, playerData.bonesData.lknee.y}, {playerData.bonesData.lankle.x, playerData.bonesData.lankle.y}, color, 1.7f);

        imDrawList->AddLine({playerData.bonesData.pelvis.x, playerData.bonesData.pelvis.y}, {playerData.bonesData.rthigh.x, playerData.bonesData.rthigh.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.rthigh.x, playerData.bonesData.rthigh.y}, {playerData.bonesData.rknee.x, playerData.bonesData.rknee.y}, color, 1.7f);
        imDrawList->AddLine({playerData.bonesData.rknee.x, playerData.bonesData.rknee.y}, {playerData.bonesData.rankle.x, playerData.bonesData.rankle.y}, color, 1.7f);
    }
  }
}


                     if (menu::ESP::enemy_count) {
    if (playerCount != 0 || robotCount != 0) {
        int totalplayers = playerCount + robotCount;
        std::string totalEnemiesStr = "Total enemy around you : " + std::to_string(totalplayers);

        int fontSize = 30;

        float textWidth = ImGui::CalcTextSize(totalEnemiesStr.c_str()).x;
        ImVec2 pos = ImVec2((screenSize.width / 2.0f) - (textWidth / 2.0f), 101.5f + countTexture.height / 2.0f - 20.0f);

        float paddingX = 20.0f;
        float paddingY = 14.0f;

        ImVec2 rectMin = ImVec2(pos.x - paddingX, pos.y - paddingY);
        ImVec2 rectMax = ImVec2(pos.x + textWidth + paddingX, pos.y + fontSize + paddingY);

        ImDrawList* imDrawList = ImGui::GetBackgroundDrawList();

        // 🟫 Background: dark black box
        imDrawList->AddRectFilled(rectMin, rectMax, ImColor(0, 0, 0, 230), 10.0f);

        // ✅ Green outline
        imDrawList->AddRect(rectMin, rectMax, ImColor(0, 255, 0, 255), 10.0f, 0, 2.0f);

        // 📝 White text using default font
        imDrawList->AddText(pos, IM_COL32(255, 255, 255, 255), totalEnemiesStr.c_str());
        }
    }
}

   
if (self.moduleControl->mainSwitch.aimbotStatus) {
if (self.moduleControl->aimbotController.showAimbotRadius) {
                //自瞄圆圈
          StaticPlayerData aimbotPlayerData;
                //自瞄对象坐标,指定部位的坐标
             ImVec3 aimbotCoord = ImVec3(0,0,0);
            //自瞄圆圈
            imDrawList->AddCircle(ImVec2(screenSize.width / 2, screenSize.height / 2), self.moduleControl->aimbotController.aimbotRadius, ImColor(0, 255, 255, 255), 0, 1.0f);
//预瞄点
        }
    }
         ImGui::End();
}

void Line(ImDrawList *draw,ImVec2 origin, ImVec2 dest, ImColor color, float thickness)
{
draw->AddLine({origin.x, origin.y},{dest.x, dest.y},color,1.0f);
}

void drawUnclosedRect2(float center_x, float center_y, float center_w, float center_h, ImVec4 rgb, float thickness) {
imDrawList->AddLine(ImVec2{center_x-(center_w/2),center_y-(center_h/2)},ImVec2{center_x-(center_w/4),center_y-(center_h/2)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);

imDrawList->AddLine(ImVec2{center_x+(center_w/2),center_y-(center_h/2)},ImVec2{center_x+(center_w/4),center_y-(center_h/2)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);

imDrawList->AddLine(ImVec2{center_x-(center_w/2),center_y+(center_h/2)},ImVec2{center_x-(center_w/4),center_y+(center_h/2)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);

imDrawList->AddLine(ImVec2{center_x+(center_w/2),center_y+(center_h/2)},ImVec2{center_x+(center_w/4),center_y+(center_h/2)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);

imDrawList->AddLine(ImVec2{center_x-(center_w/2),center_y-(center_h/2)},ImVec2{center_x-(center_w/2),center_y-(center_h/4)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);

imDrawList->AddLine(ImVec2{center_x+(center_w/2),center_y-(center_h/2)},ImVec2{center_x+(center_w/2),center_y-(center_h/4)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);

imDrawList->AddLine(ImVec2{center_x-(center_w/2),center_y+(center_h/2)},ImVec2{center_x-(center_w/2),center_y+(center_h/4)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);

imDrawList->AddLine(ImVec2{center_x+(center_w/2),center_y+(center_h/2)},ImVec2{center_x+(center_w/2),center_y+(center_h/4)},ImGui::ColorConvertFloat4ToU32(rgb),1.0f);
}

-(void)initImageTexture: (id<MTLDevice>)device {
    NSData *countData = [[NSData alloc] initWithBase64EncodedString:countDataBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    countTexture = [self loadImageTexture : device : (void*)[countData bytes] : [countData length]];
    
    NSData *countData1 = [[NSData alloc] initWithBase64EncodedString:countData1Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    count1Texture = [self loadImageTexture : device : (void*)[countData1 bytes] : [countData1 length]];
    
    NSData *countData2 = [[NSData alloc] initWithBase64EncodedString:countData2Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    count2Texture = [self loadImageTexture : device : (void*)[countData2 bytes] : [countData2 length]];
    
    NSData *countData3 = [[NSData alloc] initWithBase64EncodedString:countData3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    count3Texture = [self loadImageTexture : device : (void*)[countData3 bytes] : [countData3 length]];
    
    NSData *countData4 = [[NSData alloc] initWithBase64EncodedString:countData4Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    count4Texture = [self loadImageTexture : device : (void*)[countData4 bytes] : [countData4 length]];
    
    NSData *countData5 = [[NSData alloc] initWithBase64EncodedString:countData5Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    count5Texture = [self loadImageTexture : device : (void*)[countData5 bytes] : [countData5 length]];
    
    NSData *quan = [[NSData alloc] initWithBase64EncodedString:quanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    quanTexture = [self loadImageTexture : device : (void*)[quan bytes] : [quan length]];
    
    NSData *shoulei = [[NSData alloc] initWithBase64EncodedString:shouleiBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    shouleiTexture = [self loadImageTexture : device : (void*)[shoulei bytes] : [shoulei length]];
    
    NSData *playerData = [[NSData alloc] initWithBase64EncodedString:playerDataBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    playerTexture = [self loadImageTexture : device : (void*)[playerData bytes] : [playerData length]];
    
    NSData *robotData = [[NSData alloc] initWithBase64EncodedString:robotDataBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    robotTexture = [self loadImageTexture : device : (void*)[robotData bytes] : [robotData length]];
    //手持武器
    NSData *M416 = [[NSData alloc] initWithBase64EncodedString:M416Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    M416Texture = [self loadImageTexture : device : (void*)[M416 bytes] : [M416 length]];
    
    NSData *M16 = [[NSData alloc] initWithBase64EncodedString:M16Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    M16Texture = [self loadImageTexture : device : (void*)[M16 bytes] : [M16 length]];

    NSData *Groza = [[NSData alloc] initWithBase64EncodedString:GrozaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    GrozaTexture = [self loadImageTexture : device : (void*)[Groza bytes] : [Groza length]];

    NSData *Akm = [[NSData alloc] initWithBase64EncodedString:AkmBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    AkmTexture = [self loadImageTexture : device : (void*)[Akm bytes] : [Akm length]];

    NSData *SCAR = [[NSData alloc] initWithBase64EncodedString:SCARBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    SCARTexture = [self loadImageTexture : device : (void*)[SCAR bytes] : [SCAR length]];

    NSData *MK47 = [[NSData alloc] initWithBase64EncodedString:MK47Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    MK47Texture = [self loadImageTexture : device : (void*)[MK47 bytes] : [MK47 length]];

    NSData *AUG = [[NSData alloc] initWithBase64EncodedString:AUGBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    AUGTexture = [self loadImageTexture : device : (void*)[AUG bytes] : [AUG length]];

    NSData *M762 = [[NSData alloc] initWithBase64EncodedString:M762Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    M762Texture = [self loadImageTexture : device : (void*)[M762 bytes] : [M762 length]];
    
    NSData *QBZ = [[NSData alloc] initWithBase64EncodedString:QBZBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    QBZTexture = [self loadImageTexture : device : (void*)[QBZ bytes] : [QBZ length]];
    
    NSData *lei = [[NSData alloc] initWithBase64EncodedString:leiBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    leiTexture = [self loadImageTexture : device : (void*)[lei bytes] : [lei length]];
  
    NSData *huo = [[NSData alloc] initWithBase64EncodedString:huoBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    huoTexture = [self loadImageTexture : device : (void*)[huo bytes] : [huo length]];

    NSData *yan = [[NSData alloc] initWithBase64EncodedString:yanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    yanTexture = [self loadImageTexture : device : (void*)[yan bytes] : [yan length]];

    NSData *shan = [[NSData alloc] initWithBase64EncodedString:shanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    shanTexture = [self loadImageTexture : device : (void*)[shan bytes] : [shan length]];

    NSData *R1895 = [[NSData alloc] initWithBase64EncodedString:R1895Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    R1895Texture = [self loadImageTexture : device : (void*)[R1895 bytes] : [R1895 length]];

    NSData *P92 = [[NSData alloc] initWithBase64EncodedString:P92Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    P92Texture = [self loadImageTexture : device : (void*)[P92 bytes] : [P92 length]];

    NSData *P1911 = [[NSData alloc] initWithBase64EncodedString:P1911Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    P1911Texture = [self loadImageTexture : device : (void*)[P1911 bytes] : [P1911 length]];

    NSData *P18C = [[NSData alloc] initWithBase64EncodedString:P18CBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    P18CTexture = [self loadImageTexture : device : (void*)[P18C bytes] : [P18C length]];

    NSData *R45 = [[NSData alloc] initWithBase64EncodedString:R45Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    R45Texture = [self loadImageTexture : device : (void*)[R45 bytes] : [R45 length]];
 
    NSData *SKS = [[NSData alloc] initWithBase64EncodedString:SKSBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    SKSTexture = [self loadImageTexture : device : (void*)[SKS bytes] : [SKS length]];

    NSData *MINI = [[NSData alloc] initWithBase64EncodedString:MINIBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    MINITexture = [self loadImageTexture : device : (void*)[MINI bytes] : [MINI length]];

    NSData *MK14 = [[NSData alloc] initWithBase64EncodedString:MK14Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    MK14Texture = [self loadImageTexture : device : (void*)[MK14 bytes] : [MK14 length]];

    NSData *VSS = [[NSData alloc] initWithBase64EncodedString:VSSBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    VSSTexture = [self loadImageTexture : device : (void*)[VSS bytes] : [VSS length]];

    NSData *QBU = [[NSData alloc] initWithBase64EncodedString:QBUBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    QBUTexture = [self loadImageTexture : device : (void*)[QBU bytes] : [QBU length]];

    NSData *SLR = [[NSData alloc] initWithBase64EncodedString:SLRBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    SLRTexture = [self loadImageTexture : device : (void*)[SLR bytes] : [SLR length]];

    NSData *AWM = [[NSData alloc] initWithBase64EncodedString:AWMBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    AWMTexture = [self loadImageTexture : device : (void*)[AWM bytes] : [AWM length]];

    NSData *K98 = [[NSData alloc] initWithBase64EncodedString:K98Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    K98Texture = [self loadImageTexture : device : (void*)[K98 bytes] : [K98 length]];

    NSData *MO = [[NSData alloc] initWithBase64EncodedString:MOBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    MOTexture = [self loadImageTexture : device : (void*)[MO bytes] : [MO length]];

    NSData *LIAN = [[NSData alloc] initWithBase64EncodedString:LIANBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    LIANTexture = [self loadImageTexture : device : (void*)[LIAN bytes] : [LIAN length]];

    NSData *GUN = [[NSData alloc] initWithBase64EncodedString:GUNBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    GUNTexture = [self loadImageTexture : device : (void*)[GUN bytes] : [GUN length]];
 
    NSData *DAO = [[NSData alloc] initWithBase64EncodedString:DAOBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    DAOTexture = [self loadImageTexture : device : (void*)[DAO bytes] : [DAO length]];

    NSData *GUO = [[NSData alloc] initWithBase64EncodedString:GUOBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    GUOTexture = [self loadImageTexture : device : (void*)[GUO bytes] : [GUO length]];

    NSData *UZI = [[NSData alloc] initWithBase64EncodedString:UZIBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UZITexture = [self loadImageTexture : device : (void*)[UZI bytes] : [UZI length]];

    NSData *TANG = [[NSData alloc] initWithBase64EncodedString:TANGBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    TANGTexture = [self loadImageTexture : device : (void*)[TANG bytes] : [TANG length]];

    NSData *VKT = [[NSData alloc] initWithBase64EncodedString:VKTBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    VKTTexture = [self loadImageTexture : device : (void*)[VKT bytes] : [VKT length]];

    NSData *MP5K = [[NSData alloc] initWithBase64EncodedString:MP5KBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    MP5KTexture = [self loadImageTexture : device : (void*)[MP5K bytes] : [MP5K length]];

    NSData *UMP9 = [[NSData alloc] initWithBase64EncodedString:UMP9Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UMP9Texture = [self loadImageTexture : device : (void*)[UMP9 bytes] : [UMP9 length]];

    NSData *YN = [[NSData alloc] initWithBase64EncodedString:YNBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    YNTexture = [self loadImageTexture : device : (void*)[YN bytes] : [YN length]];
    
    NSData *M24 = [[NSData alloc] initWithBase64EncodedString:M24Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    M24Texture = [self loadImageTexture : device : (void*)[M24 bytes] : [M24 length]];

    NSData *DP28 = [[NSData alloc] initWithBase64EncodedString:DP28Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    DP28Texture = [self loadImageTexture : device : (void*)[DP28 bytes] : [DP28 length]];

    NSData *MG3 = [[NSData alloc] initWithBase64EncodedString:MG3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    MG3Texture = [self loadImageTexture : device : (void*)[MG3 bytes] : [MG3 length]];

    NSData *M249 = [[NSData alloc] initWithBase64EncodedString:M249Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    M249Texture = [self loadImageTexture : device : (void*)[M249 bytes] : [M249 length]];

    NSData *DBS = [[NSData alloc] initWithBase64EncodedString:DBSBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    DBSTexture = [self loadImageTexture : device : (void*)[DBS bytes] : [DBS length]];

    NSData *S686 = [[NSData alloc] initWithBase64EncodedString:S686Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    S686Texture = [self loadImageTexture : device : (void*)[S686 bytes] : [S686 length]];

    NSData *S12K = [[NSData alloc] initWithBase64EncodedString:S12KBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    S12KTexture = [self loadImageTexture : device : (void*)[S12K bytes] : [S12K length]];

    //载具
    NSData *JP = [[NSData alloc] initWithBase64EncodedString:JPBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    JPTexture = [self loadImageTexture : device : (void*)[JP bytes] : [JP length]];

    NSData *BB = [[NSData alloc] initWithBase64EncodedString:BBBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    BBTexture = [self loadImageTexture : device : (void*)[BB bytes] : [BB length]];

    NSData *jc = [[NSData alloc] initWithBase64EncodedString:jcBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    jcTexture = [self loadImageTexture : device : (void*)[jc bytes] : [jc length]];
    
    NSData *mtt = [[NSData alloc] initWithBase64EncodedString:mttBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    mttTexture = [self loadImageTexture : device : (void*)[mtt bytes] : [mtt length]];
    
    NSData *mt = [[NSData alloc] initWithBase64EncodedString:mtBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    mtTexture = [self loadImageTexture : device : (void*)[mt bytes] : [mt length]];
    
    NSData *my = [[NSData alloc] initWithBase64EncodedString:myBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    myTexture = [self loadImageTexture : device : (void*)[my bytes] : [my length]];
    
    NSData *R8 = [[NSData alloc] initWithBase64EncodedString:R8Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    R8Texture = [self loadImageTexture : device : (void*)[R8 bytes] : [R8 length]];
    
    NSData *mt3 = [[NSData alloc] initWithBase64EncodedString:mt3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    mt3Texture = [self loadImageTexture : device : (void*)[mt3 bytes] : [mt3 length]];
    
    NSData *m416 = [[NSData alloc] initWithBase64EncodedString:m416Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    m416Texture = [self loadImageTexture : device : (void*)[m416 bytes] : [m416 length]];

    NSData *akm = [[NSData alloc] initWithBase64EncodedString:akmBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    akmTexture = [self loadImageTexture : device : (void*)[akm bytes] : [akm length]];
    
    NSData *aug = [[NSData alloc] initWithBase64EncodedString:augBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    augTexture = [self loadImageTexture : device : (void*)[aug bytes] : [aug length]];
    
    NSData *groza = [[NSData alloc] initWithBase64EncodedString:grozaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    grozaTexture = [self loadImageTexture : device : (void*)[groza bytes] : [groza length]];
    
    NSData *m16 = [[NSData alloc] initWithBase64EncodedString:m16Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    m16Texture = [self loadImageTexture : device : (void*)[m16 bytes] : [m16 length]];
    
    NSData *m24 = [[NSData alloc] initWithBase64EncodedString:m24Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    m24Texture = [self loadImageTexture : device : (void*)[m24 bytes] : [m24 length]];
    
    NSData *m249 = [[NSData alloc] initWithBase64EncodedString:m249Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    m249Texture = [self loadImageTexture : device : (void*)[m249 bytes] : [m249 length]];
    
    NSData *m762 = [[NSData alloc] initWithBase64EncodedString:m762Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    m762Texture = [self loadImageTexture : device : (void*)[m762 bytes] : [m762 length]];
    
    NSData *mg3 = [[NSData alloc] initWithBase64EncodedString:mg3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    mg3Texture = [self loadImageTexture : device : (void*)[mg3 bytes] : [mg3 length]];
    
    NSData *mini = [[NSData alloc] initWithBase64EncodedString:miniBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    miniTexture = [self loadImageTexture : device : (void*)[mini bytes] : [mini length]];
    
    NSData *mk14 = [[NSData alloc] initWithBase64EncodedString:mk14Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    mk14Texture = [self loadImageTexture : device : (void*)[mk14 bytes] : [mk14 length]];
    
    NSData *mk47 = [[NSData alloc] initWithBase64EncodedString:mk47Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    mk47Texture = [self loadImageTexture : device : (void*)[mk47 bytes] : [mk47 length]];
    
    NSData *scar = [[NSData alloc] initWithBase64EncodedString:scarBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    scarTexture = [self loadImageTexture : device : (void*)[scar bytes] : [scar length]];
    
    NSData *slr = [[NSData alloc] initWithBase64EncodedString:slrBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    slrTexture = [self loadImageTexture : device : (void*)[slr bytes] : [slr length]];
    
    NSData *awm = [[NSData alloc] initWithBase64EncodedString:awmBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    awmTexture = [self loadImageTexture : device : (void*)[awm bytes] : [awm length]];
    
    NSData *dp28 = [[NSData alloc] initWithBase64EncodedString:dp28Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    dp28Texture = [self loadImageTexture : device : (void*)[dp28 bytes] : [dp28 length]];
    
    NSData *k98 = [[NSData alloc] initWithBase64EncodedString:k98Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    k98Texture = [self loadImageTexture : device : (void*)[k98 bytes] : [k98 length]];
    
    NSData *vss = [[NSData alloc] initWithBase64EncodedString:vssBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    vssTexture = [self loadImageTexture : device : (void*)[vss bytes] : [vss length]];
    
    NSData *sks = [[NSData alloc] initWithBase64EncodedString:sksBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    sksTexture = [self loadImageTexture : device : (void*)[sks bytes] : [sks length]];
    
    NSData *hz = [[NSData alloc] initWithBase64EncodedString:hzBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    hzTexture = [self loadImageTexture : device : (void*)[hz bytes] : [hz length]];
    
    
    NSData *yl = [[NSData alloc] initWithBase64EncodedString:ylBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    ylTexture = [self loadImageTexture : device : (void*)[yl bytes] : [yl length]];

    NSData *jjb = [[NSData alloc] initWithBase64EncodedString:jjbBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    jjbTexture = [self loadImageTexture : device : (void*)[jjb bytes] : [jjb length]];
    
    NSData *zty = [[NSData alloc] initWithBase64EncodedString:ztyBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    ztyTexture = [self loadImageTexture : device : (void*)[zty bytes] : [zty length]];
    
    NSData *zhen = [[NSData alloc] initWithBase64EncodedString:zhenBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    zhenTexture = [self loadImageTexture : device : (void*)[zhen bytes] : [zhen length]];
    
    NSData *ylx = [[NSData alloc] initWithBase64EncodedString:ylxBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    ylxTexture = [self loadImageTexture : device : (void*)[ylx bytes] : [ylx length]];
    
    NSData *b4 = [[NSData alloc] initWithBase64EncodedString:b4Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    b4Texture = [self loadImageTexture : device : (void*)[b4 bytes] : [b4 length]];

    NSData *b3 = [[NSData alloc] initWithBase64EncodedString:b3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    b3Texture = [self loadImageTexture : device : (void*)[b3 bytes] : [b3 length]];

    NSData *b6 = [[NSData alloc] initWithBase64EncodedString:b6Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    b6Texture = [self loadImageTexture : device : (void*)[b6 bytes] : [b6 length]];

    NSData *b8 = [[NSData alloc] initWithBase64EncodedString:b8Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    b8Texture = [self loadImageTexture : device : (void*)[b8 bytes] : [b8 length]];

    NSData *kt = [[NSData alloc] initWithBase64EncodedString:ktBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    ktTexture = [self loadImageTexture : device : (void*)[kt bytes] : [kt length]];

    NSData *t3 = [[NSData alloc] initWithBase64EncodedString:t3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    t3Texture = [self loadImageTexture : device : (void*)[t3 bytes] : [t3 length]];

    NSData *j3 = [[NSData alloc] initWithBase64EncodedString:j3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    j3Texture = [self loadImageTexture : device : (void*)[j3 bytes] : [j3 length]];

    NSData *bb3 = [[NSData alloc] initWithBase64EncodedString:bb3Base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    bb3Texture = [self loadImageTexture : device : (void*)[bb3 bytes] : [bb3 length]];

    NSData *tlei = [[NSData alloc] initWithBase64EncodedString:tleiBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    tleiTexture = [self loadImageTexture : device : (void*)[tlei bytes] : [tlei length]];

    NSData *tyan = [[NSData alloc] initWithBase64EncodedString:tyanBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    tyanTexture = [self loadImageTexture : device : (void*)[tyan bytes] : [tyan length]];

    NSData *thuo = [[NSData alloc] initWithBase64EncodedString:thuoBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    thuoTexture = [self loadImageTexture : device : (void*)[thuo bytes] : [thuo length]];

    NSData *leizha = [[NSData alloc] initWithBase64EncodedString:leizhaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    leizhaTexture = [self loadImageTexture : device : (void*)[leizha bytes] : [leizha length]];

    NSData *hongzha = [[NSData alloc] initWithBase64EncodedString:hongzhaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    hongzhaTexture = [self loadImageTexture : device : (void*)[hongzha bytes] : [hongzha length]];

    NSData *sld = [[NSData alloc] initWithBase64EncodedString:sldBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    sldTexture = [self loadImageTexture : device : (void*)[sld bytes] : [sld length]];

    NSData *ywd = [[NSData alloc] initWithBase64EncodedString:ywdBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    ywdTexture = [self loadImageTexture : device : (void*)[ywd bytes] : [ywd length]];

    NSData *rsp = [[NSData alloc] initWithBase64EncodedString:rspBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    rspTexture = [self loadImageTexture : device : (void*)[rsp bytes] : [rsp length]];


}

-(id<MTLTexture>)loadImageTexture:(id<MTLDevice>)device :(void*) imageData :(size_t) fileDataSize {
    int width, height;
    unsigned char *pixels = stbi_load_from_memory((stbi_uc const *)imageData, (int)fileDataSize, &width, &height, NULL, 4);

    MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
                                                                                                 width:(NSUInteger)width
                                                                                                height:(NSUInteger)height
                                                                                             mipmapped:NO];
    textureDescriptor.usage = MTLTextureUsageShaderRead;
    textureDescriptor.storageMode = MTLStorageModeShared;
    id<MTLTexture> texture = [device newTextureWithDescriptor:textureDescriptor];
    [texture replaceRegion:MTLRegionMake2D(0, 0, (NSUInteger)width, (NSUInteger)height) mipmapLevel:0 withBytes:pixels bytesPerRow:(NSUInteger)width * 4];
    
    return texture;
}


@end
