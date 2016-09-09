From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 17/20] drm/amd/powerplay: add pptable point check before use it
Date: Fri, 9 Sep 2016 21:39:35 +0800
Message-ID: <1473428378-679-18-git-send-email-Rex.Zhu@amd.com>
References: <1473428378-679-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473428378-679-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJYmFkMjgxY2Q3ZmQ2NjBhYmU2MTI4OTRkZjgyYmUyODRjOWI4NjVhOQpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2h3bWdyL2h3bWdyLmMKaW5kZXggMmIxNjJlZS4uMTFhNDY4MyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci9od21nci5jCkBAIC01NjYsNyArNTY2LDggQEAgaW50IHBo
bV9pbml0aWFsaXphX2R5bmFtaWNfc3RhdGVfYWRqdXN0bWVudF9ydWxlX3NldHRpbmdzKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IKIAkJdGFibGVfY2xrX3ZsdC0+ZW50cmllc1syXS52ID0gODEwOwog
CQl0YWJsZV9jbGtfdmx0LT5lbnRyaWVzWzNdLmNsayA9IFBQX0RBTF9QT1dFUkxFVkVMX1BFUkZP
Uk1BTkNFOwogCQl0YWJsZV9jbGtfdmx0LT5lbnRyaWVzWzNdLnYgPSA5MDA7Ci0JCXBwdGFibGVf
aW5mby0+dmRkY19kZXBfb25fZGFsX3B3cmwgPSB0YWJsZV9jbGtfdmx0OworCQlpZiAocHB0YWJs
ZV9pbmZvICE9IE5VTEwpCisJCQlwcHRhYmxlX2luZm8tPnZkZGNfZGVwX29uX2RhbF9wd3JsID0g
dGFibGVfY2xrX3ZsdDsKIAkJaHdtZ3ItPmR5bl9zdGF0ZS52ZGRjX2RlcF9vbl9kYWxfcHdybCA9
IHRhYmxlX2Nsa192bHQ7CiAJfQogCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
