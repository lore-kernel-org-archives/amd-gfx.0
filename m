From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: do not free fence buf when driver probes.
Date: Mon, 10 Apr 2017 17:37:50 +0800
Message-ID: <1491817071-17014-2-git-send-email-ray.huang@amd.com>
References: <1491817071-17014-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491817071-17014-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

RmVuY2UgYnVmIG5lZWRzIHRvIGJlIHVzZWQgb24gc3VzcGVuZC9yZXN1bWUgcGhhc2UuCgpTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYwppbmRleCA2OGNjYWVkLi4xOTE4MGFhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0zNTgsOCArMzU4LDYgQEAgc3RhdGljIGludCBwc3Bf
bG9hZF9mdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAocmV0KQogCQlnb3RvIGZh
aWxlZF9tZW07CiAKLQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJnBzcC0+ZmVuY2VfYnVmX2JvLAot
CQkJICAgICAgJnBzcC0+ZmVuY2VfYnVmX21jX2FkZHIsICZwc3AtPmZlbmNlX2J1Zik7CiAJa2Zy
ZWUoY21kKTsKIAogCXJldHVybiAwOwpAQCAtNDIzLDYgKzQyMSwxMCBAQCBzdGF0aWMgaW50IHBz
cF9od19maW5pKHZvaWQgKmhhbmRsZSkKIAkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZwc3AtPmZ3
X3ByaV9ibywKIAkJCQkgICAgICAmcHNwLT5md19wcmlfbWNfYWRkciwgJnBzcC0+ZndfcHJpX2J1
Zik7CiAKKwlpZiAocHNwLT5mZW5jZV9idWZfYm8pCisJCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgm
cHNwLT5mZW5jZV9idWZfYm8sCisJCQkJICAgICAgJnBzcC0+ZmVuY2VfYnVmX21jX2FkZHIsICZw
c3AtPmZlbmNlX2J1Zik7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
