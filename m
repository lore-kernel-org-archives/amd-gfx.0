From: Frank.Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: skip vm entries checking while in sriov vf
Date: Thu, 11 Oct 2018 20:09:12 +0800
Message-ID: <1539259752-15172-2-git-send-email-Frank.Min@amd.com>
References: <1539259752-15172-1-git-send-email-Frank.Min@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539259752-15172-1-git-send-email-Frank.Min-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Frank.Min" <Frank.Min-5C7GfCeVMHo@public.gmane.org>

dm0gcGFnZSB0YWJsZSB3b3VsZCBiZSBhbGxvY2F0ZWQgd2hpbGUgaW4gYW1kZ3B1X3ZtX2luaXQK
YnkgYW1kZ3B1X2FsbG9jYXRlX3N0YXRpY19jc2EgZm9yIHNyaW92LCBzbyB0aGUgY2hlY2tpbmcK
aGVyZSB3b3VsZCBiZSBza2lwcGVkLgoKQ2hhbmdlLUlkOiBJZDMwYjg2YWQxNWFlNTA5YWVlZDll
ZDhhYjYwYzI1OWM4OGFmM2RmNQpTaWduZWQtb2ZmLWJ5OiBGcmFuay5NaW4gPEZyYW5rLk1pbkBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgOSAr
KysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCA2OTA0ZDc5Li42MDY2
Zjg3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMzEwMCwxMSAr
MzEwMCwxMiBAQCBpbnQgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sIHVucwogCQlyZXR1cm4gcjsKIAogCS8qIFNh
bml0eSBjaGVja3MgKi8KLQlpZiAoIVJCX0VNUFRZX1JPT1QoJnZtLT52YS5yYl9yb290KSB8fCB2
bS0+cm9vdC5lbnRyaWVzKSB7Ci0JCXIgPSAtRUlOVkFMOwotCQlnb3RvIHVucmVzZXJ2ZV9ibzsK
KwlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworCQlpZiAoIVJCX0VNUFRZX1JPT1QoJnZt
LT52YS5yYl9yb290KSB8fCB2bS0+cm9vdC5lbnRyaWVzKSB7CisJCQlyID0gLUVJTlZBTDsKKwkJ
CWdvdG8gdW5yZXNlcnZlX2JvOworCQl9CiAJfQotCiAJaWYgKHBhc2lkKSB7CiAJCXVuc2lnbmVk
IGxvbmcgZmxhZ3M7CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
