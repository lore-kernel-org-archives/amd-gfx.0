From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: remove duplicate function prototypes
Date: Thu,  8 Jun 2017 15:05:00 -0400
Message-ID: <1496948702-1066-1-git-send-email-AlexBin.Xie@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

VGhlcmUgYXJlIHR3byBpZGVudGljYWwgZnVuY3Rpb24gcHJvdG90eXBlcyBpbiBzYW1lIGhlYWRl
cmUgZmlsZQoKU2lnbmVkLW9mZi1ieTogQWxleCBYaWUgPEFsZXhCaW4uWGllQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggfCAxIC0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCA3
NjZjNzlkLi43ZjY0NzY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAtMTY4
OCw3ICsxNjg4LDYgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYW1kZ3B1
X3R0bV9hZGV2KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2KQogCXJldHVybiBjb250YWluZXJf
b2YoYmRldiwgc3RydWN0IGFtZGdwdV9kZXZpY2UsIG1tYW4uYmRldik7CiB9CiAKLWJvb2wgYW1k
Z3B1X2RldmljZV9pc19weChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KTsKIGludCBhbWRncHVfZGV2
aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCSAgICAgICBzdHJ1Y3QgZHJt
X2RldmljZSAqZGRldiwKIAkJICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2LAotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
