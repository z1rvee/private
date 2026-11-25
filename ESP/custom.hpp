#pragma once

#define  IMGUI_DEFINE_MATH_OPERATORS
#include "ESP/imgui/imgui.h"
#include "ESP/imgui/imgui_internal.h"

#include <string>
#include <vector>
#include <functional>

using namespace std;

#define to_vec4( r, g, b, a ) ImColor( r / 255.f, g / 255.f, b / 255.f, a )

class c_custom {

public:
    bool safemode = true;
    float m_anim = 0.f;

    float menu_anim = 0.f;
    float menu_alpha = 0.f;

    int m_tab = 0;
    vector <const char*> tabs = {("Rage"), ("Visuals"), ("Skins"), ("Profile")}, tabs_icons = {("B"), ("D"), ("F"), ("H")};

    int t_aimbot = 0;
    vector < const char* > aimbot = {("Aimbot"), ("Silent aim"), ("Rage")};

    int t_visuals = 0;
    vector < const char* > visuals =  {("ESP"), ("Items")};

    int t_skins = 0;
    vector < const char* > skins = {("Skins"), ("Weapons"), ("Vehicle")};

    int t_profile = 0;
    vector < const char* > profile = {("Main")};

    float col_buf[4] = { 1.f, 1.f, 1.f, 1.f };

    void render_arrows_for_horizontal_bar( ImVec2 pos, float alpha, float width, float height );

    bool expand_button( const char* label, bool selected, float rounding = 0.f, ImDrawFlags flags = NULL );
    bool tab( const char* icon, const char* label, bool selected );
    bool sub_tab( const char* label, bool selected );

    void tab_area( const char* str_id, ImVec2 size, std::function < void ( ) > content );

    void begin_child( const char* name, ImVec2 size );
    void end_child( );

    int accent_color[4] = { 130, 141, 255, 255 };
    ImColor get_accent_color( float a = 1.f ) {

        return to_vec4( accent_color[0], accent_color[1], accent_color[2], a );
    }

};

inline c_custom custom;
