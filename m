From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: bump version for API to find bo by cpu mapping
Date: Mon, 30 Jul 2018 18:02:30 +0800
Message-ID: <1532944950-28619-2-git-send-email-Jerry.Zhang@amd.com>
References: <1532944950-28619-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532944950-28619-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, david1.zhou-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

YnVtcCB2ZXJzaW9uIGZvciBuZXcgQVBJIGludm9sdmVkLgoKU2lnbmVkLW9mZi1ieTogSnVud2Vp
IFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCmlu
ZGV4IDg4NDNhMDYuLjZiNTI1NTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMKQEAgLTcwLDkgKzcwLDEwIEBACiAgKiAtIDMuMjUuMCAtIEFkZCBzdXBwb3J0IGZvciBz
ZW5zb3IgcXVlcnkgaW5mbyAoc3RhYmxlIHBzdGF0ZSBzY2xrL21jbGspLgogICogLSAzLjI2LjAg
LSBHRlg5OiBQcm9jZXNzIEFNREdQVV9JQl9GTEFHX1RDX1dCX05PVF9JTlZBTElEQVRFLgogICog
LSAzLjI3LjAgLSBBZGQgbmV3IGNodW5rIHRvIHRvIEFNREdQVV9DUyB0byBlbmFibGUgQk9fTElT
VCBjcmVhdGlvbi4KKyAqIC0gMy4yOC4wIC0gQWRkIEFQSSB0byBmaW5kIGJvIGJ5IGNwdSBtYXBw
aW5nIGZvciBVTUQgYm8gdmFsaWRhdGlvbi4KICAqLwogI2RlZmluZSBLTVNfRFJJVkVSX01BSk9S
CTMKLSNkZWZpbmUgS01TX0RSSVZFUl9NSU5PUgkyNworI2RlZmluZSBLTVNfRFJJVkVSX01JTk9S
CTI4CiAjZGVmaW5lIEtNU19EUklWRVJfUEFUQ0hMRVZFTAkwCiAKIGludCBhbWRncHVfdnJhbV9s
aW1pdCA9IDA7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
