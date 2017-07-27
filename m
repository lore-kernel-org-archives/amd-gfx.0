From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] drm/amdgpu/sdma4: drop hdp flush from wptr shadow update
Date: Thu, 27 Jul 2017 15:46:03 -0400
Message-ID: <1501184765-26699-3-git-send-email-alexander.deucher@amd.com>
References: <1501184765-26699-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1501184765-26699-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

VGhlIHdiIGJ1ZmZlciBpcyBpbiBzeXN0ZW0gbWVtb3J5LCBub3QgdnJhbSBzbyB0aGUgZmx1c2gK
aXMgdXNlbGVzcy4KCkNjOiBGcmFuayBNaW4gPEZyYW5rLk1pbkBhbWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwppbmRleCA5
MzkyNzk5Li4zZmZkZjg4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3Y0XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwpA
QCAtMzEyLDcgKzMxMiw2IEBAIHN0YXRpYyB2b2lkIHNkbWFfdjRfMF9yaW5nX3NldF93cHRyKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKIAkJCQkJb2Zmc2V0ID0gYWRldi0+c2RtYS5pbnN0YW5j
ZVtpXS5wb2xsX21lbV9vZmZzOwogCQkJCQlhdG9taWM2NF9zZXQoKGF0b21pYzY0X3QgKikmYWRl
di0+d2Iud2Jbb2Zmc2V0XSwKIAkJCQkJCSAgICAgKHJpbmctPndwdHIgPDwgMikpOwotCQkJCQlu
YmlvX3Y2XzFfaGRwX2ZsdXNoKGFkZXYpOwogCQkJCX0KIAkJCX0KIAkJfQotLSAKMi41LjUKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
