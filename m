From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/10] drm/amdgpu: set runtime pm state to active on resume
Date: Wed, 31 Aug 2016 18:08:51 -0400
Message-ID: <1472681336-30106-5-git-send-email-alexander.deucher@amd.com>
References: <1472681336-30106-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472681336-30106-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

VGhlIHNiaW9zIGFsd2F5cyBwb3dlcnMgdXAgdGhlIGRHUFUgb24gcmVzdW1lLgoKU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDggKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMKaW5kZXggNzE2YWRiNS4uMzQyNmFlMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYwpAQCAtNDk1LDYgKzQ5NSwxNCBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9w
c19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQogewogCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0g
dG9fcGNpX2RldihkZXYpOwogCXN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gcGNpX2dldF9k
cnZkYXRhKHBkZXYpOworCisJLyogR1BVIGNvbWVzIHVwIGVuYWJsZWQgYnkgdGhlIGJpb3Mgb24g
cmVzdW1lICovCisJaWYgKGFtZGdwdV9kZXZpY2VfaXNfcHgoZHJtX2RldikpIHsKKwkJcG1fcnVu
dGltZV9kaXNhYmxlKGRldik7CisJCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOworCQlwbV9y
dW50aW1lX2VuYWJsZShkZXYpOworCX0KKwogCXJldHVybiBhbWRncHVfZGV2aWNlX3Jlc3VtZShk
cm1fZGV2LCB0cnVlLCB0cnVlLCBmYWxzZSk7CiB9CiAKLS0gCjIuNS41CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
