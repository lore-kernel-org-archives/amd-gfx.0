From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 22/39] drm/amd/dal: fix infinite loop
Date: Wed, 23 Nov 2016 21:02:51 -0500
Message-ID: <20161124020308.28124-23-harry.wentland@amd.com>
References: <20161124020308.28124-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161124020308.28124-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgoKLSBleHBvc2VkIGJ5IExDRCBl
bmFibGVkIGJpb3MuICAgcm9vdCBjYXVzZSBub3QgdW5kZXJzdG9vZCB5ZXQKCkNoYW5nZS1JZDog
STYwNDQzMjIyNDg1NjUxMmI0ZDRmMjRkYThjY2M2M2I5MTM5NWYxYTAKU2lnbmVkLW9mZi1ieTog
VG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQg
PGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMv
Y29yZS9kY19saW5rLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3Jl
L2RjX2xpbmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2NvcmUvZGNfbGluay5jCmlu
ZGV4IDYyMGVmMDM2NTFmMS4uMTFjYzA1ZjlhM2EwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2RhbC9kYy9jb3JlL2RjX2xpbmsuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rh
bC9kYy9jb3JlL2RjX2xpbmsuYwpAQCAtMTA0MCw3ICsxMDQwLDcgQEAgc3RhdGljIGJvb2wgY29u
c3RydWN0KAogCiAJbGluay0+cHVibGljLmxpbmtfZW5jX2h3X2luc3QgPSBsaW5rLT5saW5rX2Vu
Yy0+dHJhbnNtaXR0ZXI7CiAKLQlmb3IgKGkgPSAwOyA7IGkrKykgeworCWZvciAoaSA9IDA7IGkg
PCA0OyBpKyspIHsKIAkJaWYgKEJQX1JFU1VMVF9PSyAhPQogCQkJCWJwX2Z1bmNzLT5nZXRfZGV2
aWNlX3RhZyhkY19jdHgtPmRjX2Jpb3MsIGxpbmstPmxpbmtfaWQsIGksICZsaW5rLT5kZXZpY2Vf
dGFnKSkgewogCQkJRENfRVJST1IoIkZhaWxlZCB0byBmaW5kIGRldmljZSB0YWchXG4iKTsKLS0g
CjIuMTAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
