From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 5/5] drm/amdgpu: move PD/PT bos on LRU again
Date: Fri, 10 Aug 2018 19:55:59 +0800
Message-ID: <1533902159-14232-6-git-send-email-ray.huang@amd.com>
References: <1533902159-14232-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533902159-14232-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

VGhlIG5ldyBidWxrIG1vdmluZyBmdW5jdGlvbmFsaXR5IGlzIHJlYWR5LCB0aGUgb3ZlcmhlYWQg
b2YgbW92aW5nIFBEL1BUIGJvcyB0bwpMUlUgaXMgZml4ZWQuIFNvIG1vdmUgdGhlbSBvbiBMUlUg
YWdhaW4uCgpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwppbmRleCA4MWZiMWFjLi45ZjQ0NTE0IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMTEyNyw3ICsxMTI3LDcgQEAgaW50IGFtZGdwdV92
bV91cGRhdGVfZGlyZWN0b3JpZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCSAg
IHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSwKIAkJCQkJICAgdm1fc3RhdHVzKTsKIAkJYm9fYmFz
ZS0+bW92ZWQgPSBmYWxzZTsKLQkJbGlzdF9kZWxfaW5pdCgmYm9fYmFzZS0+dm1fc3RhdHVzKTsK
KwkJbGlzdF9tb3ZlKCZib19iYXNlLT52bV9zdGF0dXMsICZ2bS0+aWRsZSk7CiAKIAkJYm8gPSBi
b19iYXNlLT5iby0+cGFyZW50OwogCQlpZiAoIWJvKQotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
