From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [V2 6/6] drm/amd/powerplay: Fix potential NULL pointer issue
Date: Fri, 2 Dec 2016 14:03:48 +0800
Message-ID: <1480658628-24446-7-git-send-email-Xiangliang.Yu@amd.com>
References: <1480658628-24446-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1480658628-24446-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

SWYgZG9lc24ndCBlbmFibGUgZHBtLCB0aGUgcG93ZXJwbGF5IHdpbGwgbm90IGFsbG9jYXRlIG1l
bW9yeSBmb3IKaHcgbWFuYWdlbWVudC4gU28sIGh3X2luaXRfcG93ZXJfc3RhdGVfdGFibGUgZnVu
Y3Rpb24gd2lsbCByZWZlcmVuY2UKTlVMTCBwb2ludGVyIHdoZW4gcmVzZXR0aW5nLgoKU2lnbmVk
LW9mZi1ieTogWGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYyB8IDQgKystLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKaW5kZXggNTFhMzYwNy4uYzgxY2Yx
NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxh
eS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwpA
QCAtMTAwNCwxMiArMTAwNCwxMiBAQCBpbnQgYW1kX3Bvd2VycGxheV9yZXNldCh2b2lkICpoYW5k
bGUpCiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAotCWh3X2luaXRfcG93ZXJfc3RhdGVfdGFi
bGUoaW5zdGFuY2UtPmh3bWdyKTsKLQogCWlmICgoYW1kZ3B1X2RwbSA9PSAwKQogCQl8fCBjZ3Nf
aXNfdmlydHVhbGl6YXRpb25fZW5hYmxlZChpbnN0YW5jZS0+c211X21nci0+ZGV2aWNlKSkKIAkJ
cmV0dXJuIDA7CiAKKwlod19pbml0X3Bvd2VyX3N0YXRlX3RhYmxlKGluc3RhbmNlLT5od21ncik7
CisKIAlpZiAoZXZlbnRtZ3IgPT0gTlVMTCB8fCBldmVudG1nci0+cHBfZXZlbnRtZ3JfaW5pdCA9
PSBOVUxMKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
