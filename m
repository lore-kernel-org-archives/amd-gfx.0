From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] drm/amdgpu/gmc9: disable partial wr rmw if ECC is not
 enabled
Date: Wed, 16 May 2018 15:51:56 -0500
Message-ID: <20180516205156.29064-4-alexander.deucher@amd.com>
References: <20180516205156.29064-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180516205156.29064-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

VGhlIHZiaW9zIG1pc3Rha2VubHkgc2V0cyB0aGlzIGJpdCBvbiBzb21lIGJvYXJkcyB3aXRob3V0
IEVDQy4KVGhpcyBjYW4gbGVhZCB0byByZWR1Y2VkIHBlcmZvcm1hbmNlIGluIHNvbWUgd29ya2xv
YWRzLiAgRGlzYWJsZQp0aGUgYml0IGlmIHRoZSBib2FyZCBkb2VzIG5vdCBoYXZlIEVDQy4KClNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwpp
bmRleCBiNjBlZDI4OGQzMTQuLjNjMGE4NWQ0ZTRhYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jCkBAIC02NzUsNiArNjc1LDcgQEAgc3RhdGljIGludCBnbWNfdjlfMF9sYXRl
X2luaXQodm9pZCAqaGFuZGxlKQogCQkJRFJNX0lORk8oIkVDQyBpcyBhY3RpdmUuXG4iKTsKIAkJ
fSBlbHNlIGlmIChyID09IDApIHsKIAkJCURSTV9JTkZPKCJFQ0MgaXMgbm90IHByZXNlbnQuXG4i
KTsKKwkJCWFkZXYtPmRmX2Z1bmNzLT5lbmFibGVfZWNjX2ZvcmNlX3Bhcl93cl9ybXcoYWRldiwg
ZmFsc2UpOwogCQl9IGVsc2UgewogCQkJRFJNX0VSUk9SKCJnbWNfdjlfMF9lY2NfYXZhaWxhYmxl
KCkgZmFpbGVkLiByOiAlZFxuIiwgcik7CiAJCQlyZXR1cm4gcjsKLS0gCjIuMTMuNgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
