From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/scheduler: add WARN_ON for s_fence->parent
Date: Wed, 8 Nov 2017 14:46:18 +0800
Message-ID: <20171108064618.9184-2-david1.zhou@amd.com>
References: <20171108064618.9184-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108064618.9184-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: jim.qu-5C7GfCeVMHo@public.gmane.org, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMWY2YzgxMDAyZmIyYmEyMWMxN2NkYzE0ZmRkZTg2NTc5YjI4Mzc0ZQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9z
Y2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIv
Z3B1X3NjaGVkdWxlci5jCmluZGV4IGJiOGEyOGI4Yjk5My4uMmRiNjZjYjk2ZTkyIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jCkBAIC0yNDEsNiAr
MjQxLDcgQEAgdm9pZCBhbWRfc2NoZWRfZW50aXR5X2Zpbmkoc3RydWN0IGFtZF9ncHVfc2NoZWR1
bGVyICpzY2hlZCwKIAkJCWFtZF9zY2hlZF9mZW5jZV9zY2hlZHVsZWQoc19mZW5jZSk7CiAJCQlk
bWFfZmVuY2Vfc2V0X2Vycm9yKCZzX2ZlbmNlLT5maW5pc2hlZCwgLUVTUkNIKTsKIAkJCWFtZF9z
Y2hlZF9mZW5jZV9maW5pc2hlZChzX2ZlbmNlKTsKKwkJCVdBUk5fT04oc19mZW5jZS0+cGFyZW50
KTsKIAkJCWRtYV9mZW5jZV9wdXQoJnNfZmVuY2UtPmZpbmlzaGVkKTsKIAkJCXNjaGVkLT5vcHMt
PmZyZWVfam9iKGpvYik7CiAJCX0KLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
