From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: Add interrupt SQ source struct to amdgpu_gfx
 struct.
Date: Tue, 5 Jun 2018 09:17:26 -0400
Message-ID: <1528204647-28803-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1528204647-28803-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528204647-28803-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
Cc: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org

RnJvbTogRGF2aWQgUGFuYXJpdGkgPERhdmlkLlBhbmFyaXRpQGFtZC5jb20+CgpTUSBjYW4gZ2Vu
ZXJhdGUgaW50ZXJydXB0cyBvbiBFREMvRUNDIGVycm9ycyBhbmQgdGhpcyBzdHJ1Y3QgY29udHJv
bHMKaG93IHRoZSBpbnRlcnJ1cHQgaXMgaGFuZGxlZC4gIFRoZSBndXRzIGFyZSBmaWxsZWQgaW4g
aW4gdGhlCmdmX3Y8bWFqb3I+XzxtaW5vcj4uYyBmaWxlcy4KClNpZ25lZC1vZmYtYnk6IERhdmlk
IFBhbmFyaXRpIDxEYXZpZC5QYW5hcml0aUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IDc2YWQ2MzIuLmU4YzZjYzEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC05NjksNiArOTY5LDcgQEAgc3RydWN0
IGFtZGdwdV9nZnggewogCXN0cnVjdCBhbWRncHVfaXJxX3NyYwkJcHJpdl9yZWdfaXJxOwogCXN0
cnVjdCBhbWRncHVfaXJxX3NyYwkJcHJpdl9pbnN0X2lycTsKIAlzdHJ1Y3QgYW1kZ3B1X2lycV9z
cmMJCWNwX2VjY19lcnJvcl9pcnE7CisJc3RydWN0IGFtZGdwdV9pcnFfc3JjCQlzcV9pcnE7CiAJ
LyogZ2Z4IHN0YXR1cyAqLwogCXVpbnQzMl90CQkJZ2Z4X2N1cnJlbnRfc3RhdHVzOwogCS8qIGNl
IHJhbSBzaXplKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
