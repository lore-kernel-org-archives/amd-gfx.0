From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 6/8] Revert "Revert "drm/amdgpu/gmc9: use
 amdgpu_ring_emit_reg_write_reg_wait in gpu tlb flush""
Date: Tue, 3 Apr 2018 17:08:00 +0800
Message-ID: <1522746482-31353-7-git-send-email-Emily.Deng@amd.com>
References: <1522746482-31353-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1522746482-31353-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

VGhpcyByZXZlcnRzIGNvbW1pdCBjNDFlZDdlYmJhOGViNmRmMjY2NzgzZjU0YTRkM2Q2NDMyNTJl
YTc1LgpUaGUgdmVnYTEwIHNyaW92IHN0aWxsIG5lZWQgdGhlc2UgcGF0Y2hlcy4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgOCArKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYwppbmRleCAwNzA5NDZlLi5hZWFlZDdmIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTM4NSwxMSArMzg1LDkgQEAgc3RhdGljIHVpbnQ2NF90
IGdtY192OV8wX2VtaXRfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCiAJ
YW1kZ3B1X3JpbmdfZW1pdF93cmVnKHJpbmcsIGh1Yi0+Y3R4MF9wdGJfYWRkcl9oaTMyICsgKDIg
KiB2bWlkKSwKIAkJCSAgICAgIHVwcGVyXzMyX2JpdHMocGRfYWRkcikpOwogCi0JYW1kZ3B1X3Jp
bmdfZW1pdF93cmVnKHJpbmcsIGh1Yi0+dm1faW52X2VuZzBfcmVxICsgZW5nLCByZXEpOwotCi0J
Lyogd2FpdCBmb3IgdGhlIGludmFsaWRhdGUgdG8gY29tcGxldGUgKi8KLQlhbWRncHVfcmluZ19l
bWl0X3JlZ193YWl0KHJpbmcsIGh1Yi0+dm1faW52X2VuZzBfYWNrICsgZW5nLAotCQkJCSAgMSA8
PCB2bWlkLCAxIDw8IHZtaWQpOworCWFtZGdwdV9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0
KHJpbmcsIGh1Yi0+dm1faW52X2VuZzBfcmVxICsgZW5nLAorCQkJCQkgICAgaHViLT52bV9pbnZf
ZW5nMF9hY2sgKyBlbmcsCisJCQkJCSAgICByZXEsIDEgPDwgdm1pZCk7CiAKIAlyZXR1cm4gcGRf
YWRkcjsKIH0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
