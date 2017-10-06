From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: fix ret checks in amd_powerplay.c
Date: Fri, 6 Oct 2017 13:18:55 +0800
Message-ID: <1507267136-5636-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZTc0NWJjMTBkOTMzNDYyODYzYjQyOTVlYjI2Y2MyYWYwOGYwNjU0NwpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYW1kX3Bvd2VycGxheS5jCmluZGV4IGYzZjMwM2UuLjQ2MzkwNWIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTM5Niw3ICszOTYs
NyBAQCBzdGF0aWMgaW50IHBwX2RwbV9mb3JjZV9wZXJmb3JtYW5jZV9sZXZlbCh2b2lkICpoYW5k
bGUsCiAJaHdtZ3ItPnJlcXVlc3RfZHBtX2xldmVsID0gbGV2ZWw7CiAJaHdtZ3JfaGFuZGxlX3Rh
c2socHBfaGFuZGxlLCBBTURfUFBfVEFTS19SRUFESlVTVF9QT1dFUl9TVEFURSwgTlVMTCwgTlVM
TCk7CiAJcmV0ID0gaHdtZ3ItPmh3bWdyX2Z1bmMtPmZvcmNlX2RwbV9sZXZlbChod21nciwgbGV2
ZWwpOwotCWlmIChyZXQpCisJaWYgKCFyZXQpCiAJCWh3bWdyLT5kcG1fbGV2ZWwgPSBod21nci0+
cmVxdWVzdF9kcG1fbGV2ZWw7CiAKIAltdXRleF91bmxvY2soJnBwX2hhbmRsZS0+cHBfbG9jayk7
Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
