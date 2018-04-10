From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Fix 64-bit division in hwss_edp_power_control
Date: Tue, 10 Apr 2018 16:10:07 -0400
Message-ID: <20180410201007.6522-1-harry.wentland@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, charlene.liu-5C7GfCeVMHo@public.gmane.org, anthony.koo-5C7GfCeVMHo@public.gmane.org
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVu
Y2VyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2Rj
ZTExMF9od19zZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2Ux
MTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCmluZGV4IGYzMmNjZGZkMThhMy4uM2JhMDU3ZTJhNDY3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTEx
MF9od19zZXF1ZW5jZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
MTEwL2RjZTExMF9od19zZXF1ZW5jZXIuYwpAQCAtODYwLDcgKzg2MCw3IEBAIHZvaWQgaHdzc19l
ZHBfcG93ZXJfY29udHJvbCgKIAkJCQkJZG1fZ2V0X2VsYXBzZV90aW1lX2luX25zKAogCQkJCQkJ
CWN0eCwKIAkJCQkJCQljdXJyZW50X3RzLAotCQkJCQkJCWxpbmstPmxpbmtfdHJhY2UudGltZV9z
dGFtcC5lZHBfcG93ZXJvZmYpIC8gMTAwMDAwMDsKKwkJCQkJCQlkaXY2NF91NjQobGluay0+bGlu
a190cmFjZS50aW1lX3N0YW1wLmVkcF9wb3dlcm9mZiwgMTAwMDAwMCkpOwogCQkJdW5zaWduZWQg
bG9uZyBsb25nIHdhaXRfdGltZV9tcyA9IDA7CiAKIAkJCS8qIG1heCA1MDBtcyBmcm9tIExDRFZE
RCBvZmYgdG8gb24gKi8KLS0gCjIuMTUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
