

#ifndef  BASE_ENGINE_H
#define  BASE_ENGINE_H
#pragma-once
//#include "pch.h"

// Data
extern bool msg_closed;
extern HWND main_hwnd;
extern WNDCLASSEX main_hwnd_wc;
extern ID3D11Device* g_pd3dDevice;
extern ID3D11DeviceContext* g_pd3dDeviceContext;
extern IDXGISwapChain* g_pSwapChain;
extern ID3D11RenderTargetView* g_mainRenderTargetView;

// Forward declarations of helper functions
bool CreateDeviceD3D(HWND hWnd);
void CleanupDeviceD3D();
void CreateRenderTarget();
void CleanupRenderTarget();
LRESULT WINAPI WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);


#endif // ! BASE_ENGINE_H
