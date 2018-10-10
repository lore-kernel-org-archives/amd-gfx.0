From: likun Gao <likun.gao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/5] drm/amdgpu/rlc: unify rlc function into structure
Date: Wed, 10 Oct 2018 19:42:52 +0800
Message-ID: <1539171776-8157-2-git-send-email-likun.gao@amd.com>
References: <1539171776-8157-1-git-send-email-likun.gao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539171776-8157-1-git-send-email-likun.gao-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KClB1dCBmdW5jdGlvbiBybGNfaW5p
dCxybGNfZmluaSxybGNfcmVzdW1lLHJsY19zdG9wLHJsY19zdGFydCBpbnRvIHN0cnVjdHVyZQph
bWRncHVfcmxjX2Z1bmNzLgoKU2lnbmVkLW9mZi1ieTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggfCA2ICsr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZnguaAppbmRleCBiNjFiNWMxLi5iYjdiMWFkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCkBAIC00MSw2ICs0MSwxMiBAQAogc3RydWN0IGFt
ZGdwdV9ybGNfZnVuY3MgewogCXZvaWQgKCplbnRlcl9zYWZlX21vZGUpKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KTsKIAl2b2lkICgqZXhpdF9zYWZlX21vZGUpKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KTsKKwlpbnQgICgqcmxjX2luaXQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KTsKKwl2b2lkICgqcmxjX2ZpbmkpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKKwlpbnQg
ICgqcmxjX3Jlc3VtZSkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOworCXZvaWQgKCpybGNf
c3RvcCkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOworCXZvaWQgKCpybGNfcmVzZXQpKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKKwl2b2lkICgqcmxjX3N0YXJ0KShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldik7CiB9OwogCiBzdHJ1Y3QgYW1kZ3B1X3JsYyB7Ci0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
