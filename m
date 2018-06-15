From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH 4/4] drm/amdgpu: Use gmc_vram_full_visible in
 vram_mgr_bo_invisible_size
Date: Fri, 15 Jun 2018 16:42:30 +0200
Message-ID: <20180615144230.18480-5-michel@daenzer.net>
References: <20180615144230.18480-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180615144230.18480-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKaW5kZXggOWIzNGRmNzAxN2YwLi45ODE0ZTlhYWIz
MTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21n
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCkBA
IC0xMTMsNyArMTEzLDcgQEAgdTY0IGFtZGdwdV92cmFtX21ncl9ib19pbnZpc2libGVfc2l6ZShz
dHJ1Y3QgYW1kZ3B1X2JvICpibykKIAl1bnNpZ25lZCBwYWdlcyA9IG1lbS0+bnVtX3BhZ2VzOwog
CXU2NCB1c2FnZSA9IDA7CiAKLQlpZiAoYWRldi0+Z21jLnZpc2libGVfdnJhbV9zaXplID09IGFk
ZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSkKKwlpZiAoYW1kZ3B1X2dtY192cmFtX2Z1bGxfdmlzaWJs
ZSgmYWRldi0+Z21jKSkKIAkJcmV0dXJuIDA7CiAKIAlpZiAobWVtLT5zdGFydCA+PSBhZGV2LT5n
bWMudmlzaWJsZV92cmFtX3NpemUgPj4gUEFHRV9TSElGVCkKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
