From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: Change comp GFXv9 ring name to remove
 space
Date: Wed, 19 Apr 2017 09:10:56 -0400
Message-ID: <20170419131056.16369-2-tom.stdenis@amd.com>
References: <20170419131056.16369-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170419131056.16369-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

dW1yIGV4cGVjdHMgdGhlIHJpbmcgbmFtZSB0byBiZSBhIGNvbXBsZXRlIHdvcmQuICBUaGlzIGFs
c28KbWFrZXMgaXQgY29uc2lzdGVudCB3aXRoIEdGWHY3LzguCgpTaWduZWQtb2ZmLWJ5OiBUb20g
U3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDg5
OGJjNWMzYTQyYi4uNDJjZmQzYjQ1MzkwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMKQEAgLTEwOTQsNyArMTA5NCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfc3dfaW5pdCh2
b2lkICpoYW5kbGUpCiAJCXJpbmctPnBpcGUgPSBpIC8gODsKIAkJcmluZy0+cXVldWUgPSBpICUg
ODsKIAkJcmluZy0+ZW9wX2dwdV9hZGRyID0gYWRldi0+Z2Z4Lm1lYy5ocGRfZW9wX2dwdV9hZGRy
ICsgKGkgKiBNRUNfSFBEX1NJWkUpOwotCQlzcHJpbnRmKHJpbmctPm5hbWUsICJjb21wICVkLiVk
LiVkIiwgcmluZy0+bWUsIHJpbmctPnBpcGUsIHJpbmctPnF1ZXVlKTsKKwkJc3ByaW50ZihyaW5n
LT5uYW1lLCAiY29tcF8lZC4lZC4lZCIsIHJpbmctPm1lLCByaW5nLT5waXBlLCByaW5nLT5xdWV1
ZSk7CiAJCWlycV90eXBlID0gQU1ER1BVX0NQX0lSUV9DT01QVVRFX01FQzFfUElQRTBfRU9QICsg
cmluZy0+cGlwZTsKIAkJLyogdHlwZS0yIHBhY2tldHMgYXJlIGRlcHJlY2F0ZWQgb24gTUVDLCB1
c2UgdHlwZS0zIGluc3RlYWQgKi8KIAkJciA9IGFtZGdwdV9yaW5nX2luaXQoYWRldiwgcmluZywg
MTAyNCwKLS0gCjIuMTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
