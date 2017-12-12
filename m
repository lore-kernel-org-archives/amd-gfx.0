From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 7/7] drm/amdgpu:correct vce fw data and stack size config
Date: Tue, 12 Dec 2017 17:46:45 +0800
Message-ID: <1513072005-3477-7-git-send-email-Monk.Liu@amd.com>
References: <1513072005-3477-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513072005-3477-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4KCkNoYW5nZS1JZDogSWMxYmM0OWMy
MWQzYTkwYzQ3N2QxMTE2MmY5ZDZkOWUyMDczZmJiZDMKU2lnbmVkLW9mZi1ieTogRnJhbmsgTWlu
IDxGcmFuay5NaW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2Vf
djRfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3Y0XzAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMKaW5kZXggNTVmMDE4Ni4uZTk4
ZjU0OCAxMDA3NTUKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3Y0XzAuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jCkBAIC00MjMsNyArNDIz
LDcgQEAgc3RhdGljIGludCB2Y2VfdjRfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAlpZiAocikK
IAkJcmV0dXJuIHI7CiAKLQlzaXplICA9IChWQ0VfVjRfMF9TVEFDS19TSVpFICsgVkNFX1Y0XzBf
REFUQV9TSVpFKSAqIDI7CisJc2l6ZSAgPSBWQ0VfVjRfMF9TVEFDS19TSVpFICsgVkNFX1Y0XzBf
REFUQV9TSVpFOwogCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgIT0gQU1ER1BVX0ZXX0xP
QURfUFNQKQogCQlzaXplICs9IFZDRV9WNF8wX0ZXX1NJWkU7CiAKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
