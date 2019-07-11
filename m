From: Tianci Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/discovery: fix DCE_HWIP mapping error in hw_id_map
 array
Date: Thu, 11 Jul 2019 16:00:50 +0800
Message-ID: <1562832050-28203-1-git-send-email-tianci.yin@amd.com>
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
Cc: Jack Xiao <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>, Tianci Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogdGlhbmN5aW4gPHRpYW5jaS55aW5AYW1kLmNvbT4KCklEIG9mIERDRV9IV0lQIGZyb20g
dmJpb3MgaXMgRE1VX0hXSUQsCm1pc21hdGNoIGNhdXNlIG51bGwgcG9pbnRlciBjcmFzaCBpbiBu
YXZpMTAgbW9kcHJvYmUuCgpDaGFuZ2UtSWQ6IEkzYmUzNjNjZjUyNDhkZTkwNGIzYmRhZTJmMzRk
M2JiZTBiYmJjMDdkClNpZ25lZC1vZmYtYnk6IHRpYW5jeWluIDx0aWFuY2kueWluQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jCmluZGV4IGUwNDlhZTYu
LjE0ODE4OTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNjb3ZlcnkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292
ZXJ5LmMKQEAgLTEyMyw3ICsxMjMsNyBAQCBzdGF0aWMgaW50IGh3X2lkX21hcFtNQVhfSFdJUF0g
PSB7CiAJW1VWRF9IV0lQXQk9IFVWRF9IV0lELAogCVtWQ0VfSFdJUF0JPSBWQ0VfSFdJRCwKIAlb
REZfSFdJUF0JPSBERl9IV0lELAotCVtEQ0VfSFdJUF0JPSBEQ0VBWl9IV0lELAorCVtEQ0VfSFdJ
UF0JPSBETVVfSFdJRCwKIAlbT1NTU1lTX0hXSVBdCT0gT1NTU1lTX0hXSUQsCiAJW1NNVUlPX0hX
SVBdCT0gU01VSU9fSFdJRCwKIAlbUFdSX0hXSVBdCT0gUFdSX0hXSUQsCi0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
