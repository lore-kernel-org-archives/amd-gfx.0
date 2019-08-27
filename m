From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amd/powerplay: enable jpeg powergating for navi1x
Date: Tue, 27 Aug 2019 07:20:15 +0000
Message-ID: <20190827071941.23862-3-xiaojie.yuan@amd.com>
References: <20190827071941.23862-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190827071941.23862-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

anBlZyBwZyBkZXBlbmRzIG9uIHZjbiBwZwoKU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4
aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9u
YXZpMTBfcHB0LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25h
dmkxMF9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwpp
bmRleCAyZDkwOGFmYmY1MjUuLjE5NzA4NDNmMjI1ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L25hdmkxMF9wcHQuYwpAQCAtMzY4LDcgKzM2OCw4IEBAIG5hdmkxMF9nZXRfYWxs
b3dlZF9mZWF0dXJlX21hc2soc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJCSoodWludDY0X3Qg
KilmZWF0dXJlX21hc2sgfD0gRkVBVFVSRV9NQVNLKEZFQVRVUkVfQVRIVUJfUEdfQklUKTsKIAog
CWlmIChzbXUtPmFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOKQotCQkqKHVpbnQ2
NF90ICopZmVhdHVyZV9tYXNrIHw9IEZFQVRVUkVfTUFTSyhGRUFUVVJFX1ZDTl9QR19CSVQpOwor
CQkqKHVpbnQ2NF90ICopZmVhdHVyZV9tYXNrIHw9IEZFQVRVUkVfTUFTSyhGRUFUVVJFX1ZDTl9Q
R19CSVQpCisJCQkJfCBGRUFUVVJFX01BU0soRkVBVFVSRV9KUEVHX1BHX0JJVCk7CiAKIAkvKiBk
aXNhYmxlIERQTSBVQ0xLIGFuZCBEUyBTT0NDTEsgb24gbmF2aTEwIEEwIHNlY3VyZSBib2FyZCAq
LwogCWlmIChpc19hc2ljX3NlY3VyZShzbXUpKSB7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
