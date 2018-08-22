From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v5 5/5] drm/amdgpu: move PD/PT bos on LRU again
Date: Wed, 22 Aug 2018 15:52:55 +0800
Message-ID: <1534924375-5837-6-git-send-email-ray.huang@amd.com>
References: <1534924375-5837-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534924375-5837-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
YWdhaW4uCgpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgpUZXN0
ZWQtYnk6IE1pa2UgTG90aGlhbiA8bWlrZUBmaXJlYnVybi5jby51az4KVGVzdGVkLWJ5OiBEaWV0
ZXIgTsO8dHplbCA8RGlldGVyQG51ZXR6ZWwtaGguZGU+CkFja2VkLWJ5OiBDaHVubWluZyBaaG91
IDxkYXZpZDEuemhvdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5a
aGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCBkYjFmMjhhLi5kMTk1YTNk
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMTEwNyw3ICsxMTA3
LDcgQEAgaW50IGFtZGdwdV92bV91cGRhdGVfZGlyZWN0b3JpZXMoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCiAJCQkJCSAgIHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSwKIAkJCQkJICAgdm1f
c3RhdHVzKTsKIAkJYm9fYmFzZS0+bW92ZWQgPSBmYWxzZTsKLQkJbGlzdF9kZWxfaW5pdCgmYm9f
YmFzZS0+dm1fc3RhdHVzKTsKKwkJbGlzdF9tb3ZlKCZib19iYXNlLT52bV9zdGF0dXMsICZ2bS0+
aWRsZSk7CiAKIAkJYm8gPSBib19iYXNlLT5iby0+cGFyZW50OwogCQlpZiAoIWJvKQotLSAKMi43
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
