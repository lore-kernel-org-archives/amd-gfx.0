From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 25/26] drm/amd/powerplay: fix the issue of checking on message
 mapping
Date: Mon, 25 Feb 2019 20:12:31 +0800
Message-ID: <1551096752-18205-26-git-send-email-ray.huang@amd.com>
References: <1551096752-18205-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1551096752-18205-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

VGhlIHZlZ2EyMF9tZXNzYWdlX21hcFtpbmRleF0gc2NvcGUgc2hvdWxkIGJlIGluIFBQU01DX01l
c3NhZ2VfQ291bnQgbm90IGluClNNVV9NU0dfTUFYX0NPVU5ULgoKU2lnbmVkLW9mZi1ieTogSHVh
bmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS92ZWdhMjBfcHB0LmMgfCA5ICsrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS92ZWdhMjBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92
ZWdhMjBfcHB0LmMKaW5kZXggOGVhNDRiNy4uZjcxODhhNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvdmVnYTIwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L3ZlZ2EyMF9wcHQuYwpAQCAtMTMxLDEwICsxMzEsMTUgQEAgc3RhdGljIGlu
dCB2ZWdhMjBfbWVzc2FnZV9tYXBbU01VX01TR19NQVhfQ09VTlRdID0gewogCiBzdGF0aWMgaW50
IHZlZ2EyMF9nZXRfc211X21zZ19pbmRleChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtYywgdWludDMy
X3QgaW5kZXgpCiB7Ci0JaWYgKGluZGV4ID4gU01VX01TR19NQVhfQ09VTlQgfHwgaW5kZXggPiBQ
UFNNQ19NZXNzYWdlX0NvdW50KQorCWludCB2YWw7CisJaWYgKGluZGV4ID4gU01VX01TR19NQVhf
Q09VTlQpCiAJCXJldHVybiAtRUlOVkFMOwotCXJldHVybiB2ZWdhMjBfbWVzc2FnZV9tYXBbaW5k
ZXhdOwogCisJdmFsID0gdmVnYTIwX21lc3NhZ2VfbWFwW2luZGV4XTsKKwlpZiAodmFsID4gUFBT
TUNfTWVzc2FnZV9Db3VudCkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlyZXR1cm4gdmFsOwogfQog
CiBzdGF0aWMgaW50IHZlZ2EyMF9hbGxvY2F0ZV9kcG1fY29udGV4dChzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
