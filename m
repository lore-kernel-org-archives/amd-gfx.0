From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/pp: missing curly braces in
 smu7_enable_sclk_mclk_dpm()
Date: Thu, 17 May 2018 15:56:05 +0300
Message-ID: <20180517125604.GA10930@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2UgYWRkZWQgc29tZSBtb3JlIGxpbmVzIG9mIGNvZGUgdG8gdGhpcyBpZiBzdGF0ZW1lbnQgYnV0
IGZvcmdvdCB0byBhZGQKY3VybHkgYnJhY2VzLgoKRml4ZXM6IDBjMjRlN2VmMjMzYiAoImRybS9h
bWQvcG93ZXJwbGF5OiBhZGQgc3BlY2lmaWMgY2hhbmdlcyBmb3IgVkVHQU0gaW4gc211N19od21n
ci5jIikKU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUu
Y29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3Nt
dTdfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdt
Z3IuYwppbmRleCA4ZWIzZjUxNzY2NDYuLjY0NmM5ZTliZjY4MSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYwpAQCAtMTAxOCw3ICsxMDE4
LDcgQEAgc3RhdGljIGludCBzbXU3X2VuYWJsZV9zY2xrX21jbGtfZHBtKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpCiAJc3RydWN0IHNtdTdfaHdtZ3IgKmRhdGEgPSAoc3RydWN0IHNtdTdfaHdtZ3Ig
KikoaHdtZ3ItPmJhY2tlbmQpOwogCiAJLyogZW5hYmxlIFNDTEsgZHBtICovCi0JaWYgKCFkYXRh
LT5zY2xrX2RwbV9rZXlfZGlzYWJsZWQpCisJaWYgKCFkYXRhLT5zY2xrX2RwbV9rZXlfZGlzYWJs
ZWQpIHsKIAkJaWYgKGh3bWdyLT5jaGlwX2lkID09IENISVBfVkVHQU0pCiAJCQlzbXU3X2Rpc2Fi
bGVfc2Nsa192Y2VfaGFuZHNoYWtlKGh3bWdyKTsKIApAQCAtMTAyNiw2ICsxMDI2LDcgQEAgc3Rh
dGljIGludCBzbXU3X2VuYWJsZV9zY2xrX21jbGtfZHBtKHN0cnVjdCBwcF9od21nciAqaHdtZ3Ip
CiAJCSgwID09IHNtdW1fc2VuZF9tc2dfdG9fc21jKGh3bWdyLCBQUFNNQ19NU0dfRFBNX0VuYWJs
ZSkpLAogCQkiRmFpbGVkIHRvIGVuYWJsZSBTQ0xLIERQTSBkdXJpbmcgRFBNIFN0YXJ0IEZ1bmN0
aW9uISIsCiAJCXJldHVybiAtRUlOVkFMKTsKKwl9CiAKIAkvKiBlbmFibGUgTUNMSyBkcG0gKi8K
IAlpZiAoMCA9PSBkYXRhLT5tY2xrX2RwbV9rZXlfZGlzYWJsZWQpIHsKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
