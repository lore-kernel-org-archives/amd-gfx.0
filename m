From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/powerplay: delete useless code in iceland_hwmgr.c.
Date: Mon, 22 Aug 2016 20:49:36 +0800
Message-ID: <1471870176-14890-4-git-send-email-Rex.Zhu@amd.com>
References: <1471870176-14890-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471870176-14890-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNmY5MDBhMTk4MmE1ZjQ3Zjk4OTQ5YTg1OGM3Y2RkMjg3YjMzOGM4OQpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvaWNlbGFuZF9od21nci5jIHwgMiAtLQogMSBmaWxlIGNoYW5n
ZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3IvaWNlbGFuZF9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaHdtZ3IvaWNlbGFuZF9od21nci5jCmluZGV4IGY0OGYzZWEuLjhhN2FkYTUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2ljZWxhbmRfaHdtZ3IuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9pY2VsYW5kX2h3bWdyLmMK
QEAgLTI0NDUsOCArMjQ0NSw2IEBAIHN0YXRpYyBpbnQgaWNlbGFuZF9wb3B1bGF0ZV9hbGxfZ3Jh
cGhpY19sZXZlbHMoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAkvKiBzZXQgcGNpZURwbUxldmVs
IHRvIG1pZF9wY2llX2xldmVsX2VuYWJsZWQqLwogCWRhdGEtPnNtY19zdGF0ZV90YWJsZS5HcmFw
aGljc0xldmVsWzFdLnBjaWVEcG1MZXZlbCA9IG1pZF9wY2llX2xldmVsX2VuYWJsZWQ7CiAKLQlm
b3IgKGkgPSAwOyBpIDwgZHBtX3RhYmxlLT5zY2xrX3RhYmxlLmNvdW50OyBpKyspCi0KIAkvKiBs
ZXZlbCBjb3VudCB3aWxsIHNlbmQgdG8gc21jIG9uY2UgYXQgaW5pdCBzbWMgdGFibGUgYW5kIG5l
dmVyIGNoYW5nZSovCiAJcmVzdWx0ID0gaWNlbGFuZF9jb3B5X2J5dGVzX3RvX3NtYyhod21nci0+
c211bWdyLCBsZXZlbF9hcnJheV9hZHJlc3MsICh1aW50OF90ICopbGV2ZWxzLCAodWludDMyX3Qp
bGV2ZWxfYXJyYXlfc2l6ZSwgZGF0YS0+c3JhbV9lbmQpOwogCi0tIAoxLjkuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
