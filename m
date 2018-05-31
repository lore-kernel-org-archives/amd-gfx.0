From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/18] drm/amd/display: Drop duplicate
 dc_stream_set_static_screen_events definition
Date: Thu, 31 May 2018 10:23:39 -0400
Message-ID: <20180531142347.4086-11-harry.wentland@amd.com>
References: <20180531142347.4086-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180531142347.4086-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Krunoslav Kovac <Krunoslav.Kovac-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS3J1bm9zbGF2IEtvdmFjIDxLcnVub3NsYXYuS292YWNAYW1kLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBLcnVub3NsYXYgS292YWMgPEtydW5vc2xhdi5Lb3ZhY0BhbWQuY29tPgpSZXZpZXdlZC1i
eTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjX3N0cmVhbS5oIHwgNSAtLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjX3N0cmVhbS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3N0cmVhbS5o
CmluZGV4IGZlNGRhZGQ2NzgwNC4uNTg0YzU2Yjk0OTM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfc3RyZWFtLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjX3N0cmVhbS5oCkBAIC0zMDMsOSArMzAzLDQgQEAgYm9vbCBkY19zdHJl
YW1fZ2V0X2NydGNfcG9zaXRpb24oc3RydWN0IGRjICpkYywKIAkJCQkgdW5zaWduZWQgaW50ICp2
X3BvcywKIAkJCQkgdW5zaWduZWQgaW50ICpub21fdl9wb3MpOwogCi12b2lkIGRjX3N0cmVhbV9z
ZXRfc3RhdGljX3NjcmVlbl9ldmVudHMoc3RydWN0IGRjICpkYywKLQkJCQkJc3RydWN0IGRjX3N0
cmVhbV9zdGF0ZSAqKnN0cmVhbSwKLQkJCQkJaW50IG51bV9zdHJlYW1zLAotCQkJCQljb25zdCBz
dHJ1Y3QgZGNfc3RhdGljX3NjcmVlbl9ldmVudHMgKmV2ZW50cyk7Ci0KICNlbmRpZiAvKiBEQ19T
VFJFQU1fSF8gKi8KLS0gCjIuMTcuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
