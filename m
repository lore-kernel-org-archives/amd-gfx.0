From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/24] drm/amdkfd: Fix typo in dbgdev_wave_reset_wavefronts
Date: Tue, 15 Aug 2017 22:59:59 -0400
Message-ID: <1502852422-19620-2-git-send-email-Felix.Kuehling@amd.com>
References: <1502852422-19620-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502852422-19620-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClJl
dmlld2VkLWJ5OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kYmdkZXYuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kYmdkZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kYmdkZXYuYwppbmRleCBkNWUxOWI1Li44YjE0YTRlIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGJnZGV2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RiZ2Rldi5jCkBAIC04MjMsNyArODIzLDcgQEAgaW50IGRiZ2Rldl93YXZl
X3Jlc2V0X3dhdmVmcm9udHMoc3RydWN0IGtmZF9kZXYgKmRldiwgc3RydWN0IGtmZF9wcm9jZXNz
ICpwKQogCWZvciAodm1pZCA9IGZpcnN0X3ZtaWRfdG9fc2Nhbjsgdm1pZCA8PSBsYXN0X3ZtaWRf
dG9fc2Nhbjsgdm1pZCsrKSB7CiAJCWlmIChkZXYtPmtmZDJrZ2QtPmdldF9hdGNfdm1pZF9wYXNp
ZF9tYXBwaW5nX3ZhbGlkCiAJCQkJKGRldi0+a2dkLCB2bWlkKSkgewotCQkJaWYgKGRldi0+a2Zk
MmtnZC0+Z2V0X2F0Y192bWlkX3Bhc2lkX21hcHBpbmdfdmFsaWQKKwkJCWlmIChkZXYtPmtmZDJr
Z2QtPmdldF9hdGNfdm1pZF9wYXNpZF9tYXBwaW5nX3Bhc2lkCiAJCQkJCShkZXYtPmtnZCwgdm1p
ZCkgPT0gcC0+cGFzaWQpIHsKIAkJCQlwcl9kZWJ1ZygiS2lsbGluZyB3YXZlIGZyb250cyBvZiB2
bWlkICVkIGFuZCBwYXNpZCAlZFxuIiwKIAkJCQkJCXZtaWQsIHAtPnBhc2lkKTsKLS0gCjIuNy40
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
