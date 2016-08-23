From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix IB alignment for UVD
Date: Tue, 23 Aug 2016 12:55:23 -0400
Message-ID: <1471971324-31740-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Fang <peter.fang-5C7GfCeVMHo@public.gmane.org>

QWNjb3JkaW5nIHRvIHRoZSBodyB0ZWFtLCBpdCBzaG91bGQgYmUgMTYsIG5vdCA4LgoKQ2M6IFBl
dGVyIEZhbmcgPHBldGVyLmZhbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwppbmRleCA0YzhlNjhhLi5lYWI4ZDczIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCkBAIC0yOTIsNyArMjkyLDcgQEAgc3RhdGlj
IGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRh
LCBzdHJ1Y3QgZHJtX2ZpbGUKIAkJCXR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9VVkQ7CiAJCQly
aW5nX21hc2sgPSBhZGV2LT51dmQucmluZy5yZWFkeSA/IDEgOiAwOwogCQkJaWJfc3RhcnRfYWxp
Z25tZW50ID0gQU1ER1BVX0dQVV9QQUdFX1NJWkU7Ci0JCQlpYl9zaXplX2FsaWdubWVudCA9IDg7
CisJCQlpYl9zaXplX2FsaWdubWVudCA9IDE2OwogCQkJYnJlYWs7CiAJCWNhc2UgQU1ER1BVX0hX
X0lQX1ZDRToKIAkJCXR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9WQ0U7Ci0tIAoyLjUuNQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
