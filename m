From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/19] drm/amdgpu: fix vm init error path
Date: Fri, 5 Aug 2016 17:38:34 +0800
Message-ID: <1470389926-5719-8-git-send-email-David1.Zhou@amd.com>
References: <1470389926-5719-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470389926-5719-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZTNkNTQ0MGRjMGQyZDNhNjFkOGU3ODVhYjA4YjhiOTFlZGEyMjNkYgpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKaW5kZXggZTY1NzZjMi4uZDZhMmRkYiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTE1ODEsNyArMTU4MSw3IEBAIGludCBhbWRncHVfdm1f
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pCiAJ
ciA9IGFtZF9zY2hlZF9lbnRpdHlfaW5pdCgmcmluZy0+c2NoZWQsICZ2bS0+ZW50aXR5LAogCQkJ
CSAgcnEsIGFtZGdwdV9zY2hlZF9qb2JzKTsKIAlpZiAocikKLQkJcmV0dXJuIHI7CisJCWdvdG8g
ZXJyOwogCiAJdm0tPnBhZ2VfZGlyZWN0b3J5X2ZlbmNlID0gTlVMTDsKIApAQCAtMTYxMyw2ICsx
NjEzLDkgQEAgZXJyb3JfZnJlZV9wYWdlX2RpcmVjdG9yeToKIGVycm9yX2ZyZWVfc2NoZWRfZW50
aXR5OgogCWFtZF9zY2hlZF9lbnRpdHlfZmluaSgmcmluZy0+c2NoZWQsICZ2bS0+ZW50aXR5KTsK
IAorZXJyOgorCWRybV9mcmVlX2xhcmdlKHZtLT5wYWdlX3RhYmxlcyk7CisKIAlyZXR1cm4gcjsK
IH0KIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
