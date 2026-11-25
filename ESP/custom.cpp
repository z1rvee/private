#include "ESP/custom.hpp"
#include <unordered_map>
using namespace ImGui;
extern ImFont* main_font;
extern ImFont* main_font1;
void c_custom::render_arrows_for_horizontal_bar( ImVec2 pos, float alpha, float width, float height ) {

    auto draw = GetWindowDrawList();
    draw->AddRect( pos, pos + ImVec2( width, height ), ImColor( 0.f, 0.f, 0.f, alpha * GetStyle( ).Alpha ), 4 );
}

bool c_custom::expand_button( const char* label, bool selected, float rounding, ImDrawFlags flags ) {

    ImGuiWindow* window = GetCurrentWindow( );
    ImGuiID id = window->GetID( label );

    ImVec2 label_size = CalcTextSize( label, 0, 1 );
    ImVec2 icon_size = GetIO( ).Fonts->Fonts[1]->CalcTextSizeA( GetIO( ).Fonts->Fonts[1]->FontSize - 2, FLT_MAX, 0, "A" );
    ImVec2 pos = window->DC.CursorPos;

    auto draw = window->DrawList;

    ImRect rect( pos, pos + ImVec2( GetWindowWidth( ), 45 ) );
    ItemAdd( rect, id );
    ItemSize( rect, GetStyle( ).FramePadding.y );

    bool hovered, held;
    bool pressed = ButtonBehavior( rect, id, &hovered, &held, NULL );

    static std::unordered_map < ImGuiID, float > values;
    auto value = values.find( id );
    if ( value == values.end( ) ) {

        values.insert( { id, 0.f } );
        value = values.find( id );
    }

    value->second = ImLerp( value->second, ( selected ? 1.f : 0.f ), 0.035f );

    draw->AddRectFilled( rect.Min, rect.Max, ImColor( 1.f, 1.f, 1.f, 0.025f * value->second ), rounding, flags );
    draw->AddText( GetIO( ).Fonts->Fonts[1], GetIO( ).Fonts->Fonts[1]->FontSize - 2, ImVec2( rect.Min.x + 50 / 2 - icon_size.x / 2, rect.GetCenter( ).y - icon_size.y / 2 ), GetColorU32( ImGuiCol_Text, ( value->second > 0.3f ? value->second : 0.3f ) ), "A" );
    draw->AddText( ImVec2( rect.Min.x + 50, rect.GetCenter( ).y - label_size.y / 2 ), GetColorU32( ImGuiCol_Text, ( value->second > 0.3f ? value->second : 0.3f ) ), label );

    return pressed;
}

bool c_custom::tab( const char* icon, const char* label, bool selected ) {

    ImGuiWindow* window = GetCurrentWindow( );
    ImGuiID id = window->GetID( label );
    ImGuiStyle& style = ImGui::GetStyle();

    ImVec2 label_size = GetIO( ).Fonts->Fonts[0]->CalcTextSizeA( GetIO( ).Fonts->Fonts[0]->FontSize, FLT_MAX, 0, label );
    ImVec2 icon_size = GetIO( ).Fonts->Fonts[1]->CalcTextSizeA( GetIO( ).Fonts->Fonts[1]->FontSize, FLT_MAX, 0, icon );
    ImVec2 pos = window->DC.CursorPos;

    auto draw = window->DrawList;

    ImRect rect( pos, pos + ImVec2( GetWindowWidth( ), 40 ) );
    ItemAdd( rect, id );
    ItemSize(ImVec4(rect.Min.x, rect.Min.y, rect.Max.x, rect.Max.y + 10), GetStyle().FramePadding.y);

    bool hovered, held;
    bool pressed = ButtonBehavior( rect, id, &hovered, &held, NULL );

    static std::unordered_map < ImGuiID, float > values;
    auto value = values.find( id );
    if ( value == values.end( ) ) {

        values.insert( { id, 0.f } );
        value = values.find( id );
    }

    value->second = ImLerp( value->second, ( selected || hovered ? 1.f : 0.f ), 0.035f );

    draw->AddRectFilled(ImVec2(rect.Min.x + 5, rect.Min.y - 10), ImVec2(rect.Max.x - 5, rect.Max.y - 5), ImColor(51 / 255.f, 51 / 255.f, 51 / 255.f, value->second * 0.5f * style.Alpha), 6 );
    draw->AddText(GetIO().Fonts->Fonts[2], GetIO().Fonts->Fonts[2]->FontSize, 
    ImVec2(rect.Min.x + 70 - 70 * value->second / 2 - icon_size.x / 2, rect.GetCenter().y - 8 - icon_size.y / 2), ImColor(130 / 255.0f, 141 / 255.0f, 255 / 255.0f, (value->second > 0.3f ? value->second : 0.3f) * style.Alpha), icon);
    
    draw->AddText(GetIO().Fonts->Fonts[0], GetIO().Fonts->Fonts[0]->FontSize * value->second, 
    ImVec2(rect.Min.x + 150 / 2 - label_size.x / 2 * value->second, rect.GetCenter().y - 8 - label_size.y / 2 * value->second), ImColor(130 / 255.0f, 141 / 255.0f, 255 / 255.0f, (value->second > 0.1f ? value->second : 0.0f) * style.Alpha), label);

    draw->AddLine(ImVec2(rect.GetCenter().x - 55 * value->second, rect.GetCenter().y + 12 * value->second), 
    ImVec2(rect.GetCenter().x + 55 * value->second, rect.GetCenter().y + 12 * value->second), custom.get_accent_color(value->second * GetStyle().Alpha), 2);
    return pressed;
}

