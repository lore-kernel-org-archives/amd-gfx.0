From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 041/102] drm/amdgpu: Initialize asic functions for Arcturus
Date: Mon, 15 Jul 2019 16:23:36 -0500
Message-ID: <20190715212437.31793-39-alexander.deucher@amd.com>
References: <20190715212437.31793-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212437.31793-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+CgpBZnRlciBjaGVycnktcGlja2luZyBk
b29yYmVsbCByZXdvcmsgY2hhbmdlcyBmcm9tIGRybS1uZXh0CmJyYW5jaCwgQXJjdHVydXMgYXNp
YyBmdW5jdGlvbnMgcG9pbnRlciBuZWVkIHRvIGJlIGluaXRpYWxpemVkCnRvIGluaXQgZG9vcmJl
bGwgaW5kZXggZm9yIEFyY3R1cnVzLgoKU2lnbmVkLW9mZi1ieTogT2FrIFplbmcgPE9hay5aZW5n
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwpp
bmRleCBiYjZhZWQyMDZjOGUuLjhjODgxNjk3ZDI5YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jCkBAIC0xMDExLDYgKzEwMTEsNyBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9lYXJs
eV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCQlBTURfUEdfU1VQUE9SVF9STENfU01VX0hTOwogCQli
cmVhazsKIAljYXNlIENISVBfQVJDVFVSVVM6CisJCWFkZXYtPmFzaWNfZnVuY3MgPSAmdmVnYTIw
X2FzaWNfZnVuY3M7CiAJCWFkZXYtPmNnX2ZsYWdzID0gMDsKIAkJYWRldi0+cGdfZmxhZ3MgPSAw
OwogCQlicmVhazsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
