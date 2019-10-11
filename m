From: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 29/29] drm/amd/display: null check pp_smu clock table before
 using it
Date: Fri, 11 Oct 2019 15:53:24 -0400
Message-ID: <20191011195324.16268-30-Bhawanpreet.Lakha@amd.com>
References: <20191011195324.16268-1-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191011195324.16268-1-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQmhhd2FucHJlZXQgTGFraGEgPEJoYXdhbnByZWV0Lkxha2hhQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjEvcm5f
Y2xrX21nci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19t
Z3IvZGNuMjEvcm5fY2xrX21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Ns
a19tZ3IvZGNuMjEvcm5fY2xrX21nci5jCmluZGV4IDBlNzEyZGY4NzEwOS4uYjY0N2UwMzIwZTRi
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24y
MS9ybl9jbGtfbWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19t
Z3IvZGNuMjEvcm5fY2xrX21nci5jCkBAIC02NTYsNyArNjU2LDcgQEAgdm9pZCBybl9jbGtfbWdy
X2NvbnN0cnVjdCgKIAogCWNsa19tZ3ItPmJhc2UuYndfcGFyYW1zID0gJnJuX2J3X3BhcmFtczsK
IAotCWlmIChwcF9zbXUpIHsKKwlpZiAocHBfc211ICYmIHBwX3NtdS0+cm5fZnVuY3MuZ2V0X2Rw
bV9jbG9ja190YWJsZSkgewogCQlwcF9zbXUtPnJuX2Z1bmNzLmdldF9kcG1fY2xvY2tfdGFibGUo
JnBwX3NtdS0+cm5fZnVuY3MucHBfc211LCAmY2xvY2tfdGFibGUpOwogCQlybl9jbGtfbWdyX2hl
bHBlcl9wb3B1bGF0ZV9id19wYXJhbXMoY2xrX21nci0+YmFzZS5id19wYXJhbXMsICZjbG9ja190
YWJsZSwgJmN0eC0+YXNpY19pZCk7CiAJfQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
