From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [Part II PATCH 14/15] drm/amd/powerplay: add enabling voltage
 controller back
Date: Thu, 28 Jul 2016 15:25:04 +0800
Message-ID: <1469690705-877-15-git-send-email-ray.huang@amd.com>
References: <1469690705-877-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469690705-877-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEtlbiBXYW5nIDxRaW5ncWluZy5XYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvaWNlbGFuZF9od21nci5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQs
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaHdtZ3IvaWNlbGFuZF9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3IvaWNlbGFuZF9od21nci5jCmluZGV4IDYwNzUwNTAuLmQ1MzhkMjggMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2ljZWxhbmRfaHdtZ3IuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9pY2VsYW5kX2h3bWdyLmMKQEAg
LTI5NzAsMTMgKzI5NzAsMTEgQEAgaW50IGljZWxhbmRfc3RhcnRfZHBtKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpCiAKIAlQSE1fV1JJVEVfSU5ESVJFQ1RfRklFTEQoaHdtZ3ItPmRldmljZSwgQ0dT
X0lORF9SRUdfX1BDSUUsIFNXUlNUX0NPTU1BTkRfMSwgUkVTRVRMQywgMHgwKTsKIAotI2lmIDAK
IAlQUF9BU1NFUlRfV0lUSF9DT0RFKAogCQkJKDAgPT0gc211bV9zZW5kX21zZ190b19zbWMoaHdt
Z3ItPnNtdW1nciwKIAkJCQkJUFBTTUNfTVNHX1ZvbHRhZ2VfQ250bF9FbmFibGUpKSwKIAkJCSJG
YWlsZWQgdG8gZW5hYmxlIHZvbHRhZ2UgRFBNIGR1cmluZyBEUE0gU3RhcnQgRnVuY3Rpb24hIiwK
IAkJCXJldHVybiAtMSk7Ci0jZW5kaWYKIAogCWlmICgwICE9IGljZWxhbmRfZW5hYmxlX3NjbGtf
bWNsa19kcG0oaHdtZ3IpKSB7CiAJCVBQX0FTU0VSVF9XSVRIX0NPREUoMCwgIkZhaWxlZCB0byBl
bmFibGUgU2NsayBEUE0gYW5kIE1jbGsgRFBNISIsIHJldHVybiAtMSk7Ci0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
