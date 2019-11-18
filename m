From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/5] drm/amdgpu: enable TMZ bit in FRAME_CONTROL for gfx10
Date: Mon, 18 Nov 2019 13:18:36 +0800
Message-ID: <1574054316-2802-5-git-send-email-aaron.liu@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574054316-2802-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Luben.Tuikov-5C7GfCeVMHo@public.gmane.org, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBlbmFibGVzIFRNWiBiaXQgaW4gRlJBTUVfQ09OVFJPTCBmb3IgZ2Z4MTAuCgpT
aWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwppbmRleCBkNmUxMWVlLi44ZGNlMDY3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYwpAQCAtNDU4OCw3ICs0NTg4LDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8w
X3JpbmdfZW1pdF9jbnR4Y250bChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCiAJCWdmeF92MTBf
MF9yaW5nX2VtaXRfY2VfbWV0YShyaW5nLAogCQkJCSAgICBmbGFncyAmIEFNREdQVV9JQl9QUkVF
TVBURUQgPyB0cnVlIDogZmFsc2UpOwogCi0JZ2Z4X3YxMF8wX3JpbmdfZW1pdF90bXoocmluZywg
dHJ1ZSwgZmFsc2UpOworCWdmeF92MTBfMF9yaW5nX2VtaXRfdG16KHJpbmcsIHRydWUsIHRydXN0
ZWQpOwogCiAJZHcyIHw9IDB4ODAwMDAwMDA7IC8qIHNldCBsb2FkX2VuYWJsZSBvdGhlcndpc2Ug
dGhpcyBwYWNrYWdlIGlzIGp1c3QgTk9QcyAqLwogCWlmIChmbGFncyAmIEFNREdQVV9IQVZFX0NU
WF9TV0lUQ0gpIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
