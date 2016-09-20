From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix gtt_mgr bo's offset
Date: Tue, 20 Sep 2016 17:09:12 +0800
Message-ID: <1474362552-9062-1-git-send-email-Flora.Cui@amd.com>
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
Cc: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJODllOWJlM2Q1Yzk2ZDQ2NjU1ZjNhOTc3ZmI1NTdiMjBiNGQ4NzYwOQpTaWdu
ZWQtb2ZmLWJ5OiBGbG9yYSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMKaW5kZXggMjYyZTg3Mi4uYjI2NmNmNyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ3R0X21nci5jCkBAIC0xMjgsOCArMTI4LDgg
QEAgaW50IGFtZGdwdV9ndHRfbWdyX2FsbG9jKHN0cnVjdCB0dG1fbWVtX3R5cGVfbWFuYWdlciAq
bWFuLAogCiAJaWYgKCFyKSB7CiAJCW1lbS0+c3RhcnQgPSBub2RlLT5zdGFydDsKLQkJdGJvLT5v
ZmZzZXQgPSAodGJvLT5tZW0uc3RhcnQgPDwgUEFHRV9TSElGVCkgKwotCQkgICAgdGJvLT5iZGV2
LT5tYW5bdGJvLT5tZW0ubWVtX3R5cGVdLmdwdV9vZmZzZXQ7CisJCXRiby0+b2Zmc2V0ID0gKG1l
bS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKworCQkgICAgdGJvLT5iZGV2LT5tYW5bbWVtLT5tZW1f
dHlwZV0uZ3B1X29mZnNldDsKIAl9CiAKIAlyZXR1cm4gcjsKLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
