From: Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: Fix code error for translating int type to
 bool type correctly
Date: Tue, 21 May 2019 19:46:12 +0800
Message-ID: <1558439172-4802-1-git-send-email-Jack.Gui@amd.com>
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
Cc: Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

Rml4IGNvZGUgZXJyb3IgdG8gc3VwcG9ydCB2YWx1ZSA8IDAgb3IgPiAxLgoKU2lnbmVkLW9mZi1i
eTogQ2hlbmdtaW5nIEd1aSA8SmFjay5HdWlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRncHVfc211LmMKaW5kZXggM2E0NzEzMC4uZDVmMDNiOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwpAQCAtMzQ4LDcgKzM0OCw3IEBAIHN0YXRpYyBpbnQg
c211X2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0g
JmFkZXYtPnNtdTsKIAogCXNtdS0+YWRldiA9IGFkZXY7Ci0Jc211LT5wbV9lbmFibGVkID0gYW1k
Z3B1X2RwbTsKKwlzbXUtPnBtX2VuYWJsZWQgPSAhIWFtZGdwdV9kcG07CiAJbXV0ZXhfaW5pdCgm
c211LT5tdXRleCk7CiAKIAlyZXR1cm4gc211X3NldF9mdW5jcyhhZGV2KTsKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
