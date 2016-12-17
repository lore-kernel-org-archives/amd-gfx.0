From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/23] drm/amdgpu: add new flag for virtual function
Date: Sun, 18 Dec 2016 00:16:30 +0800
Message-ID: <1481991405-30422-9-git-send-email-Xiangliang.Yu@amd.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481991405-30422-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

QWRkIG5ldyBmbGFnIHRvIGlkZW50aWZ5IGNoaXBzIHRoYXQgaXMgc3VwcG9ydCB2aXJ0dWFsaXph
dGlvbi4KClNpZ25lZC1vZmYtYnk6IFhpYW5nbGlhbmcgWXUgPFhpYW5nbGlhbmcuWXVAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oIHwgMSArCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2FtZF9zaGFyZWQuaAppbmRleCBjMDI0NjlhLi45ZTU1NWM3IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKQEAgLTU5LDYgKzU5LDcgQEAgZW51bSBhbWRfY2hpcF9m
bGFncyB7CiAJQU1EX0lTX0FQVSAgICAgID0gMHgwMDAyMDAwMFVMLAogCUFNRF9JU19QWCAgICAg
ICA9IDB4MDAwNDAwMDBVTCwKIAlBTURfRVhQX0hXX1NVUFBPUlQgPSAweDAwMDgwMDAwVUwsCisJ
QU1EX0lTX1ZGCT0gMHgwMDEwMDAwMFVMLAogfTsKIAogZW51bSBhbWRfaXBfYmxvY2tfdHlwZSB7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
