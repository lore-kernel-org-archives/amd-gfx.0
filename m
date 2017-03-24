From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 13/18] drm/amdgpu: fix update sub levels
Date: Fri, 24 Mar 2017 11:16:52 +0800
Message-ID: <1490325417-26745-14-git-send-email-David1.Zhou@amd.com>
References: <1490325417-26745-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490325417-26745-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

c3ViIGxldmVsIHBkZXMgYWx3YXlzIGFyZSB3cml0dGVuIHRvIGluY29ycmVjdCBwbGFjZS4KCkNo
YW5nZS1JZDogSWM0MGJiZjJhZmZhOWNkZDA0OTBmOGQ3ZGRlODgzY2FiMzZiZDYwZmMKU2lnbmVk
LW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMKaW5kZXggNzFmOTBlNS4uNWM1MTgxNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKQEAgLTY2MSw3ICs2NjEsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91
cGRhdGVfbGV2ZWwoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJLyogYXNzdW1lIHRoZSB3
b3JzdCBjYXNlICovCiAJbmR3ICs9IHBhcmVudC0+bGFzdF9lbnRyeV91c2VkICogNjsKIAotCXBk
X2FkZHIgPSBhbWRncHVfYm9fZ3B1X29mZnNldCh2bS0+cm9vdC5ibyk7CisJcGRfYWRkciA9IGFt
ZGdwdV9ib19ncHVfb2Zmc2V0KHBhcmVudC0+Ym8pOwogCiAJc2hhZG93ID0gcGFyZW50LT5iby0+
c2hhZG93OwogCWlmIChzaGFkb3cpIHsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
