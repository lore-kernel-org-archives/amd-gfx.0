From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 3/3] present: Wait for screen pixmap BO idle
 before setting modes for unflip
Date: Tue, 21 Feb 2017 18:03:40 +0900
Message-ID: <20170221090340.10647-4-michel@daenzer.net>
References: <20170221090340.10647-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170221090340.10647-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUbyBtYWtlIHN1
cmUgdGhlIHNjcmVlbiBwaXhtYXAgY29udGVudHMgYXJlIHVwIHRvIGRhdGUgd2hlbiBpdCBzdGFy
dHMKYmVpbmcgc2Nhbm5lZCBvdXQuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWlj
aGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvcmFkZW9uX3ByZXNlbnQuYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvcmFkZW9uX3By
ZXNlbnQuYyBiL3NyYy9yYWRlb25fcHJlc2VudC5jCmluZGV4IGIzNmUyOWIxOS4uMWIwZGRjYjgy
IDEwMDY0NAotLS0gYS9zcmMvcmFkZW9uX3ByZXNlbnQuYworKysgYi9zcmMvcmFkZW9uX3ByZXNl
bnQuYwpAQCAtNDA0LDYgKzQwNCw4IEBAIG1vZGVzZXQ6CiAgICAgb2xkX2ZiX2lkID0gaW5mby0+
ZHJtbW9kZS5mYl9pZDsKICAgICBpbmZvLT5kcm1tb2RlLmZiX2lkID0gMDsKIAorICAgIHJhZGVv
bl9jc19mbHVzaF9pbmRpcmVjdChzY3JuKTsKKyAgICByYWRlb25fYm9fd2FpdChpbmZvLT5mcm9u
dF9ibyk7CiAgICAgZm9yIChpID0gMDsgaSA8IGNvbmZpZy0+bnVtX2NydGM7IGkrKykgewogCXhm
ODZDcnRjUHRyIGNydGMgPSBjb25maWctPmNydGNbaV07CiAJZHJtbW9kZV9jcnRjX3ByaXZhdGVf
cHRyIGRybW1vZGVfY3J0YyA9IGNydGMtPmRyaXZlcl9wcml2YXRlOwotLSAKMi4xMS4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
