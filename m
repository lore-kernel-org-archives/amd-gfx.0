From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 049/459] drm/amdgpu: add flag to support IH clock gating
Date: Mon, 17 Jun 2019 14:10:10 -0500
Message-ID: <20190617191700.17899-38-alexander.deucher@amd.com>
References: <20190617191700.17899-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617191700.17899-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgoKU2lnbmVkLW9mZi1i
eTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFy
ZWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKaW5kZXggYWJm
MDQ1NGIxYTlkLi4xNWZiYjJkZmY0NjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
aW5jbHVkZS9hbWRfc2hhcmVkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2Ft
ZF9zaGFyZWQuaApAQCAtOTUsNiArOTUsNyBAQCBlbnVtIGFtZF9wb3dlcmdhdGluZ19zdGF0ZSB7
CiAjZGVmaW5lIEFNRF9DR19TVVBQT1JUX1ZDTl9NR0NHCQkJKDEgPDwgMjQpCiAjZGVmaW5lIEFN
RF9DR19TVVBQT1JUX0hEUF9EUwkJCSgxIDw8IDI1KQogI2RlZmluZSBBTURfQ0dfU1VQUE9SVF9I
RFBfU0QJCQkoMSA8PCAyNikKKyNkZWZpbmUgQU1EX0NHX1NVUFBPUlRfSUhfQ0cJCQkoMSA8PCAy
NykKIC8qIFBHIGZsYWdzICovCiAjZGVmaW5lIEFNRF9QR19TVVBQT1JUX0dGWF9QRwkJCSgxIDw8
IDApCiAjZGVmaW5lIEFNRF9QR19TVVBQT1JUX0dGWF9TTUcJCQkoMSA8PCAxKQotLSAKMi4yMC4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