bool c_custom::sub_tab(const char* label, bool selected) {
    ImGuiWindow* window = GetCurrentWindow();
    ImGuiID id = window->GetID(label);

    ImVec2 label_size = CalcTextSize(label, 0, 1);
    ImVec2 pos = window->DC.CursorPos;

    auto draw = window->DrawList;

    ImRect rect(pos, pos + label_size);
    ItemAdd(rect, id);
    ItemSize(ImVec4(rect.Min.x, rect.Min.y, rect.Max.x + 15, rect.Max.y), GetStyle().FramePadding.y);

    bool hovered, held;
    bool pressed = ButtonBehavior(rect, id, &hovered, &held, NULL);

    static std::unordered_map < ImGuiID, float > values;
    auto value = values.find(id);
    if (value == values.end()) {
        values.insert({ id, 0.f });
        value = values.find(id);
    }

    value->second = ImLerp(value->second, (selected ? 1.f : 0.f), 0.035f);

    draw->AddText({ rect.Min.x, (rect.Min.y + 2) - 2 * value->second }, GetColorU32(ImGuiCol_Text, (value->second > 0.3f ? value->second : 0.3f)), label);
    draw->AddLine(ImVec2(rect.GetCenter().x - 20 * value->second, rect.Max.y + 5 * value->second), ImVec2(rect.GetCenter().x + 20 * value->second, rect.Max.y + 5 * value->second), custom.get_accent_color(value->second * GetStyle().Alpha), 2);
    return pressed;
}


struct tab_area_structure {

    bool hovered, should_expand;
    float width;
};

void c_custom::tab_area( const char* str_id, ImVec2 size, std::function < void ( ) > content ) {
    ImGuiStyle& style = ImGui::GetStyle();

    static std::unordered_map < std::string, tab_area_structure > values;
    auto value = values.find( std::string( str_id ) );
    if ( value == values.end( ) ) {

        values.insert( { std::string( str_id ), { false, false, size.x } } );
        value = values.find( std::string( str_id ) );
    }

    value->second.width = ImLerp( value->second.width, ( value->second.should_expand && value->second.hovered ) ? size.x + 60 : size.x, 1.f);

    if ( ( value->second.should_expand && value->second.hovered ) )
        GetForegroundDrawList( )->AddRectFilled( GetWindowPos( ) + ImVec2( value->second.width, 0 ), GetWindowPos( ) + GetWindowSize( ), ImColor( 0.f, 0.f, 0.f, 0.2f ), GetStyle( ).WindowRounding );

    PushStyleVar( ImGuiStyleVar_ItemSpacing, ImVec2( 0, 0 ) );

    BeginChild( std::string( str_id ).append( ".child" ).c_str( ), ImVec2( value->second.width, size.y ) );

    value->second.hovered = IsMouseHoveringRect( GetCurrentWindow( )->Pos, GetCurrentWindow( )->Pos + ImVec2( value->second.width, size.y ) ); // could use IsWindowHovered( ); , but it bugs

    GetWindowDrawList( )->AddRectFilled( GetCurrentWindow( )->Pos, GetCurrentWindow( )->Pos + GetCurrentWindow( )->Size, ImColor( 28 / 255.f, 30 / 255.f, 36 / 255.f, 255 / 255.f * style.Alpha), 8 );

    content( );

    EndChild( );

    PopStyleVar();

}

void c_custom::begin_child( const char* name, ImVec2 size ) {

    ImGuiContext& g = *GImGui;
    ImGuiWindow* window = GetCurrentWindow( );
    ImGuiStyle& style = ImGui::GetStyle();

    ImVec2 pos = window->DC.CursorPos;

    BeginChild( std::string( name ).append( ".main" ).c_str( ), size, false, ImGuiWindowFlags_AlwaysAutoResize);

    GetWindowDrawList( )->AddRectFilled( pos, pos + size, ImColor(28 / 255.f, 30 / 255.f, 36 / 255.f, 255 / 255.f * style.Alpha), 4);
    GetWindowDrawList( )->AddText(GetIO().Fonts->Fonts[0], GetIO().Fonts->Fonts[0]->FontSize, pos + ImVec2( 10, 8 ), ImColor(180 / 255.f, 180 / 255.f, 180 / 255.f, 255 / 255.f * style.Alpha), name, FindRenderedTextEnd(name));

    SetCursorPosY( 30 );
    BeginChild( name, { size.x, size.y - 30 } );
    SetCursorPosX( 10 );

    BeginGroup( );

    PushStyleVar( ImGuiStyleVar_ItemSpacing, { 8, 8 } );
    ImGui::PushFont(main_font);
}

void c_custom::end_child( ) {

    ImGui::PopFont();
    PopStyleVar();
    EndGroup( );
    EndChild( );
    EndChild( );
}
