From: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: Fix maybe-uninitialized warning in
 df_v3_6_pmc_start
Date: Wed, 15 May 2019 16:24:13 -0400
Message-ID: <20190515202413.6522-2-Bhawanpreet.Lakha@amd.com>
References: <20190515202413.6522-1-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190515202413.6522-1-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>

VGhpcyBmaXhlcyB0aGUgd2FybmluZyBiZWxvdwoKZXJyb3I6IOKAmHJldOKAmSBtYXkgYmUgdXNl
ZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFs
aXplZF0KICBpbnQgeGdtaV90eF9saW5rLCByZXQ7CiAgICAgICAgICAgICAgICAgICAgXn5+ClNp
Z25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2RmX3YzXzYuYwppbmRleCAyMDFjMDA0MTE3MjAuLmE4NDQyNTA4ZWVhNSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYwpAQCAtNDU5LDcgKzQ1OSw3IEBAIHN0YXRpYyBp
bnQgZGZfdjNfNl9zdG9wX3hnbWlfbGlua19jbnRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogc3RhdGljIGludCBkZl92M182X3BtY19zdGFydChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwgdWludDY0X3QgY29uZmlnLAogCQkJICAgICBpbnQgaXNfZW5hYmxlKQogewotCWludCB4Z21p
X3R4X2xpbmssIHJldDsKKwlpbnQgeGdtaV90eF9saW5rLCByZXQgPSAwOwogCiAJc3dpdGNoIChh
ZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENISVBfVkVHQTIwOgotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
