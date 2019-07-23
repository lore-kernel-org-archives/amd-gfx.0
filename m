From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: no pptable transfer and dpms enabled
 with "dpm=0"
Date: Tue, 23 Jul 2019 16:41:11 +0800
Message-ID: <20190723084112.11439-1-evan.quan@amd.com>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

SG9ub3IgdGhlICdkcG0nIG1vZHVsZSBwYXJhbWV0ZXIgc2V0dGluZyBvbiBTVyBTTVUgcm91dGlu
ZSBhcyB3aGF0CndlIGRpZCBvbiBwcmV2aW91cyBBU0lDcy4gU01VIEZXIGxvYWRpbmcgaXMgc3Rp
bGwgcHJvY2VlZGVkIGV2ZW4Kd2l0aCAiZHBtPTAiLgoKQ2hhbmdlLUlkOiBJNGUyYmQ0MzQwMzVj
MzE1MzkxZDBjMGNiYWJiNmFjOGM2ZjIzZjIzOQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2
YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdw
dV9zbXUuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IDY5MzVhMDBjZDM4OS4u
MjY2NjE0ZTI3MzkyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jCkBAIC0xMDM3LDYgKzEwMzcsOSBAQCBzdGF0aWMgaW50IHNtdV9od19pbml0KHZvaWQgKmhh
bmRsZSkKIAkJfQogCX0KIAorCWlmICghc211LT5wbV9lbmFibGVkKQorCQlyZXR1cm4gMDsKKwog
CXJldCA9IHNtdV9mZWF0dXJlX2luaXRfZHBtKHNtdSk7CiAJaWYgKHJldCkKIAkJZ290byBmYWls
ZWQ7Ci0tIAoyLjIyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
