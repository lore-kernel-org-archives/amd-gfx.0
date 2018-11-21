From: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device
 initialization
Date: Wed, 21 Nov 2018 22:00:34 +0000
Message-ID: <1542837620-13571-5-git-send-email-ozeng@amd.com>
References: <1542837620-13571-1-git-send-email-ozeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542837620-13571-1-git-send-email-ozeng-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMmYwMDRiYmJlMjU2NTAzNTQ2MDY4NmY0ZmMxNmU4NmI3N2EyYTliNQpTaWdu
ZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8b3plbmdAYW1kLmNvbT4KU3VnZ2VzdGVkLWJ5OiBGZWxpeCBL
dWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU3VnZ2VzdGVkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmlu
ZGV4IGNiMDZlNjguLmE5NDJhODggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKQEAgLTUxMyw2ICs1MTMsMTMgQEAgdm9pZCBhbWRncHVfZGV2aWNlX3BjaV9j
b25maWdfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKi8KIHN0YXRpYyBpbnQg
YW1kZ3B1X2RldmljZV9kb29yYmVsbF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
eworCWlmIChhZGV2LT5hc2ljX3R5cGUgPCBDSElQX1ZFR0ExMCkKKwkJdmlfZG9vcmJlbGxfaW5k
ZXhfaW5pdChhZGV2KTsKKwllbHNlIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9WRUdBMTAp
CisJCXZlZ2ExMF9kb29yYmVsbF9pbmRleF9pbml0KGFkZXYpOworCWVsc2UKKwkJdmVnYTEyX2Rv
b3JiZWxsX2luZGV4X2luaXQoYWRldik7CisKIAkvKiBObyBkb29yYmVsbCBvbiBTSSBoYXJkd2Fy
ZSBnZW5lcmF0aW9uICovCiAJaWYgKGFkZXYtPmFzaWNfdHlwZSA8IENISVBfQk9OQUlSRSkgewog
CQlhZGV2LT5kb29yYmVsbC5iYXNlID0gMDsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
