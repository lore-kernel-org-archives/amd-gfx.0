From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 32/36] drm/amdgpu: enable DPG mode for Navi12
Date: Thu,  1 Aug 2019 15:29:53 -0500
Message-ID: <20190801202957.29791-33-alexander.deucher@amd.com>
References: <20190801202957.29791-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190801202957.29791-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkVuYWJsZSBEeW5hbWlj
IFBvd2VyIEdhdGluZyBWQ04gZm9yIE5hdmkxMi4KClNpZ25lZC1vZmYtYnk6IEJveXVhbiBaaGFu
ZyA8Ym95dWFuLnpoYW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9q
aWUueXVhbkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jCmluZGV4IDdjMDBhYWVlZmRhOS4uODVlNzY4OGRiYWEwIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L252LmMKQEAgLTYxNCw3ICs2MTQsNyBAQCBzdGF0aWMgaW50IG52X2NvbW1v
bl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJYnJlYWs7CiAJY2FzZSBDSElQX05BVkkxMjoK
IAkJYWRldi0+Y2dfZmxhZ3MgPSAwOwotCQlhZGV2LT5wZ19mbGFncyA9IDA7CisJCWFkZXYtPnBn
X2ZsYWdzID0gQU1EX1BHX1NVUFBPUlRfVkNOX0RQRzsKIAkJYWRldi0+ZXh0ZXJuYWxfcmV2X2lk
ID0gYWRldi0+cmV2X2lkICsgMHhhOwogCQlicmVhazsKIAlkZWZhdWx0OgotLSAKMi4yMC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
