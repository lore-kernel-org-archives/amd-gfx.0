From: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove program of lbpw for renoir
Date: Mon, 16 Sep 2019 01:40:25 +0000
Message-ID: <1568598006-13573-1-git-send-email-aaron.liu@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

VGhlc2UgaXMgbm8gTEJQVyBvbiBSZW5vaXIuIFNvIHJlbW92aW5nIHByb2dyYW0gb2YgbGJwdyBm
b3IgcmVub2lyLgoKU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMiAtLQogMSBmaWxl
IGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8w
LmMKaW5kZXggYjc1ZWY4OS4uZmUyMWVmOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jCkBAIC0xNjQ2LDcgKzE2NDYsNiBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3JsY19pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUp
IHsKIAljYXNlIENISVBfUkFWRU46Ci0JY2FzZSBDSElQX1JFTk9JUjoKIAkJZ2Z4X3Y5XzBfaW5p
dF9sYnB3KGFkZXYpOwogCQlicmVhazsKIAljYXNlIENISVBfVkVHQTIwOgpAQCAtMzAxMyw3ICsz
MDEyLDYgQEAgc3RhdGljIGludCBnZnhfdjlfMF9ybGNfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENISVBfUkFW
RU46Ci0JY2FzZSBDSElQX1JFTk9JUjoKIAkJaWYgKGFtZGdwdV9sYnB3ID09IDApCiAJCQlnZnhf
djlfMF9lbmFibGVfbGJwdyhhZGV2LCBmYWxzZSk7CiAJCWVsc2UKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
