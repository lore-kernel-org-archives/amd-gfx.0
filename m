From: Huang Rui <ray.huang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: move PD/PT bos on LRU again
Date: Wed, 8 Aug 2018 17:59:37 +0800
Message-ID: <1533722377-27020-6-git-send-email-ray.huang@amd.com>
References: <1533722377-27020-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1533722377-27020-1-git-send-email-ray.huang@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Huang Rui <ray.huang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlIG5ldyBidWxrIG1vdmluZyBmdW5jdGlvbmFsaXR5IGlzIHJlYWR5LCB0aGUgb3ZlcmhlYWQg
b2YgbW92aW5nIFBEL1BUIGJvcyB0bwpMUlUgaXMgZml4ZWQuIFNvIG1vdmUgdGhlbSBvbiBMUlUg
YWdhaW4uCgpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwppbmRleCBlZGEwYmI5Li4zNTUwMTY2IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMTA5MCw3ICsxMDkwLDcgQEAgaW50IGFtZGdwdV92
bV91cGRhdGVfZGlyZWN0b3JpZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCSAg
IHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSwKIAkJCQkJICAgdm1fc3RhdHVzKTsKIAkJYm9fYmFz
ZS0+bW92ZWQgPSBmYWxzZTsKLQkJbGlzdF9kZWxfaW5pdCgmYm9fYmFzZS0+dm1fc3RhdHVzKTsK
KwkJbGlzdF9tb3ZlKCZib19iYXNlLT52bV9zdGF0dXMsICZ2bS0+aWRsZSk7CiAKIAkJYm8gPSBi
b19iYXNlLT5iby0+cGFyZW50OwogCQlpZiAoIWJvKQotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
