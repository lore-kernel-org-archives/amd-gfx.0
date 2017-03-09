From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 23/23] drm/amdgpu: get cs support of AMDGPU_HW_IP_UVD_ENC
Date: Thu,  9 Mar 2017 10:25:43 -0500
Message-ID: <1489073143-23428-24-git-send-email-alexander.deucher@amd.com>
References: <1489073143-23428-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489073143-23428-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8
bGVvLmxpdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMg
fCA5ICsrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKaW5kZXggMmJmYjJiZWMuLmIzOWYzMGYgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCkBAIC04Miw2ICs4MiwxNSBAQCBpbnQg
YW1kZ3B1X2NzX2dldF9yaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgaXBfdHlw
ZSwKIAkJCXJldHVybiAtRUlOVkFMOwogCQl9CiAJCWJyZWFrOworCWNhc2UgQU1ER1BVX0hXX0lQ
X1VWRF9FTkM6CisJCWlmIChyaW5nIDwgYWRldi0+dXZkLm51bV9lbmNfcmluZ3MpeworCQkJKm91
dF9yaW5nID0gJmFkZXYtPnV2ZC5yaW5nX2VuY1tyaW5nXTsKKwkJfSBlbHNlIHsKKwkJCURSTV9F
UlJPUigib25seSAlZCBVVkQgRU5DIHJpbmdzIGFyZSBzdXBwb3J0ZWRcbiIsCisJCQkJYWRldi0+
dXZkLm51bV9lbmNfcmluZ3MpOworCQkJcmV0dXJuIC1FSU5WQUw7CisJCX0KKwkJYnJlYWs7CiAJ
fQogCiAJaWYgKCEoKm91dF9yaW5nICYmICgqb3V0X3JpbmcpLT5hZGV2KSkgewotLSAKMi41LjUK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
