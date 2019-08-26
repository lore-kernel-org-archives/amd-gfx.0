From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/4] drm/amdgpu: Extends amdgpu vm definitions (v2)
Date: Mon, 26 Aug 2019 23:07:11 +0000
Message-ID: <20190826230355.25007-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

RnJvbTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+CgpBZGQgUlcgbXR5cGUgaW50cm9kdWNl
ZCBmb3IgYXJjdHVydXMuCgp2MjoKKiBEb24ndCBhZGQgcHJvYmUtaW52YWxpZGF0aW9uIGJpdCBm
cm9tIFVBUEkKKiBEb24ndCBhZGQgdW51c2VkIEFNREdQVV9NVFlQRV8gZGVmaW5pdGlvbnMKClNp
Z25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBG
ZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KLS0tCiBpbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvdWFw
aS9kcm0vYW1kZ3B1X2RybS5oCmluZGV4IGNhOTdiNjgwMjI3NS4uZjNhZDQyOTE3M2UzIDEwMDY0
NAotLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaApAQCAtNTAzLDYgKzUwMyw4IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2dl
bV9vcCB7CiAjZGVmaW5lIEFNREdQVV9WTV9NVFlQRV9DQwkJKDMgPDwgNSkKIC8qIFVzZSBVQyBN
VFlQRSBpbnN0ZWFkIG9mIGRlZmF1bHQgTVRZUEUgKi8KICNkZWZpbmUgQU1ER1BVX1ZNX01UWVBF
X1VDCQkoNCA8PCA1KQorLyogVXNlIFJXIE1UWVBFIGluc3RlYWQgb2YgZGVmYXVsdCBNVFlQRSAq
LworI2RlZmluZSBBTURHUFVfVk1fTVRZUEVfUlcJCSg1IDw8IDUpCiAKIHN0cnVjdCBkcm1fYW1k
Z3B1X2dlbV92YSB7CiAJLyoqIEdFTSBvYmplY3QgaGFuZGxlICovCi0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
