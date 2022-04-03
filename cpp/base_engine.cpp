

#include "base_engine.h"

bool msg_closed = false;
ID3D11Device* g_pd3dDevice = NULL;
ID3D11DeviceContext* g_pd3dDeviceContext = NULL;
IDXGISwapChain* g_pSwapChain = NULL;
ID3D11RenderTargetView* g_mainRenderTargetView = NULL;
HWND main_hwnd = NULL;
WNDCLASSEX main_hwnd_wc;
// Helper functions


