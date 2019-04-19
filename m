From: likun Gao <likun.gao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: enable MGCG for PCO
Date: Fri, 19 Apr 2019 15:20:57 +0800
Message-ID: <1555658457-14475-1-git-send-email-likun.gao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, Hang Zhou <Hang.Zhou-5C7GfCeVMHo@public.gmane.org>, Huang Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KCkVuYWJsZSBNR0NHIGZvciBwaWNh
c3NvLgoKU2lnbmVkLW9mZi1ieTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYwppbmRleCBhMTM2NjMyLi40OTAwZTQ5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMKQEAgLTkwMSw3ICs5MDEsOCBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9lYXJseV9pbml0
KHZvaWQgKmhhbmRsZSkKIAogCQkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9SVF9TRE1B
IHwgQU1EX1BHX1NVUFBPUlRfVkNOOwogCQl9IGVsc2UgaWYgKGFkZXYtPnBkZXYtPmRldmljZSA9
PSAweDE1ZDgpIHsKLQkJCWFkZXYtPmNnX2ZsYWdzID0gQU1EX0NHX1NVUFBPUlRfR0ZYX01HTFMg
fAorCQkJYWRldi0+Y2dfZmxhZ3MgPSBBTURfQ0dfU1VQUE9SVF9HRlhfTUdDRyB8CisJCQkJQU1E
X0NHX1NVUFBPUlRfR0ZYX01HTFMgfAogCQkJCUFNRF9DR19TVVBQT1JUX0dGWF9DUF9MUyB8CiAJ
CQkJQU1EX0NHX1NVUFBPUlRfR0ZYXzNEX0NHQ0cgfAogCQkJCUFNRF9DR19TVVBQT1JUX0dGWF8z
RF9DR0xTIHwKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
