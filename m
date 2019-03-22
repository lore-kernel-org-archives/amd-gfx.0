From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix vm_cpu_update hit NULL pointer
Date: Fri, 22 Mar 2019 13:30:32 +0800
Message-ID: <1553232632-27710-1-git-send-email-Monk.Liu@amd.com>
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
To: amd-gfx-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

c2hvdWxkIHVzZSBhbWRncHVfYm9fbWFwLCBvdGhlcndpc2UgeW91J2xsIGhpdCBOVUxMCnBvaW50
ZXIgYnVnIGlmIHdpdGggYW1kZ3B1X2JvX2twdHIKClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxN
b25rLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bV9jcHUuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bV9jcHUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9jcHUuYwppbmRl
eCA5ZDUzOTgyLi4xZmI2Mjk1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtX2NwdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bV9jcHUuYwpAQCAtNzYsOCArNzYsMTAgQEAgc3RhdGljIGludCBhbWRncHVfdm1fY3B1X3Vw
ZGF0ZShzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCiB7CiAJdW5zaWduZWQgaW50
IGk7CiAJdWludDY0X3QgdmFsdWU7CisJdm9pZCAqcHRyOwogCi0JcGUgKz0gKHVuc2lnbmVkIGxv
bmcpYW1kZ3B1X2JvX2twdHIoYm8pOworCWFtZGdwdV9ib19rbWFwKGJvLCAmcHRyKTsKKwlwZSAr
PSAodW5zaWduZWQgbG9uZylwdHI7CiAKIAl0cmFjZV9hbWRncHVfdm1fc2V0X3B0ZXMocGUsIGFk
ZHIsIGNvdW50LCBpbmNyLCBmbGFncyk7CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
