From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Reenable manual GPU reset from sysfs
Date: Fri, 19 Jan 2018 17:35:37 -0500
Message-ID: <1516401337-5359-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

T3RoZXJ3aXNlIGl0IGtlZXBzIHJlamVjdGluZyB0aGUgcmVzZXQuCgpTaWduZWQtb2ZmLWJ5OiBB
bmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggZDA5YzRlZS4uNTAyNTQwNCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjYyMCw3ICsyNjIwLDcgQEAg
aW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
CiAJdWludDY0X3QgcmVzZXRfZmxhZ3MgPSAwOwogCWludCBpLCByLCByZXNjaGVkOwogCi0JaWYg
KCFhbWRncHVfZGV2aWNlX2lwX2NoZWNrX3NvZnRfcmVzZXQoYWRldikpIHsKKwlpZiAoIWZvcmNl
ICYmICFhbWRncHVfZGV2aWNlX2lwX2NoZWNrX3NvZnRfcmVzZXQoYWRldikpIHsKIAkJRFJNX0lO
Rk8oIk5vIGhhcmR3YXJlIGhhbmcgZGV0ZWN0ZWQuIERpZCBzb21lIGJsb2NrcyBzdGFsbD9cbiIp
OwogCQlyZXR1cm4gMDsKIAl9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
