From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix fence memory leak in wait_all_fence V2
Date: Fri, 7 Apr 2017 17:07:53 +0800
Message-ID: <1491556073-20459-1-git-send-email-David1.Zhou@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

VjI6IHJlbW92ZSAqKmFycmF5IG1ldGhvZCwgZGlyZWN0bHkgZmVuY2VfcHV0IGFmdGVyIGZlbmNl
IHdhaXQuCgpDaGFuZ2UtSWQ6IElkZGUzZjkyOWNiZTRmZTgwNjNhN2I5MTNlMzYxZDZkOGJjMjc0
NWRjClNpZ25lZC1vZmYtYnk6IENodW5taW5nIFpob3UgPERhdmlkMS5aaG91QGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMKaW5kZXggZGUxYzRjMy4uYzkzOTM3NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2NzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2NzLmMKQEAgLTEyMzAsNiArMTIzMCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3dhaXRf
YWxsX2ZlbmNlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCWNvbnRpbnVlOwogCiAJ
CXIgPSBrY2xfZmVuY2Vfd2FpdF90aW1lb3V0KGZlbmNlLCB0cnVlLCB0aW1lb3V0KTsKKwkJZmVu
Y2VfcHV0KGZlbmNlKTsKIAkJaWYgKHIgPCAwKQogCQkJcmV0dXJuIHI7CiAKLS0gCjEuOS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
