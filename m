From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3 5/5] drm/amdgpu: move PD/PT bos on LRU again
Date: Mon, 13 Aug 2018 17:58:51 +0800
Message-ID: <1534154331-11810-6-git-send-email-ray.huang@amd.com>
References: <1534154331-11810-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534154331-11810-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
ZWQtYnk6IE1pa2UgTG90aGlhbiA8bWlrZUBmaXJlYnVybi5jby51az4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKaW5kZXggZWUxYWY1My4uODcyYWU1YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKQEAgLTExMjUsNyArMTEyNSw3IEBAIGludCBhbWRncHVfdm1fdXBkYXRlX2Rp
cmVjdG9yaWVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgICBzdHJ1Y3QgYW1k
Z3B1X3ZtX2JvX2Jhc2UsCiAJCQkJCSAgIHZtX3N0YXR1cyk7CiAJCWJvX2Jhc2UtPm1vdmVkID0g
ZmFsc2U7Ci0JCWxpc3RfZGVsX2luaXQoJmJvX2Jhc2UtPnZtX3N0YXR1cyk7CisJCWxpc3RfbW92
ZSgmYm9fYmFzZS0+dm1fc3RhdHVzLCAmdm0tPmlkbGUpOwogCiAJCWJvID0gYm9fYmFzZS0+Ym8t
PnBhcmVudDsKIAkJaWYgKCFibykKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
