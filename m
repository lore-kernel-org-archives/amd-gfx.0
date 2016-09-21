From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 03/15] Free priv in amdgpu_set_pixmap_bo also
 if priv->bo == NULL
Date: Wed, 21 Sep 2016 18:50:42 +0900
Message-ID: <20160921095054.28302-3-michel@daenzer.net>
References: <20160921095054.28302-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160921095054.28302-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpGaXhlcyBtZW1v
cnkgbGVhayB3aGVuIGRlc3Ryb3lpbmcgcGl4bWFwcyB3aXRoIHByaXYtPmJvID09IE5VTEwuCgpS
ZXBvcnRlZC1ieTogUWlhbmcgWXUgPHFpYW5nLnl1QGFtZC5jb20+CihQb3J0ZWQgZnJvbSBhbWRn
cHUgY29tbWl0IDdmN2Y5ODI1Y2FmMzk4MzkwMjQ5MWRhMjdjMTZkMTRjZDhiZjliN2QpCgpTaWdu
ZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBz
cmMvcmFkZW9uLmggfCA3ICsrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3JhZGVvbi5oIGIvc3JjL3JhZGVvbi5o
CmluZGV4IGM5MTRhNTguLjBiZjZkMzcgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb24uaAorKysgYi9z
cmMvcmFkZW9uLmgKQEAgLTY5MSwxMSArNjkxLDEyIEBAIHN0YXRpYyBpbmxpbmUgQm9vbCByYWRl
b25fc2V0X3BpeG1hcF9ibyhQaXhtYXBQdHIgcFBpeCwgc3RydWN0IHJhZGVvbl9ibyAqYm8pCiAJ
ICAgIHJldHVybiBUUlVFOwogCiAJaWYgKHByaXYpIHsKLQkgICAgaWYgKHByaXYtPmJvID09IGJv
KQotCQlyZXR1cm4gVFJVRTsKKwkgICAgaWYgKHByaXYtPmJvKSB7CisJCWlmIChwcml2LT5ibyA9
PSBibykKKwkJICAgIHJldHVybiBUUlVFOwogCi0JICAgIGlmIChwcml2LT5ibykKIAkJcmFkZW9u
X2JvX3VucmVmKHByaXYtPmJvKTsKKwkgICAgfQogCiAJICAgIGlmICghYm8pIHsKIAkJZnJlZShw
cml2KTsKLS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
