From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Set queue_preemption_timeout_ms default value
Date: Wed, 26 Jun 2019 15:22:54 +0000
Message-ID: <1561562565-24858-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Zeng,
 Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

U2V0IGRlZmF1bHQgdmFsdWUgb2YgdGhpcyBrZXJuZWwgcGFyYW1ldGVyIHRvIDkwMDANCg0KQ2hh
bmdlLUlkOiBJZjkxZGI0ZDJjMmFjMDhlMjVkNzcyOGQ0OTYyOWNiYWVjMGQ2Yzc3Mw0KU2lnbmVk
LW9mZi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMNCmluZGV4IDdjZjZhYjAuLmU3NGExNzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYw0KQEAgLTcwMCw3ICs3MDAsNyBAQCBNT0RVTEVfUEFSTV9ERVND
KGh3c19nd3Nfc3VwcG9ydCwgIk1FQyBGVyBzdXBwb3J0IGd3cyBiYXJyaWVycyAoZmFsc2UgPSBu
b3Qgc3VwcA0KICAgKiBET0M6IHF1ZXVlX3ByZWVtcHRpb25fdGltZW91dF9tcyAoaW50KQ0KICAg
KiBxdWV1ZSBwcmVlbXB0aW9uIHRpbWVvdXQgaW4gbXMgKDEgPSBNaW5pbXVtLCA5MDAwID0gZGVm
YXVsdCkNCiAgICovDQotaW50IHF1ZXVlX3ByZWVtcHRpb25fdGltZW91dF9tczsNCitpbnQgcXVl
dWVfcHJlZW1wdGlvbl90aW1lb3V0X21zID0gOTAwMDsNCiBtb2R1bGVfcGFyYW0ocXVldWVfcHJl
ZW1wdGlvbl90aW1lb3V0X21zLCBpbnQsIDA2NDQpOw0KIE1PRFVMRV9QQVJNX0RFU0MocXVldWVf
cHJlZW1wdGlvbl90aW1lb3V0X21zLCAicXVldWUgcHJlZW1wdGlvbiB0aW1lb3V0IGluIG1zICgx
ID0gTWluaW11bSwgOTAwMCA9IGRlZmF1bHQpIik7DQogI2VuZGlmDQotLSANCjIuNy40DQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
