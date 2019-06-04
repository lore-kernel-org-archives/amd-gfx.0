From: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: no need fbcon under sriov
Date: Tue, 4 Jun 2019 21:43:05 +0800
Message-ID: <1559655785-30379-1-git-send-email-yttao@amd.com>
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
Cc: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>

VW5kZXIgU3Jpb3YsIHRoZXJlIGlzIG5vIG5lZWQgb2YgdGhlIHN1cHBvcnQgZm9yIGZiY29uLgoK
U2lnbmVkLW9mZi1ieTogWWludGlhbiBUYW8gPHl0dGFvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMKaW5kZXggMWYzOGQ2Zi4uMjhkMDk1YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtMTAxMiw3ICsxMDEyLDggQEAgYW1kZ3B1X3BjaV9yZW1v
dmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiB7CiAJc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBj
aV9nZXRfZHJ2ZGF0YShwZGV2KTsKIAotCURSTV9FUlJPUigiRGV2aWNlIHJlbW92YWwgaXMgY3Vy
cmVudGx5IG5vdCBzdXBwb3J0ZWQgb3V0c2lkZSBvZiBmYmNvblxuIik7CisJaWYgKCFhbWRncHVf
c3Jpb3ZfdmYoYWRldikpCisJCURSTV9FUlJPUigiRGV2aWNlIHJlbW92YWwgaXMgY3VycmVudGx5
IG5vdCBzdXBwb3J0ZWQgb3V0c2lkZSBvZiBmYmNvblxuIik7CiAJZHJtX2Rldl91bnBsdWcoZGV2
KTsKIAlkcm1fZGV2X3B1dChkZXYpOwogCXBjaV9kaXNhYmxlX2RldmljZShwZGV2KTsKLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
