From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] amdgpu: add PRT page attribute
Date: Thu, 16 Mar 2017 11:56:40 +0800
Message-ID: <1489636601-31486-4-git-send-email-Jerry.Zhang@amd.com>
References: <1489636601-31486-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489636601-31486-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGlu
Y2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL2Ry
bS9hbWRncHVfZHJtLmgKaW5kZXggMzRmODI4Mi4uYTczYjQwYSAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9kcm0vYW1kZ3B1X2RybS5oCisrKyBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaApAQCAtNDIz
LDYgKzQyMyw4IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2dlbV9vcCB7CiAjZGVmaW5lIEFNREdQVV9W
TV9QQUdFX1dSSVRFQUJMRQkoMSA8PCAyKQogLyogZXhlY3V0YWJsZSBtYXBwaW5nLCBuZXcgZm9y
IFZJICovCiAjZGVmaW5lIEFNREdQVV9WTV9QQUdFX0VYRUNVVEFCTEUJKDEgPDwgMykKKy8qIHBh
cnRpYWxseSByZXNpZGVudCB0ZXh0dXJlICovCisjZGVmaW5lIEFNREdQVV9WTV9QQUdFX1BSVAkJ
KDEgPDwgNCkKIAogc3RydWN0IGRybV9hbWRncHVfZ2VtX3ZhIHsKIAkvKiogR0VNIG9iamVjdCBo
YW5kbGUgKi8KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
