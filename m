From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amdgpu:enable MCBP for SR-IOV
Date: Wed, 8 Mar 2017 15:54:02 +0800
Message-ID: <1488959642-15014-4-git-send-email-Monk.Liu@amd.com>
References: <1488959642-15014-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1488959642-15014-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNzc5YWJjNmE0NzU5M2JlMGZmNTIzNGMzZTJmMmNkZmQyNWJhNzBjYQpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKaW5kZXggOGRiYTVm
Zi4uYmU0OWMzMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4
XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCkBAIC02NTUy
LDYgKzY1NTIsMTAgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfcmluZ19lbWl0X2liX2dmeChzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCiAKIAljb250cm9sIHw9IGliLT5sZW5ndGhfZHcgfCAodm1f
aWQgPDwgMjQpOwogCisJaWYgKHJpbmcgJiYgYW1kZ3B1X3NyaW92X3ZmKHJpbmctPmFkZXYpICYm
CisJCWliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX1BSRUVNUFQpCisJCWNvbnRyb2wgfD0gKDE8
PDIxKTsKKwogCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIGhlYWRlcik7CiAJYW1kZ3B1X3Jpbmdf
d3JpdGUocmluZywKICNpZmRlZiBfX0JJR19FTkRJQU4KLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
