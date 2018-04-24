From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from
 ring hang.
Date: Tue, 24 Apr 2018 11:30:36 -0400
Message-ID: <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1524583836-12130-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David.Panariti-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

SWYgdGhlIHJpbmcgaXMgaGFuZ2luZyBmb3Igc29tZSByZWFzb24gYWxsb3cgdG8gcmVjb3ZlciB0
aGUgd2FpdGluZwpieSBzZW5kaW5nIGZhdGFsIHNpZ25hbC4KCk9yaWdpbmFsbHktYnk6IERhdmlk
IFBhbmFyaXRpIDxEYXZpZC5QYW5hcml0aUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
R3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCAxNCArKysrKysrKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4IGViODBlZGYuLjM3YTM2YWYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKQEAgLTQyMSwxMCArNDIxLDE2IEBAIGludCBh
bWRncHVfY3R4X3dhaXRfcHJldl9mZW5jZShzdHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4LCB1bnNpZ25l
ZCByaW5nX2lkKQogCiAJaWYgKG90aGVyKSB7CiAJCXNpZ25lZCBsb25nIHI7Ci0JCXIgPSBkbWFf
ZmVuY2Vfd2FpdF90aW1lb3V0KG90aGVyLCBmYWxzZSwgTUFYX1NDSEVEVUxFX1RJTUVPVVQpOwot
CQlpZiAociA8IDApIHsKLQkJCURSTV9FUlJPUigiRXJyb3IgKCVsZCkgd2FpdGluZyBmb3IgZmVu
Y2UhXG4iLCByKTsKLQkJCXJldHVybiByOworCisJCXdoaWxlICh0cnVlKSB7CisJCQlpZiAoKHIg
PSBkbWFfZmVuY2Vfd2FpdF90aW1lb3V0KG90aGVyLCB0cnVlLAorCQkJCQlNQVhfU0NIRURVTEVf
VElNRU9VVCkpID49IDApCisJCQkJcmV0dXJuIDA7CisKKwkJCWlmIChmYXRhbF9zaWduYWxfcGVu
ZGluZyhjdXJyZW50KSkgeworCQkJCURSTV9FUlJPUigiRXJyb3IgKCVsZCkgd2FpdGluZyBmb3Ig
ZmVuY2UhXG4iLCByKTsKKwkJCQlyZXR1cm4gcjsKKwkJCX0KIAkJfQogCX0KIAotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
