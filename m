From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] Revert "drm/amd/pp: Add a pp feature mask bit for AutoWattman
 feature"
Date: Mon, 5 Mar 2018 14:46:19 +0800
Message-ID: <1520232379-11024-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

VGhpcyByZXZlcnRzIGNvbW1pdCBlNDI5ZWE4N2IyOTM5YzRjY2UxYjQzOWJhZjZkNzY1MzVhMDc2
N2YyLgoKSW1wbGVtZW50IFdvcmtsb2FkIEF3YXJlIER5bmFtaWMgcG93ZXIgbWFuYWdlbWVudCBp
bnN0YW5kIG9mCkF1dG9XYXR0bWFuIGZlYXR1cmUgaW4gbGludXguCgpDaGFuZ2UtSWQ6IEk2MTli
YTU2OTViMTRlMWQxNjU4MjljOThkMjc3NmU1MTczZjI3MzdlClNpZ25lZC1vZmYtYnk6IFJleCBa
aHUgPFJleC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9p
bmMvaHdtZ3IuaCB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9od21nci5oCmluZGV4IDk0ZGY2ZWUuLmIxNTFhZDg1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaApAQCAtODUsNyAr
ODUsNiBAQCBlbnVtIFBQX0ZFQVRVUkVfTUFTSyB7CiAJUFBfU09DQ0xLX0RQTV9NQVNLID0gMHgx
MDAwLAogCVBQX0RDRUZDTEtfRFBNX01BU0sgPSAweDIwMDAsCiAJUFBfT1ZFUkRSSVZFX01BU0sg
PSAweDQwMDAsCi0JUFBfQVVUT1dBVFRNQU5fTUFTSyA9IDB4ODAwMCwKIH07CiAKIGVudW0gUEhN
X0JhY2tFbmRfTWFnaWMgewotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
