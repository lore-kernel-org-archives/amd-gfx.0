From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amd/powerplay: fix copy error in
 smu7_clockpoweragting.c
Date: Mon, 13 Mar 2017 16:51:21 +0800
Message-ID: <1489395082-30583-2-git-send-email-Rex.Zhu@amd.com>
References: <1489395082-30583-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489395082-30583-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJMGU0MWZkYjJkZjc5NGRjYmU0YzUwOGU5YTcxZGQ2MDYxMjQzMDQ4MgpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19jbG9ja3Bvd2VyZ2F0aW5nLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2Nsb2NrcG93ZXJnYXRpbmcu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfY2xvY2twb3dlcmdh
dGluZy5jCmluZGV4IDhjZjcxZjMuLjI2MWI4MjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfY2xvY2twb3dlcmdhdGluZy5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfY2xvY2twb3dlcmdhdGluZy5jCkBA
IC0xNzgsNyArMTc4LDcgQEAgaW50IHNtdTdfcG93ZXJnYXRlX3ZjZShzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyLCBib29sIGJnYXRlKQogCWlmIChiZ2F0ZSkgewogCQljZ3Nfc2V0X3Bvd2VyZ2F0aW5n
X3N0YXRlKGh3bWdyLT5kZXZpY2UsCiAJCQkJCQlBTURfSVBfQkxPQ0tfVFlQRV9WQ0UsCi0JCQkJ
CQlBTURfUEdfU1RBVEVfVU5HQVRFKTsKKwkJCQkJCUFNRF9QR19TVEFURV9HQVRFKTsKIAkJY2dz
X3NldF9jbG9ja2dhdGluZ19zdGF0ZShod21nci0+ZGV2aWNlLAogCQkJCUFNRF9JUF9CTE9DS19U
WVBFX1ZDRSwKIAkJCQlBTURfQ0dfU1RBVEVfR0FURSk7Ci0tIAoxLjkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
