From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/14] drm/amdgpu/si: fix the dce6 for si macro
Date: Tue, 30 Aug 2016 19:50:04 +0800
Message-ID: <1472557811-8015-8-git-send-email-ray.huang@amd.com>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472557811-8015-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJM2U1ZjQyMTU4YzU3ZDFlYzcyMmY3MTNiMTI5MTg5YmM1ZjgwMmIxMQpTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9zaS9zaWQuaCB8IDYgKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVnL3NpL3NpZC5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL2FzaWNfcmVnL3NpL3NpZC5oCmluZGV4IDk2MDkxOTkuLmNlZDAzOTAgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9zaS9zaWQuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc2kvc2lkLmgKQEAgLTE5
NjgsNyArMTk2OCwxMSBAQAogI2RlZmluZSBBTURHUFVfTU1fSU5ERVgJCSAgICAgICAgMHgwMDAw
CiAjZGVmaW5lIEFNREdQVV9NTV9EQVRBCQkgICAgICAgIDB4MDAwMQogCi0jZGVmaW5lIEFTSUNf
SVNfRENFNihhZGV2KSAoKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFUkRFKSkKKyNkZWZpbmUg
QVNJQ19JU19EQ0U2KGFkZXYpICgoYWRldi0+YXNpY190eXBlID09IENISVBfVkVSREUpICAgIHx8
IFwKKwkJCSAgICAoYWRldi0+YXNpY190eXBlID09IENISVBfVEFISVRJKSAgIHx8IFwKKwkJCSAg
ICAoYWRldi0+YXNpY190eXBlID09IENISVBfUElUQ0FJUk4pIHx8IFwKKwkJCSAgICAoYWRldi0+
YXNpY190eXBlID09IENISVBfT0xBTkQpKQorCiAjZGVmaW5lIFZFUkRFX05VTV9DUlRDIDYKICNk
ZWZpbmUJQkxBQ0tPVVRfTU9ERV9NQVNLCQkJMHgwMDAwMDAwNwogI2RlZmluZQlWR0FfUkVOREVS
X0NPTlRST0wJCQkweEMwCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
