From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH umr] Skip sq_cmd halt waves on SI ASICs
Date: Mon, 28 Aug 2017 08:37:09 -0400
Message-ID: <20170828123709.28252-1-tom.stdenis@amd.com>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIHNy
Yy9saWIvc3FfY21kX2hhbHRfd2F2ZXMuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9saWIvc3FfY21kX2hhbHRfd2F2ZXMuYyBiL3Ny
Yy9saWIvc3FfY21kX2hhbHRfd2F2ZXMuYwppbmRleCA5M2U5OGQ1YTYwMzUuLjg5NzMxMzhhZjkw
YyAxMDA2NDQKLS0tIGEvc3JjL2xpYi9zcV9jbWRfaGFsdF93YXZlcy5jCisrKyBiL3NyYy9saWIv
c3FfY21kX2hhbHRfd2F2ZXMuYwpAQCAtMzAsNiArMzAsMTAgQEAgaW50IHVtcl9zcV9jbWRfaGFs
dF93YXZlcyhzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMsIGVudW0gdW1yX3NxX2NtZF9oYWx0X3Jlc3Vt
ZSBtb2QKIAl1aW50MzJfdCB2YWx1ZTsKIAl1aW50NjRfdCBhZGRyOwogCisJLy8gU1FfQ01EIGlz
IG5vdCBwcmVzZW50IG9uIFNJCisJaWYgKGFzaWMtPmZhbWlseSA9PSBGQU1JTFlfU0kpCisJCXJl
dHVybiAwOworCiAJcmVnID0gdW1yX2ZpbmRfcmVnX2RhdGEoYXNpYywgIm1tU1FfQ01EIik7CiAJ
aWYgKCFyZWcpIHsKIAkJZnByaW50ZihzdGRlcnIsICJbQlVHXTogQ2Fubm90IGZpbmQgU1FfQ01E
IHJlZ2lzdGVyIGluIHVtcl9zcV9jbWRfaGFsdF93YXZlcygpXG4iKTsKLS0gCjIuMTIuMAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
