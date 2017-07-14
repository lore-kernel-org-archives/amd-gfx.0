From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH umr] Remove duplicate comparison in PM4 ring detection.
Date: Fri, 14 Jul 2017 10:37:28 -0400
Message-ID: <20170714143728.10119-1-tom.stdenis@amd.com>
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
Yy9hcHAvcmluZ19yZWFkLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvc3JjL2FwcC9yaW5nX3JlYWQuYyBiL3NyYy9hcHAvcmluZ19yZWFkLmMKaW5k
ZXggNzE0YTU0ZTRmNWVhLi40MDFhMWFjODdiOGQgMTAwNjQ0Ci0tLSBhL3NyYy9hcHAvcmluZ19y
ZWFkLmMKKysrIGIvc3JjL2FwcC9yaW5nX3JlYWQuYwpAQCAtNTQsNyArNTQsNiBAQCB2b2lkIHVt
cl9yZWFkX3Jpbmcoc3RydWN0IHVtcl9hc2ljICphc2ljLCBjaGFyICpyaW5ncGF0aCkKIAkgICAg
IW1lbWNtcChyaW5nbmFtZSwgInV2ZCIsIDMpIHx8CiAJICAgICFtZW1jbXAocmluZ25hbWUsICJ2
Y25fZGVjIiwgNykgfHwKIAkgICAgIW1lbWNtcChyaW5nbmFtZSwgInZjbl9lbmMiLCA3KSB8fAot
CSAgICAhbWVtY21wKHJpbmduYW1lLCAidmNuX2VuYyIsIDcpIHx8CiAJICAgICFtZW1jbXAocmlu
Z25hbWUsICJjb21wIiwgNCkpIHsKIAkJZW5hYmxlX2RlY29kZXIgPSAxOwogCQlkZWNvZGVyLnBt
ID0gNDsKLS0gCjIuMTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
