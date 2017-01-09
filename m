From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/4] drm/amd/powerplay: add new smu message.
Date: Mon, 9 Jan 2017 14:51:38 +0800
Message-ID: <1483944700-3842-2-git-send-email-Rex.Zhu@amd.com>
References: <1483944700-3842-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483944700-3842-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTdmMDI1NTVmYmM3OWE5ZTVhMmU5ZDMxNjBmZGRiYzZjNTAyZWFmNApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaW5jL3NtdTdfcHBzbWMuaCB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaW5jL3NtdTdfcHBzbWMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9z
bXU3X3Bwc21jLmgKaW5kZXggYmNlMDAwOS4uZmJjNTA0YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTdfcHBzbWMuaAorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvc211N19wcHNtYy5oCkBAIC0zOTQsNiArMzk0LDkgQEAgdHlw
ZWRlZiB1aW50MTZfdCBQUFNNQ19SZXN1bHQ7CiAKICNkZWZpbmUgUFBTTUNfTVNHX1NldFZCSVRp
bWVvdXQgICAgICAgICAgICAgICAoKHVpbnQxNl90KSAweDMwNikKIAorI2RlZmluZSBQUFNNQ19N
U0dfRW5hYmxlRHBtRGlkdCAgICAgICAgICAgICAgICgodWludDE2X3QpIDB4MzA5KQorI2RlZmlu
ZSBQUFNNQ19NU0dfRGlzYWJsZURwbURpZHQgICAgICAgICAgICAgICgodWludDE2X3QpIDB4MzBB
KQorCiAjZGVmaW5lIFBQU01DX01TR19TZWN1cmVTUkJNV3JpdGUgICAgICAgICAgICAgKCh1aW50
MTZfdCkgMHg2MDApCiAjZGVmaW5lIFBQU01DX01TR19TZWN1cmVTUkJNUmVhZCAgICAgICAgICAg
ICAgKCh1aW50MTZfdCkgMHg2MDEpCiAjZGVmaW5lIFBQU01DX01TR19TZXRBZGRyZXNzICAgICAg
ICAgICAgICAgICAgKCh1aW50MTZfdCkgMHg4MDApCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
