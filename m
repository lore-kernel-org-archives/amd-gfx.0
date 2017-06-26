From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] drm/amdgpu: fix solid screen and hard hang when 2k + 4k
 display connected with DP
Date: Mon, 26 Jun 2017 20:18:11 +0800
Message-ID: <1498479491-31585-1-git-send-email-ray.huang@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Sonny Jiang <sonny.jiang-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Joe Qiao <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCgpWMSAtPiBW
MjoKLSBBZGQgUkVBRF9PTkNFIHRvIGF2b2lkIGNvbXBsaWVyIG1pZ2h0IGNhdXNlIHRvIHJlYWQg
YXMgcHJldmlvdXMgZmVuY2UgdmFsdWUuCgpJIHdpbGwgcmVmaW5lIGZlbmNlIGNoZWNraW5nIHdp
dGggZmVuY2UgaW50ZXJmYWNlIGF0IGFtZGdwdV9mZW5jZS5jIGFmdGVyIFMzCnN0cmVzcyBpc3N1
ZSBjb21wbGV0ZWQgYXMgQ2hyaXN0aWFuJ3Mgc3VnZ2VzdGlvbi4KClRoYW5rcywKUmF5CgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCA1YmVkNDgzLi5hZjNjODdiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0xMzAsNyArMTMwLDcgQEAgcHNwX2NtZF9z
dWJtaXRfYnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLAogCXJldCA9IHBzcF9jbWRfc3VibWl0
KHBzcCwgdWNvZGUsIGNtZF9idWZfbWNfYWRkciwKIAkJCSAgICAgZmVuY2VfbWNfYWRkciwgaW5k
ZXgpOwogCi0Jd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2VfYnVmKSAhPSBpbmRl
eCkgeworCXdoaWxlIChSRUFEX09OQ0UoKigodW5zaWduZWQgaW50ICopcHNwLT5mZW5jZV9idWYp
KSA8IGluZGV4KSB7CiAJCW1zbGVlcCgxKTsKIAl9CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
