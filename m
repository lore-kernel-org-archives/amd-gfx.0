From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 7/7] drm/amd/powerplay: delete duplicate code in smu7_hwmgr.c
Date: Wed, 2 Nov 2016 18:27:41 +0800
Message-ID: <1478082461-23495-8-git-send-email-Rex.Zhu@amd.com>
References: <1478082461-23495-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1478082461-23495-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Vm9sdGFnZSBDb250cm9sbGVyIGhhdmUgYmVlbiBlbmFibGVkIChTTUMgbWVzc2FnZSkKYmVmb3Jl
IFVMViBlbmFibGVtZW50LgoKQ2hhbmdlLUlkOiBJNDgzM2M4ZDUzNjExYzhiOTM3MTIyNTRkNWEx
NTJhZThlOThhN2Q3OAotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3Nt
dTdfaHdtZ3IuYyB8IDcgLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21n
ci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCmlu
ZGV4IGE1MDc2NWQuLmUyMjA0NjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9od21nci9zbXU3X2h3bWdyLmMKQEAgLTk5MywxMyArOTkzLDYgQEAgc3RhdGljIGludCBz
bXU3X3N0YXJ0X2RwbShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCVBITV9XUklURV9JTkRJUkVD
VF9GSUVMRChod21nci0+ZGV2aWNlLCBDR1NfSU5EX1JFR19fUENJRSwKIAkJCVNXUlNUX0NPTU1B
TkRfMSwgUkVTRVRMQywgMHgwKTsKIAotCVBQX0FTU0VSVF9XSVRIX0NPREUoCi0JCQkoMCA9PSBz
bXVtX3NlbmRfbXNnX3RvX3NtYyhod21nci0+c211bWdyLAotCQkJCQlQUFNNQ19NU0dfVm9sdGFn
ZV9DbnRsX0VuYWJsZSkpLAotCQkJIkZhaWxlZCB0byBlbmFibGUgdm9sdGFnZSBEUE0gZHVyaW5n
IERQTSBTdGFydCBGdW5jdGlvbiEiLAotCQkJcmV0dXJuIC1FSU5WQUwpOwotCi0KIAlpZiAoc211
N19lbmFibGVfc2Nsa19tY2xrX2RwbShod21ncikpIHsKIAkJcHJpbnRrKEtFUk5fRVJSICJGYWls
ZWQgdG8gZW5hYmxlIFNjbGsgRFBNIGFuZCBNY2xrIERQTSEiKTsKIAkJcmV0dXJuIC1FSU5WQUw7
Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
