From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: jt_size was wrongly counted twice
Date: Thu, 10 Aug 2017 16:22:46 +0800
Message-ID: <1502353366-5149-1-git-send-email-evan.quan@amd.com>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYzZjMDMxZjE2MGNiNWVkNTc0NGVkMzAyZjBkODE5NTA1ZWNlNDI3ZQpTaWdu
ZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBI
dWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91Y29kZS5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYwppbmRleCBkMzQ2OGEy
Li4zNmM3NjMzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dWNvZGUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYwpA
QCAtMzU4LDggKzM1OCw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Vjb2RlX3BhdGNoX2p0KHN0cnVj
dCBhbWRncHVfZmlybXdhcmVfaW5mbyAqdWNvZGUsCiAJCQkgICAobGUzMl90b19jcHUoaGVhZGVy
LT5qdF9vZmZzZXQpICogNCk7CiAJbWVtY3B5KGRzdF9hZGRyLCBzcmNfYWRkciwgbGUzMl90b19j
cHUoaGVhZGVyLT5qdF9zaXplKSAqIDQpOwogCi0JdWNvZGUtPnVjb2RlX3NpemUgKz0gbGUzMl90
b19jcHUoaGVhZGVyLT5qdF9zaXplKSAqIDQ7Ci0KIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
